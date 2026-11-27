import * as pdfjs from 'pdfjs-dist';
import workerUrl from 'pdfjs-dist/build/pdf.worker.min.mjs?url';

pdfjs.GlobalWorkerOptions.workerSrc = workerUrl;

export interface EmployeeEntry {
  empId: string;
  name: string;
  email: string;
  department: string;
}

export interface DriveCertRecord {
  fileId: string;
  fileName: string;
  webViewLink: string;
  holderName: string;
  nismSeries: string;
  certificateNumber: string;
  enrolmentNumber: string;
  examDate: string;
  expiryDate: string;
  marksObtained: number;
  totalMarks: number;
  percentage: number;
  passStatus: 'PASS' | 'FAIL';
  cpeOrExamType: string;
  matchedEmployee?: EmployeeEntry | null;
}

export interface ExpiryInfo {
  status: 'expired' | 'expiring_soon' | 'active' | 'unknown';
  daysRemaining: number;
  label: string;
}

const DRIVE_API = 'https://www.googleapis.com/drive/v3';
const DRIVE_UPLOAD = 'https://www.googleapis.com/upload/drive/v3';
const GMAIL_API = 'https://gmail.googleapis.com/gmail/v1/users/me/messages/send';

export const DEFAULT_CLIENT_ID = '841567171153-akkmgnvla2s2fdatkrppm369el4m1s39.apps.googleusercontent.com';
export const DEFAULT_FOLDER_URL = 'https://drive.google.com/drive/folders/1JrXSh0eBiQVaozHR1Yv5LST4-lzHJCAo';
export const DEFAULT_GOOGLE_EMAIL = 'ashutosh.kumar@fundsindia.com';
export const DEFAULT_FOLDER_NAME = 'FundsIndia - NISM Certificates';
export const DIRECTORY_FILE_NAME = 'nism-employee-directory.json';
export const ANALYSIS_CACHE_FILE_NAME = 'nism-analysis-data.json';

declare global {
  interface Window {
    google?: {
      accounts?: {
        oauth2?: {
          initTokenClient: (cfg: {
            client_id: string;
            scope: string;
            login_hint?: string;
            callback: (resp: { access_token?: string; expires_in?: number; error?: string; error_description?: string }) => void;
          }) => { requestAccessToken: (opts?: { prompt?: string }) => void };
        };
      };
    };
  }
}

let gisPromise: Promise<void> | null = null;
export function loadGoogleIdentity(): Promise<void> {
  if (window.google?.accounts?.oauth2) return Promise.resolve();
  if (!gisPromise) {
    gisPromise = new Promise((resolve, reject) => {
      const s = document.createElement('script');
      s.src = 'https://accounts.google.com/gsi/client';
      s.async = true;
      s.onload = () => resolve();
      s.onerror = () => { gisPromise = null; reject(new Error('Could not load Google Sign-In script.')); };
      document.head.appendChild(s);
    });
  }
  return gisPromise;
}

export async function requestGoogleToken(clientId: string, opts?: { silent?: boolean; loginHint?: string }): Promise<{ token: string; expiresIn: number }> {
  await loadGoogleIdentity();
  return new Promise((resolve, reject) => {
    const client = window.google!.accounts!.oauth2!.initTokenClient({
      client_id: clientId.trim(),
      scope: 'https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/gmail.send',
      login_hint: opts?.loginHint || DEFAULT_GOOGLE_EMAIL,
      callback: (resp) => {
        if (resp.error || !resp.access_token) {
          reject(new Error(resp.error_description || resp.error || 'Google authorization failed.'));
        } else {
          resolve({ token: resp.access_token, expiresIn: Number(resp.expires_in) || 3500 });
        }
      },
    });
    client.requestAccessToken({ prompt: opts?.silent ? '' : 'consent' });
  });
}

