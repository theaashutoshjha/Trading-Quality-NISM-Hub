import { ChangeEvent, DragEvent, useEffect, useMemo, useState } from 'react';
import { useStaff } from './App';
import { api } from '../shared/api';
import {
  ANALYSIS_CACHE_FILE_NAME,
  DEFAULT_CLIENT_ID,
  DEFAULT_FOLDER_URL,
  DEFAULT_GOOGLE_EMAIL,
  DIRECTORY_FILE_NAME,
  DriveCertRecord,
  EmployeeEntry,
  GoogleApiError,
  GoogleApiErrorDetails,
  analyseCertificateBytes,
  buildApiActivationUrl,
  buildAuditEmail,
  buildComplianceCsv,
  buildGmailComposeUrl,
  detectCertFileType,
  downloadDriveFileBytes,
  extractProjectIdFromClientId,
  fmtDispDate,
  getExpiryInfo,
  isSupportedCertFile,
  listDriveCertificates,
  loadJsonFromDrive,
  matchCertificatesWithDirectory,
  requestGoogleToken,
  resolveOrCreateFolder,
  saveJsonToDrive,
  sendEmailViaGmail,
  uploadCertificateToDrive,
} from './nismDrive';

const LS_CLIENT_ID = 'fi_google_client_id';
const LS_FOLDER = 'fi_nism_drive_folder';
const LS_GOOGLE_EMAIL = 'fi_google_sender_email';
const SS_TOKEN = 'fi_google_token_cache';

const APPS_SCRIPT_SNIPPET = `function doPost(e) {
  var data = JSON.parse(e.postData.contents);
  MailApp.sendEmail({
    to: data.to || data.recipient || 'qaudits@fundsindia.com',
    subject: data.subject || 'NISM Compliance Alert',
    body: data.plainBody || '',
    htmlBody: data.htmlBody || undefined
  });
  return ContentService.createTextOutput(JSON.stringify({ ok: true }))
    .setMimeType(ContentService.MimeType.JSON);
}`;

type StatusFilter = 'all' | 'active' | 'expiring_soon' | 'expired' | 'unknown' | 'unmatched' | 'needs_review';

