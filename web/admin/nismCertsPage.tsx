import { ChangeEvent, DragEvent, useEffect, useMemo, useState } from 'react';
import { useStaff } from './App';
import { api } from '../shared/api';
import {
  ANALYSIS_CACHE_FILE_NAME,
  DEFAULT_CLIENT_ID,
  DEFAULT_FOLDER_URL,
  DEFAULT_GOOGLE_EMAIL,
  DEFAULT_TEAM_FOLDERS,
  DIRECTORY_FILE_NAME,
  DriveCertRecord,
  DriveSheetRef,
  DriveTeamFolder,
  EmployeeEntry,
  GoogleApiError,
  GoogleApiErrorDetails,
  analyseCertificateBytes,
  buildApiActivationUrl,
  buildAuditEmail,
  buildComplianceCsv,
  buildGmailComposeUrl,
  defaultRenewalStatus,
  detectCertFileType,
  downloadDriveFileBytes,
  ensureDriveSubfolder,
  extractProjectIdFromClientId,
  findDriveSheet,
  fmtDispDate,
  getExpiryInfo,
  importCertsFromDriveSheet,
  isSupportedCertFile,
  listDriveCertificates,
  listDriveTeamFolders,
  loadJsonFromDrive,
  matchCertificatesWithDirectory,
  requestGoogleToken,
  resolveOrCreateFolder,
  saveJsonToDrive,
  sendEmailViaGmail,
  syncCertsToDriveSheet,
  trashDriveFile,
  uploadCertificateToDrive,
} from './nismDrive';

const LS_CLIENT_ID = 'fi_google_client_id';
const LS_FOLDER = 'fi_nism_drive_folder';
const LS_GOOGLE_EMAIL = 'fi_google_sender_email';
const LS_UPLOAD_TEAM = 'fi_nism_upload_team';
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
type PageTab = 'certs' | 'sheet' | 'missing' | 'directory';