export function extractFolderId(input: string): string {
  const s = input.trim();
  if (!s) return '';
  const m = s.match(/\/folders\/([a-zA-Z0-9_-]+)/);
  if (m) return m[1];
  const q = s.match(/[?&]id=([a-zA-Z0-9_-]+)/);
  if (q) return q[1];
  return s;
}

async function driveErr(res: Response, ctx: string): Promise<Error> {
  const t = await res.text().catch(() => '');
  if (res.status === 401) return new Error('Google session expired. Click "Connect Google Drive & Gmail" again.');
  return new Error(`${ctx} (${res.status}): ${t || res.statusText}`);
}

export async function resolveOrCreateFolder(token: string, folderInput?: string): Promise<{ id: string; name: string; webViewLink: string }> {
  const explicitId = extractFolderId(folderInput || '');
  if (explicitId) {
    const r = await fetch(`${DRIVE_API}/files/${encodeURIComponent(explicitId)}?fields=id,name,trashed,webViewLink`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    if (!r.ok) throw await driveErr(r, 'Could not open specified Drive folder');
    const d: any = await r.json();
    if (d.trashed) throw new Error('The specified Google Drive folder is in Trash.');
    return { id: d.id, name: d.name, webViewLink: d.webViewLink || `https://drive.google.com/drive/folders/${d.id}` };
  }

  const q = encodeURIComponent(`name='${DEFAULT_FOLDER_NAME}' and mimeType='application/vnd.google-apps.folder' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id,name,webViewLink)&pageSize=5`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!sr.ok) throw await driveErr(sr, 'Drive folder search failed');
  const sd: any = await sr.json();
  if (sd.files?.[0]?.id) {
    const f = sd.files[0];
    return { id: f.id, name: f.name, webViewLink: f.webViewLink || `https://drive.google.com/drive/folders/${f.id}` };
  }

  const cr = await fetch(`${DRIVE_API}/files?fields=id,name,webViewLink`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ name: DEFAULT_FOLDER_NAME, mimeType: 'application/vnd.google-apps.folder' }),
  });
  if (!cr.ok) throw await driveErr(cr, 'Could not create Drive folder');
  const c: any = await cr.json();
  return { id: c.id, name: c.name, webViewLink: c.webViewLink || `https://drive.google.com/drive/folders/${c.id}` };
}

export async function listDrivePdfs(token: string, folderId: string): Promise<Array<{ id: string; name: string; mimeType: string; webViewLink: string; modifiedTime?: string; folderName?: string }>> {
  const out: Array<{ id: string; name: string; mimeType: string; webViewLink: string; modifiedTime?: string; folderName?: string }> = [];
  const queue: Array<{ id: string; name: string; depth: number }> = [{ id: folderId, name: '', depth: 0 }];
  const seen = new Set<string>();

  while (queue.length) {
    const cur = queue.shift()!;
    if (seen.has(cur.id)) continue;
    seen.add(cur.id);

    let pageToken = '';
    do {
      const q = encodeURIComponent(`'${cur.id}' in parents and trashed=false and (mimeType='application/pdf' or mimeType='application/vnd.google-apps.folder')`);
      const url = `${DRIVE_API}/files?q=${q}&orderBy=modifiedTime desc&fields=nextPageToken,files(id,name,mimeType,webViewLink,modifiedTime)&pageSize=200&supportsAllDrives=true&includeItemsFromAllDrives=true${pageToken ? '&pageToken=' + encodeURIComponent(pageToken) : ''}`;
      const r = await fetch(url, { headers: { Authorization: `Bearer ${token}` } });
      if (!r.ok) throw await driveErr(r, 'Failed to list PDFs in Drive folder');
      const d: any = await r.json();
      for (const f of (d.files || [])) {
        if (f.mimeType === 'application/vnd.google-apps.folder') {
          if (cur.depth < 3) queue.push({ id: String(f.id), name: String(f.name || ''), depth: cur.depth + 1 });
        } else if (f.mimeType === 'application/pdf') {
          out.push({
            id: String(f.id),
            name: String(f.name || 'Certificate.pdf'),
            mimeType: String(f.mimeType || 'application/pdf'),
            webViewLink: f.webViewLink || `https://drive.google.com/file/d/${f.id}/view`,
            modifiedTime: f.modifiedTime,
            folderName: cur.name || undefined,
          });
        }
      }
      pageToken = d.nextPageToken || '';
    } while (pageToken);
  }
  return out;
}

