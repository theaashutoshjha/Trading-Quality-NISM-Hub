import { ChangeEvent, useEffect, useMemo, useState } from 'react';
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
  buildAuditEmail,
  downloadDriveFileBytes,
  extractPdfText,
  fmtDispDate,
  getExpiryInfo,
  listDrivePdfs,
  loadJsonFromDrive,
  matchCertificatesWithDirectory,
  parseNismPdfText,
  requestGoogleToken,
  resolveOrCreateFolder,
  saveJsonToDrive,
  sendEmailViaGmail,
  uploadPdfToDrive,
} from './nismDrive';

const LS_CLIENT_ID = 'fi_google_client_id';
const LS_FOLDER = 'fi_nism_drive_folder';
const SS_TOKEN = 'fi_google_token_cache';

export function NismCertsPage() {
  const { me } = useStaff();
  const [clientId, setClientId] = useState(() => {
    try { return localStorage.getItem(LS_CLIENT_ID) || DEFAULT_CLIENT_ID; } catch { return DEFAULT_CLIENT_ID; }
  });
  const [folderInput, setFolderInput] = useState(() => {
    try { return localStorage.getItem(LS_FOLDER) || DEFAULT_FOLDER_URL; } catch { return DEFAULT_FOLDER_URL; }
  });
  const [googleEmail, setGoogleEmail] = useState(DEFAULT_GOOGLE_EMAIL);
  const [token, setToken] = useState('');
  const [folder, setFolder] = useState<{ id: string; name: string; webViewLink: string } | null>(null);
  const [certs, setCerts] = useState<DriveCertRecord[]>([]);
  const [directory, setDirectory] = useState<EmployeeEntry[]>([]);
  const [thresholdDays, setThresholdDays] = useState(90);
  const [auditEmail, setAuditEmail] = useState('qaudits@fundsindia.com');
  const [tab, setTab] = useState<'certs' | 'missing' | 'directory'>('certs');
  const [dirText, setDirText] = useState('');
  const [busy, setBusy] = useState('');
  const [err, setErr] = useState('');
  const [msg, setMsg] = useState('');
  const [previewHtml, setPreviewHtml] = useState<string | null>(null);
  const [sched, setSched] = useState({ enabled: true, recipient: 'qaudits@fundsindia.com', thresholdDays: 90, frequency: 'weekly', lastSentAt: '', webhookUrl: '' });
  const [schedSaved, setSchedSaved] = useState('');

  async function initFolderWithToken(tok: string, fldInput: string) {
    setToken(tok);
    const fld = await resolveOrCreateFolder(tok, fldInput);
    setFolder(fld);
    const [savedDir, savedCerts] = await Promise.all([
      loadJsonFromDrive<EmployeeEntry[]>(tok, fld.id, DIRECTORY_FILE_NAME),
      loadJsonFromDrive<DriveCertRecord[]>(tok, fld.id, ANALYSIS_CACHE_FILE_NAME),
    ]);
    if (Array.isArray(savedDir)) setDirectory(savedDir);
    if (Array.isArray(savedCerts)) setCerts(savedCerts);
    setMsg(`Connected to Google Drive folder "${fld.name}". Loaded ${savedCerts?.length || 0} analysed certificate(s) and ${savedDir?.length || 0} employee(s).`);
  }

  useEffect(() => {
    api.get('/api/admin/settings').then((r) => {
      if (r.settings?.nism_schedule) setSched((p) => ({ ...p, ...r.settings.nism_schedule }));
    }).catch(() => {});

    // Auto-restore cached token or attempt silent Google OAuth reconnect on mount
    let cachedTok = '';
    try {
      const raw = sessionStorage.getItem(SS_TOKEN);
      if (raw) {
        const parsed = JSON.parse(raw);
        if (parsed?.token && parsed?.expiresAt > Date.now() + 60_000) cachedTok = parsed.token;
      }
    } catch { /* ignore */ }

    if (cachedTok) {
      initFolderWithToken(cachedTok, folderInput).catch(() => {
        try { sessionStorage.removeItem(SS_TOKEN); } catch {}
        setToken('');
      });
    } else if (clientId) {
      requestGoogleToken(clientId, { silent: true, loginHint: googleEmail })
        .then(({ token: tok, expiresIn }) => {
          try { sessionStorage.setItem(SS_TOKEN, JSON.stringify({ token: tok, expiresAt: Date.now() + expiresIn * 1000 })); } catch {}
          return initFolderWithToken(tok, folderInput);
        })
        .catch(() => { /* silent auth not yet consented in this browser; user can click Connect once */ });
    }
  }, []); // eslint-disable-line

  async function saveSchedule() {
    await api.put('/api/admin/settings/nism_schedule', sched).catch(() => {});
    setSchedSaved('Schedule saved ✓');
    setTimeout(() => setSchedSaved(''), 2500);
  }

  const matched = useMemo(() => matchCertificatesWithDirectory(certs, directory), [certs, directory]);
  const expiringOrExpired = useMemo(
    () => matched.certs.filter((c) => {
      const st = getExpiryInfo(c.expiryDate, thresholdDays).status;
      return st === 'expired' || st === 'expiring_soon';
    }),
    [matched.certs, thresholdDays],
  );

  async function connectDrive() {
    setErr(''); setMsg('');
    if (!clientId.trim()) return setErr('Enter your Google OAuth Client ID first.');
    try {
      localStorage.setItem(LS_CLIENT_ID, clientId.trim());
      localStorage.setItem(LS_FOLDER, folderInput.trim());
    } catch { /* ignore */ }
    setBusy('Connecting to Google Drive & Gmail…');
    try {
      const { token: tok, expiresIn } = await requestGoogleToken(clientId, { loginHint: googleEmail });
      try { sessionStorage.setItem(SS_TOKEN, JSON.stringify({ token: tok, expiresAt: Date.now() + expiresIn * 1000 })); } catch {}
      await initFolderWithToken(tok, folderInput);
    } catch (e: any) {
      setErr(e.message || 'Google Drive connection failed.');
    } finally {
      setBusy('');
    }
  }

  async function scanDriveFolder() {
    if (!token || !folder) return setErr('Connect Google Drive first.');
    setErr(''); setMsg('');
    setBusy('Listing and analysing PDFs in Google Drive…');
    try {
      const files = await listDrivePdfs(token, folder.id);
      const out: DriveCertRecord[] = [];
      for (let i = 0; i < files.length; i++) {
        const f = files[i];
        setBusy(`Analysing ${i + 1}/${files.length}: ${f.name}…`);
        const bytes = await downloadDriveFileBytes(token, f.id);
        const text = await extractPdfText(bytes);
        const parsed = parseNismPdfText(text, f.name);
        out.push({ fileId: f.id, fileName: f.name, webViewLink: f.webViewLink, ...parsed });
      }
      setCerts(out);
      await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, out);
      setMsg(`Analysed ${out.length} PDF(s) from Google Drive and saved metadata to "${ANALYSIS_CACHE_FILE_NAME}" in Drive.`);
    } catch (e: any) {
      setErr(e.message || 'Failed to analyse Drive PDFs.');
    } finally {
      setBusy('');
    }
  }

  async function handlePdfUpload(e: ChangeEvent<HTMLInputElement>) {
    const files = Array.from(e.target.files || []);
    if (!files.length) return;
    if (!token || !folder) { setErr('Connect Google Drive first before uploading.'); return; }
    setErr(''); setMsg('');
    setBusy(`Uploading ${files.length} PDF(s) to Google Drive…`);
    try {
      const added: DriveCertRecord[] = [];
      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        setBusy(`Uploading & analysing ${i + 1}/${files.length}: ${file.name}…`);
        const uploaded = await uploadPdfToDrive(token, folder.id, file);
        const bytes = new Uint8Array(await file.arrayBuffer());
        const text = await extractPdfText(bytes);
        const parsed = parseNismPdfText(text, uploaded.name);
        added.push({ fileId: uploaded.id, fileName: uploaded.name, webViewLink: uploaded.webViewLink, ...parsed });
      }
      const next = [...added, ...certs.filter((c) => !added.some((a) => a.fileId === c.fileId))];
      setCerts(next);
      await saveJsonToDrive(token, folder.id, ANALYSIS_CACHE_FILE_NAME, next);
      setMsg(`Uploaded & analysed ${added.length} certificate(s) directly in Google Drive.`);
    } catch (x: any) {
      setErr(x.message || 'Upload failed.');
    } finally {
      setBusy('');
      e.target.value = '';
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
      setMsg(`Loaded ${entries.length} employee(s) in browser. Connect Google Drive to persist it in your Drive folder.`);
    }
  }

  function handleDirectoryCsv(e: ChangeEvent<HTMLInputElement>) {
    const f = e.target.files?.[0];
    if (!f) return;
    f.text().then((txt) => saveDirectory(parseDirectoryLines(txt)));
    e.target.value = '';
  }

  async function sendOneClickAuditEmail() {
    setErr(''); setMsg('');
    if (!token) return setErr('Connect Google Drive & Gmail first to send via Gmail.');
    const payload = buildAuditEmail({
      to: auditEmail.trim() || 'qaudits@fundsindia.com',
      expiringCerts: expiringOrExpired,
      missingEmployees: matched.missingEmployees,
      thresholdDays,
      actionedBy: me.email,
    });
    setBusy(`Sending audit email to ${payload.to}…`);
    try {
      await sendEmailViaGmail(token, payload);
      setMsg(`Audit email sent to ${payload.to} (${expiringOrExpired.length} expiring/expired · ${matched.missingEmployees.length} missing).`);
    } catch (e: any) {
      setErr(e.message || 'Failed to send email.');
    } finally {
      setBusy('');
    }
  }

  function openPreview() {
    const payload = buildAuditEmail({
      to: auditEmail.trim() || 'qaudits@fundsindia.com',
      expiringCerts: expiringOrExpired,
      missingEmployees: matched.missingEmployees,
      thresholdDays,
      actionedBy: me.email,
    });
    setPreviewHtml(payload.htmlBody);
  }

  return (
    <div className="stack">
      <div className="row between wrap">
        <div>
          <h1>NISM Certificate Compliance (Google Drive)</h1>
          <p className="muted" style={{ margin: 0 }}>
            All NISM PDFs, employee directory, and analysis data are stored and analysed directly in your <b>Google Drive</b> folder — nothing is saved to any database.
          </p>
        </div>
        {folder && (
          <a className="btn sm" href={folder.webViewLink} target="_blank" rel="noopener noreferrer">
            Open Drive folder ↗
          </a>
        )}
      </div>

      {err && <div className="alert err" role="alert">{err}</div>}
      {msg && <div className="alert ok">{msg}</div>}
      {busy && <div className="alert warn">⏳ {busy}</div>}

      {/* Google Drive Connection */}
      <div className="card stack">
        <div className="row between wrap">
          <h2 style={{ margin: 0 }}>1. Connect Google Drive &amp; Gmail</h2>
          <span className={'badge ' + (token ? 'g' : 'm')}>{token ? 'Connected ✓' : 'Not connected'}</span>
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
          <button className="btn" onClick={scanDriveFolder} disabled={!token || !!busy}>
            🔍 Scan &amp; Analyse Drive PDFs
          </button>
          <label className={'btn' + (!token ? ' disabled' : '')} style={{ cursor: token ? 'pointer' : 'not-allowed' }}>
            ⬆ Upload NISM PDFs to Drive
            <input type="file" accept="application/pdf" multiple hidden disabled={!token || !!busy} onChange={handlePdfUpload} />
          </label>
        </div>
      </div>

      {/* Summary Stats & One-Click Audit Email */}
      <div className="grid g4">
        <div className="card stat"><b>{matched.certs.length}</b><span>Drive certificates</span></div>
        <div className="card stat"><b>{directory.length}</b><span>Directory employees</span></div>
        <div className="card stat"><b style={{ color: 'var(--warn)' }}>{expiringOrExpired.length}</b><span>Expiring / Expired ({thresholdDays}d)</span></div>
        <div className="card stat"><b style={{ color: 'var(--err)' }}>{matched.missingEmployees.length}</b><span>Missing / Not uploaded</span></div>
      </div>

      <div className="card stack">
        <h2 style={{ margin: 0 }}>2. One-Click Audit Email</h2>
        <div className="row wrap" style={{ alignItems: 'flex-end' }}>
          <div style={{ flex: 1, minWidth: 220 }}>
            <label className="f" style={{ marginTop: 0 }}>Audit Recipient</label>
            <input value={auditEmail} onChange={(e) => setAuditEmail(e.target.value)} />
          </div>
          <div style={{ width: 150 }}>
            <label className="f" style={{ marginTop: 0 }}>Expiry window (days)</label>
            <input type="number" min={1} max={365} value={thresholdDays} onChange={(e) => setThresholdDays(Math.max(1, +e.target.value || 30))} />
          </div>
          <button className="btn" onClick={openPreview}>👁 Preview Email</button>
          <button className="btn primary" onClick={sendOneClickAuditEmail} disabled={!token || !!busy}>
            ✉ Send Audit Mail to {auditEmail || 'qaudits@fundsindia.com'}
          </button>
        </div>
        <div className="inset stack" style={{ gap: 10 }}>
          <div className="row between wrap">
            <div><b>Automated Weekly Schedule (Cron: Mondays 04:00 UTC)</b><div className="muted small">Runs automatically via Cloudflare Workers Cron; optional Apps Script Webhook dispatches email unattended.</div></div>
            {schedSaved && <span className="badge g">{schedSaved}</span>}
          </div>
          <div className="grid g3">
            <div><label className="f" style={{ marginTop: 0 }}>Auto-Schedule</label><select value={sched.enabled ? '1' : '0'} onChange={(e) => setSched({ ...sched, enabled: e.target.value === '1' })}><option value="1">Enabled (Weekly)</option><option value="0">Disabled</option></select></div>
            <div><label className="f" style={{ marginTop: 0 }}>Recipient Email</label><input value={sched.recipient} onChange={(e) => setSched({ ...sched, recipient: e.target.value })} /></div>
            <div><label className="f" style={{ marginTop: 0 }}>Apps Script / Mail Webhook (optional)</label><input value={sched.webhookUrl || ''} onChange={(e) => setSched({ ...sched, webhookUrl: e.target.value })} placeholder="https://script.google.com/macros/s/…" /></div>
          </div>
          <div className="row between wrap">
            <span className="muted small">{sched.lastSentAt ? `Last scheduled check: ${sched.lastSentAt}` : 'No scheduled run recorded yet.'}</span>
            <button type="button" className="btn sm primary" onClick={saveSchedule}>Save schedule</button>
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
        <div className="card tscroll">
          {!matched.certs.length ? (
            <div className="muted">No certificates analysed yet. Connect Google Drive and click <b>Scan &amp; Analyse Drive PDFs</b> or upload PDFs.</div>
          ) : (
            <table className="t">
              <thead><tr><th>Employee / Holder</th><th>Matched ID</th><th>NISM Series</th><th>Certificate #</th><th>Exam Date</th><th>Expiry</th><th>Score</th><th>PDF</th></tr></thead>
              <tbody>
                {matched.certs.map((c) => {
                  const exp = getExpiryInfo(c.expiryDate, thresholdDays);
                  return (
                    <tr key={c.fileId}>
                      <td><b>{c.matchedEmployee?.name || c.holderName}</b>{c.matchedEmployee?.email && <div className="muted small">{c.matchedEmployee.email}</div>}</td>
                      <td>{c.matchedEmployee ? <span className="badge g">{c.matchedEmployee.empId || 'Matched'}</span> : <span className="badge w">Unmatched</span>}</td>
                      <td className="small">{c.nismSeries}</td>
                      <td className="small">{c.certificateNumber}</td>
                      <td className="small">{fmtDispDate(c.examDate)}</td>
                      <td><span className={'badge ' + (exp.status === 'expired' ? 'r' : exp.status === 'expiring_soon' ? 'w' : 'g')}>{fmtDispDate(c.expiryDate)} · {exp.label}</span></td>
                      <td className="small">{c.marksObtained}/{c.totalMarks} ({c.percentage}%)</td>
                      <td><a className="btn sm" href={c.webViewLink} target="_blank" rel="noopener noreferrer">View</a></td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
        </div>
      )}

      {tab === 'missing' && (
        <div className="card tscroll">
          {!directory.length ? (
            <div className="muted">Upload an Employee Directory first to see who is missing a NISM certificate.</div>
          ) : !matched.missingEmployees.length ? (
            <div className="alert ok">All {directory.length} employees in the directory have a matching NISM certificate in Google Drive.</div>
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
              <p className="muted small" style={{ margin: 0 }}>Format: <code>empId, name, email, department</code> (CSV file or paste below). Matched against Drive PDFs by name &amp; employee ID.</p>
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
    </div>
  );
}