function getCertTeam(c: DriveCertRecord): string {
  return (
    c.team?.trim() ||
    (c.folderName ? c.folderName.split('/')[0].trim() : '') ||
    c.matchedEmployee?.department?.trim() ||
    'Unassigned'
  );
}

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
  const [driveTeamFolders, setDriveTeamFolders] = useState<DriveTeamFolder[]>([]);
  const [driveSheet, setDriveSheet] = useState<DriveSheetRef | null>(null);
  const [driveApiErr, setDriveApiErr] = useState<GoogleApiErrorDetails | null>(null);
  const [gmailApiErr, setGmailApiErr] = useState<GoogleApiErrorDetails | null>(null);

  const [uploadTeam, setUploadTeam] = useState(() => {
    try { return localStorage.getItem(LS_UPLOAD_TEAM) || ''; } catch { return ''; }
  });
  const [customTeamName, setCustomTeamName] = useState('');

  const [certs, setCerts] = useState<DriveCertRecord[]>([]);
  const [directory, setDirectory] = useState<EmployeeEntry[]>([]);
  const [thresholdDays, setThresholdDays] = useState(90);
  const [auditEmail, setAuditEmail] = useState('qaudits@fundsindia.com');
  const [tab, setTab] = useState<PageTab>('certs');
  const [dirText, setDirText] = useState('');
  const [busy, setBusy] = useState('');
  const [err, setErr] = useState('');
  const [msg, setMsg] = useState('');
  const [dragOver, setDragOver] = useState(false);

  const [searchQ, setSearchQ] = useState('');
  const [statusFilter, setStatusFilter] = useState<StatusFilter>('all');
  const [seriesFilter, setSeriesFilter] = useState('all');
  const [teamFilter, setTeamFilter] = useState('all');
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());

  const [previewHtml, setPreviewHtml] = useState<string | null>(null);
  const [editingCert, setEditingCert] = useState<DriveCertRecord | null>(null);
  const [pdfPassword, setPdfPassword] = useState('');
  const [unlockErr, setUnlockErr] = useState('');
  const [inspectCert, setInspectCert] = useState<DriveCertRecord | null>(null);
  const [showAppsScriptHelp, setShowAppsScriptHelp] = useState(false);

  const [sched, setSched] = useState({ enabled: true, recipient: 'qaudits@fundsindia.com', thresholdDays: 90, frequency: 'weekly', lastSentAt: '', webhookUrl: '' });
  const [schedSaved, setSchedSaved] = useState('');

  const driveConnected = Boolean(token && folder);
  const activeProjectId = driveApiErr?.projectId || gmailApiErr?.projectId || extractProjectIdFromClientId(clientId) || '841567171153';

  const teamOptions = useMemo(() => {
    const map = new Map<string, string>();
    for (const t of DEFAULT_TEAM_FOLDERS) map.set(t.toLowerCase(), t);
    for (const f of driveTeamFolders) map.set(f.name.trim().toLowerCase(), f.name.trim());
    for (const c of certs) {
      const t = c.team?.trim() || (c.folderName ? c.folderName.split('/')[0].trim() : '');
      if (t && t !== 'Uploaded Batch' && t !== 'Unassigned') map.set(t.toLowerCase(), t);
    }
    return Array.from(map.values()).sort((a, b) => a.localeCompare(b));
  }, [driveTeamFolders, certs]);

  const resolvedUploadTeam = uploadTeam === '__NEW__' ? customTeamName.trim() : uploadTeam.trim();

  async function initFolderWithToken(tok: string, fldInput: string) {
    setToken(tok);
    setFolder(null);
    setDriveApiErr(null);
    try {
      const fld = await resolveOrCreateFolder(tok, fldInput);
      setFolder(fld);
      const [savedDir, subfolders, existingSheet, liveFiles] = await Promise.all([
        loadJsonFromDrive<EmployeeEntry[]>(tok, fld.id, DIRECTORY_FILE_NAME),
        listDriveTeamFolders(tok, fld.id).catch(() => []),
        findDriveSheet(tok, fld.id).catch(() => null),
        listDriveCertificates(tok, fld.id).catch(() => null),
      ]);
      if (Array.isArray(savedDir) && savedDir.length) setDirectory(savedDir);

      // Load primary records from Google Sheet; if no Sheet exists yet, migrate any legacy JSON once or create the Sheet
      let activeCerts: DriveCertRecord[] = [];
      let sheetRef = existingSheet;
      let migratedFromJson = false;
      if (sheetRef) {
        activeCerts = await importCertsFromDriveSheet(tok, sheetRef.id).catch(() => []);
      } else {
        const legacy = await loadJsonFromDrive<DriveCertRecord[]>(tok, fld.id, ANALYSIS_CACHE_FILE_NAME);
        if (Array.isArray(legacy) && legacy.length) {
          activeCerts = legacy;
          migratedFromJson = true;
        }
      }

      let prunedCount = 0;
      let newInDriveCount = 0;
      if (liveFiles) {
        const liveById = new Map(liveFiles.map((f) => [f.id, f]));
        const before = activeCerts.length;
        activeCerts = activeCerts
          .filter((c) => {
            const isManualOrLocal = c.fileId.startsWith('manual_') || c.fileId.startsWith('local_') || c.source === 'local';
            return isManualOrLocal || liveById.has(c.fileId);
          })
          .map((c) => {
            const lf = liveById.get(c.fileId);
            if (!lf) return c;
            const folderTeam = lf.folderName ? lf.folderName.split('/')[0].trim() : '';
            return {
              ...c,
              fileName: lf.name,
              webViewLink: lf.webViewLink,
              folderName: lf.folderName || c.folderName,
              team: folderTeam || c.team,
            };
          });
        prunedCount = before - activeCerts.length;
        const cachedIds = new Set(activeCerts.map((c) => c.fileId));
        newInDriveCount = liveFiles.filter((f) => !cachedIds.has(f.id)).length;
      }

      if (!sheetRef || migratedFromJson || prunedCount > 0) {
        const m = matchCertificatesWithDirectory(activeCerts, Array.isArray(savedDir) ? savedDir : directory);
        sheetRef = await syncCertsToDriveSheet(tok, fld.id, m.certs, m.missingEmployees, thresholdDays, sheetRef?.id).catch(() => sheetRef);
      }

      setCerts(activeCerts);
      setDriveTeamFolders(subfolders);
      setDriveSheet(sheetRef);
      const extraNotes = [
        migratedFromJson ? 'migrated into Google Sheet' : '',
        prunedCount ? `removed ${prunedCount} deleted file(s)` : '',
        newInDriveCount ? `${newInDriveCount} new file(s) in Drive ready to scan` : '',
      ].filter(Boolean).join(' · ');
      setMsg(
        `Connected to Drive "${fld.name}" (${subfolders.length} team folder(s)) & Google Sheet "${sheetRef?.name || 'NISM Compliance Master Sheet'}". Loaded ${activeCerts.length} record(s)${extraNotes ? ` (${extraNotes})` : ''}.`,
      );
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
    const teamCounts = new Map<string, number>();
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
      const tKey = getCertTeam(c);
      teamCounts.set(tKey, (teamCounts.get(tKey) || 0) + 1);
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
      teamList: Array.from(teamCounts.entries()).sort((a, b) => b[1] - a[1]),
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

      if (teamFilter !== 'all' && getCertTeam(c) !== teamFilter) return false;

      if (q) {
        const hay = [
          c.holderName,
          c.empId,
          c.email,
          c.team,
          c.matchedEmployee?.name,
          c.matchedEmployee?.empId,
          c.matchedEmployee?.email,
          c.matchedEmployee?.department,
          c.nismSeries,
          c.certificateNumber,
          c.enrolmentNumber,
          c.fileName,
          c.folderName,
          c.remarks,
        ].filter(Boolean).join(' ').toLowerCase();
        if (!hay.includes(q)) return false;
      }
      return true;
    });
  }, [matched.certs, thresholdDays, statusFilter, seriesFilter, teamFilter, searchQ]);

  async function persistAllToDrive(nextCerts: DriveCertRecord[]) {
    if (!token || !folder) return;
    const m = matchCertificatesWithDirectory(nextCerts, directory);
    const ref = await syncCertsToDriveSheet(token, folder.id, m.certs, m.missingEmployees, thresholdDays, driveSheet?.id);
    setDriveSheet(ref);
  }

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
    if (!token || !folder) return setErr('Google Drive folder is not connected yet. Connect Google Drive first, or upload certificates directly below.');
    setErr(''); setMsg('');
    setBusy('Listing team folders, PDFs & Images in Google Drive…');
    try {
      const [files, subfolders] = await Promise.all([
        listDriveCertificates(token, folder.id),
        listDriveTeamFolders(token, folder.id).catch(() => []),
      ]);
      setDriveTeamFolders(subfolders);
      if (!files.length) {
        setCerts([]);
        setMsg(`No PDF or image certificates found inside "${folder.name}" (or its ${subfolders.length} team subfolders).`);
        return;
      }

      const prevByFileId = new Map(certs.map((c) => [c.fileId, c]));
      const out: DriveCertRecord[] = [];
      let lockedCount = 0;
      let errCount = 0;

      for (let i = 0; i < files.length; i++) {
        const f = files[i];
        const teamFromFolder = f.folderName ? f.folderName.split('/')[0].trim() : '';
        const prev = prevByFileId.get(f.id);
        setBusy(`Analysing ${i + 1}/${files.length}: ${f.name}${teamFromFolder ? ` (${teamFromFolder})` : ''}…`);
        try {
          const bytes = await downloadDriveFileBytes(token, f.id);
          const parsed = await analyseCertificateBytes({
            bytes,
            fileName: f.name,
            mimeType: f.mimeType,
            onProgress: (stage) => setBusy(`Analysing ${i + 1}/${files.length} (${f.name}): ${stage}`),
          });
          if (parsed.passwordProtected) lockedCount++;
          out.push({
            fileId: f.id,
            fileName: f.name,
            webViewLink: f.webViewLink,
            folderName: f.folderName,
            team: teamFromFolder || prev?.team || undefined,
            empId: prev?.empId,
            email: prev?.email,
            remarks: prev?.remarks,
            source: 'drive',
            ...parsed,
          });
        } catch (fileErr: any) {
          if (fileErr instanceof GoogleApiError && (fileErr.details.reason === 'SERVICE_DISABLED' || fileErr.details.reason === 'UNAUTHENTICATED')) {
            throw fileErr;
          }
          errCount++;
          out.push({
            fileId: f.id,
            fileName: f.name,
            webViewLink: f.webViewLink,
            folderName: f.folderName,
            team: teamFromFolder || prev?.team || undefined,
            empId: prev?.empId,
            email: prev?.email,
            remarks: prev?.remarks,
            source: 'drive',
            holderName: f.name.replace(/\.[^.]+$/, '').replace(/[_-]+/g, ' ').trim(),
            nismSeries: 'NISM Certification',
            certificateNumber: '—',
            enrolmentNumber: '—',
            examDate: '',
            expiryDate: '',
            marksObtained: 0,
            totalMarks: 100,
            percentage: 0,
            passStatus: 'PASS',
            cpeOrExamType: 'Certification Examination',
            fileType: f.fileType,
            mimeType: f.mimeType,
            extractionMethod: f.fileType === 'image' ? 'image-ocr' : 'pdf-text',
            analysisConfidence: 'low',
            extractionError: String(fileErr?.message || 'Could not download or analyse file.'),
          });
        }
        if ((i + 1) % 3 === 0 || i === files.length - 1) setCerts([...out]);
        if ((i + 1) % 25 === 0) {
          await persistAllToDrive(out).catch(() => {});
        }
      }

      const nowIso = new Date().toISOString();
      const stamped = out.map((c) => ({
        ...c,
        updatedAt: nowIso,
        renewalStatus: c.renewalStatus || defaultRenewalStatus(c.expiryDate, thresholdDays),
      }));
      setCerts(stamped);
      await persistAllToDrive(stamped);
      const pdfCount = stamped.filter((x) => x.fileType !== 'image').length;
      const imgCount = stamped.filter((x) => x.fileType === 'image').length;
      const notes = [
        lockedCount ? `${lockedCount} password-protected PDF(s)` : '',
        errCount ? `${errCount} file error(s)` : '',
      ].filter(Boolean).join(', ');
      setMsg(`Analysed ${stamped.length} file(s) (${pdfCount} PDF, ${imgCount} Image) across Drive team folders and saved to Google Sheet${notes ? ` — ${notes} (marked for review/unlock)` : ''}.`);
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

    if (!resolvedUploadTeam) {
      setErr('Please select a Team folder (e.g. CS, QA, Equity, Gold, Platinum) before uploading certificates so they are stored team-wise.');
      return;
    }

    setErr(''); setMsg('');
    try { localStorage.setItem(LS_UPLOAD_TEAM, resolvedUploadTeam); } catch { /* ignore */ }
    const useDrive = Boolean(token && folder);
    setBusy(`${useDrive ? `Uploading to "${resolvedUploadTeam}" & analysing` : `Analysing for "${resolvedUploadTeam}"`} ${files.length} certificate(s)…`);

    try {
      let targetFolderId = folder?.id || '';
      let teamFolderName = resolvedUploadTeam;
      if (useDrive && folder) {
        setBusy(`Opening/creating Drive team folder "${resolvedUploadTeam}"…`);
        const sub = await ensureDriveSubfolder(token, folder.id, resolvedUploadTeam);
        targetFolderId = sub.id;
        teamFolderName = sub.name;
        setDriveTeamFolders((prev) => (prev.some((x) => x.id === sub.id) ? prev : [...prev, sub].sort((a, b) => a.name.localeCompare(b.name))));
      }

      const added: DriveCertRecord[] = [];
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const ft = detectCertFileType(file.name, file.type) || 'pdf';
        try {
          const bytes = new Uint8Array(await file.arrayBuffer());
          let fileId = `local_${Date.now()}_${i}_${file.name}`;
          let webViewLink = '';
          let uploadedName = file.name;
          let uploadedMime = file.type;
          let source: 'drive' | 'local' = 'local';

          if (useDrive && targetFolderId) {
            setBusy(`Uploading ${i + 1}/${files.length} to "${teamFolderName}": ${file.name}…`);
            const uploaded = await uploadCertificateToDrive(token, targetFolderId, file);
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
            folderName: teamFolderName,
            team: teamFolderName,
            source,
            localPreviewUrl,
            ...parsed,
          });
        } catch (fileErr: any) {
          if (fileErr instanceof GoogleApiError && (fileErr.details.reason === 'SERVICE_DISABLED' || fileErr.details.reason === 'UNAUTHENTICATED')) {
            throw fileErr;
          }
          added.push({
            fileId: `local_${Date.now()}_${i}_${file.name}`,
            fileName: file.name,
            webViewLink: '',
            folderName: teamFolderName,
            team: teamFolderName,
            source: useDrive ? 'drive' : 'local',
            holderName: file.name.replace(/\.[^.]+$/, '').replace(/[_-]+/g, ' ').trim(),
            nismSeries: 'NISM Certification',
            certificateNumber: '—',
            enrolmentNumber: '—',
            examDate: '',
            expiryDate: '',
            marksObtained: 0,
            totalMarks: 100,
            percentage: 0,
            passStatus: 'PASS',
            cpeOrExamType: 'Certification Examination',
            fileType: ft,
            mimeType: file.type,
            extractionMethod: ft === 'image' ? 'image-ocr' : 'pdf-text',
            analysisConfidence: 'low',
            extractionError: String(fileErr?.message || 'Could not read uploaded file.'),
          });
        }
      }

      const nowIso = new Date().toISOString();
      const stampedAdded = added.map((c) => ({
        ...c,
        updatedAt: nowIso,
        renewalStatus: c.renewalStatus || defaultRenewalStatus(c.expiryDate, thresholdDays),
      }));
      const next = [...stampedAdded, ...certs.filter((c) => !stampedAdded.some((a) => a.fileId === c.fileId || (a.source === 'local' && a.fileName === c.fileName && a.team === c.team)))];
      setCerts(next);
      if (uploadTeam === '__NEW__') {
        setUploadTeam(teamFolderName);
        setCustomTeamName('');
      }

      if (useDrive && folder) {
        await persistAllToDrive(next);
        setMsg(`Uploaded ${stampedAdded.length} certificate(s) into team folder "${teamFolderName}" and saved to Google Sheet${skipped ? ` (${skipped} unsupported file(s) skipped)` : ''}.`);
      } else {
        setMsg(`Analysed ${stampedAdded.length} certificate(s) under team "${teamFolderName}" (${stampedAdded.filter((x) => x.fileType === 'pdf').length} PDF, ${stampedAdded.filter((x) => x.fileType === 'image').length} Image)${skipped ? ` · ${skipped} unsupported file(s) skipped` : ''}.`);
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

  async function syncSheetToDrive() {
    if (!token || !folder) return setErr('Connect Google Drive first to create/update the Google Sheet in Drive.');
    setErr(''); setMsg('');
    setBusy('Saving all records directly to Google Sheet in Drive…');
    try {
      await persistAllToDrive(certs);
      setMsg(`Saved ${certs.length} row(s) to Google Sheet "${driveSheet?.name || 'NISM Compliance Master Sheet'}" in Drive folder "${folder.name}".`);
    } catch (e: any) {
      setErr(e.message || 'Google Sheet sync failed.');
    } finally {
      setBusy('');
    }
  }

  async function pullFromDriveSheet() {
    if (!token || !folder || !driveSheet) return setErr('No Google Sheet found in this Drive folder yet. Click "Save & Sync Google Sheet" first.');
    setErr(''); setMsg('');
    setBusy(`Loading rows from Google Sheet "${driveSheet.name}"…`);
    try {
      const imported = await importCertsFromDriveSheet(token, driveSheet.id);
      if (!imported.length) {
        setMsg('Google Sheet has no certificate rows to import.');
        return;
      }
      const byKey = new Map(certs.map((c) => [c.fileId, c]));
      const merged = imported.map((row) => {
        const old = byKey.get(row.fileId);
        return old ? { ...old, ...row } : row;
      });
      setCerts(merged);
      setMsg(`Loaded ${merged.length} row(s) from Google Sheet "${driveSheet.name}".`);
    } catch (e: any) {
      setErr(e.message || 'Failed to load from Google Sheet.');
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
            if (!sched.webhookUrl) {
              setErr(e.message);
              return;
            }
          } else {
            throw e;
          }
        }
      }

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
    const cleaned: DriveCertRecord = {
      ...editingCert,
      folderName: editingCert.team || editingCert.folderName,
      renewalStatus: editingCert.renewalStatus || defaultRenewalStatus(editingCert.expiryDate, thresholdDays),
      updatedAt: new Date().toISOString(),
      analysisConfidence: 'high',
      passwordProtected: false,
      extractionError: undefined,
    };
    const updated = certs.map((c) => (c.fileId === cleaned.fileId ? cleaned : c));
    setCerts(updated);
    setEditingCert(null);
    setPdfPassword('');
    setUnlockErr('');
    if (token && folder) {
      try {
        await persistAllToDrive(updated);
        setMsg(`Updated "${cleaned.fileName}" and synced to Google Sheet.`);
      } catch (e: any) {
        setErr(e.message || 'Updated locally, but Google Sheet save failed.');
      }
    } else {
      setMsg(`Updated "${cleaned.fileName}".`);
    }
  }

  async function unlockDrivePdf() {
    if (!editingCert || !token || !pdfPassword) return;
    setUnlockErr('');
    setBusy(`Unlocking ${editingCert.fileName}…`);
    try {
      const bytes = await downloadDriveFileBytes(token, editingCert.fileId);
      const parsed = await analyseCertificateBytes({
        bytes,
        fileName: editingCert.fileName,
        mimeType: editingCert.mimeType,
        password: pdfPassword,
      });
      if (parsed.passwordProtected) {
        setUnlockErr(parsed.extractionError || 'Incorrect password.');
      } else {
        setEditingCert({ ...editingCert, ...parsed, passwordProtected: false, extractionError: undefined });
        setPdfPassword('');
      }
    } catch (e: any) {
      setUnlockErr(e?.message || 'Failed to unlock PDF.');
    } finally {
      setBusy('');
    }
  }

  async function removeCert(c: DriveCertRecord) {
    const isDriveBacked = Boolean(
      token && folder && c.source !== 'local' && !c.fileId.startsWith('manual_') && !c.fileId.startsWith('local_') && !c.fileId.startsWith('sheet_'),
    );
    if (isDriveBacked) {
      if (!confirm(`Remove "${c.fileName}" from the portal and move it to Trash in Google Drive?`)) return;
      try {
        await trashDriveFile(token, c.fileId);
      } catch (e: any) {
        setErr(e?.message || 'Could not trash file in Google Drive.');
        return;
      }
    }
    if (c.localPreviewUrl) URL.revokeObjectURL(c.localPreviewUrl);
    const updated = certs.filter((x) => x.fileId !== c.fileId);
    setCerts(updated);
    setSelectedIds((prev) => {
      const n = new Set(prev);
      n.delete(c.fileId);
      return n;
    });
    if (token && folder) {
      await persistAllToDrive(updated).catch(() => {});
    }
    setMsg(`Removed "${c.fileName}"${isDriveBacked ? ' and moved Drive file to Trash' : ''}.`);
  }

  function addBlankSheetRow() {
    const team = resolvedUploadTeam || (teamFilter !== 'all' ? teamFilter : '') || 'QA';
    const newRow: DriveCertRecord = {
      fileId: `manual_${Date.now()}_${Math.random().toString(36).slice(2, 7)}`,
      fileName: 'Manual Entry',
      webViewLink: '',
      holderName: 'New Employee',
      team,
      folderName: team,
      empId: '',
      email: '',
      nismSeries: 'NISM-Series-V-A',
      certificateNumber: '—',
      enrolmentNumber: '—',
      examDate: '',
      expiryDate: '',
      marksObtained: 0,
      totalMarks: 100,
      percentage: 0,
      passStatus: 'PASS',
      renewalStatus: 'Needs Review',
      updatedAt: new Date().toISOString(),
      cpeOrExamType: 'Certification Examination',
      fileType: 'pdf',
      extractionMethod: 'manual',
      analysisConfidence: 'high',
      source: 'local',
    };
    setCerts((prev) => [newRow, ...prev]);
    setTab('sheet');
    setMsg('Added a new row to the Master Sheet — fill in details and click "Save & Sync Google Sheet".');
  }

  function updateRowField(fileId: string, patch: Partial<DriveCertRecord>) {
    setCerts((prev) => prev.map((c) => {
      if (c.fileId !== fileId) return c;
      const merged: DriveCertRecord = {
        ...c,
        ...patch,
        updatedAt: new Date().toISOString(),
      };
      if ('marksObtained' in patch || 'totalMarks' in patch) {
        const tot = merged.totalMarks || 100;
        merged.percentage = tot > 0 ? Math.round((merged.marksObtained / tot) * 10000) / 100 : 0;
      }
      if ('team' in patch && patch.team !== undefined) {
        merged.folderName = patch.team;
      }
      if ('expiryDate' in patch && !('renewalStatus' in patch)) {
        const prevDefault = defaultRenewalStatus(c.expiryDate, thresholdDays);
        if (!c.renewalStatus || c.renewalStatus === prevDefault) {
          merged.renewalStatus = defaultRenewalStatus(merged.expiryDate, thresholdDays);
        }
      }
      return merged;
    }));
  }

  async function removeSelectedRows() {
    if (!selectedIds.size) return;
    const toRemove = certs.filter((c) => selectedIds.has(c.fileId));
    const driveFiles = toRemove.filter(
      (c) => token && folder && c.source !== 'local' && !c.fileId.startsWith('manual_') && !c.fileId.startsWith('local_') && !c.fileId.startsWith('sheet_'),
    );
    if (driveFiles.length > 0 && !confirm(`Remove ${toRemove.length} selected row(s) and move ${driveFiles.length} file(s) to Trash in Google Drive?`)) {
      return;
    }
    for (const df of driveFiles) {
      await trashDriveFile(token, df.fileId).catch(() => {});
    }
    const updated = certs.filter((c) => {
      if (selectedIds.has(c.fileId)) {
        if (c.localPreviewUrl) URL.revokeObjectURL(c.localPreviewUrl);
        return false;
      }
      return true;
    });
    setCerts(updated);
    setSelectedIds(new Set());
    if (token && folder) {
      await persistAllToDrive(updated).catch(() => {});
    }
    setMsg(`Removed ${toRemove.length} selected row(s)${driveFiles.length ? ` and moved ${driveFiles.length} Drive file(s) to Trash` : ''}.`);
  }

  const showApiDiagnostic = Boolean(driveApiErr?.reason === 'SERVICE_DISABLED' || gmailApiErr?.reason === 'SERVICE_DISABLED');
  const activeTeamFolderObj = driveTeamFolders.find((f) => f.name.trim().toLowerCase() === teamFilter.toLowerCase());

  return (
    <div className="stack">
      <div className="row between wrap">
        <div>
          <h1>NISM Certificate Compliance (Google Drive &amp; Sheet)</h1>
          <p className="muted" style={{ margin: 0 }}>
            Store certificates <b>team-wise</b> in Google Drive folders, analyse every <b>PDF &amp; Image</b> (Exam Date, Expiry, Score &amp; OCR), manage all records in the <b>Master Sheet</b>, and email compliance alerts.
          </p>
        </div>
        <div className="row wrap">
          {certs.length > 0 && (
            <button className="btn sm" onClick={exportCsv}>⬇ Export CSV ({matched.certs.length})</button>
          )}
          {driveSheet && (
            <a className="btn sm" href={driveSheet.webViewLink} target="_blank" rel="noopener noreferrer">
              📊 Open Google Sheet ↗
            </a>
          )}
          {folder && (
            <a className="btn sm" href={folder.webViewLink} target="_blank" rel="noopener noreferrer">
              📁 Open Drive folder ↗
            </a>
          )}
        </div>
      </div>

      {err && <div className="alert err" role="alert">{err}</div>}
      {msg && <div className="alert ok">{msg}</div>}
      {busy && <div className="alert warn">⏳ {busy}</div>}

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
            <a className="btn sm" href={driveApiErr?.activationUrl || buildApiActivationUrl('drive.googleapis.com', activeProjectId)} target="_blank" rel="noopener noreferrer">
              1. Enable Google Drive API (Project {activeProjectId}) ↗
            </a>
            <a className="btn sm" href={gmailApiErr?.activationUrl || buildApiActivationUrl('gmail.googleapis.com', activeProjectId)} target="_blank" rel="noopener noreferrer">
              2. Enable Gmail API (Project {activeProjectId}) ↗
            </a>
          </div>
        </div>
      )}

      {/* 1. Google Drive, Team Folder & Certificate Upload */}
      <div className="card stack">
        <div className="row between wrap">
          <h2 style={{ margin: 0 }}>1. Connect Google Drive &amp; Upload Team-Wise Certificates</h2>
          <div className="row wrap" style={{ gap: 8 }}>
            <span className={'badge ' + (token ? 'g' : 'm')}>{token ? 'Google Signed In ✓' : 'Not signed in'}</span>
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
            <label className="f" style={{ marginTop: 0 }}>Google Drive Root Folder URL or ID</label>
            <input value={folderInput} onChange={(e) => setFolderInput(e.target.value)} placeholder="https://drive.google.com/drive/folders/..." />
          </div>
        </div>

        {/* Team Folder Selector for Uploads */}
        <div className="inset stack" style={{ gap: 10 }}>
          <div className="grid g2">
            <div>
              <label className="f" style={{ marginTop: 0 }}>Team Folder for Upload (Required when uploading PDFs / Images)</label>
              <select
                value={uploadTeam}
                onChange={(e) => setUploadTeam(e.target.value)}
              >
                <option value="">-- Select Team Folder (Complaince, CS, Equity, Gold, QA…) --</option>
                {teamOptions.map((t) => (
                  <option key={t} value={t}>{t}</option>
                ))}
                <option value="__NEW__">+ Create New Team Folder…</option>
              </select>
            </div>
            {uploadTeam === '__NEW__' ? (
              <div>
                <label className="f" style={{ marginTop: 0 }}>New Team Folder Name</label>
                <input
                  value={customTeamName}
                  onChange={(e) => setCustomTeamName(e.target.value)}
                  placeholder="Enter new team folder name (e.g. Wealth Advisory)"
                />
              </div>
            ) : (
              <div className="small muted" style={{ alignSelf: 'end', paddingBottom: 8 }}>
                {resolvedUploadTeam
                  ? <>Uploads go into Drive subfolder <b>/{resolvedUploadTeam}/</b> (auto-created if missing).</>
                  : 'Choose a team above before selecting or dropping PDF / Image certificates.'}
              </div>
            )}
          </div>
        </div>

        <div className="row wrap">
          <button className="btn primary" onClick={connectDrive} disabled={!!busy}>
            {token ? '↻ Reconnect Google Drive, Sheets & Gmail' : '🔗 Connect Google Drive, Sheets & Gmail'}
          </button>
          <button className="btn" onClick={scanDriveFolder} disabled={!driveConnected || !!busy}>
            🔍 Scan &amp; Analyse All Drive (PDFs &amp; Images)
          </button>
          <label className={'btn good' + (!resolvedUploadTeam ? ' disabled' : '')} style={{ cursor: busy ? 'not-allowed' : 'pointer' }}>
            ⬆ Upload to {resolvedUploadTeam ? `"${resolvedUploadTeam}"` : 'Team Folder'} (PDF / Image)
            <input
              type="file"
              accept=".pdf,application/pdf,image/*,.png,.jpg,.jpeg,.webp,.bmp,.tif,.tiff,.gif,.jfif,.avif"
              multiple
              hidden
              disabled={!!busy}
              onChange={handleCertUpload}
            />
          </label>
          {driveConnected && (
            <button className="btn" onClick={syncSheetToDrive} disabled={!!busy}>
              📊 Save &amp; Sync Google Sheet
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
            Drop NISM Certificate PDFs or Images here {resolvedUploadTeam ? `→ Team "${resolvedUploadTeam}"` : '(select Team above first)'}
          </div>
          <div className="muted small">
            {driveConnected
              ? `Files are saved directly inside "${folder?.name}/${resolvedUploadTeam || '<Team>'}/", analysed for Exam Date, Expiry & Score, and listed in the Master Sheet.`
              : 'Works locally too — select a Team above, drop/upload PDFs or images, manage them in the Master Sheet, and send audit emails.'}
          </div>
        </div>

        {/* Team Subfolders Quick-Visit Bar */}
        {(driveTeamFolders.length > 0 || stats.teamList.length > 0) && (
          <div className="row wrap" style={{ gap: 6 }}>
            <span className="small muted" style={{ fontWeight: 700 }}>Teams:</span>
            <button type="button" className={'chip' + (teamFilter === 'all' ? ' on' : '')} onClick={() => setTeamFilter('all')}>
              All ({matched.certs.length})
            </button>
            {Array.from(new Set([...driveTeamFolders.map((f) => f.name), ...stats.teamList.map(([t]) => t)])).map((t) => {
              const cnt = stats.teamList.find(([k]) => k === t)?.[1] || 0;
              return (
                <button
                  key={t}
                  type="button"
                  className={'chip' + (teamFilter === t ? ' on' : '')}
                  onClick={() => setTeamFilter(t)}
                >
                  📁 {t} ({cnt})
                </button>
              );
            })}
            {activeTeamFolderObj && (
              <a className="btn sm" href={activeTeamFolderObj.webViewLink} target="_blank" rel="noopener noreferrer">
                Open "{activeTeamFolderObj.name}" in Drive ↗
              </a>
            )}
          </div>
        )}
      </div>

      {/* Summary Stats */}
      <div className="grid g4">
        <div className="card stat">
          <b>{matched.certs.length}</b>
          <span>Total certificates ({stats.pdfs} PDF · {stats.images} Img)</span>
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

      {/* Tabs: Certificates / Master Sheet / Missing / Directory */}
      <div className="tabs">
        <button className={tab === 'certs' ? 'on' : ''} onClick={() => setTab('certs')}>Analysed Certificates ({matched.certs.length})</button>
        <button className={tab === 'sheet' ? 'on' : ''} onClick={() => setTab('sheet')}>📊 Master Sheet ({matched.certs.length})</button>
        <button className={tab === 'missing' ? 'on' : ''} onClick={() => setTab('missing')}>Missing / Not Uploaded ({matched.missingEmployees.length})</button>
        <button className={tab === 'directory' ? 'on' : ''} onClick={() => setTab('directory')}>Employee Directory ({directory.length})</button>
      </div>

      {(tab === 'certs' || tab === 'sheet') && matched.certs.length > 0 && (
        <div className="card stack" style={{ padding: 14 }}>
          <div className="row wrap">
            <input
              style={{ flex: 1, minWidth: 220 }}
              value={searchQ}
              onChange={(e) => setSearchQ(e.target.value)}
              placeholder="Search by employee name, ID, team, certificate #, enrolment #, NISM series, or filename…"
            />
            <select style={{ width: 'auto', minWidth: 170 }} value={teamFilter} onChange={(e) => setTeamFilter(e.target.value)}>
              <option value="all">All Teams ({matched.certs.length})</option>
              {stats.teamList.map(([t, cnt]) => (
                <option key={t} value={t}>{t} ({cnt})</option>
              ))}
            </select>
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
        </div>
      )}

      {tab === 'certs' && (
        <div className="card tscroll">
          {!matched.certs.length ? (
            <div className="muted">
              No certificates analysed yet. Connect Google Drive and click <b>Scan &amp; Analyse All Drive (PDFs &amp; Images)</b>, or select a Team above and upload PDFs/Images.
            </div>
          ) : !filteredCerts.length ? (
            <div className="muted">No certificates match the current search/filter.</div>
          ) : (
            <table className="t">
              <thead>
                <tr>
                  <th>Employee / Holder</th>
                  <th>Team</th>
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
                  const teamName = getCertTeam(c);
                  return (
                    <tr key={c.fileId}>
                      <td>
                        <b>{c.matchedEmployee?.name || c.holderName}</b>
                        {(c.matchedEmployee?.email || c.email) && <div className="muted small">{c.matchedEmployee?.email || c.email}</div>}
                        {c.holderName && c.matchedEmployee && c.matchedEmployee.name.toLowerCase() !== c.holderName.toLowerCase() && (
                          <div className="muted small">Cert name: {c.holderName}</div>
                        )}
                        <div className="muted small">{c.fileName}</div>
                      </td>
                      <td><span className="badge m">{teamName}</span></td>
                      <td>
                        {c.matchedEmployee
                          ? <span className="badge g">{c.matchedEmployee.empId || 'Matched'}</span>
                          : c.empId
                            ? <span className="badge">{c.empId}</span>
                            : <span className="badge w">Unmatched</span>}
                      </td>
                      <td>
                        <span className="badge">{methodLabel}</span>
                        {c.passwordProtected && <div style={{ marginTop: 4 }}><span className="badge r">🔒 Locked PDF</span></div>}
                        {!c.passwordProtected && c.extractionError && <div style={{ marginTop: 4 }}><span className="badge r">⚠ Read Error</span></div>}
                        {!c.passwordProtected && !c.extractionError && c.analysisConfidence === 'low' && <div style={{ marginTop: 4 }}><span className="badge w">Review</span></div>}
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
                        {c.expiryInferred && <div className="muted small">(3yr rule)</div>}
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
                          <button className="btn sm" onClick={() => { setEditingCert({ ...c, team: getCertTeam(c) }); setPdfPassword(''); setUnlockErr(''); }} title="Edit parsed details">Edit</button>
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
      )}

      {/* 📊 Master Sheet Tab (Inline Add / Edit / Remove / Live 18-Column Google Sheet) */}
      {tab === 'sheet' && (
        <div className="card stack">
          <div className="row between wrap">
            <div>
              <h2 style={{ margin: 0 }}>Compliance Master Sheet</h2>
              <p className="muted small" style={{ margin: 0 }}>
                Add, edit, or remove any record directly inline. Syncs directly to the live 18-column <b>NISM Compliance Master Sheet</b> (Google Sheet) in your Drive folder.
              </p>
            </div>
            <div className="row wrap">
              <button className="btn sm good" onClick={addBlankSheetRow}>＋ Add Row</button>
              {selectedIds.size > 0 && (
                <button className="btn sm danger" onClick={removeSelectedRows}>🗑 Remove Selected ({selectedIds.size})</button>
              )}
              {driveConnected && (
                <>
                  <button className="btn sm primary" onClick={syncSheetToDrive} disabled={!!busy}>💾 Save &amp; Sync Google Sheet</button>
                  {driveSheet && (
                    <>
                      <button className="btn sm" onClick={pullFromDriveSheet} disabled={!!busy}>⬇ Pull Edits from Google Sheet</button>
                      <a className="btn sm" href={driveSheet.webViewLink} target="_blank" rel="noopener noreferrer">Open Google Sheet ↗</a>
                    </>
                  )}
                </>
              )}
              <button className="btn sm" onClick={exportCsv}>⬇ CSV</button>
            </div>
          </div>

          <div className="tscroll">
            {!filteredCerts.length ? (
              <div className="muted">No rows in sheet yet. Click <b>＋ Add Row</b> or scan/upload certificates above.</div>
            ) : (
              <table className="t" style={{ minWidth: 2150 }}>
                <thead>
                  <tr>
                    <th style={{ width: 32 }}>
                      <input
                        type="checkbox"
                        checked={filteredCerts.length > 0 && filteredCerts.every((c) => selectedIds.has(c.fileId))}
                        onChange={(e) => {
                          if (e.target.checked) setSelectedIds(new Set(filteredCerts.map((c) => c.fileId)));
                          else setSelectedIds(new Set());
                        }}
                      />
                    </th>
                    <th>Holder Name</th>
                    <th>Employee Code</th>
                    <th>Advisor Email</th>
                    <th>Department</th>
                    <th>NISM Series</th>
                    <th>Certificate No</th>
                    <th>Enrolment No</th>
                    <th>Exam Date</th>
                    <th>Valid Till</th>
                    <th>Days Remaining</th>
                    <th>Compliance Status</th>
                    <th>Marks Obtained</th>
                    <th>Total Marks</th>
                    <th>Percentage</th>
                    <th>Result</th>
                    <th>Renewal Status</th>
                    <th>Drive File Link</th>
                    <th>Updated At</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredCerts.map((c) => {
                    const exp = getExpiryInfo(c.expiryDate, thresholdDays);
                    const expClass = exp.status === 'expired' ? 'r' : exp.status === 'expiring_soon' ? 'w' : exp.status === 'active' ? 'g' : 'm';
                    const compStatus = exp.status === 'expired' ? 'Expired' : exp.status === 'expiring_soon' ? 'Expiring Soon' : exp.status === 'active' ? 'Active' : 'Unknown Date';
                    const cellInput = { padding: '6px 8px', fontSize: '.82rem', borderRadius: 8, minWidth: 95 };
                    return (
                      <tr key={c.fileId}>
                        <td>
                          <input
                            type="checkbox"
                            checked={selectedIds.has(c.fileId)}
                            onChange={(e) => {
                              setSelectedIds((prev) => {
                                const n = new Set(prev);
                                if (e.target.checked) n.add(c.fileId);
                                else n.delete(c.fileId);
                                return n;
                              });
                            }}
                          />
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 150 }}
                            value={c.holderName || c.matchedEmployee?.name || ''}
                            onChange={(e) => updateRowField(c.fileId, { holderName: e.target.value })}
                          />
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, width: 92, minWidth: 92 }}
                            value={c.empId ?? c.matchedEmployee?.empId ?? ''}
                            onChange={(e) => updateRowField(c.fileId, { empId: e.target.value })}
                            placeholder="FI..."
                          />
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 170 }}
                            value={c.email ?? c.matchedEmployee?.email ?? ''}
                            onChange={(e) => updateRowField(c.fileId, { email: e.target.value })}
                            placeholder="name@fundsindia.com"
                          />
                        </td>
                        <td>
                          <select
                            style={{ ...cellInput, minWidth: 118 }}
                            value={getCertTeam(c)}
                            onChange={(e) => updateRowField(c.fileId, { team: e.target.value })}
                          >
                            {!teamOptions.includes(getCertTeam(c)) && <option value={getCertTeam(c)}>{getCertTeam(c)}</option>}
                            {teamOptions.map((t) => <option key={t} value={t}>{t}</option>)}
                          </select>
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 185 }}
                            value={c.nismSeries}
                            onChange={(e) => updateRowField(c.fileId, { nismSeries: e.target.value })}
                          />
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 140, fontFamily: 'monospace' }}
                            value={c.certificateNumber}
                            onChange={(e) => updateRowField(c.fileId, { certificateNumber: e.target.value })}
                          />
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 115, fontFamily: 'monospace' }}
                            value={c.enrolmentNumber}
                            onChange={(e) => updateRowField(c.fileId, { enrolmentNumber: e.target.value })}
                          />
                        </td>
                        <td>
                          <input
                            type="date"
                            style={{ ...cellInput, minWidth: 132 }}
                            value={c.examDate}
                            onChange={(e) => updateRowField(c.fileId, { examDate: e.target.value })}
                          />
                        </td>
                        <td>
                          <input
                            type="date"
                            style={{ ...cellInput, minWidth: 132 }}
                            value={c.expiryDate}
                            onChange={(e) => updateRowField(c.fileId, { expiryDate: e.target.value, expiryInferred: false })}
                          />
                        </td>
                        <td className="small" style={{ fontWeight: 700, whiteSpace: 'nowrap' }}>
                          {exp.status === 'unknown' ? '—' : `${exp.daysRemaining} d`}
                        </td>
                        <td style={{ whiteSpace: 'nowrap' }}>
                          <span className={'badge ' + expClass}>{compStatus}</span>
                        </td>
                        <td>
                          <input
                            type="number"
                            style={{ ...cellInput, width: 72, minWidth: 72 }}
                            value={c.marksObtained}
                            onChange={(e) => updateRowField(c.fileId, { marksObtained: Number(e.target.value) || 0 })}
                          />
                        </td>
                        <td>
                          <input
                            type="number"
                            style={{ ...cellInput, width: 72, minWidth: 72 }}
                            value={c.totalMarks}
                            onChange={(e) => updateRowField(c.fileId, { totalMarks: Number(e.target.value) || 100 })}
                          />
                        </td>
                        <td className="small" style={{ fontWeight: 700 }}>{c.percentage}%</td>
                        <td>
                          <select
                            style={{ ...cellInput, width: 80, minWidth: 80 }}
                            value={c.passStatus}
                            onChange={(e) => updateRowField(c.fileId, { passStatus: e.target.value as 'PASS' | 'FAIL' })}
                          >
                            <option value="PASS">PASS</option>
                            <option value="FAIL">FAIL</option>
                          </select>
                        </td>
                        <td>
                          <input
                            style={{ ...cellInput, minWidth: 165 }}
                            value={c.renewalStatus ?? defaultRenewalStatus(c.expiryDate, thresholdDays)}
                            onChange={(e) => updateRowField(c.fileId, { renewalStatus: e.target.value })}
                            placeholder="Active / Renewal Pending"
                          />
                        </td>
                        <td>
                          <div className="row" style={{ gap: 4, flexWrap: 'nowrap' }}>
                            <input
                              style={{ ...cellInput, minWidth: 145 }}
                              value={c.webViewLink || ''}
                              onChange={(e) => updateRowField(c.fileId, { webViewLink: e.target.value })}
                              placeholder="https://drive.google.com/..."
                            />
                            {c.webViewLink && (
                              <a className="btn sm" href={c.webViewLink} target="_blank" rel="noopener noreferrer" title="Open Drive file">↗</a>
                            )}
                          </div>
                        </td>
                        <td className="small muted" style={{ whiteSpace: 'nowrap' }}>
                          {c.updatedAt ? c.updatedAt.slice(0, 19).replace('T', ' ') : '—'}
                        </td>
                        <td>
                          <div className="row" style={{ gap: 6 }}>
                            <button className="btn sm danger" onClick={() => removeCert(c)} title="Remove row (and trash Drive file)">✕</button>
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
              <thead><tr><th>Employee ID</th><th>Name</th><th>Email</th><th>Department / Team</th><th>Status</th></tr></thead>
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
          <div className="modal" style={{ maxWidth: 700 }}>
            <div className="row between" style={{ marginBottom: 12 }}>
              <h2 style={{ margin: 0 }}>Edit Certificate Details</h2>
              <button className="btn sm ghost" onClick={() => setEditingCert(null)}>✕</button>
            </div>
            <div className="muted small" style={{ marginBottom: 12 }}>{editingCert.fileName}</div>
            {editingCert.extractionError && (
              <div className="alert warn" style={{ marginTop: 0 }}>
                <div>{editingCert.extractionError}</div>
                {editingCert.passwordProtected && editingCert.source === 'drive' && token && (
                  <div className="row wrap" style={{ marginTop: 8 }}>
                    <input
                      type="password"
                      style={{ flex: 1, minWidth: 180 }}
                      value={pdfPassword}
                      onChange={(e) => setPdfPassword(e.target.value)}
                      placeholder="Enter PDF password to unlock & extract…"
                    />
                    <button type="button" className="btn sm primary" disabled={!pdfPassword || !!busy} onClick={unlockDrivePdf}>
                      🔓 Unlock &amp; Re-analyse
                    </button>
                  </div>
                )}
                {unlockErr && <div className="small" style={{ color: 'var(--err)', marginTop: 6 }}>{unlockErr}</div>}
              </div>
            )}
            <div className="grid g2">
              <div>
                <label className="f" style={{ marginTop: 0 }}>Team / Folder</label>
                <select value={editingCert.team || ''} onChange={(e) => setEditingCert({ ...editingCert, team: e.target.value })}>
                  <option value="">Unassigned</option>
                  {editingCert.team && !teamOptions.includes(editingCert.team) && <option value={editingCert.team}>{editingCert.team}</option>}
                  {teamOptions.map((t) => <option key={t} value={t}>{t}</option>)}
                </select>
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Holder Name</label>
                <input value={editingCert.holderName} onChange={(e) => setEditingCert({ ...editingCert, holderName: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Employee ID</label>
                <input value={editingCert.empId || ''} onChange={(e) => setEditingCert({ ...editingCert, empId: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Employee Email</label>
                <input value={editingCert.email || ''} onChange={(e) => setEditingCert({ ...editingCert, email: e.target.value })} />
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
                <label className="f" style={{ marginTop: 0 }}>Exam Type</label>
                <select value={editingCert.cpeOrExamType} onChange={(e) => setEditingCert({ ...editingCert, cpeOrExamType: e.target.value })}>
                  <option value="Certification Examination">Certification Examination</option>
                  <option value="CPE">CPE</option>
                </select>
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Exam Date (YYYY-MM-DD)</label>
                <input type="date" value={editingCert.examDate} onChange={(e) => setEditingCert({ ...editingCert, examDate: e.target.value })} />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Valid Till / Expiry (YYYY-MM-DD)</label>
                <input type="date" value={editingCert.expiryDate} onChange={(e) => setEditingCert({ ...editingCert, expiryDate: e.target.value, expiryInferred: false })} />
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
                <label className="f" style={{ marginTop: 0 }}>Pass Status</label>
                <select value={editingCert.passStatus} onChange={(e) => setEditingCert({ ...editingCert, passStatus: e.target.value as 'PASS' | 'FAIL' })}>
                  <option value="PASS">PASS</option>
                  <option value="FAIL">FAIL</option>
                </select>
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Renewal Status</label>
                <input
                  value={editingCert.renewalStatus ?? defaultRenewalStatus(editingCert.expiryDate, thresholdDays)}
                  onChange={(e) => setEditingCert({ ...editingCert, renewalStatus: e.target.value })}
                  placeholder="Active / Renewal Required"
                />
              </div>
              <div>
                <label className="f" style={{ marginTop: 0 }}>Remarks</label>
                <input value={editingCert.remarks || ''} onChange={(e) => setEditingCert({ ...editingCert, remarks: e.target.value })} />
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