export async function uploadPdfToDrive(token: string, folderId: string, file: File): Promise<{ id: string; name: string; webViewLink: string }> {
  const bytes = new Uint8Array(await file.arrayBuffer());
  const boundary = `fi_nism_${Date.now()}`;
  const meta = JSON.stringify({ name: file.name, parents: [folderId] });
  const enc = new TextEncoder();
  const pre = enc.encode(`--${boundary}\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n${meta}\r\n--${boundary}\r\nContent-Type: ${file.type || 'application/pdf'}\r\n\r\n`);
  const end = enc.encode(`\r\n--${boundary}--`);
  const body = new Uint8Array(pre.length + bytes.length + end.length);
  body.set(pre, 0); body.set(bytes, pre.length); body.set(end, pre.length + bytes.length);

  const r = await fetch(`${DRIVE_UPLOAD}/files?uploadType=multipart&fields=id,name,webViewLink`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': `multipart/related; boundary=${boundary}` },
    body,
  });
  if (!r.ok) throw await driveErr(r, 'Upload to Drive failed');
  const d: any = await r.json();
  return { id: d.id, name: d.name, webViewLink: d.webViewLink || `https://drive.google.com/file/d/${d.id}/view` };
}

export async function downloadDriveFileBytes(token: string, fileId: string): Promise<Uint8Array> {
  const r = await fetch(`${DRIVE_API}/files/${encodeURIComponent(fileId)}?alt=media`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!r.ok) throw await driveErr(r, 'Download from Drive failed');
  return new Uint8Array(await r.arrayBuffer());
}

export async function loadJsonFromDrive<T>(token: string, folderId: string, fileName: string): Promise<T | null> {
  const q = encodeURIComponent(`'${folderId}' in parents and name='${fileName}' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id)&pageSize=1`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!sr.ok) return null;
  const sd: any = await sr.json();
  const id = sd.files?.[0]?.id;
  if (!id) return null;
  const dr = await fetch(`${DRIVE_API}/files/${encodeURIComponent(id)}?alt=media`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!dr.ok) return null;
  try { return (await dr.json()) as T; } catch { return null; }
}

export async function saveJsonToDrive(token: string, folderId: string, fileName: string, data: unknown): Promise<void> {
  const q = encodeURIComponent(`'${folderId}' in parents and name='${fileName}' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id)&pageSize=1`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  const sd: any = sr.ok ? await sr.json() : { files: [] };
  const existingId = sd.files?.[0]?.id;
  const jsonText = JSON.stringify(data, null, 2);

  if (existingId) {
    const ur = await fetch(`${DRIVE_UPLOAD}/files/${encodeURIComponent(existingId)}?uploadType=media`, {
      method: 'PATCH',
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
      body: jsonText,
    });
    if (!ur.ok) throw await driveErr(ur, `Failed to update ${fileName} in Drive`);
    return;
  }

  const boundary = `fi_json_${Date.now()}`;
  const meta = JSON.stringify({ name: fileName, parents: [folderId], mimeType: 'application/json' });
  const body = `--${boundary}\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n${meta}\r\n--${boundary}\r\nContent-Type: application/json\r\n\r\n${jsonText}\r\n--${boundary}--`;
  const cr = await fetch(`${DRIVE_UPLOAD}/files?uploadType=multipart&fields=id`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': `multipart/related; boundary=${boundary}` },
    body,
  });
  if (!cr.ok) throw await driveErr(cr, `Failed to save ${fileName} in Drive`);
}