export function NismCertsPage() {
  const { me } = useStaff();
  const [clientId, setClientId] = useState(() => {
    try { return localStorage.getItem(LS_CLIENT_ID) || DEFAULT_CLIENT_ID; } catch { return DEFAULT_CLIENT_ID; }
  });
  const [folderInput, setFolderInput] = useState(() => {
    try { return localStorage.getItem(LS_FOLDER) || DEFAULT_FOLDER_URL; } catch { return DEFAULT_FOLDER_URL; }
  });
  const [googleEmail, setGoogleEmail] = useState(() => {
    try { return localStorage.getItem(LS_GOOGLE_EMAIL) || DEFAULT_GOOGLE_EMAIL; } catch { return DEFAULT_GOOGLE_EMAIL; }
  });

  const [token, setToken] = useState('');
  const [folder, setFolder] = useState<{ id: string; name: string; webViewLink: string } | null>(null);
  const [driveApiErr, setDriveApiErr] = useState<GoogleApiErrorDetails | null>(null);
  const [gmailApiErr, setGmailApiErr] = useState<GoogleApiErrorDetails | null>(null);

  const [certs, setCerts] = useState<DriveCertRecord[]>([]);
  const [directory, setDirectory] = useState<EmployeeEntry[]>([]);
  const [thresholdDays, setThresholdDays] = useState(90);
  const [auditEmail, setAuditEmail] = useState('qaudits@fundsindia.com');
  const [tab, setTab] = useState<'certs' | 'missing' | 'directory'>('certs');
  const [dirText, setDirText] = useState('');
  const [busy, setBusy] = useState('');
  const [err, setErr] = useState('');
  const [msg, setMsg] = useState('');
  const [dragOver, setDragOver] = useState(false);

  const [searchQ, setSearchQ] = useState('');
  const [statusFilter, setStatusFilter] = useState<StatusFilter>('all');
  const [seriesFilter, setSeriesFilter] = useState('all');

  const [previewHtml, setPreviewHtml] = useState<string | null>(null);
  const [editingCert, setEditingCert] = useState<DriveCertRecord | null>(null);
  const [inspectCert, setInspectCert] = useState<DriveCertRecord | null>(null);
  const [showAppsScriptHelp, setShowAppsScriptHelp] = useState(false);

  const [sched, setSched] = useState({ enabled: true, recipient: 'qaudits@fundsindia.com', thresholdDays: 90, frequency: 'weekly', lastSentAt: '', webhookUrl: '' });
  const [schedSaved, setSchedSaved] = useState('');

  const driveConnected = Boolean(token && folder);
  const activeProjectId = driveApiErr?.projectId || gmailApiErr?.projectId || extractProjectIdFromClientId(clientId) || '841567171153';

  async function initFolderWithToken(tok: string, fldInput: string) {
    setToken(tok);
    setFolder(null);
    setDriveApiErr(null);
    try {
      const fld = await resolveOrCreateFolder(tok, fldInput);
      setFolder(fld);
      const [savedDir, savedCerts] = await Promise.all([
        loadJsonFromDrive<EmployeeEntry[]>(tok, fld.id, DIRECTORY_FILE_NAME),
        loadJsonFromDrive<DriveCertRecord[]>(tok, fld.id, ANALYSIS_CACHE_FILE_NAME),
      ]);
      if (Array.isArray(savedDir) && savedDir.length) setDirectory(savedDir);
      if (Array.isArray(savedCerts) && savedCerts.length) setCerts(savedCerts);
      setMsg(`Connected to Google Drive folder "${fld.name}". Loaded ${savedCerts?.length || 0} analysed certificate(s) and ${savedDir?.length || 0} employee(s).`);
    } catch (e: any) {
      setFolder(null);
      if (e instanceof GoogleApiError) {
        if (e.details.reason === 'UNAUTHENTICATED') {
          setToken('');
          try { sessionStorage.removeItem(SS_TOKEN); } catch { /* ignore */ }
        } else if (e.details.reason === 'SERVICE_DISABLED') {
          setDriveApiErr(e.details);
        }
      }
      throw e;
    }
  }

  useEffect(() => {
    api.get('/api/admin/settings').then((r) => {
      if (r.settings?.nism_schedule) setSched((p) => ({ ...p, ...r.settings.nism_schedule }));
    }).catch(() => {});

    let cachedTok = '';
    try {
      const raw = sessionStorage.getItem(SS_TOKEN);
      if (raw) {
        const parsed = JSON.parse(raw);
        if (parsed?.token && parsed?.expiresAt > Date.now() + 60_000) cachedTok = parsed.token;
      }
    } catch { /* ignore */ }

    if (cachedTok) {
      initFolderWithToken(cachedTok, folderInput).catch((e: any) => {
        if (e instanceof GoogleApiError && e.details.reason === 'SERVICE_DISABLED') {
          setErr(e.message);
        } else {
          try { sessionStorage.removeItem(SS_TOKEN); } catch { /* ignore */ }
          setToken('');
        }
      });
    } else if (clientId) {
      requestGoogleToken(clientId, { silent: true, loginHint: googleEmail })
        .then(({ token: tok, expiresIn }) => {
          try { sessionStorage.setItem(SS_TOKEN, JSON.stringify({ token: tok, expiresAt: Date.now() + expiresIn * 1000 })); } catch { /* ignore */ }
          return initFolderWithToken(tok, folderInput);
        })
        .catch(() => { /* silent auth not yet consented; user can click Connect or use local upload */ });
    }
  }, []); // eslint-disable-line

  async function saveSchedule() {
    setErr('');
    try {
      await api.put('/api/admin/settings/nism_schedule', sched);
      setSchedSaved('Schedule saved ✓');
      setTimeout(() => setSchedSaved(''), 2500);
    } catch (e: any) {
      setErr(e?.message || 'Failed to save schedule & webhook.');
    }
  }

  const matched = useMemo(() => matchCertificatesWithDirectory(certs, directory), [certs, directory]);

  const stats = useMemo(() => {
    let active = 0, expiring = 0, expired = 0, unknown = 0, pdfs = 0, images = 0, needsReview = 0, unmatched = 0;
    const seriesCounts = new Map<string, number>();
    for (const c of matched.certs) {
      const st = getExpiryInfo(c.expiryDate, thresholdDays).status;
      if (st === 'active') active++;
      else if (st === 'expiring_soon') expiring++;
      else if (st === 'expired') expired++;
      else unknown++;
      if (c.fileType === 'image') images++;
      else pdfs++;
      if (c.analysisConfidence === 'low' || !c.expiryDate || c.certificateNumber === '—') needsReview++;
      if (!c.matchedEmployee) unmatched++;
      const sKey = c.nismSeries.split(':')[0].trim() || 'NISM Certification';
      seriesCounts.set(sKey, (seriesCounts.get(sKey) || 0) + 1);
    }
    return {
      active,
      expiring,
      expired,
      unknown,
      pdfs,
      images,
      needsReview,
      unmatched,
      seriesList: Array.from(seriesCounts.entries()).sort((a, b) => b[1] - a[1]),
    };
  }, [matched.certs, thresholdDays]);

  const expiringOrExpired = useMemo(
    () => matched.certs.filter((c) => {
      const st = getExpiryInfo(c.expiryDate, thresholdDays).status;
      return st === 'expired' || st === 'expiring_soon';
    }),
    [matched.certs, thresholdDays],
  );

  const filteredCerts = useMemo(() => {
    const q = searchQ.trim().toLowerCase();
    return matched.certs.filter((c) => {
      const st = getExpiryInfo(c.expiryDate, thresholdDays).status;
      if (statusFilter === 'active' && st !== 'active') return false;
      if (statusFilter === 'expiring_soon' && st !== 'expiring_soon') return false;
      if (statusFilter === 'expired' && st !== 'expired') return false;
      if (statusFilter === 'unknown' && st !== 'unknown') return false;
      if (statusFilter === 'unmatched' && c.matchedEmployee) return false;
      if (statusFilter === 'needs_review' && !(c.analysisConfidence === 'low' || !c.expiryDate || c.certificateNumber === '—')) return false;

      if (seriesFilter !== 'all') {
        const sKey = c.nismSeries.split(':')[0].trim() || 'NISM Certification';
        if (sKey !== seriesFilter) return false;
      }

      if (q) {
        const hay = [
          c.holderName,
          c.matchedEmployee?.name,
          c.matchedEmployee?.empId,
          c.matchedEmployee?.email,
          c.matchedEmployee?.department,
          c.nismSeries,
          c.certificateNumber,
          c.enrolmentNumber,
          c.fileName,
          c.folderName,
        ].filter(Boolean).join(' ').toLowerCase();
        if (!hay.includes(q)) return false;
      }
      return true;
    });
  }, [matched.certs, thresholdDays, statusFilter, seriesFilter, searchQ]);

  async function connectDrive() {
    setErr(''); setMsg('');
    if (!clientId.trim()) return setErr('Enter your Google OAuth Client ID first.');
    try {
      localStorage.setItem(LS_CLIENT_ID, clientId.trim());
      localStorage.setItem(LS_FOLDER, folderInput.trim());
      localStorage.setItem(LS_GOOGLE_EMAIL, googleEmail.trim());
    } catch { /* ignore */ }
    setBusy('Connecting to Google Drive & Gmail…');
    try {
      const { token: tok, expiresIn } = await requestGoogleToken(clientId, { loginHint: googleEmail });
      try { sessionStorage.setItem(SS_TOKEN, JSON.stringify({ token: tok, expiresAt: Date.now() + expiresIn * 1000 })); } catch { /* ignore */ }
      setGmailApiErr(null);
      await initFolderWithToken(tok, folderInput);
    } catch (e: any) {
      setErr(e.message || 'Google Drive connection failed.');
    } finally {
      setBusy('');
    }
  }

  async function retryDriveWithCurrentToken() {
    if (!token) return connectDrive();
    setErr(''); setMsg('');
    setBusy('Checking Google Drive folder access…');
    try {
      await initFolderWithToken(token, folderInput);
    } catch (e: any) {
      setErr(e.message || 'Google Drive connection failed.');
    } finally {
      setBusy('');
    }
  }

  async function scanDriveFolder() {
    if (!token || !folder) return setErr('Google Drive folder is not connected yet. Connect Google Drive (or enable Google Drive API in Cloud Console) first, or upload certificates directly below.');
    setErr(''); setMsg('');
    setBusy('Listing PDFs & Images in Google Drive…');
    try {
      const files = await listDriveCertificates(token, folder.id);
      if (!files.length) {
        setCerts([]);
        setMsg(`No PDF or image certificates found inside "${folder.name}" (or its subfolders).`);
        return;
      }
      const out: DriveCertRecord[] = [];
      for (let i = 0; i < files.length; i++) {
        const f = files[i];
        setBusy(`Analysing ${i + 1}/${files.length}: ${f.name}…`);
        const bytes = await downloadDriveFileBytes(token, f.id);
        const parsed = await analyseCertificateBytes({
          bytes,
          fileName: f.name,
          mimeType: f.mimeType,
          onProgress: (stage) => setBusy(`Analysing ${i + 1}/${files.length} (${f.name}): ${stage}`),
        });
        out.push({
          fileId: f.id,
          fileName: f.name,
          webViewLink: f.webViewLink,
          folderName: f.folderName,
          source: 'drive',
          ...parsed,
        });
      }
      setCerts(out);
      await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, out);
      setMsg(`Analysed ${out.length} certificate(s) (${out.filter((x) => x.fileType === 'pdf').length} PDF, ${out.filter((x) => x.fileType === 'image').length} Image) from Google Drive and saved metadata to "${ANALYSIS_CACHE_FILE_NAME}".`);
    } catch (e: any) {
      if (e instanceof GoogleApiError) {
        if (e.details.reason === 'SERVICE_DISABLED') setDriveApiErr(e.details);
        else if (e.details.reason === 'UNAUTHENTICATED') {
          setToken(''); setFolder(null);
          try { sessionStorage.removeItem(SS_TOKEN); } catch { /* ignore */ }
        }
      }
      setErr(e.message || 'Failed to analyse Drive certificates.');
    } finally {
      setBusy('');
    }
  }

  async function processUploadedFiles(rawFiles: File[]) {
    const files = rawFiles.filter((f) => isSupportedCertFile(f.name, f.type));
    const skipped = rawFiles.length - files.length;
    if (!files.length) {
      setErr('Please select valid NISM certificate files in PDF or Image format (.pdf, .png, .jpg, .jpeg, .webp, .bmp, .tiff).');
      return;
    }

    setErr(''); setMsg('');
    const useDrive = Boolean(token && folder);
    setBusy(`${useDrive ? 'Uploading & analysing' : 'Analysing'} ${files.length} certificate(s)…`);

    try {
      const added: DriveCertRecord[] = [];
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const ft = detectCertFileType(file.name, file.type) || 'pdf';
        const bytes = new Uint8Array(await file.arrayBuffer());

        let fileId = `local_${Date.now()}_${i}_${file.name}`;
        let webViewLink = '';
        let uploadedName = file.name;
        let uploadedMime = file.type;
        let source: 'drive' | 'local' = 'local';

        if (useDrive && folder) {
          setBusy(`Uploading ${i + 1}/${files.length} to Drive: ${file.name}…`);
          const uploaded = await uploadCertificateToDrive(token, folder.id, file);
          fileId = uploaded.id;
          uploadedName = uploaded.name;
          uploadedMime = uploaded.mimeType;
          webViewLink = uploaded.webViewLink;
          source = 'drive';
        }

        const parsed = await analyseCertificateBytes({
          bytes,
          fileName: uploadedName,
          mimeType: uploadedMime,
          onProgress: (stage) => setBusy(`Analysing ${i + 1}/${files.length} (${uploadedName}): ${stage}`),
        });

        const localPreviewUrl = !useDrive && ft === 'image' ? URL.createObjectURL(file) : undefined;
        added.push({
          fileId,
          fileName: uploadedName,
          webViewLink,
          folderName: useDrive ? folder!.name : 'Uploaded Batch',
          source,
          localPreviewUrl,
          ...parsed,
        });
      }

      const next = [...added, ...certs.filter((c) => !added.some((a) => a.fileId === c.fileId || (a.source === 'local' && a.fileName === c.fileName)))];
      setCerts(next);

      if (useDrive && folder) {
        const cleanForDrive = next.map(({ localPreviewUrl: _lp, ...rest }) => rest);
        await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, cleanForDrive);
        setMsg(`Uploaded & analysed ${added.length} certificate(s) directly in Google Drive${skipped ? ` (${skipped} unsupported file(s) skipped)` : ''}.`);
      } else {
        setMsg(`Analysed ${added.length} certificate(s) locally (${added.filter((x) => x.fileType === 'pdf').length} PDF, ${added.filter((x) => x.fileType === 'image').length} Image)${skipped ? ` · ${skipped} unsupported file(s) skipped` : ''}.`);
      }
    } catch (x: any) {
      if (x instanceof GoogleApiError && x.details.reason === 'SERVICE_DISABLED') setDriveApiErr(x.details);
      setErr(x.message || 'Certificate upload/analysis failed.');
    } finally {
      setBusy('');
    }
  }

  function handleCertUpload(e: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(e.target.files || []);
    e.target.value = '';
    if (files.length) void processUploadedFiles(files);
  }

  function handleDrop(e: DragEvent<HTMLDivElement>) {
    e.preventDefault();
    setDragOver(false);
    const files = Array.from(e.dataTransfer.files || []);
    if (files.length) void processUploadedFiles(files);
  }

  async function syncCurrentListToDrive() {
    if (!token || !folder) return setErr('Connect Google Drive first.');
    setErr(''); setMsg('');
    setBusy('Saving current analysis & directory to Google Drive…');
    try {
      const cleanForDrive = certs.map(({ localPreviewUrl: _lp, ...rest }) => rest);
      await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, cleanForDrive);
      if (directory.length) await saveJsonToDrive(token, folder.id, DIRECTORY_FILE_NAME, directory);
      setMsg(`Synced ${certs.length} certificate record(s) and ${directory.length} directory employee(s) to Drive folder "${folder.name}".`);
    } catch (e: any) {
      setErr(e.message || 'Sync to Drive failed.');
    } finally {
      setBusy('');
    }
  }

  function parseDirectoryLines(raw: string): EmployeeEntry[] {
    const rows: EmployeeEntry[] = [];
    for (const line of raw.split(/\r?\n/)) {
      const t = line.trim();
      if (!t || /^emp(loyee)?\s*id\b/i.test(t) || /^name\b/i.test(t)) continue;
      const parts = t.split(/[,\t]/).map((x) => x.trim());
      if (parts.length === 1) {
        rows.push({ empId: '', name: parts[0], email: '', department: '' });
      } else {
        const looksLikeId = /^[A-Z0-9_-]{2,20}$/i.test(parts[0]) && /\d/.test(parts[0]);
        if (looksLikeId) {
          rows.push({ empId: parts[0], name: parts[1] || '', email: parts[2] || '', department: parts[3] || '' });
        } else {
          rows.push({ empId: parts[1] || '', name: parts[0], email: parts[2] || '', department: parts[3] || '' });
        }
      }
    }
    return rows.filter((r) => r.name);
  }

  async function saveDirectory(entries: EmployeeEntry[]) {
    setDirectory(entries);
    if (token && folder) {
      setBusy('Saving employee directory to Google Drive…');
      try {
        await saveJsonToDrive(token, folder.id, DIRECTORY_FILE_NAME, entries);
        setMsg(`Saved ${entries.length} employee(s) to "${DIRECTORY_FILE_NAME}" in Google Drive.`);
      } catch (e: any) {
        setErr(e.message || 'Failed to save directory to Drive.');
      } finally {
        setBusy('');
      }
    } else {
      setMsg(`Loaded ${entries.length} employee(s) and matched against ${certs.length} certificate(s).`);
    }
  }

  function handleDirectoryCsv(e: ChangeEvent<HTMLInputElement>) {
    const f = e.target.files?.[0];
    if (!f) return;
    f.text().then((txt) => saveDirectory(parseDirectoryLines(txt)));
    e.target.value = '';
  }

  function currentEmailPayload() {
    return buildAuditEmail({
      to: auditEmail.trim() || 'qaudits@fundsindia.com',
      expiringCerts: expiringOrExpired,
      missingEmployees: matched.missingEmployees,
      thresholdDays,
      actionedBy: me.email,
      totalCerts: matched.certs.length,
    });
  }

  async function sendOneClickAuditEmail() {
    setErr(''); setMsg('');
    const payload = currentEmailPayload();
    setBusy(`Sending audit email to ${payload.to}…`);
    try {
      // 1. Try Gmail API if OAuth token exists and Gmail API wasn't already flagged disabled
      if (token && !gmailApiErr) {
        try {
          await sendEmailViaGmail(token, payload);
          setMsg(`Audit email sent via Gmail API to ${payload.to} (${expiringOrExpired.length} expiring/expired · ${matched.missingEmployees.length} missing).`);
          return;
        } catch (e: any) {
          if (e instanceof GoogleApiError && e.details.reason === 'UNAUTHENTICATED') {
            setToken(''); setFolder(null);
            try { sessionStorage.removeItem(SS_TOKEN); } catch { /* ignore */ }
            throw e;
          }
          if (e instanceof GoogleApiError && e.details.reason === 'SERVICE_DISABLED') {
            setGmailApiErr(e.details);
            // Fall through to webhook / server relay if available
            if (!sched.webhookUrl) {
              setErr(e.message);
              return;
            }
          } else {
            throw e;
          }
        }
      }

      // 2. Fallback: Server Mail Relay (Resend secret or Apps Script Webhook)
      const relay = await api.post('/api/admin/nism-send-mail', {
        to: payload.to,
        subject: payload.subject,
        htmlBody: payload.htmlBody,
        plainBody: payload.plainBody,
        webhookUrl: sched.webhookUrl || undefined,
      });
      setMsg(`Audit email sent via ${relay.via === 'resend' ? 'Mail Relay' : 'Apps Script Webhook'} to ${payload.to} (${expiringOrExpired.length} expiring/expired · ${matched.missingEmployees.length} missing).`);
    } catch (e: any) {
      setErr(e.message || 'Failed to send email. Enable Gmail API in Google Cloud Console, configure an Apps Script Webhook, or use "Open in Gmail Web" below.');
    } finally {
      setBusy('');
    }
  }

  async function sendViaWebhookOnly() {
    setErr(''); setMsg('');
    const payload = currentEmailPayload();
    setBusy(`Sending audit email via Mail Relay / Webhook to ${payload.to}…`);
    try {
      const relay = await api.post('/api/admin/nism-send-mail', {
        to: payload.to,
        subject: payload.subject,
        htmlBody: payload.htmlBody,
        plainBody: payload.plainBody,
        webhookUrl: sched.webhookUrl || undefined,
      });
      setMsg(`Audit email sent via ${relay.via === 'resend' ? 'Mail Relay' : 'Apps Script Webhook'} to ${payload.to}.`);
    } catch (e: any) {
      setErr(e.message || 'Relay send failed.');
    } finally {
      setBusy('');
    }
  }

  function openInGmailWeb() {
    const payload = currentEmailPayload();
    const url = buildGmailComposeUrl({ to: payload.to, subject: payload.subject, body: payload.plainBody });
    window.open(url, '_blank', 'noopener,noreferrer');
    setMsg('Opened Gmail Web compose tab with recipient, subject, and summary. Tip: click "Copy Rich Email Table" to paste the full formatted HTML tables into the message body.');
  }

  async function copyRichEmailReport() {
    const payload = currentEmailPayload();
    try {
      if (typeof ClipboardItem !== 'undefined' && navigator.clipboard?.write) {
        const item = new ClipboardItem({
          'text/html': new Blob([payload.htmlBody], { type: 'text/html' }),
          'text/plain': new Blob([payload.plainBody], { type: 'text/plain' }),
        });
        await navigator.clipboard.write([item]);
      } else {
        await navigator.clipboard.writeText(payload.plainBody);
      }
      setMsg('Copied full compliance report (rich HTML tables + plain text) to clipboard — ready to paste into Gmail or Outlook.');
    } catch {
      setErr('Clipboard copy failed. Use "Download HTML" or "Preview Email" instead.');
    }
  }

  function downloadFile(content: string, fileName: string, mime: string) {
    const blob = new Blob([content], { type: mime });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = fileName;
    a.click();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  }

  function exportCsv() {
    const csv = buildComplianceCsv(matched.certs, matched.missingEmployees, thresholdDays);
    downloadFile(csv, `nism-compliance-report-${new Date().toISOString().slice(0, 10)}.csv`, 'text/csv;charset=utf-8');
  }

  function downloadEmailHtml() {
    const payload = currentEmailPayload();
    downloadFile(payload.htmlBody, `nism-audit-email-${new Date().toISOString().slice(0, 10)}.html`, 'text/html;charset=utf-8');
  }

  async function saveEditedCert() {
    if (!editingCert) return;
    const updated = certs.map((c) => (c.fileId === editingCert.fileId ? { ...editingCert, analysisConfidence: 'high' as const } : c));
    setCerts(updated);
    setEditingCert(null);
    if (token && folder) {
      try {
        const clean = updated.map(({ localPreviewUrl: _lp, ...rest }) => rest);
        await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, clean);
        setMsg(`Updated "${editingCert.fileName}" and saved to Google Drive.`);
      } catch (e: any) {
        setErr(e.message || 'Updated locally, but Drive save failed.');
      }
    } else {
      setMsg(`Updated "${editingCert.fileName}".`);
    }
  }

  async function removeCert(c: DriveCertRecord) {
    if (c.localPreviewUrl) URL.revokeObjectURL(c.localPreviewUrl);
    const updated = certs.filter((x) => x.fileId !== c.fileId);
    setCerts(updated);
    if (token && folder) {
      const clean = updated.map(({ localPreviewUrl: _lp, ...rest }) => rest);
      await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, clean).catch(() => {});
    }
  }

  const showApiDiagnostic = Boolean(driveApiErr?.reason === 'SERVICE_DISABLED' || gmailApiErr?.reason === 'SERVICE_DISABLED');

  return (
    <div className="stack">
      <div className="row between wrap">
        <div>
          <h1>NISM Certificate Compliance (Google Drive)</h1>
          <p className="muted" style={{ margin: 0 }}>
            Analyse all NISM certificates in <b>PDF and Image</b> formats (with built-in OCR for images &amp; scanned PDFs), match against your employee directory, and send compliance emails — nothing is saved to any database.
          </p>
        </div>
        <div className="row wrap">
          {certs.length > 0 && (
            <button className="btn sm" onClick={exportCsv}>⬇ Export CSV ({matched.certs.length})</button>
          )}
          {folder && (
            <a className="btn sm" href={folder.webViewLink} target="_blank" rel="noopener noreferrer">
              Open Drive folder ↗
            </a>
          )}
        </div>
      </div>

      {err && <div className="alert err" role="alert">{err}</div>}
      {msg && <div className="alert ok">{msg}</div>}
      {busy && <div className="alert warn">⏳ {busy}</div>}

      {/* Google Cloud API Enablement Diagnostic Banner when 403 SERVICE_DISABLED occurs */}
      {showApiDiagnostic && (
        <div className="card stack" style={{ borderLeft: '4px solid var(--err)' }}>
          <div className="row between wrap">
            <div>
              <h3 style={{ margin: 0, color: 'var(--err)' }}>Google Cloud APIs Disabled on Project {activeProjectId}</h3>
              <p className="muted small" style={{ margin: '4px 0 0' }}>
                Your Google Sign-In succeeded, but Google Cloud project <b>{activeProjectId}</b> does not have <b>Google Drive API</b> and/or <b>Gmail API</b> enabled yet. Enable both APIs below, wait 1–2 minutes, then click <b>Retry Connection</b>.
              </p>
            </div>
            <button className="btn sm primary" onClick={retryDriveWithCurrentToken} disabled={!!busy}>↻ Retry Connection</button>
          </div>
          <div className="row wrap">
            <a
              className="btn sm"
              href={driveApiErr?.activationUrl || buildApiActivationUrl('drive.googleapis.com', activeProjectId)}
              target="_blank"
              rel="noopener noreferrer"
            >
              1. Enable Google Drive API (Project {activeProjectId}) ↗
            </a>
            <a
              className="btn sm"
              href={gmailApiErr?.activationUrl || buildApiActivationUrl('gmail.googleapis.com', activeProjectId)}
              target="_blank"
              rel="noopener noreferrer"
            >
              2. Enable Gmail API (Project {activeProjectId}) ↗
            </a>
          </div>
          <div className="muted small">
            Meanwhile, you can still <b>Upload &amp; Analyse PDF / Image certificates</b> directly below and send the audit email via <b>Open in Gmail Web</b> or an <b>Apps Script Webhook</b>.
          </div>
        </div>
      )}

      {/* 1. Google Drive & Certificate Upload */}
      <div className="card stack">
        <div className="row between wrap">
          <h2 style={{ margin: 0 }}>1. Connect Google Drive &amp; Upload Certificates (PDF &amp; Images)</h2>
          <div className="row wrap" style={{ gap: 8 }}>
            <span className={'badge ' + (token ? 'g' : 'm')}>
              {token ? 'Google Signed In ✓' : 'Not signed in'}
            </span>
            <span className={'badge ' + (driveConnected ? 'g' : driveApiErr ? 'r' : 'm')}>
              {driveConnected ? 'Drive Connected ✓' : driveApiErr ? 'Drive API Disabled (403)' : 'Drive Not Connected'}
            </span>
            <span className={'badge ' + (gmailApiErr ? 'r' : token ? 'g' : 'm')}>
              {gmailApiErr ? 'Gmail API Disabled (403)' : token ? 'Gmail Ready' : 'Gmail Not Connected'}
            </span>
          </div>
        </div>

        <div className="grid g3">
          <div>
            <label className="f" style={{ marginTop: 0 }}>Google Account (Gmail Sender)</label>
            <input value={googleEmail} onChange={(e) => setGoogleEmail(e.target.value)} placeholder="ashutosh.kumar@fundsindia.com" />
          </div>
          <div>
            <label className="f" style={{ marginTop: 0 }}>Google OAuth Client ID</label>
            <input value={clientId} onChange={(e) => setClientId(e.target.value)} placeholder="1234567890-abc...apps.googleusercontent.com" />
          </div>
          <div>
            <label className="f" style={{ marginTop: 0 }}>Google Drive Folder URL or ID</label>
            <input value={folderInput} onChange={(e) => setFolderInput(e.target.value)} placeholder="https://drive.google.com/drive/folders/..." />
          </div>
        </div>

        <div className="row wrap">
          <button className="btn primary" onClick={connectDrive} disabled={!!busy}>
            {token ? '↻ Reconnect Google Drive & Gmail' : '🔗 Connect Google Drive & Gmail'}
          </button>
          <button className="btn" onClick={scanDriveFolder} disabled={!driveConnected || !!busy} title={driveConnected ? 'Scan Drive folder and subfolders for PDFs & images' : 'Connect a working Google Drive folder first'}>
            🔍 Scan &amp; Analyse Drive (PDFs &amp; Images)
          </button>
          <label className="btn good" style={{ cursor: busy ? 'not-allowed' : 'pointer' }}>
            ⬆ Upload &amp; Analyse Certificates (PDF / Image)
            <input
              type="file"
              accept=".pdf,application/pdf,image/*,.png,.jpg,.jpeg,.webp,.bmp,.tif,.tiff,.gif"
              multiple
              hidden
              disabled={!!busy}
              onChange={handleCertUpload}
            />
          </label>
          {driveConnected && certs.some((c) => c.source === 'local') && (
            <button className="btn" onClick={syncCurrentListToDrive} disabled={!!busy}>
              ☁ Sync Analysis to Drive
            </button>
          )}
        </div>

        <div
          className="inset"
          onDragOver={(e) => { e.preventDefault(); setDragOver(true); }}
          onDragLeave={() => setDragOver(false)}
          onDrop={handleDrop}
          style={{
            textAlign: 'center',
            border: dragOver ? '2px dashed var(--pri)' : '1px dashed var(--line)',
            background: dragOver ? 'var(--pri-t)' : undefined,
            transition: 'all .15s ease',
          }}
        >
          <div style={{ fontWeight: 700 }}>
            Drop NISM Certificate PDFs or Images here (.pdf, .png, .jpg, .jpeg, .webp, .tiff)
          </div>
          <div className="muted small">
            {driveConnected
              ? `Files dropped here are uploaded straight to "${folder?.name}" in Google Drive and analysed automatically.`
              : 'Works immediately even before Drive API is enabled — analyses every PDF & image with OCR so you can review the list and send the audit mail.'}
          </div>
        </div>
      </div>

      {/* Summary Stats */}
      <div className="grid g4">
        <div className="card stat">
          <b>{matched.certs.length}</b>
          <span>Analysed certificates ({stats.pdfs} PDF · {stats.images} Img)</span>
        </div>
        <div className="card stat">
          <b style={{ color: 'var(--acc)' }}>{stats.active}</b>
          <span>Active / Valid certificates</span>
        </div>
        <div className="card stat">
          <b style={{ color: 'var(--warn)' }}>{expiringOrExpired.length}</b>
          <span>Expiring ({thresholdDays}d) / Expired ({stats.expired})</span>
        </div>
        <div className="card stat">
          <b style={{ color: 'var(--err)' }}>{matched.missingEmployees.length}</b>
          <span>Missing / Not uploaded ({directory.length} dir)</span>
        </div>
      </div>

      {/* 2. Audit Email & Schedule */}
      <div className="card stack">
        <div className="row between wrap">
          <h2 style={{ margin: 0 }}>2. Send Compliance Audit Email</h2>
          <button className="btn sm ghost" onClick={() => setShowAppsScriptHelp(true)}>⚡ Apps Script Mail Setup (No GCP API needed)</button>
        </div>
        <div className="row wrap" style={{ alignItems: 'flex-end' }}>
          <div style={{ flex: 1, minWidth: 220 }}>
            <label className="f" style={{ marginTop: 0 }}>Audit Recipient(s) (comma-separated)</label>
            <input value={auditEmail} onChange={(e) => setAuditEmail(e.target.value)} placeholder="qaudits@fundsindia.com" />
          </div>
          <div style={{ width: 160 }}>
            <label className="f" style={{ marginTop: 0 }}>Expiry window (days)</label>
            <input type="number" min={1} max={365} value={thresholdDays} onChange={(e) => setThresholdDays(Math.max(1, +e.target.value || 30))} />
          </div>
          <button className="btn" onClick={() => setPreviewHtml(currentEmailPayload().htmlBody)}>👁 Preview Email</button>
          <button
            className="btn primary"
            onClick={sendOneClickAuditEmail}
            disabled={!!busy || (!token && !sched.webhookUrl)}
            title={!token && !sched.webhookUrl ? 'Connect Google Drive & Gmail or add an Apps Script Webhook below' : 'Send via Gmail API or configured Mail Relay'}
          >
            ✉ Send Audit Mail to {auditEmail || 'qaudits@fundsindia.com'}
          </button>
        </div>

        <div className="row wrap">
          <button className="btn sm" onClick={openInGmailWeb}>🌐 Open in Gmail Web ↗</button>
          <button className="btn sm" onClick={copyRichEmailReport}>📋 Copy Rich Email Table</button>
          <button className="btn sm" onClick={downloadEmailHtml}>⬇ Download Email (.html)</button>
          {sched.webhookUrl && (
            <button className="btn sm" onClick={sendViaWebhookOnly} disabled={!!busy}>⚡ Send via Apps Script Webhook</button>
          )}
        </div>

        <div className="inset stack" style={{ gap: 10 }}>
          <div className="row between wrap">
            <div>
              <b>Automated Weekly Schedule &amp; Apps Script Mail Webhook</b>
              <div className="muted small">Runs Mondays 04:00 UTC via Cloudflare Workers Cron; Apps Script Webhook also enables 1-click mail sending even when Gmail API is disabled.</div>
            </div>
            {schedSaved && <span className="badge g">{schedSaved}</span>}
          </div>
          <div className="grid g3">
            <div>
              <label className="f" style={{ marginTop: 0 }}>Auto-Schedule</label>
              <select value={sched.enabled ? '1' : '0'} onChange={(e) => setSched({ ...sched, enabled: e.target.value === '1' })}>
                <option value="1">Enabled (Weekly)</option>
                <option value="0">Disabled</option>
              </select>
            </div>
            <div>
              <label className="f" style={{ marginTop: 0 }}>Recipient Email</label>
              <input value={sched.recipient} onChange={(e) => setSched({ ...sched, recipient: e.target.value })} />
            </div>
            <div>
              <label className="f" style={{ marginTop: 0 }}>Apps Script / Mail Webhook (https://…)</label>
              <input value={sched.webhookUrl || ''} onChange={(e) => setSched({ ...sched, webhookUrl: e.target.value })} placeholder="https://script.google.com/macros/s/…/exec" />
            </div>
          </div>
          <div className="row between wrap">
            <span className="muted small">{sched.lastSentAt ? `Last scheduled check: ${sched.lastSentAt}` : 'No scheduled run recorded yet.'}</span>
            <button type="button" className="btn sm primary" onClick={saveSchedule}>Save schedule &amp; webhook</button>
          </div>
        </div>
      </div>

      {/* Tabs: Certificates / Missing / Directory */}
      <div className="tabs">
        <button className={tab === 'certs' ? 'on' : ''} onClick={() => setTab('certs')}>Analysed Certificates ({matched.certs.length})</button>
        <button className={tab === 'missing' ? 'on' : ''} onClick={() => setTab('missing')}>Missing / Not Uploaded ({matched.missingEmployees.length})</button>
        <button className={tab === 'directory' ? 'on' : ''} onClick={() => setTab('directory')}>Employee Directory ({directory.length})</button>
      </div>

      {tab === 'certs' && (
        <div className="card stack">
          {matched.certs.length > 0 && (
            <>
              <div className="row wrap">
                <input
                  style={{ flex: 1, minWidth: 220 }}
                  value={searchQ}
                  onChange={(e) => setSearchQ(e.target.value)}
                  placeholder="Search by employee name, ID, certificate #, enrolment #, NISM series, or filename…"
                />
                {stats.seriesList.length > 1 && (
                  <select style={{ width: 'auto', minWidth: 200 }} value={seriesFilter} onChange={(e) => setSeriesFilter(e.target.value)}>
                    <option value="all">All NISM Series ({matched.certs.length})</option>
                    {stats.seriesList.map(([s, cnt]) => (
                      <option key={s} value={s}>{s} ({cnt})</option>
                    ))}
                  </select>
                )}
              </div>

              <div className="row wrap" style={{ gap: 8 }}>
                {([
                  ['all', `All (${matched.certs.length})`],
                  ['active', `Active (${stats.active})`],
                  ['expiring_soon', `Expiring ≤${thresholdDays}d (${stats.expiring})`],
                  ['expired', `Expired (${stats.expired})`],
                  ['unknown', `Unknown Date (${stats.unknown})`],
                  ['unmatched', `Unmatched (${stats.unmatched})`],
                  ['needs_review', `Needs Review (${stats.needsReview})`],
                ] as Array<[StatusFilter, string]>).map(([key, label]) => (
                  <button
                    key={key}
                    type="button"
                    className={'chip' + (statusFilter === key ? ' on' : '')}
                    onClick={() => setStatusFilter(key)}
                  >
                    {label}
                  </button>
                ))}
              </div>
            </>
          )}

          <div className="tscroll">
            {!matched.certs.length ? (
              <div className="muted">
                No certificates analysed yet. Connect Google Drive and click <b>Scan &amp; Analyse Drive (PDFs &amp; Images)</b>, or click <b>Upload &amp; Analyse Certificates (PDF / Image)</b> above.
              </div>
            ) : !filteredCerts.length ? (
              <div className="muted">No certificates match the current search/filter.</div>
            ) : (
              <table className="t">
                <thead>
                  <tr>
                    <th>Employee / Holder</th>
                    <th>Match</th>
                    <th>Format</th>
                    <th>NISM Series</th>
                    <th>Certificate &amp; Enrol #</th>
                    <th>Exam Date</th>
                    <th>Expiry Status</th>
                    <th>Score</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredCerts.map((c) => {
                    const exp = getExpiryInfo(c.expiryDate, thresholdDays);
                    const expClass = exp.status === 'expired' ? 'r' : exp.status === 'expiring_soon' ? 'w' : exp.status === 'active' ? 'g' : 'm';
                    const methodLabel = c.extractionMethod === 'image-ocr' ? 'IMG · OCR' : c.extractionMethod === 'pdf-ocr' ? 'PDF · OCR' : c.extractionMethod === 'manual' ? 'Edited' : 'PDF · Text';
                    return (
                      <tr key={c.fileId}>
                        <td>
                          <b>{c.matchedEmployee?.name || c.holderName}</b>
                          {c.matchedEmployee?.email && <div className="muted small">{c.matchedEmployee.email}</div>}
                          {c.holderName && c.matchedEmployee && c.matchedEmployee.name.toLowerCase() !== c.holderName.toLowerCase() && (
                            <div className="muted small">Cert name: {c.holderName}</div>
                          )}
                          <div className="muted small">{c.fileName}{c.folderName ? ` · ${c.folderName}` : ''}</div>
                        </td>
                        <td>
                          {c.matchedEmployee
                            ? <span className="badge g">{c.matchedEmployee.empId || 'Matched'}</span>
                            : <span className="badge w">Unmatched</span>}
                        </td>
                        <td>
                          <span className="badge">{methodLabel}</span>
                          {c.analysisConfidence === 'low' && <div style={{ marginTop: 4 }}><span className="badge w">Review</span></div>}
                        </td>
                        <td className="small">
                          <div>{c.nismSeries}</div>
                          <div className="muted">{c.cpeOrExamType}</div>
                        </td>
                        <td className="small" style={{ fontFamily: 'monospace' }}>
                          <div>{c.certificateNumber}</div>
                          {c.enrolmentNumber !== '—' && <div className="muted">Enrol: {c.enrolmentNumber}</div>}
                        </td>
                        <td className="small">{fmtDispDate(c.examDate)}</td>
                        <td>
                          <span className={'badge ' + expClass}>{fmtDispDate(c.expiryDate)} · {exp.label}</span>
                        </td>
                        <td className="small">
                          {c.cpeOrExamType === 'CPE' && c.marksObtained === 0
                            ? <span className="badge g">CPE · {c.passStatus}</span>
                            : c.marksObtained === 0 && c.percentage === 0
                              ? <span className={'badge ' + (c.passStatus === 'FAIL' ? 'r' : 'g')}>{c.passStatus}</span>
                              : <span>{c.marksObtained}/{c.totalMarks} ({c.percentage}%) <span className={'badge ' + (c.passStatus === 'FAIL' ? 'r' : 'g')}>{c.passStatus}</span></span>}
                        </td>
                        <td>
                          <div className="row" style={{ gap: 6 }}>
                            <button className="btn sm" onClick={() => setEditingCert({ ...c })} title="Edit parsed details">Edit</button>
                            <button className="btn sm" onClick={() => setInspectCert(c)} title="Inspect extracted OCR / PDF text and image preview">
                              {c.localPreviewUrl ? 'Preview' : 'Text'}
                            </button>
                            {c.webViewLink && (
                              <a className="btn sm" href={c.webViewLink} target="_blank" rel="noopener noreferrer">View</a>
                            )}
                            <button className="btn sm danger" onClick={() => removeCert(c)} title="Remove from list">✕</button>
                          </div>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            )}
          </div>
        </div>
      )}

      {tab === 'missing' && (
        <div className="card tscroll">
          {!directory.length ? (
            <div className="muted">Upload an Employee Directory first to see who is missing a NISM certificate.</div>
          ) : !matched.missingEmployees.length ? (
            <div className="alert ok">All {directory.length} employees in the directory have a matching NISM certificate.</div>
          ) : (
            <table className="t">
              <thead><tr><th>Employee ID</th><th>Name</th><th>Email</th><th>Department</th><th>Status</th></tr></thead>
              <tbody>
                {matched.missingEmployees.map((e, i) => (
                  <tr key={i}>
                    <td>{e.empId || '—'}</td>
                    <td><b>{e.name}</b></td>
                    <td className="small">{e.email || '—'}</td>
                    <td className="small">{e.department || '—'}</td>
                    <td><span className="badge r">Missing / Not uploaded</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      )}

      {tab === 'directory' && (
        <div className="card stack">
          <div className="row between wrap">
            <div>
              <h2 style={{ margin: 0 }}>Upload Employee Directory</h2>
              <p className="muted small" style={{ margin: 0 }}>Format: <code>empId, name, email, department</code> (CSV file or paste below). Matched against PDF &amp; image certificates by name, email &amp; employee ID.</p>
            </div>
            <label className="btn" style={{ cursor: 'pointer' }}>
              📄 Upload CSV
              <input type="file" accept=".csv,.txt" hidden onChange={handleDirectoryCsv} />
            </label>
          </div>
          <textarea rows={8} value={dirText} onChange={(e) => setDirText(e.target.value)} placeholder="FI1001, B Rajesh Chakravarthi Rao, rajesh@fundsindia.com, Trading & Quality" />
          <div className="row">
            <button className="btn primary" disabled={!dirText.trim()} onClick={() => saveDirectory(parseDirectoryLines(dirText))}>
              Save &amp; Match Directory
            </button>
          </div>
        </div>
      )}

      {/* Email Preview Modal */}
      {previewHtml && (
        <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && setPreviewHtml(null)}>
          <div className="modal" style={{ maxWidth: 1050 }}>
            <div className="row between" style={{ marginBottom: 12 }}>
              <h2 style={{ margin: 0 }}>Audit Email Preview → {auditEmail}</h2>
              <button className="btn sm ghost" onClick={() => setPreviewHtml(null)}>✕</button>
            </div>
            <iframe title="Email preview" srcDoc={previewHtml} style={{ width: '100%', height: '65vh', border: '1px solid var(--line)', borderRadius: 12, background: '#fff' }} />
          </div>
        </div>
      )}

      {/* Edit Parsed Certificate Modal */}
      {editingCert && (
        <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && setEditingCert(null)}>
          <div className="modal" style={{ maxWidth: 680 }}>
            <div className="row between" style={{ marginBottom: 12 }}>
              <h2 style={{ margin: 0 }}>Edit Certificate Details</h2>
              <button className="btn sm ghost" onClick={() => setEditingCert(null)}>✕</button>
            </div>
            <div className="muted small" style={{ marginBottom: 12 }}>{editingCert.fileName}</div>
            <div className="grid g2">
              <div>
                <label className="f" style={{ marginTop: 0 }}>Holder Name</label>
                <input value={editingCert.holderName} onChange={(e) => setEditingCert({ ...editingCert, holderName: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>NISM Series</label>
                <input value={editingCert.nismSeries} onChange={(e) => setEditingCert({ ...editingCert, nismSeries: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Certificate Number</label>
                <input value={editingCert.certificateNumber} onChange={(e) => setEditingCert({ ...editingCert, certificateNumber: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Enrolment Number</label>
                <input value={editingCert.enrolmentNumber} onChange={(e) => setEditingCert({ ...editingCert, enrolmentNumber: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Exam Date (YYYY-MM-DD)</label>
                <input type="date" value={editingCert.examDate} onChange={(e) => setEditingCert({ ...editingCert, examDate: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Valid Till / Expiry (YYYY-MM-DD)</label>
                <input type="date" value={editingCert.expiryDate} onChange={(e) => setEditingCert({ ...editingCert, expiryDate: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Marks Obtained</label>
                <input
                  type="number"
                  value={editingCert.marksObtained}
                  onChange={(e) => {
                    const m = Number(e.target.value) || 0;
                    const tot = editingCert.totalMarks || 100;
                    setEditingCert({ ...editingCert, marksObtained: m, percentage: tot ? Math.round((m / tot) * 10000) / 100 : 0 });
                  }}
                />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Total Marks</label>
                <input
                  type="number"
                  value={editingCert.totalMarks}
                  onChange={(e) => {
                    const tot = Number(e.target.value) || 100;
                    setEditingCert({ ...editingCert, totalMarks: tot, percentage: tot ? Math.round((editingCert.marksObtained / tot) * 10000) / 100 : 0 });
                  }}
                />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Exam Type</label>
                <select value={editingCert.cpeOrExamType} onChange={(e) => setEditingCert({ ...editingCert, cpeOrExamType: e.target.value })}>
                  <option value="Certification Examination">Certification Examination</option>
                  <option value="CPE">CPE</option>
                </select>
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Pass Status</label>
                <select value={editingCert.passStatus} onChange={(e) => setEditingCert({ ...editingCert, passStatus: e.target.value as 'PASS' | 'FAIL' })}>
                  <option value="PASS">PASS</option>
                  <option value="FAIL">FAIL</option>
                </select>
              </div>
            </div>
            <div className="row" style={{ marginTop: 18, justifyContent: 'flex-end' }}>
              <button className="btn" onClick={() => setEditingCert(null)}>Cancel</button>
              <button className="btn primary" onClick={saveEditedCert}>Save Changes</button>
            </div>
          </div>
        </div>
      )}

      {/* Inspect Extracted Text / Image Modal */}
      {inspectCert && (
        <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && setInspectCert(null)}>
          <div className="modal" style={{ maxWidth: 760 }}>
            <div className="row between" style={{ marginBottom: 12 }}>
              <h2 style={{ margin: 0 }}>Extracted Text — {inspectCert.fileName}</h2>
              <button className="btn sm ghost" onClick={() => setInspectCert(null)}>✕</button>
            </div>
            {inspectCert.localPreviewUrl && (
              <div style={{ marginBottom: 12, textAlign: 'center' }}>
                <img src={inspectCert.localPreviewUrl} alt={inspectCert.fileName} style={{ maxWidth: '100%', maxHeight: 280, borderRadius: 12, border: '1px solid var(--line)' }} />
              </div>
            )}
            <textarea readOnly rows={12} value={inspectCert.rawTextSnippet || '(No text extracted — use Edit to fill fields manually if this scan was unreadable.)'} />
          </div>
        </div>
      )}

      {/* Apps Script Setup Modal */}
      {showAppsScriptHelp && (
        <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && setShowAppsScriptHelp(false)}>
          <div className="modal" style={{ maxWidth: 720 }}>
            <div className="row between" style={{ marginBottom: 12 }}>
              <h2 style={{ margin: 0 }}>1-Minute Google Apps Script Mail Webhook</h2>
              <button className="btn sm ghost" onClick={() => setShowAppsScriptHelp(false)}>✕</button>
            </div>
            <p className="muted small">
              If Gmail API is disabled in Google Cloud Console, you can send emails directly from your <b>{googleEmail}</b> account via Google Apps Script (no GCP API enablement required):
            </p>
            <ol className="small" style={{ paddingLeft: 18, lineHeight: 1.7 }}>
              <li>Open <a href="https://script.google.com/" target="_blank" rel="noopener noreferrer">script.google.com ↗</a> signed in as <b>{googleEmail}</b> and click <b>New project</b>.</li>
              <li>Paste the code below, click <b>Deploy → New deployment → Web app</b>.</li>
              <li>Set <b>Execute as: Me</b> and <b>Who has access: Anyone</b>, then authorize &amp; copy the <code>/exec</code> URL.</li>
              <li>Paste that URL into <b>Apps Script / Mail Webhook</b> above and click <b>Save schedule &amp; webhook</b>.</li>
            </ol>
            <textarea readOnly rows={11} value={APPS_SCRIPT_SNIPPET} />
            <div className="row" style={{ marginTop: 12, justifyContent: 'flex-end' }}>
              <button
                className="btn primary"
                onClick={() => {
                  navigator.clipboard.writeText(APPS_SCRIPT_SNIPPET).then(() => setMsg('Copied Apps Script snippet to clipboard.')).catch(() => {});
                }}
              >
                📋 Copy Script
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
