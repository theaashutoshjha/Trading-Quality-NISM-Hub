import * as pdfjs from 'pdfjs-dist';
import workerUrl from 'pdfjs-dist/build/pdf.worker.min.mjs?url';
import { createWorker, type Worker as TesseractWorker } from 'tesseract.js';
import tesseractWorkerUrl from 'tesseract.js/dist/worker.min.js?url';

pdfjs.GlobalWorkerOptions.workerSrc = workerUrl;

export interface EmployeeEntry {
  empId: string;
  name: string;
  email: string;
  department: string;
}

export type CertFileType = 'pdf' | 'image';
export type ExtractionMethod = 'pdf-text' | 'pdf-ocr' | 'image-ocr' | 'manual';
export type AnalysisConfidence = 'high' | 'medium' | 'low';

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
  fileType?: CertFileType;
  mimeType?: string;
  folderName?: string;
  extractionMethod?: ExtractionMethod;
  analysisConfidence?: AnalysisConfidence;
  rawTextSnippet?: string;
  source?: 'drive' | 'local';
  localPreviewUrl?: string;
  passwordProtected?: boolean;
  extractionError?: string;
  team?: string;
  empId?: string;
  email?: string;
  remarks?: string;
  expiryInferred?: boolean;
}

export interface ExpiryInfo {
  status: 'expired' | 'expiring_soon' | 'active' | 'unknown';
  daysRemaining: number;
  label: string;
}

export interface GoogleApiErrorDetails {
  statusCode: number;
  reason: string;
  service: string;
  serviceTitle: string;
  projectId: string;
  activationUrl: string;
  rawMessage: string;
}

export class GoogleApiError extends Error {
  details: GoogleApiErrorDetails;
  constructor(message: string, details: GoogleApiErrorDetails) {
    super(message);
    this.name = 'GoogleApiError';
    this.details = details;
  }
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
export const SHEET_FILE_NAME = 'NISM Compliance Master Sheet';

export const DEFAULT_TEAM_FOLDERS = [
  'Complaince',
  'CS',
  'EQ-OB',
  'Equity',
  'Equity Ops',
  'Gold',
  'MFD- Ban',
  'MFD-Che',
  'OB',
  'OB-TP',
  'Platinum',
  'QA',
  'Silver',
];

export interface DriveTeamFolder {
  id: string;
  name: string;
  webViewLink: string;
}

const CERT_EXT_RE = /\.(pdf|png|jpe?g|webp|bmp|tiff?|gif|jfif|avif)$/i;
const IMAGE_EXT_RE = /\.(png|jpe?g|webp|bmp|tiff?|gif|jfif|avif)$/i;
const IMAGE_MIME_TYPES = new Set([
  'image/png',
  'image/jpeg',
  'image/jpg',
  'image/webp',
  'image/bmp',
  'image/tiff',
  'image/gif',
]);

export function detectCertFileType(fileName: string, mimeType?: string): CertFileType | null {
  const mt = (mimeType || '').toLowerCase();
  if (mt === 'application/pdf' || /\.pdf$/i.test(fileName)) return 'pdf';
  if (IMAGE_MIME_TYPES.has(mt) || mt.startsWith('image/') || IMAGE_EXT_RE.test(fileName)) return 'image';
  return null;
}

export function isSupportedCertFile(fileName: string, mimeType?: string): boolean {
  if (fileName === DIRECTORY_FILE_NAME || fileName === ANALYSIS_CACHE_FILE_NAME) return false;
  return detectCertFileType(fileName, mimeType) !== null || CERT_EXT_RE.test(fileName);
}

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

export function buildApiActivationUrl(service: string, projectId: string): string {
  return `https://console.developers.google.com/apis/api/${encodeURIComponent(service)}/overview?project=${encodeURIComponent(projectId)}`;
}

export function extractProjectIdFromClientId(clientId: string): string {
  const m = clientId.trim().match(/^(\d{6,20})-/);
  return m ? m[1] : '';
}

async function driveErr(res: Response, ctx: string): Promise<Error> {
  const t = await res.text().catch(() => '');
  if (res.status === 401) {
    return new GoogleApiError('Google session expired. Click "Connect Google Drive & Gmail" again.', {
      statusCode: 401,
      reason: 'UNAUTHENTICATED',
      service: '',
      serviceTitle: '',
      projectId: '',
      activationUrl: '',
      rawMessage: t || res.statusText,
    });
  }

  let parsed: any = null;
  try { parsed = JSON.parse(t); } catch { /* ignore */ }
  const errObj = parsed?.error;
  const errInfo = Array.isArray(errObj?.details)
    ? errObj.details.find((d: any) => d?.reason === 'SERVICE_DISABLED' || d?.['@type']?.includes('ErrorInfo'))
    : null;
  const reason = errInfo?.reason || errObj?.errors?.[0]?.reason || '';
  const meta = errInfo?.metadata || {};
  const msg = String(errObj?.message || t || res.statusText);

  if (reason === 'SERVICE_DISABLED' || reason === 'accessNotConfigured' || /has not been used in project .* before or it is disabled/i.test(msg)) {
    const projectId = String(meta.containerInfo || msg.match(/project\s+(\d{6,20})/i)?.[1] || '');
    const service = String(meta.service || (ctx.toLowerCase().includes('gmail') ? 'gmail.googleapis.com' : 'drive.googleapis.com'));
    const serviceTitle = String(meta.serviceTitle || (service.includes('gmail') ? 'Gmail API' : 'Google Drive API'));
    const activationUrl = String(meta.activationUrl || (projectId ? buildApiActivationUrl(service, projectId) : 'https://console.developers.google.com'));
    return new GoogleApiError(
      `${serviceTitle} is disabled on Google Cloud project ${projectId || '(unknown)'}. Enable it in Google Cloud Console, wait ~1–2 minutes, and retry.`,
      {
        statusCode: res.status,
        reason: 'SERVICE_DISABLED',
        service,
        serviceTitle,
        projectId,
        activationUrl,
        rawMessage: msg,
      },
    );
  }

  if (res.status === 403 && (/insufficient/i.test(reason) || /insufficient/i.test(msg))) {
    return new GoogleApiError(
      `${ctx}: Missing Google permission scopes. Click "Reconnect Google Drive & Gmail" and check BOTH Google Drive and Gmail permissions on the consent screen.`,
      {
        statusCode: 403,
        reason: 'INSUFFICIENT_SCOPES',
        service: '',
        serviceTitle: '',
        projectId: '',
        activationUrl: '',
        rawMessage: msg,
      },
    );
  }

  if (res.status === 404) {
    return new GoogleApiError(
      `${ctx}: Drive folder not found or your Google account does not have access to it.`,
      {
        statusCode: 404,
        reason: 'NOT_FOUND',
        service: 'drive.googleapis.com',
        serviceTitle: 'Google Drive API',
        projectId: '',
        activationUrl: '',
        rawMessage: msg,
      },
    );
  }

  return new Error(`${ctx} (${res.status}): ${msg}`);
}

export async function resolveOrCreateFolder(token: string, folderInput?: string): Promise<{ id: string; name: string; webViewLink: string }> {
  const explicitId = extractFolderId(folderInput || '');
  if (explicitId) {
    const r = await fetch(`${DRIVE_API}/files/${encodeURIComponent(explicitId)}?fields=id,name,trashed,webViewLink&supportsAllDrives=true`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    if (!r.ok) throw await driveErr(r, 'Could not open specified Drive folder');
    const d: any = await r.json();
    if (d.trashed) throw new Error('The specified Google Drive folder is in Trash.');
    return { id: d.id, name: d.name, webViewLink: d.webViewLink || `https://drive.google.com/drive/folders/${d.id}` };
  }

  const q = encodeURIComponent(`name='${DEFAULT_FOLDER_NAME}' and mimeType='application/vnd.google-apps.folder' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id,name,webViewLink)&pageSize=5&supportsAllDrives=true&includeItemsFromAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!sr.ok) throw await driveErr(sr, 'Drive folder search failed');
  const sd: any = await sr.json();
  if (sd.files?.[0]?.id) {
    const f = sd.files[0];
    return { id: f.id, name: f.name, webViewLink: f.webViewLink || `https://drive.google.com/drive/folders/${f.id}` };
  }

  const cr = await fetch(`${DRIVE_API}/files?fields=id,name,webViewLink&supportsAllDrives=true`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ name: DEFAULT_FOLDER_NAME, mimeType: 'application/vnd.google-apps.folder' }),
  });
  if (!cr.ok) throw await driveErr(cr, 'Could not create Drive folder');
  const c: any = await cr.json();
  return { id: c.id, name: c.name, webViewLink: c.webViewLink || `https://drive.google.com/drive/folders/${c.id}` };
}