/* ---------- PDF Text Extraction & NISM Parsing ---------- */
const MONTHS: Record<string, string> = {
  jan: '01', january: '01', feb: '02', february: '02', mar: '03', march: '03', apr: '04', april: '04',
  may: '05', jun: '06', june: '06', jul: '07', july: '07', aug: '08', august: '08',
  sep: '09', sept: '09', september: '09', oct: '10', october: '10', nov: '11', november: '11', dec: '12', december: '12',
};

export function parseDateIso(input?: string): string {
  if (!input) return '';
  const s = input.trim().replace(/(\d{1,2})(st|nd|rd|th)\b/gi, '$1').replace(/\s+/g, ' ');
  let m = /^(\d{4})[\/\-.](\d{1,2})[\/\-.](\d{1,2})$/.exec(s);
  if (m) return `${m[1]}-${m[2].padStart(2, '0')}-${m[3].padStart(2, '0')}`;
  m = /^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})$/.exec(s);
  if (m) return `${m[3]}-${m[2].padStart(2, '0')}-${m[1].padStart(2, '0')}`;
  m = /^(\d{1,2})[\s\-\/.,]+([A-Za-z]+)[.,]?[\s\-\/.,]+(\d{4})$/.exec(s);
  if (m) {
    const mon = MONTHS[m[2].toLowerCase()] || MONTHS[m[2].toLowerCase().slice(0, 3)];
    if (mon) return `${m[3]}-${mon}-${m[1].padStart(2, '0')}`;
  }
  m = /^([A-Za-z]+)[.,]?[\s\-\/.,]+(\d{1,2})[.,]?[\s\-\/.,]+(\d{4})$/.exec(s);
  if (m) {
    const mon = MONTHS[m[1].toLowerCase()] || MONTHS[m[1].toLowerCase().slice(0, 3)];
    if (mon) return `${m[3]}-${mon}-${m[2].padStart(2, '0')}`;
  }
  return '';
}

export function fmtDispDate(iso: string): string {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(iso)) return iso || '—';
  const [y, m, d] = iso.split('-').map(Number);
  return new Intl.DateTimeFormat('en-IN', { day: '2-digit', month: 'short', year: 'numeric', timeZone: 'UTC' }).format(new Date(Date.UTC(y, m - 1, d)));
}

export function getExpiryInfo(expiryIso: string, thresholdDays = 30): ExpiryInfo {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(expiryIso)) return { status: 'unknown', daysRemaining: 9999, label: 'Unknown Date' };
  const [y, m, d] = expiryIso.split('-').map(Number);
  const expMs = Date.UTC(y, m - 1, d);
  const now = new Date();
  const refMs = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate());
  const days = Math.round((expMs - refMs) / 86_400_000);
  if (days < 0) return { status: 'expired', daysRemaining: days, label: `Expired ${Math.abs(days)}d ago` };
  if (days === 0) return { status: 'expiring_soon', daysRemaining: 0, label: 'Expires today' };
  if (days <= thresholdDays) return { status: 'expiring_soon', daysRemaining: days, label: `Expiring in ${days}d` };
  return { status: 'active', daysRemaining: days, label: `Active (${days}d left)` };
}

export async function extractPdfText(bytes: Uint8Array): Promise<string> {
  const doc = await pdfjs.getDocument({ data: bytes }).promise;
  const pages: string[] = [];
  for (let p = 1; p <= Math.min(2, doc.numPages); p++) {
    const page = await doc.getPage(p);
    const tc = await page.getTextContent();
    const text = tc.items.map((it: any) => it.str || '').join(' ');
    pages.push(text);
  }
  await doc.destroy();
  return pages.join('\n').replace(/\s+/g, ' ').trim();
}

export function parseNismPdfText(text: string, fileName: string): Omit<DriveCertRecord, 'fileId' | 'fileName' | 'webViewLink'> {
  const clean = text.replace(/\s+/g, ' ').trim();
  const certNum = (clean.match(/\b(NISM-\d{8,14})\b/i)?.[1] || clean.match(/Certificate\s*(?:No|Number)\.?\s*[:\-]?\s*([A-Z0-9-]{6,25})/i)?.[1] || '').toUpperCase();
  const enrol = clean.match(/Enrol+ment\s*(?:No|Number)\.?\s*[:\-]?\s*(\d{6,15})/i)?.[1] || '';
  const series = clean.match(/(NISM[-\s]*Series[-\s]*[IVX0-9A-Z-]+(?:\s*:\s*[^.\n]{4,60})?)/i)?.[1]?.replace(/\s+/g, ' ').trim() || 'NISM Certification';

  let holderName = '';
  const namePatterns = [
    /This\s+is\s+to\s+certify\s+that\s+(?:Mr\.?|Ms\.?|Mrs\.?|Shri\.?)?\s*([A-Z][A-Za-z\s.]{2,55}?)(?=\s+(?:has|bearing|having|Enrol|Registration|S\/O|D\/O|W\/O|NISM))/i,
    /(?:Candidate\s*Name|Name\s*of\s*(?:Candidate|Participant|Holder))\s*[:\-]?\s*([A-Z][A-Za-z\s.]{2,55}?)(?=\s+(?:Enrol|Reg|Certificate|NISM|Date|Marks))/i,
  ];
  for (const re of namePatterns) {
    const m = clean.match(re);
    if (m?.[1]) { holderName = m[1].replace(/\s+/g, ' ').trim(); break; }
  }
  if (!holderName) {
    holderName = fileName.replace(/\.pdf$/i, '').replace(/[_-]+/g, ' ').trim();
  }

  const dateTok = '(?:\\d{1,2}[\\s\\-\\/.]+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)[a-z]*[\\s\\-\\/.]+\\d{4}|\\d{1,2}[\\/\\-.]\\d{1,2}[\\/\\-.]\\d{4}|\\d{4}[\\/\\-.]\\d{1,2}[\\/\\-.]\\d{1,2})';
  const examRaw = clean.match(new RegExp(`(?:Test\\s*Date|Exam(?:ination)?\\s*Date|Date\\s+of\\s+Exam(?:ination)?|Issue\\s*Date)\\s*[:\\-;]?\\s*(${dateTok})`, 'i'))?.[1] || '';
  const expRaw = clean.match(new RegExp(`(?:Valid\\s*(?:Till|Til|Upto|Up\\s*to)|Validity(?:\\s*Date)?|Expiry\\s*Date)\\s*[:\\-;]?\\s*(${dateTok})`, 'i'))?.[1] || '';
  let examDate = parseDateIso(examRaw);
  let expiryDate = parseDateIso(expRaw);
  if (!examDate || !expiryDate) {
    const allDates = (clean.match(new RegExp(dateTok, 'g')) || []).map(parseDateIso).filter(Boolean).sort();
    if (!examDate && allDates.length >= 1) examDate = allDates[0];
    if (!expiryDate && allDates.length >= 2) expiryDate = allDates[allDates.length - 1];
  }

  let marksObtained = 0, totalMarks = 100, percentage = 0;
  const scoreM = clean.match(/(?:Marks\s*(?:Obtained|Scored)|Score)\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*(?:out\s+of|\/)\s*(\d+(?:\.\d+)?)/i);
  if (scoreM) {
    marksObtained = Number(scoreM[1]);
    totalMarks = Number(scoreM[2]) || 100;
    percentage = Math.round((marksObtained / totalMarks) * 10000) / 100;
  }
  const isCpe = /\bCPE\b|Continuing\s+Professional\s+Education/i.test(clean);
  const passStatus: 'PASS' | 'FAIL' = /\bFAIL\b/i.test(clean) ? 'FAIL' : 'PASS';

  return {
    holderName,
    nismSeries: series,
    certificateNumber: certNum || '—',
    enrolmentNumber: enrol || '—',
    examDate,
    expiryDate,
    marksObtained,
    totalMarks,
    percentage,
    passStatus,
    cpeOrExamType: isCpe ? 'CPE' : 'Certification Examination',
  };
}