export interface DriveListedFile {
  id: string;
  name: string;
  mimeType: string;
  fileType: CertFileType;
  webViewLink: string;
  modifiedTime?: string;
  folderName?: string;
}

export async function listDriveCertificates(token: string, folderId: string): Promise<DriveListedFile[]> {
  const out: DriveListedFile[] = [];
  const queue: Array<{ id: string; name: string; depth: number }> = [{ id: folderId, name: '', depth: 0 }];
  const seen = new Set<string>();

  while (queue.length) {
    const cur = queue.shift()!;
    if (seen.has(cur.id)) continue;
    seen.add(cur.id);

    let pageToken = '';
    do {
      const q = encodeURIComponent(`'${cur.id}' in parents and trashed=false`);
      const url = `${DRIVE_API}/files?q=${q}&orderBy=modifiedTime desc&fields=nextPageToken,files(id,name,mimeType,webViewLink,modifiedTime,shortcutDetails(targetId,targetMimeType))&pageSize=500&supportsAllDrives=true&includeItemsFromAllDrives=true${pageToken ? '&pageToken=' + encodeURIComponent(pageToken) : ''}`;
      const r = await fetch(url, { headers: { Authorization: `Bearer ${token}` } });
      if (!r.ok) throw await driveErr(r, 'Failed to list certificates in Drive folder');
      const d: any = await r.json();
      for (const f of (d.files || [])) {
        const fname = String(f.name || '');
        const isShortcut = f.mimeType === 'application/vnd.google-apps.shortcut' && f.shortcutDetails?.targetId;
        const targetId = isShortcut ? String(f.shortcutDetails.targetId) : String(f.id);
        const mt = isShortcut ? String(f.shortcutDetails.targetMimeType || '') : String(f.mimeType || '');
        if (mt === 'application/vnd.google-apps.folder') {
          if (cur.depth < 8) {
            const subPath = cur.name ? `${cur.name} / ${fname}` : fname;
            queue.push({ id: targetId, name: subPath, depth: cur.depth + 1 });
          }
        } else if (isSupportedCertFile(fname, mt)) {
          const ft = detectCertFileType(fname, mt) || 'pdf';
          out.push({
            id: targetId,
            name: fname || (ft === 'image' ? 'Certificate.png' : 'Certificate.pdf'),
            mimeType: mt || (ft === 'image' ? 'image/png' : 'application/pdf'),
            fileType: ft,
            webViewLink: f.webViewLink || `https://drive.google.com/file/d/${targetId}/view`,
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

export const listDrivePdfs = listDriveCertificates;

export async function uploadCertificateToDrive(token: string, folderId: string, file: File): Promise<{ id: string; name: string; mimeType: string; webViewLink: string }> {
  const bytes = new Uint8Array(await file.arrayBuffer());
  const mime = file.type || (IMAGE_EXT_RE.test(file.name) ? 'image/png' : 'application/pdf');
  const boundary = `fi_nism_${Date.now()}`;
  const meta = JSON.stringify({ name: file.name, parents: [folderId] });
  const enc = new TextEncoder();
  const pre = enc.encode(`--${boundary}\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n${meta}\r\n--${boundary}\r\nContent-Type: ${mime}\r\n\r\n`);
  const end = enc.encode(`\r\n--${boundary}--`);
  const body = new Uint8Array(pre.length + bytes.length + end.length);
  body.set(pre, 0); body.set(bytes, pre.length); body.set(end, pre.length + bytes.length);

  const r = await fetch(`${DRIVE_UPLOAD}/files?uploadType=multipart&fields=id,name,mimeType,webViewLink&supportsAllDrives=true`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': `multipart/related; boundary=${boundary}` },
    body,
  });
  if (!r.ok) throw await driveErr(r, 'Upload to Drive failed');
  const d: any = await r.json();
  return {
    id: d.id,
    name: d.name,
    mimeType: d.mimeType || mime,
    webViewLink: d.webViewLink || `https://drive.google.com/file/d/${d.id}/view`,
  };
}

export const uploadPdfToDrive = uploadCertificateToDrive;

export async function downloadDriveFileBytes(token: string, fileId: string): Promise<Uint8Array> {
  const r = await fetch(`${DRIVE_API}/files/${encodeURIComponent(fileId)}?alt=media&supportsAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!r.ok) throw await driveErr(r, 'Download from Drive failed');
  return new Uint8Array(await r.arrayBuffer());
}

export async function loadJsonFromDrive<T>(token: string, folderId: string, fileName: string): Promise<T | null> {
  const q = encodeURIComponent(`'${folderId}' in parents and name='${fileName}' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id)&pageSize=1&supportsAllDrives=true&includeItemsFromAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!sr.ok) return null;
  const sd: any = await sr.json();
  const id = sd.files?.[0]?.id;
  if (!id) return null;
  const dr = await fetch(`${DRIVE_API}/files/${encodeURIComponent(id)}?alt=media&supportsAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!dr.ok) return null;
  try { return (await dr.json()) as T; } catch { return null; }
}

export async function saveJsonToDrive(token: string, folderId: string, fileName: string, data: unknown): Promise<void> {
  const q = encodeURIComponent(`'${folderId}' in parents and name='${fileName}' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&fields=files(id)&pageSize=1&supportsAllDrives=true&includeItemsFromAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  const sd: any = sr.ok ? await sr.json() : { files: [] };
  const existingId = sd.files?.[0]?.id;
  const jsonText = JSON.stringify(data, null, 2);

  if (existingId) {
    const ur = await fetch(`${DRIVE_UPLOAD}/files/${encodeURIComponent(existingId)}?uploadType=media&supportsAllDrives=true`, {
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
  const cr = await fetch(`${DRIVE_UPLOAD}/files?uploadType=multipart&fields=id&supportsAllDrives=true`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': `multipart/related; boundary=${boundary}` },
    body,
  });
  if (!cr.ok) throw await driveErr(cr, `Failed to save ${fileName} in Drive`);
}

export async function listDriveTeamFolders(token: string, rootFolderId: string): Promise<DriveTeamFolder[]> {
  const out: DriveTeamFolder[] = [];
  let pageToken = '';
  do {
    const q = encodeURIComponent(`'${rootFolderId}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`);
    const url = `${DRIVE_API}/files?q=${q}&orderBy=name&fields=nextPageToken,files(id,name,webViewLink)&pageSize=200&supportsAllDrives=true&includeItemsFromAllDrives=true${pageToken ? '&pageToken=' + encodeURIComponent(pageToken) : ''}`;
    const r = await fetch(url, { headers: { Authorization: `Bearer ${token}` } });
    if (!r.ok) throw await driveErr(r, 'Failed to list team folders in Drive');
    const d: any = await r.json();
    for (const f of (d.files || [])) {
      out.push({
        id: String(f.id),
        name: String(f.name || ''),
        webViewLink: f.webViewLink || `https://drive.google.com/drive/folders/${f.id}`,
      });
    }
    pageToken = d.nextPageToken || '';
  } while (pageToken);
  return out;
}

export async function ensureDriveSubfolder(token: string, rootFolderId: string, teamName: string): Promise<DriveTeamFolder> {
  const clean = teamName.trim();
  if (!clean) throw new Error('Team folder name is required.');
  const existing = await listDriveTeamFolders(token, rootFolderId);
  const found = existing.find((f) => f.name.trim().toLowerCase() === clean.toLowerCase());
  if (found) return found;

  const cr = await fetch(`${DRIVE_API}/files?fields=id,name,webViewLink&supportsAllDrives=true`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      name: clean,
      parents: [rootFolderId],
      mimeType: 'application/vnd.google-apps.folder',
    }),
  });
  if (!cr.ok) throw await driveErr(cr, `Could not create team folder "${clean}" in Drive`);
  const c: any = await cr.json();
  return { id: c.id, name: c.name, webViewLink: c.webViewLink || `https://drive.google.com/drive/folders/${c.id}` };
}

export interface DriveSheetRef {
  id: string;
  name: string;
  webViewLink: string;
}

export async function findDriveSheet(token: string, rootFolderId: string): Promise<DriveSheetRef | null> {
  const q = encodeURIComponent(`'${rootFolderId}' in parents and mimeType='application/vnd.google-apps.spreadsheet' and trashed=false`);
  const sr = await fetch(`${DRIVE_API}/files?q=${q}&orderBy=modifiedTime desc&fields=files(id,name,webViewLink)&pageSize=10&supportsAllDrives=true&includeItemsFromAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!sr.ok) return null;
  const sd: any = await sr.json();
  const files: any[] = sd.files || [];
  const match = files.find((f) => String(f.name || '').toLowerCase() === SHEET_FILE_NAME.toLowerCase()) || files[0];
  if (!match?.id) return null;
  return {
    id: String(match.id),
    name: String(match.name || SHEET_FILE_NAME),
    webViewLink: match.webViewLink || `https://docs.google.com/spreadsheets/d/${match.id}/edit`,
  };
}

export async function syncCertsToDriveSheet(
  token: string,
  rootFolderId: string,
  certs: DriveCertRecord[],
  missingEmployees: EmployeeEntry[],
  thresholdDays: number,
  existingSheetId?: string,
): Promise<DriveSheetRef> {
  const csv = buildComplianceCsv(certs, missingEmployees, thresholdDays);
  const sheetId = existingSheetId || (await findDriveSheet(token, rootFolderId))?.id;

  if (sheetId) {
    const ur = await fetch(`${DRIVE_UPLOAD}/files/${encodeURIComponent(sheetId)}?uploadType=media&fields=id,name,webViewLink&supportsAllDrives=true`, {
      method: 'PATCH',
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'text/csv; charset=UTF-8' },
      body: csv,
    });
    if (ur.ok) {
      const d: any = await ur.json();
      return {
        id: String(d.id || sheetId),
        name: String(d.name || SHEET_FILE_NAME),
        webViewLink: d.webViewLink || `https://docs.google.com/spreadsheets/d/${sheetId}/edit`,
      };
    }
  }

  const boundary = `fi_sheet_${Date.now()}`;
  const meta = JSON.stringify({
    name: SHEET_FILE_NAME,
    parents: [rootFolderId],
    mimeType: 'application/vnd.google-apps.spreadsheet',
  });
  const body = `--${boundary}\r\nContent-Type: application/json; charset=UTF-8\r\n\r\n${meta}\r\n--${boundary}\r\nContent-Type: text/csv; charset=UTF-8\r\n\r\n${csv}\r\n--${boundary}--`;
  const cr = await fetch(`${DRIVE_UPLOAD}/files?uploadType=multipart&fields=id,name,webViewLink&supportsAllDrives=true`, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': `multipart/related; boundary=${boundary}` },
    body,
  });
  if (!cr.ok) throw await driveErr(cr, 'Failed to create Google Sheet in Drive');
  const created: any = await cr.json();
  return {
    id: String(created.id),
    name: String(created.name || SHEET_FILE_NAME),
    webViewLink: created.webViewLink || `https://docs.google.com/spreadsheets/d/${created.id}/edit`,
  };
}

function parseCsvRows(csvText: string): string[][] {
  const rows: string[][] = [];
  let row: string[] = [];
  let cell = '';
  let inQuotes = false;
  for (let i = 0; i < csvText.length; i++) {
    const ch = csvText[i];
    if (inQuotes) {
      if (ch === '"' && csvText[i + 1] === '"') {
        cell += '"';
        i++;
      } else if (ch === '"') {
        inQuotes = false;
      } else {
        cell += ch;
      }
    } else if (ch === '"') {
      inQuotes = true;
    } else if (ch === ',') {
      row.push(cell);
      cell = '';
    } else if (ch === '\r' || ch === '\n') {
      if (ch === '\r' && csvText[i + 1] === '\n') i++;
      row.push(cell);
      if (row.some((c) => c.trim() !== '')) rows.push(row);
      row = [];
      cell = '';
    } else {
      cell += ch;
    }
  }
  row.push(cell);
  if (row.some((c) => c.trim() !== '')) rows.push(row);
  return rows;
}

export async function importCertsFromDriveSheet(token: string, sheetId: string): Promise<DriveCertRecord[]> {
  const r = await fetch(`${DRIVE_API}/files/${encodeURIComponent(sheetId)}/export?mimeType=text/csv&supportsAllDrives=true`, {
    headers: { Authorization: `Bearer ${token}` },
  });
  if (!r.ok) throw await driveErr(r, 'Failed to read Google Sheet');
  const csv = await r.text();
  const rows = parseCsvRows(csv);
  if (rows.length < 2) return [];
  const hdr = rows[0].map((h) => h.trim().toLowerCase());
  const idx = (name: string) => hdr.findIndex((h) => h.includes(name));
  const iType = idx('record type');
  const iTeam = idx('team');
  const iEmpId = idx('employee id');
  const iName = idx('name');
  const iEmail = idx('email');
  const iSeries = idx('nism series');
  const iCert = idx('certificate #');
  const iEnrol = idx('enrolment #');
  const iExamType = idx('exam type');
  const iExamDate = idx('exam date');
  const iExpiry = idx('expiry date');
  const iMarks = hdr.findIndex((h) => h === 'marks');
  const iTotal = idx('total marks');
  const iPct = idx('percentage');
  const iPass = idx('pass status');
  const iFmt = idx('file format');
  const iMethod = idx('extraction method');
  const iConf = idx('confidence');
  const iFile = idx('file name');
  const iLink = idx('link');
  const iRemarks = idx('remarks');

  const out: DriveCertRecord[] = [];
  for (let rIdx = 1; rIdx < rows.length; rIdx++) {
    const cols = rows[rIdx];
    const get = (k: number) => (k >= 0 && k < cols.length ? cols[k].trim() : '');
    const recType = get(iType).toUpperCase();
    if (recType === 'MISSING_EMPLOYEE') continue;
    const holderName = get(iName);
    if (!holderName) continue;
    const fileName = get(iFile) || `${holderName}.pdf`;
    const webViewLink = get(iLink);
    const idFromLink = webViewLink.match(/\/d\/([a-zA-Z0-9_-]+)/)?.[1] || '';
    const marksObtained = Number(get(iMarks)) || 0;
    const totalMarks = Number(get(iTotal)) || 100;
    const percentage = Number(get(iPct)) || (totalMarks > 0 ? Math.round((marksObtained / totalMarks) * 10000) / 100 : 0);
    const team = get(iTeam);
    out.push({
      fileId: idFromLink || `sheet_${rIdx}_${fileName}`,
      fileName,
      webViewLink,
      holderName,
      team: team || undefined,
      folderName: team || undefined,
      empId: get(iEmpId) || undefined,
      email: get(iEmail) || undefined,
      nismSeries: get(iSeries) || 'NISM Certification',
      certificateNumber: get(iCert) || '—',
      enrolmentNumber: get(iEnrol) || '—',
      examDate: parseDateIso(get(iExamDate)) || get(iExamDate),
      expiryDate: parseDateIso(get(iExpiry)) || get(iExpiry),
      marksObtained,
      totalMarks,
      percentage,
      passStatus: get(iPass).toUpperCase() === 'FAIL' ? 'FAIL' : 'PASS',
      cpeOrExamType: get(iExamType) || 'Certification Examination',
      fileType: get(iFmt).toLowerCase() === 'image' ? 'image' : 'pdf',
      extractionMethod: (get(iMethod) as ExtractionMethod) || 'manual',
      analysisConfidence: (get(iConf) as AnalysisConfidence) || 'high',
      remarks: get(iRemarks) || undefined,
      source: webViewLink ? 'drive' : 'local',
    });
  }
  return out;
}

/* ---------- PDF & Image Text / OCR Extraction ---------- */
const MONTHS: Record<string, string> = {
  jan: '01', january: '01', feb: '02', february: '02', mar: '03', march: '03', apr: '04', april: '04',
  may: '05', jun: '06', june: '06', jul: '07', july: '07', aug: '08', august: '08',
  sep: '09', sept: '09', september: '09', oct: '10', october: '10', nov: '11', november: '11', dec: '12', december: '12',
};

export function parseDateIso(input?: string): string {
  if (!input) return '';
  const s = input
    .trim()
    .replace(/(\d{1,2})(st|nd|rd|th)\b/gi, '$1')
    .replace(/[,]+/g, ' ')
    .replace(/\s+/g, ' ');
  const expandYear = (y: number) => (y < 100 ? 2000 + y : y);
  let m = /^(\d{4})[\/\-.](\d{1,2})[\/\-.](\d{1,2})$/.exec(s);
  if (m) return validateIsoDate(+m[1], +m[2], +m[3]);
  m = /^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{2}|\d{4})$/.exec(s);
  if (m) return validateIsoDate(expandYear(+m[3]), +m[2], +m[1]);
  m = /^(\d{1,2})[\s\-\/.]+([A-Za-z]+)[\s\-\/.]+(\d{2}|\d{4})$/.exec(s);
  if (m) {
    const mon = MONTHS[m[2].toLowerCase()] || MONTHS[m[2].toLowerCase().slice(0, 3)];
    if (mon) return validateIsoDate(expandYear(+m[3]), +mon, +m[1]);
  }
  m = /^([A-Za-z]+)[\s\-\/.]+(\d{1,2})[\s\-\/.]+(\d{2}|\d{4})$/.exec(s);
  if (m) {
    const mon = MONTHS[m[1].toLowerCase()] || MONTHS[m[1].toLowerCase().slice(0, 3)];
    if (mon) return validateIsoDate(expandYear(+m[3]), +mon, +m[2]);
  }
  return '';
}

function addYearsMinusOneDay(isoDate: string, years: number): string {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(isoDate)) return '';
  const [y, m, d] = isoDate.split('-').map(Number);
  const dt = new Date(Date.UTC(y + years, m - 1, d));
  dt.setUTCDate(dt.getUTCDate() - 1);
  return dt.toISOString().slice(0, 10);
}

function validateIsoDate(y: number, m: number, d: number): string {
  if (y < 1990 || y > 2100 || m < 1 || m > 12 || d < 1 || d > 31) return '';
  return `${String(y).padStart(4, '0')}-${String(m).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
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

/** Extract line-preserving text from PDF using pdfjs-dist */
export async function extractPdfText(bytes: Uint8Array, password?: string): Promise<string> {
  // Clone bytes because pdfjs transfers the underlying ArrayBuffer to its worker
  const doc = await pdfjs.getDocument({ data: bytes.slice(), password }).promise;
  const pages: string[] = [];
  for (let p = 1; p <= Math.min(3, doc.numPages); p++) {
    const page = await doc.getPage(p);
    const tc = await page.getTextContent();
    const lines: string[] = [];
    let curLine = '';
    let lastY: number | null = null;
    for (const rawItem of tc.items as any[]) {
      const s = String(rawItem?.str || '');
      const y = Array.isArray(rawItem?.transform) ? Number(rawItem.transform[5]) : null;
      if (lastY !== null && y !== null && Math.abs(y - lastY) > 4) {
        if (curLine.trim()) lines.push(curLine.trim());
        curLine = s;
      } else {
        curLine += (curLine && s && !curLine.endsWith(' ') && !s.startsWith(' ') ? ' ' : '') + s;
      }
      if (y !== null) lastY = y;
      if (rawItem?.hasEOL) {
        if (curLine.trim()) lines.push(curLine.trim());
        curLine = '';
        lastY = null;
      }
    }
    if (curLine.trim()) lines.push(curLine.trim());
    pages.push(lines.join('\n'));
  }
  await doc.destroy();
  return pages.join('\n').trim();
}

async function renderPdfPagesToCanvases(bytes: Uint8Array, maxPages = 2, password?: string): Promise<HTMLCanvasElement[]> {
  const doc = await pdfjs.getDocument({ data: bytes.slice(), password }).promise;
  const canvases: HTMLCanvasElement[] = [];
  try {
    const count = Math.min(maxPages, doc.numPages);
    for (let p = 1; p <= count; p++) {
      const page = await doc.getPage(p);
      const viewport = page.getViewport({ scale: 2.2 });
      const canvas = document.createElement('canvas');
      canvas.width = Math.ceil(viewport.width);
      canvas.height = Math.ceil(viewport.height);
      const ctx = canvas.getContext('2d');
      if (ctx) {
        ctx.fillStyle = '#ffffff';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        await page.render({ canvasContext: ctx, viewport }).promise;
        canvases.push(canvas);
      }
    }
  } finally {
    await doc.destroy();
  }
  return canvases;
}

async function imageBytesToPreprocessedCanvas(bytes: Uint8Array, mimeType: string): Promise<HTMLCanvasElement> {
  const blob = new Blob([bytes.slice()], { type: mimeType || 'image/png' });
  const url = URL.createObjectURL(blob);
  try {
    const img = await new Promise<HTMLImageElement>((resolve, reject) => {
      const el = new Image();
      el.onload = () => resolve(el);
      el.onerror = () => reject(new Error('Could not decode certificate image.'));
      el.src = url;
    });
    const minTargetW = 1600;
    const scale = img.naturalWidth < minTargetW ? Math.min(3, minTargetW / Math.max(1, img.naturalWidth)) : 1;
    const w = Math.round(img.naturalWidth * scale);
    const h = Math.round(img.naturalHeight * scale);
    const canvas = document.createElement('canvas');
    canvas.width = w;
    canvas.height = h;
    const ctx = canvas.getContext('2d');
    if (ctx) {
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(0, 0, w, h);
      // Slight contrast boost + grayscale helps Tesseract read scanned NISM certificates cleanly
      ctx.filter = 'grayscale(100%) contrast(125%)';
      ctx.drawImage(img, 0, 0, w, h);
    }
    return canvas;
  } finally {
    URL.revokeObjectURL(url);
  }
}

let ocrWorkerPromise: Promise<TesseractWorker> | null = null;
let ocrProgressCb: ((pct: number) => void) | null = null;

async function getOcrWorker(): Promise<TesseractWorker> {
  if (!ocrWorkerPromise) {
    ocrWorkerPromise = createWorker('eng', 1, {
      workerPath: tesseractWorkerUrl,
      workerBlobURL: false,
      logger: (m) => {
        if (m.status === 'recognizing text' && typeof m.progress === 'number' && ocrProgressCb) {
          ocrProgressCb(Math.round(m.progress * 100));
        }
      },
    }).catch((err) => {
      ocrWorkerPromise = null;
      throw err;
    });
  }
  return ocrWorkerPromise;
}

async function runOcrOnCanvases(canvases: HTMLCanvasElement[], onProgress?: (pct: number) => void): Promise<string> {
  if (!canvases.length) return '';
  const worker = await getOcrWorker();
  const texts: string[] = [];
  for (let i = 0; i < canvases.length; i++) {
    ocrProgressCb = onProgress
      ? (p) => onProgress(Math.round(((i + p / 100) / canvases.length) * 100))
      : null;
    try {
      const res = await worker.recognize(canvases[i]);
      if (res?.data?.text) texts.push(res.data.text);
    } finally {
      ocrProgressCb = null;
    }
  }
  return texts.join('\n').trim();
}

function isPasswordError(e: unknown): boolean {
  const err = e as { name?: string; message?: string } | null;
  const msg = String(err?.message || e || '');
  return err?.name === 'PasswordException' || /no password given|incorrect password|password/i.test(msg);
}

export async function analyseCertificateBytes(params: {
  bytes: Uint8Array;
  fileName: string;
  mimeType?: string;
  password?: string;
  onProgress?: (stage: string) => void;
}): Promise<Omit<DriveCertRecord, 'fileId' | 'fileName' | 'webViewLink'>> {
  const { bytes, fileName, mimeType, password, onProgress } = params;
  const fileType: CertFileType = detectCertFileType(fileName, mimeType) || 'pdf';

  let text = '';
  let extractionMethod: ExtractionMethod = fileType === 'image' ? 'image-ocr' : 'pdf-text';
  let passwordProtected = false;
  let extractionError = '';

  if (fileType === 'pdf') {
    onProgress?.('Extracting PDF text…');
    try {
      text = await extractPdfText(bytes, password);
    } catch (e: any) {
      if (isPasswordError(e)) {
        passwordProtected = true;
        extractionError = password ? 'Incorrect PDF password.' : 'Password-protected PDF (No password given). Click Edit to unlock or enter details.';
      } else {
        extractionError = String(e?.message || 'PDF text read failed.');
      }
      text = '';
    }
    if (!passwordProtected && text.replace(/\s+/g, '').length < 40) {
      onProgress?.('Scanned PDF detected — running OCR…');
      try {
        const canvases = await renderPdfPagesToCanvases(bytes, 2, password);
        const ocrText = await runOcrOnCanvases(canvases, (pct) => onProgress?.(`OCR on scanned PDF (${pct}%)…`));
        if (ocrText.trim().length > text.trim().length) {
          text = ocrText;
          extractionMethod = 'pdf-ocr';
        }
      } catch (e: any) {
        if (isPasswordError(e)) {
          passwordProtected = true;
          extractionError = password ? 'Incorrect PDF password.' : 'Password-protected PDF (No password given). Click Edit to unlock or enter details.';
        }
      }
    }
  } else {
    onProgress?.('Preparing image for OCR…');
    try {
      const canvas = await imageBytesToPreprocessedCanvas(bytes, mimeType || 'image/png');
      onProgress?.('Running OCR on image (0%)…');
      text = await runOcrOnCanvases([canvas], (pct) => onProgress?.(`Running OCR on image (${pct}%)…`));
      extractionMethod = 'image-ocr';
    } catch (e: any) {
      extractionError = String(e?.message || 'Image OCR failed.');
      text = '';
    }
  }

  const parsed = parseNismCertificateText(text, fileName);
  return {
    ...parsed,
    fileType,
    mimeType: mimeType || (fileType === 'image' ? 'image/png' : 'application/pdf'),
    extractionMethod,
    analysisConfidence: passwordProtected ? 'low' : parsed.analysisConfidence,
    rawTextSnippet: text.slice(0, 1500),
    ...(passwordProtected ? { passwordProtected: true } : {}),
    ...(extractionError ? { extractionError } : {}),
  };
}

function normalizeOcrText(raw: string): string {
  return raw
    .replace(/\r/g, '')
    .replace(/\bN[1lI]SM\b/g, 'NISM')
    .replace(/\bVa[1l]id\b/gi, 'Valid')
    .replace(/\bCert[1l]ficate\b/gi, 'Certificate')
    .replace(/\bEnro[1l]+ment\b/gi, 'Enrolment')
    .replace(/[|]+/g, ' ')
    .replace(/[ \t]+/g, ' ')
    .trim();
}

export function parseNismCertificateText(rawText: string, fileName: string): Omit<DriveCertRecord, 'fileId' | 'fileName' | 'webViewLink'> {
  const lineText = normalizeOcrText(rawText);
  const clean = lineText.replace(/\s+/g, ' ').trim();

  // Certificate / Registration number
  const certNum = (
    clean.match(/\b(NISM[-\s]*\d{8,14})\b/i)?.[1]?.replace(/\s+/g, '') ||
    clean.match(/(?:Certificate|Cert\.?|Registration)\s*(?:No|Number)\.?\s*[:\-]?\s*([A-Z0-9-]{6,25})/i)?.[1] ||
    ''
  ).toUpperCase();

  // Enrolment number (prefer explicit Enrolment No; only fall back to Reg No if distinct from certNum)
  const enrolExplicit = clean.match(/Enrol+ment\s*(?:No|Number)\.?\s*[:\-]?\s*([A-Z0-9-]{5,18})/i)?.[1] || '';
  const enrolFallback = clean.match(/(?:Registration|Reg\.?)\s*(?:No|Number)\.?\s*[:\-]?\s*([A-Z0-9-]{5,18})/i)?.[1] || '';
  const enrol = (enrolExplicit || (enrolFallback.toUpperCase() !== certNum ? enrolFallback : '')).toUpperCase();

  // NISM Series
  const seriesMatch =
    lineText.match(/(NISM[-\s]*Series[-\s]*(?:XXIV|XXIII|XXII|XXI[-\s]*[AB]|XIX[-\s]*[ABC]|XVII|XVI|XV|XIII|XII|X[-\s]*[ABC]|IX|VIII|VII|VI|V[-\s]*[ABCD]|IV|III[-\s]*[AB]|II[-\s]*[AB]|I)\b(?:[^\n"”]{0,80}))/i) ||
    clean.match(/(NISM[-\s]*Series[-\s]*[IVX0-9A-Z-]+(?:\s*[:\-]\s*[^.\n"”]{4,60})?)/i);
  let series = seriesMatch?.[1]?.replace(/\s+/g, ' ').trim() || '';
  if (series) {
    series = series
      .replace(/^(NISM)[-\s]*(Series)[-\s]*/i, '$1-$2-')
      .replace(/["”']+\s*(?:as\s+requi.*|required\s+under.*)$/i, '')
      .replace(/\s+as\s+required\s+under.*$/i, '')
      .replace(/["”']+$/g, '')
      .replace(/\s+(?:Certificate|Valid|Enrol.*|Test\s+Date.*)$/i, '')
      .trim();
  }
  const hasExplicitSeries = Boolean(series);
  if (!series) {
    const fnSeries = fileName.match(/(?:Series|NISM)[-\s_]*([IVX]+[-\s_]*[AB]?)/i);
    series = fnSeries ? `NISM-Series-${fnSeries[1].replace(/[_\s]+/g, '-').toUpperCase()}` : 'NISM Certification';
  }

  // Holder Name
  let holderName = '';
  const namePatterns = [
    /This\s+is\s+to\s+certify\s+that\s+(?:Mr\.?\s*\/\s*Ms\.?|Mr\.?|Ms\.?|Mrs\.?|Shri\.?|Smt\.?|Dr\.?)?\s*([A-Za-z][A-Za-z\s.]{2,60}?)(?=\s*(?:\(|has|bearing|having|Enrol|Registration|PAN|S\/O|D\/O|W\/O|NISM|successfully|cleared|passed|completed))/i,
    /(?:Candidate\s*Name|Name\s*of\s*(?:the\s*)?(?:Candidate|Participant|Holder|Examinee))\s*[:\-]?\s*(?:Mr\.?\s*\/\s*Ms\.?|Mr\.?|Ms\.?|Mrs\.?|Shri\.?)?\s*([A-Za-z][A-Za-z\s.]{2,60}?)(?=\s*(?:\n|\(|Enrol|Reg|Certificate|NISM|Date|Marks|PAN|Father))/i,
    /(?:Awarded\s+to|Presented\s+to)\s+(?:Mr\.?\s*\/\s*Ms\.?|Mr\.?|Ms\.?|Mrs\.?)?\s*([A-Za-z][A-Za-z\s.]{2,60}?)(?=\s*(?:\n|has|for|NISM|Certificate))/i,
    /(?:Mr\.?\s*\/\s*Ms\.?|Mrs\.?|Mr\.?|Ms\.?|Shri\.?|Smt\.?)\s+([A-Z][A-Za-z\s.]{2,60}?)(?=\s*(?:\n|\(|PAN|Registration|Enrol|has\s+successfully|has\s+passed|bearing))/i,
  ];
  for (const re of namePatterns) {
    const m = lineText.match(re) || clean.match(re);
    if (m?.[1]) {
      const candidate = m[1].replace(/\s+/g, ' ').replace(/[.,:;\-]+$/, '').trim();
      if (candidate.length >= 3 && !/^(nism|certificate|series|examination)$/i.test(candidate)) {
        holderName = candidate;
        break;
      }
    }
  }
  const hasNameFromText = Boolean(holderName);
  if (!holderName) {
    holderName = fileName.replace(CERT_EXT_RE, '').replace(/[_-]+/g, ' ').trim();
  }

  // Dates (supports DD-MMM-YYYY, Month DD, YYYY, DD/MM/YYYY, YYYY-MM-DD, 2-digit years, prose, & multi-line PDF tables)
  const monPat = '(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:t(?:ember)?)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)';
  const dateTok = `(?:\\d{1,2}(?:st|nd|rd|th)?[\\s\\-\\/.,]+${monPat}[.,]?[\\s\\-\\/.,]+\\d{2,4}|${monPat}[.,]?[\\s\\-\\/.]+\\d{1,2}(?:st|nd|rd|th)?[.,]?[\\s\\-\\/.,]+\\d{2,4}|\\d{1,2}[\\/\\-.]\\d{1,2}[\\/\\-.]\\d{2,4}|\\d{4}[\\/\\-.]\\d{1,2}[\\/\\-.]\\d{1,2})`;

  // Official bilingual NISM certificate table row: "<Test Date> <Test Centre> <Language> <Marks> <PASS|FAIL>"
  const tableRowM = lineText.match(
    new RegExp(`(${dateTok})\\s+[^\\n]{2,70}?\\s+(?:English|Hindi|Gujarati|Marathi|Tamil|Telugu|Kannada|Malayalam|Bengali|Punjabi|Odia)\\s+(\\d{1,3}(?:\\.\\d{1,2})?)\\s+(PASS|FAIL)\\b`, 'i'),
  );

  const validRangeM = clean.match(new RegExp(`(?:Valid\\s+from|Validity\\s*(?:Period)?\\s*[:\\-]?)\\s*(${dateTok})\\s*(?:to|till|until|\\-)\\s*(${dateTok})`, 'i'));
  const examRaw =
    tableRowM?.[1] ||
    validRangeM?.[1] ||
    clean.match(new RegExp(`(?:Test\\s*Date|Exam(?:ination)?\\s*Date|Date\\s+of\\s+(?:Exam(?:ination)?|Test|Passing|Issue|Completion)|CPE\\s*(?:Program\\s*)?Date|Issue\\s*Date|Program\\s*Date)\\s*[:\\-;]?\\s*(${dateTok})`, 'i'))?.[1] ||
    clean.match(new RegExp(`(?:held|conducted|passed|completed|issued|dated)\\s+on\\s*(${dateTok})`, 'i'))?.[1] ||
    '';
  const expRaw =
    validRangeM?.[2] ||
    clean.match(new RegExp(`(?:Valid\\s*(?:Till|Til|Upto|Up\\s*to|Until|Through)|Validity(?:\\s*(?:Date|Till|Upto|Up\\s*to|of\\s+Certificate))?|Expiry\\s*Date|Expires\\s*on)\\s*[:\\-;]?\\s*(${dateTok})`, 'i'))?.[1] ||
    '';
  let examDate = parseDateIso(examRaw);
  let expiryDate = parseDateIso(expRaw);
  let expiryInferred = false;

  // Multi-line table header fallback (bilingual PDF tables can have 6–12 header lines before the values row)
  if (!examDate || !expiryDate) {
    const lines = lineText.split('\n').map((l) => l.trim()).filter(Boolean);
    for (let li = 0; li < lines.length; li++) {
      const hdr = lines[li];
      const lookahead = lines.slice(li + 1, li + 14).join(' ');
      if (!examDate && /(?:Test\s*Date|Exam(?:ination)?\s*Date|Date\s+of\s+(?:Exam|Test|Passing|Issue))/i.test(hdr)) {
        const d = (lookahead.match(new RegExp(dateTok, 'gi')) || []).map(parseDateIso).find(Boolean);
        if (d) examDate = d;
      }
      if (!expiryDate && /(?:Valid\s*(?:Till|Til|Upto|Up\s*to)|Validity|Expiry)/i.test(hdr)) {
        const datesInNext = (lookahead.match(new RegExp(dateTok, 'gi')) || []).map(parseDateIso).filter(Boolean);
        if (datesInNext.length) expiryDate = datesInNext[datesInNext.length - 1];
      }
    }
  }

  if (!examDate || !expiryDate) {
    const allDates = Array.from(new Set((clean.match(new RegExp(dateTok, 'gi')) || []).map(parseDateIso).filter(Boolean))).sort();
    if (!examDate && allDates.length >= 1) examDate = allDates[0];
    if (!expiryDate && allDates.length >= 2) {
      const later = allDates.filter((d) => !examDate || d > examDate);
      expiryDate = later.length ? later[later.length - 1] : allDates[allDates.length - 1];
    }
  }

  // NISM standard 3-year validity rule when certificate states "three years" / "3 years" and only examDate is printed
  if (examDate && !expiryDate && /(?:valid\s+for\s+(?:a\s+period\s+of\s+)?(?:three|3)\s+years|validity\s*[:\-]?\s*(?:three|3)\s+years|(?:three|3)\s+years\s+from\s+the\s+date)/i.test(clean)) {
    expiryDate = addYearsMinusOneDay(examDate, 3);
    expiryInferred = Boolean(expiryDate);
  }

  // Marks & Percentage
  let marksObtained = 0, totalMarks = 100, percentage = 0;
  const scoreM =
    clean.match(/(?:Marks\s*(?:Obtained|Scored)|Total\s*Marks|Score)\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*(?:out\s+of|\/)\s*(\d+(?:\.\d+)?)/i) ||
    clean.match(/(\d+(?:\.\d+)?)\s*(?:out\s+of|\/)\s*(100|50|60|80|120|150|200)\b/i);
  if (scoreM) {
    marksObtained = Number(scoreM[1]);
    totalMarks = Number(scoreM[2]) || 100;
    percentage = totalMarks > 0 ? Math.round((marksObtained / totalMarks) * 10000) / 100 : 0;
  } else if (tableRowM?.[2]) {
    marksObtained = Number(tableRowM[2]);
    totalMarks = marksObtained > 100 ? 150 : 100;
    percentage = totalMarks > 0 ? Math.round((marksObtained / totalMarks) * 10000) / 100 : 0;
  } else {
    const obtM = clean.match(/(?:Marks\s*(?:Obtained|Scored)|Scored)\s*[:\-]?\s*(\d+(?:\.\d+)?)\b/i);
    const maxM = clean.match(/(?:Maximum\s*Marks|Max\.?\s*Marks|Out\s+of)\s*[:\-]?\s*(\d+(?:\.\d+)?)\b/i);
    const marksBeforePass = /\bMarks\b/i.test(clean) ? clean.match(/\b(\d{1,3}(?:\.\d{1,2})?)\s+(?:PASS|FAIL)\b/i) : null;
    if (obtM) {
      marksObtained = Number(obtM[1]);
      totalMarks = maxM ? Number(maxM[1]) || 100 : 100;
      percentage = totalMarks > 0 ? Math.round((marksObtained / totalMarks) * 10000) / 100 : 0;
    } else if (marksBeforePass) {
      marksObtained = Number(marksBeforePass[1]);
      totalMarks = marksObtained > 100 ? 150 : 100;
      percentage = totalMarks > 0 ? Math.round((marksObtained / totalMarks) * 10000) / 100 : 0;
    } else {
      const pctM =
        clean.match(/(?:Percentage|Score|Marks|Secured|Result)\s*[:\-]?\s*(\d{1,3}(?:\.\d{1,2})?)\s*%/i) ||
        clean.match(/(\d{2,3}(?:\.\d{1,2})?)\s*%\s*(?:marks|score|pass)/i);
      if (pctM) {
        percentage = Number(pctM[1]);
        marksObtained = percentage;
        totalMarks = 100;
      }
    }
  }

  const isCpe = /\bCPE\b|Continuing\s+Professional\s+Education/i.test(clean);
  const passStatus: 'PASS' | 'FAIL' = /\b(?:FAIL|FAILED|NOT\s+QUALIFIED|UNSUCCESSFUL)\b/i.test(clean) ? 'FAIL' : 'PASS';

  const signals = [hasNameFromText, hasExplicitSeries, Boolean(certNum), Boolean(expiryDate || examDate)].filter(Boolean).length;
  const analysisConfidence: AnalysisConfidence = signals >= 3 ? 'high' : signals === 2 ? 'medium' : 'low';

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
    analysisConfidence,
    ...(expiryInferred ? { expiryInferred: true } : {}),
  };
}

export const parseNismPdfText = parseNismCertificateText;

/* ---------- Employee Directory Matching ---------- */
const normName = (s: string) =>
  s
    .toLowerCase()
    .replace(/\b(?:mr|ms|mrs|shri|smt|dr)\b\.?/g, ' ')
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();

export function matchCertificatesWithDirectory(certs: DriveCertRecord[], directory: EmployeeEntry[]) {
  const matchedEmpKeys = new Set<string>();
  const updatedCerts = certs.map((c) => {
    const cn = normName(c.holderName);
    const fn = normName(c.fileName.replace(CERT_EXT_RE, ''));
    const match = directory.find((emp) => {
      const en = normName(emp.name);
      const eid = emp.empId.trim().toLowerCase();
      const emailUser = emp.email.split('@')[0]?.toLowerCase().replace(/[^a-z0-9]/g, '') || '';
      if (c.empId && eid && c.empId.trim().toLowerCase() === eid) return true;
      if (c.email && emp.email && c.email.trim().toLowerCase() === emp.email.trim().toLowerCase()) return true;
      if (eid && (c.fileName.toLowerCase().includes(eid) || c.holderName.toLowerCase().includes(eid) || (c.rawTextSnippet || '').toLowerCase().includes(eid))) return true;
      if (en && (cn === en || cn.includes(en) || en.includes(cn) || fn.includes(en))) return true;
      if (emailUser.length >= 4 && fn.replace(/\s+/g, '').includes(emailUser)) return true;
      return false;
    }) || null;
    if (match) matchedEmpKeys.add((match.empId || match.email || match.name).toLowerCase());
    const team = c.team || (c.folderName ? c.folderName.split('/')[0].trim() : '') || match?.department || '';
    return { ...c, team: team || undefined, matchedEmployee: match };
  });

  const missingEmployees = directory.filter(
    (emp) => !matchedEmpKeys.has((emp.empId || emp.email || emp.name).toLowerCase()),
  );
  return { certs: updatedCerts, missingEmployees };
}

/* ---------- Email & CSV Report Builders ---------- */
const esc = (v: unknown) => String(v ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

function fmtScoreText(c: DriveCertRecord): string {
  if (c.cpeOrExamType === 'CPE' && c.marksObtained === 0) return `CPE · ${c.passStatus}`;
  if (c.marksObtained === 0 && c.percentage === 0) return c.passStatus;
  return `${c.marksObtained}/${c.totalMarks} (${c.percentage}%) · ${c.passStatus}`;
}

export function buildAuditEmail(params: {
  to: string;
  expiringCerts: DriveCertRecord[];
  missingEmployees: EmployeeEntry[];
  thresholdDays: number;
  actionedBy: string;
  totalCerts?: number;
}) {
  const { to, expiringCerts, missingEmployees, thresholdDays, actionedBy, totalCerts } = params;
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
    const scoreHtml = c.cpeOrExamType === 'CPE' && c.marksObtained === 0
      ? `<span style="background:#dcfce7;color:#166534;padding:1px 5px;border-radius:3px;font-size:10px;font-weight:700;">CPE · ${esc(c.passStatus)}</span>`
      : c.marksObtained === 0 && c.percentage === 0
        ? `<span style="background:#dcfce7;color:#166534;padding:1px 5px;border-radius:3px;font-size:10px;font-weight:700;">${esc(c.passStatus)}</span>`
        : `${c.marksObtained}/${c.totalMarks} (${c.percentage}%) <span style="background:#dcfce7;color:#166534;padding:1px 5px;border-radius:3px;font-size:10px;font-weight:700;">${esc(c.passStatus)}</span>`;
    const linkLabel = c.fileType === 'image' ? 'View Image' : 'View PDF';
    const sourceCell = c.webViewLink && /^https?:\/\//.test(c.webViewLink)
      ? `<a href="${esc(c.webViewLink)}" target="_blank" style="color:#1d4ed8;font-weight:600;">${linkLabel}</a><div style="font-size:11px;color:#64748b;">${esc(c.fileName)}</div>`
      : `<span style="font-weight:600;color:#475569;">Uploaded (${c.fileType === 'image' ? 'Image' : 'PDF'})</span><div style="font-size:11px;color:#64748b;">${esc(c.fileName)}</div>`;
    const empEmail = emp?.email || c.email || '';
    const empId = emp?.empId || c.empId || '';
    const teamLabel = c.team || c.folderName || emp?.department || '—';
    return `<tr style="background-color:${bg};">
      <td style="${td}font-weight:600;">${esc(emp?.name || c.holderName)}${empId ? `<div style="font-size:11px;color:#475569;font-weight:400;">ID: ${esc(empId)}</div>` : ''}</td>
      <td style="${td}">${empEmail ? `<a href="mailto:${esc(empEmail)}" style="color:#1d4ed8;">${esc(empEmail)}</a>` : '—'}</td>
      <td style="${td}">${esc(teamLabel)}</td>
      <td style="${td}">${esc(c.nismSeries)}</td>
      <td style="${td}font-family:monospace;">${esc(c.certificateNumber)}</td>
      <td style="${td}font-family:monospace;">${esc(c.enrolmentNumber)}</td>
      <td style="${td}">${esc(c.cpeOrExamType)}</td>
      <td style="${td}">${esc(fmtDispDate(c.examDate))}</td>
      <td style="${td}"><div style="font-weight:600;">${esc(fmtDispDate(c.expiryDate))}</div><span style="display:inline-block;padding:2px 7px;border-radius:4px;font-size:11px;font-weight:600;background:${badgeBg};color:${badgeCol};">${esc(inf.label)}</span></td>
      <td style="${td}">${scoreHtml}</td>
      <td style="${td}">${sourceCell}</td>
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
        <div style="font-size:12px;color:#e2e8f0;">FundsIndia Trading &amp; Quality — NISM Certificate Compliance Hub</div>
      </div>
      <div style="padding:20px 24px;">
        <div style="background:#f8fafc;border:1px solid #cbd5e1;border-radius:6px;padding:12px 16px;margin-bottom:18px;font-size:12px;">
          <div><b>Actioned By:</b> ${esc(actionedBy)}</div>
          <div><b>Timestamp (UTC):</b> ${esc(nowIso)}</div>
          <div><b>Summary:</b> ${typeof totalCerts === 'number' ? `${totalCerts} Total Analysed · ` : ''}${expiringCerts.length} Expiring/Expired (within ${thresholdDays} days) · ${missingEmployees.length} Missing / Not Uploaded</div>
        </div>
        <div style="font-size:12px;font-weight:700;color:#1e293b;text-transform:uppercase;margin-bottom:8px;">TABLE 1: EMPLOYEES WHOSE NISM CERTIFICATE IS EXPIRING WITHIN ${thresholdDays} DAYS / EXPIRED (${expiringCerts.length} RECORD${expiringCerts.length === 1 ? '' : 'S'})</div>
        <div style="overflow-x:auto;margin-bottom:22px;"><table cellpadding="8" cellspacing="0" width="100%" style="border-collapse:collapse;border:1px solid #cbd5e1;"><thead><tr>
          <th style="${th}">Advisor / Employee Name</th><th style="${th}">Advisor Email</th><th style="${th}">Department / Folder</th><th style="${th}">NISM Series</th><th style="${th}">Certificate Number</th><th style="${th}">Enrolment Number</th><th style="${th}">Exam Type</th><th style="${th}">Exam Date</th><th style="${th}">Valid Till / Expiry Date</th><th style="${th}">Marks &amp; Score</th><th style="${th}">Source File</th>
        </tr></thead><tbody>${expiringCerts.length ? certRows : `<tr><td colspan="11" style="${td}text-align:center;color:#475569;">No certificates expiring within ${thresholdDays} days or expired.</td></tr>`}</tbody></table></div>

        <div style="font-size:12px;font-weight:700;color:#991b1b;text-transform:uppercase;margin-bottom:8px;">TABLE 2: EMPLOYEES WITH MISSING / NOT UPLOADED NISM CERTIFICATES (${missingEmployees.length} RECORD${missingEmployees.length === 1 ? '' : 'S'})</div>
        <div style="overflow-x:auto;"><table cellpadding="8" cellspacing="0" width="100%" style="border-collapse:collapse;border:1px solid #cbd5e1;"><thead><tr>
          <th style="${th}">Employee ID</th><th style="${th}">Employee Name</th><th style="${th}">Email</th><th style="${th}">Department</th><th style="${th}">Status</th>
        </tr></thead><tbody>${missingEmployees.length ? missingRows : `<tr><td colspan="5" style="${td}text-align:center;color:#065f46;">All employees in the directory have a matching NISM certificate.</td></tr>`}</tbody></table></div>
        <div style="margin-top:18px;padding-top:14px;border-top:1px solid #e2e8f0;font-size:11px;color:#64748b;">Generated by FundsIndia Trading &amp; Quality — NISM Certification Compliance Hub.</div>
      </div>
    </div>
  </body></html>`;

  const plainBody = [
    `FundsIndia Trading & Quality — NISM Compliance Alert`,
    `Actioned By: ${actionedBy}`,
    `Timestamp (UTC): ${nowIso}`,
    '',
    `Expiring/Expired within ${thresholdDays} days (${expiringCerts.length}):`,
    ...(expiringCerts.length
      ? expiringCerts.map((c) => `- ${c.matchedEmployee?.name || c.holderName} | ${c.nismSeries} | Cert: ${c.certificateNumber} | Expiry: ${fmtDispDate(c.expiryDate)} (${getExpiryInfo(c.expiryDate, thresholdDays).label}) | ${fmtScoreText(c)}${c.webViewLink ? ` | ${c.webViewLink}` : ''}`)
      : ['(None)']),
    '',
    `Missing / Not Uploaded (${missingEmployees.length}):`,
    ...(missingEmployees.length
      ? missingEmployees.map((e) => `- ${e.empId || '-'} | ${e.name} | ${e.email || '-'} | ${e.department || '-'}`)
      : ['(None)']),
  ].join('\n');

  return { to, subject, plainBody, htmlBody };
}

function utf8ToBase64(str: string): string {
  const bytes = new TextEncoder().encode(str);
  let bin = '';
  const chunkSize = 0x8000;
  for (let i = 0; i < bytes.length; i += chunkSize) {
    bin += String.fromCharCode(...bytes.subarray(i, i + chunkSize));
  }
  return btoa(bin);
}

export async function sendEmailViaGmail(token: string, params: { to: string; subject: string; plainBody: string; htmlBody: string }): Promise<void> {
  const boundary = `fi_nism_${Date.now().toString(36)}`;
  const recipients = params.to.split(/[,;]+/).map((s) => s.trim()).filter(Boolean).join(', ');
  const mime = [
    `To: ${recipients}`,
    `Subject: =?UTF-8?B?${utf8ToBase64(params.subject)}?=`,
    'MIME-Version: 1.0',
    `Content-Type: multipart/alternative; boundary="${boundary}"`,
    '',
    `--${boundary}`,
    'Content-Type: text/plain; charset="UTF-8"',
    'Content-Transfer-Encoding: base64',
    '',
    utf8ToBase64(params.plainBody),
    '',
    `--${boundary}`,
    'Content-Type: text/html; charset="UTF-8"',
    'Content-Transfer-Encoding: base64',
    '',
    utf8ToBase64(params.htmlBody),
    '',
    `--${boundary}--`,
  ].join('\r\n');

  const raw = utf8ToBase64(mime).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  const r = await fetch(GMAIL_API, {
    method: 'POST',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ raw }),
  });
  if (!r.ok) throw await driveErr(r, 'Gmail send failed');
}

export function buildGmailComposeUrl(params: { to: string; subject: string; body: string }): string {
  const maxBody = params.body.slice(0, 1800);
  const qs = new URLSearchParams({
    view: 'cm',
    fs: '1',
    to: params.to,
    su: params.subject,
    body: maxBody,
  });
  return `https://mail.google.com/mail/?${qs.toString()}`;
}

export function buildComplianceCsv(certs: DriveCertRecord[], missingEmployees: EmployeeEntry[], thresholdDays: number): string {
  const csvEsc = (v: unknown) => `"${String(v ?? '').replace(/"/g, '""')}"`;
  const headers = [
    'Record Type', 'Team', 'Employee ID', 'Name', 'Email', 'Department / Folder', 'NISM Series',
    'Certificate #', 'Enrolment #', 'Exam Type', 'Exam Date', 'Expiry Date',
    'Compliance Status', 'Marks', 'Total Marks', 'Percentage', 'Pass Status',
    'File Format', 'Extraction Method', 'Confidence', 'File Name', 'Link', 'Remarks',
  ];
  const rows: string[] = [headers.map(csvEsc).join(',')];

  for (const c of certs) {
    const inf = getExpiryInfo(c.expiryDate, thresholdDays);
    const team = c.team || (c.folderName ? c.folderName.split('/')[0].trim() : '') || c.matchedEmployee?.department || '';
    rows.push([
      'CERTIFICATE',
      team,
      c.matchedEmployee?.empId || c.empId || '',
      c.matchedEmployee?.name || c.holderName,
      c.matchedEmployee?.email || c.email || '',
      c.matchedEmployee?.department || c.folderName || team,
      c.nismSeries,
      c.certificateNumber,
      c.enrolmentNumber,
      c.cpeOrExamType,
      c.examDate,
      c.expiryDate,
      inf.label,
      c.marksObtained,
      c.totalMarks,
      c.percentage,
      c.passStatus,
      (c.fileType || 'pdf').toUpperCase(),
      c.extractionMethod || 'pdf-text',
      c.analysisConfidence || 'medium',
      c.fileName,
      c.webViewLink || '',
      c.remarks || '',
    ].map(csvEsc).join(','));
  }

  for (const e of missingEmployees) {
    rows.push([
      'MISSING_EMPLOYEE',
      e.department,
      e.empId,
      e.name,
      e.email,
      e.department,
      '', '', '', '', '', '',
      'MISSING / NOT UPLOADED',
      '', '', '', '', '', '', '', '', '', '',
    ].map(csvEsc).join(','));
  }

  return rows.join('\r\n');
}