/* ---------- Employee Directory Matching ---------- */
const normName = (s: string) => s.toLowerCase().replace(/[^a-z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();

export function matchCertificatesWithDirectory(certs: DriveCertRecord[], directory: EmployeeEntry[]) {
  const matchedEmpKeys = new Set<string>();
  const updatedCerts = certs.map((c) => {
    const cn = normName(c.holderName);
    const fn = normName(c.fileName.replace(/\.pdf$/i, ''));
    const match = directory.find((emp) => {
      const en = normName(emp.name);
      const eid = emp.empId.trim().toLowerCase();
      if (eid && (c.fileName.toLowerCase().includes(eid) || c.holderName.toLowerCase().includes(eid))) return true;
      if (en && (cn === en || cn.includes(en) || en.includes(cn) || fn.includes(en))) return true;
      return false;
    }) || null;
    if (match) matchedEmpKeys.add((match.empId || match.email || match.name).toLowerCase());
    return { ...c, matchedEmployee: match };
  });

  const missingEmployees = directory.filter(
    (emp) => !matchedEmpKeys.has((emp.empId || emp.email || emp.name).toLowerCase()),
  );
  return { certs: updatedCerts, missingEmployees };
}

/* ---------- Email Builder (matches FundsIndia Compliance Desk template) ---------- */
const esc = (v: unknown) => String(v ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

export function buildAuditEmail(params: {
  to: string;
  expiringCerts: DriveCertRecord[];
  missingEmployees: EmployeeEntry[];
  thresholdDays: number;
  actionedBy: string;
}) {
  const { to, expiringCerts, missingEmployees, thresholdDays, actionedBy } = params;
  const nowIso = new Date().toISOString();
  const subject = `[FundsIndia Trading & Quality] NISM Compliance Alert: ${expiringCerts.length} Expiring/Expired · ${missingEmployees.length} Missing Certificate(s)`;

  const th = 'padding:8px 9px;border:1px solid #334155;background-color:#1e293b;color:#ffffff;font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:0.03em;text-align:left;';
  const td = 'padding:8px 9px;border:1px solid #cbd5e1;vertical-align:top;color:#0f172a;font-size:12px;line-height:1.4;';

  const certRows = expiringCerts.map((c, i) => {
    const inf = getExpiryInfo(c.expiryDate, thresholdDays);
    const bg = i % 2 === 0 ? '#ffffff' : '#f8fafc';
    const badgeBg = inf.status === 'expired' ? '#fef2f2' : '#fffbeb';
    const badgeCol = inf.status === 'expired' ? '#991b1b' : '#92400e';
    const emp = c.matchedEmployee;
    return `<tr style="background-color:${bg};">
      <td style="${td}font-weight:600;">${esc(emp?.name || c.holderName)}${emp?.empId ? `<div style="font-size:11px;color:#475569;font-weight:400;">ID: ${esc(emp.empId)}</div>` : ''}</td>
      <td style="${td}">${emp?.email ? `<a href="mailto:${esc(emp.email)}" style="color:#1d4ed8;">${esc(emp.email)}</a>` : '—'}</td>
      <td style="${td}">${esc(emp?.department || '—')}</td>
      <td style="${td}">${esc(c.nismSeries)}</td>
      <td style="${td}font-family:monospace;">${esc(c.certificateNumber)}</td>
      <td style="${td}font-family:monospace;">${esc(c.enrolmentNumber)}</td>
      <td style="${td}">${esc(c.cpeOrExamType)}</td>
      <td style="${td}">${esc(fmtDispDate(c.examDate))}</td>
      <td style="${td}"><div style="font-weight:600;">${esc(fmtDispDate(c.expiryDate))}</div><span style="display:inline-block;padding:2px 7px;border-radius:4px;font-size:11px;font-weight:600;background:${badgeBg};color:${badgeCol};">${esc(inf.label)}</span></td>
      <td style="${td}">${c.marksObtained}/${c.totalMarks} (${c.percentage}%) <span style="background:#dcfce7;color:#166534;padding:1px 5px;border-radius:3px;font-size:10px;font-weight:700;">${esc(c.passStatus)}</span></td>
      <td style="${td}"><a href="${esc(c.webViewLink)}" target="_blank" style="color:#1d4ed8;font-weight:600;">View PDF</a><div style="font-size:11px;color:#64748b;">${esc(c.fileName)}</div></td>
    </tr>`;
  }).join('');

  const missingRows = missingEmployees.map((e, i) => `
    <tr style="background-color:${i % 2 === 0 ? '#ffffff' : '#f8fafc'};">
      <td style="${td}font-family:monospace;">${esc(e.empId || '—')}</td>
      <td style="${td}font-weight:600;">${esc(e.name)}</td>
      <td style="${td}">${e.email ? `<a href="mailto:${esc(e.email)}" style="color:#1d4ed8;">${esc(e.email)}</a>` : '—'}</td>
      <td style="${td}">${esc(e.department || '—')}</td>
      <td style="${td}"><span style="display:inline-block;padding:2px 8px;border-radius:4px;font-size:11px;font-weight:700;background:#fef2f2;color:#991b1b;">MISSING / NOT UPLOADED</span></td>
    </tr>
  `).join('');

  const htmlBody = `<!DOCTYPE html><html><body style="margin:0;padding:16px;background:#f1f5f9;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif;color:#0f172a;">
    <div style="max-width:1280px;margin:0 auto;background:#fff;border:1px solid #cbd5e1;border-radius:8px;overflow:hidden;">
      <div style="background:#991b1b;padding:18px 24px;color:#fff;">
        <div style="font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;opacity:0.9;">FUNDSINDIA · TRADING &amp; QUALITY COMPLIANCE DESK · NISM AUDIT ALERT</div>
        <h1 style="margin:6px 0 4px 0;font-size:18px;font-weight:700;color:#fff;">NISM Expiry &amp; Missing Certificate Report</h1>
        <div style="font-size:12px;color:#e2e8f0;">FundsIndia Trading &amp; Quality — Google Drive NISM Compliance Hub</div>
      </div>
      <div style="padding:20px 24px;">
        <div style="background:#f8fafc;border:1px solid #cbd5e1;border-radius:6px;padding:12px 16px;margin-bottom:18px;font-size:12px;">
          <div><b>Actioned By:</b> ${esc(actionedBy)}</div>
          <div><b>Timestamp (UTC):</b> ${esc(nowIso)}</div>
          <div><b>Summary:</b> ${expiringCerts.length} Expiring/Expired (within ${thresholdDays} days) · ${missingEmployees.length} Missing / Not Uploaded</div>
        </div>
        <div style="font-size:12px;font-weight:700;color:#1e293b;text-transform:uppercase;margin-bottom:8px;">TABLE 1: EMPLOYEES WHOSE NISM CERTIFICATE IS EXPIRING WITHIN ${thresholdDays} DAYS (3 MONTHS) / EXPIRED (${expiringCerts.length} RECORD${expiringCerts.length === 1 ? '' : 'S'})</div>
        <div style="overflow-x:auto;margin-bottom:22px;"><table cellpadding="8" cellspacing="0" width="100%" style="border-collapse:collapse;border:1px solid #cbd5e1;"><thead><tr>
          <th style="${th}">Advisor / Employee Name</th><th style="${th}">Advisor Email</th><th style="${th}">Department / Folder</th><th style="${th}">NISM Series</th><th style="${th}">Certificate Number</th><th style="${th}">Enrolment Number</th><th style="${th}">Exam Type</th><th style="${th}">Exam Date</th><th style="${th}">Valid Till / Expiry Date</th><th style="${th}">Marks &amp; Score</th><th style="${th}">Source PDF</th>
        </tr></thead><tbody>${expiringCerts.length ? certRows : `<tr><td colspan="11" style="${td}text-align:center;color:#475569;">No certificates expiring within ${thresholdDays} days or expired.</td></tr>`}</tbody></table></div>

        <div style="font-size:12px;font-weight:700;color:#991b1b;text-transform:uppercase;margin-bottom:8px;">TABLE 2: EMPLOYEES WITH MISSING / NOT UPLOADED NISM CERTIFICATES (${missingEmployees.length} RECORD${missingEmployees.length === 1 ? '' : 'S'})</div>
        <div style="overflow-x:auto;"><table cellpadding="8" cellspacing="0" width="100%" style="border-collapse:collapse;border:1px solid #cbd5e1;"><thead><tr>
          <th style="${th}">Employee ID</th><th style="${th}">Employee Name</th><th style="${th}">Email</th><th style="${th}">Department</th><th style="${th}">Status</th>
        </tr></thead><tbody>${missingEmployees.length ? missingRows : `<tr><td colspan="5" style="${td}text-align:center;color:#065f46;">All employees in the directory have a matching NISM certificate in Drive.</td></tr>`}</tbody></table></div>
        <div style="margin-top:18px;padding-top:14px;border-top:1px solid #e2e8f0;font-size:11px;color:#64748b;">Generated by FundsIndia Trading &amp; Quality — NISM Certification Compliance Hub (Google Drive).</div>
      </div>
    </div>
  </body></html>`;

  const plainBody = [
    `FundsIndia Trading & Quality — NISM Compliance Alert`,
    `Actioned By: ${actionedBy}`,
    `Expiring/Expired (${expiringCerts.length}):`,
    ...expiringCerts.map((c) => `- ${c.matchedEmployee?.name || c.holderName} | ${c.nismSeries} | ${c.certificateNumber} | Expiry: ${c.expiryDate} (${getExpiryInfo(c.expiryDate, thresholdDays).label}) | ${c.webViewLink}`),
    '',
    `Missing / Not Uploaded (${missingEmployees.length}):`,
    ...missingEmployees.map((e) => `- ${e.empId || '-'} | ${e.name} | ${e.email || '-'} | ${e.department || '-'}`),
  ].join('\n');

  return { to, subject, plainBody, htmlBody };
}

export async function sendEmailViaGmail(token: string, params: { to: string; subject: string; plainBody: string; htmlBody: string }): Promise<void> {
  const boundary = `fi_nism_${Date.now().toString(36)}`;
  const toB64 = (s: string) => btoa(unescape(encodeURIComponent(s)));
  const mime = [
    `To: ${params.to}`,
    `Subject: =?UTF-8?B?${toB64(params.subject)}?=`,
    'MIME-Version: 1.0',
    `Content-Type: multipart/alternative; boundary="${boundary}"`,
    '',
    `--${boundary}`,
    'Content-Type: text/plain; charset="UTF-8"',
    'Content-Transfer-Encoding: base64',
    '',
    toB64(params.plainBody),
    '',
    `--${boundary}`,
    'Content-Type: text/html; charset="UTF-8"',
    'Content-Transfer-Encoding: base64',
    '',
    toB64(params.htmlBody),
    '',
    `--${boundary}--`,
  ].join('\r\n');

  const raw = toB64(mime).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  const r = await fetch(GMAIL_API, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ raw }),
  });
  if (!r.ok) throw await driveErr(r, 'Gmail send failed');
}
