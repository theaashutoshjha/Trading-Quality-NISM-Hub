import { FormEvent, ReactNode, useEffect, useState } from 'react';
import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom';
import QRCode from 'qrcode';
import { api } from '../shared/api';
import { CATEGORIES, ErrorBox, Markdown, Spinner, ThemeSettings, fmtDate, fmtDateTime, useLoad } from '../shared/components';
import { useStaff } from './App';

/* ---------- small helpers ---------- */
function Modal({ title, onClose, children, wide }: { title: string; onClose: () => void; children: ReactNode; wide?: boolean }) {
  useEffect(() => {
    const k = (e: KeyboardEvent) => e.key === 'Escape' && onClose();
    window.addEventListener('keydown', k);
    return () => window.removeEventListener('keydown', k);
  }, [onClose]);
  return (
    <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && onClose()}>
      <div className="modal" role="dialog" aria-modal="true" aria-label={title} style={wide ? { maxWidth: 860 } : undefined}>
        <div className="row between"><h2 style={{ margin: 0 }}>{title}</h2><button className="btn sm ghost" onClick={onClose} aria-label="Close">✕</button></div>
        {children}
      </div>
    </div>
  );
}
function useToast() {
  const [t, setT] = useState('');
  useEffect(() => { if (t) { const x = setTimeout(() => setT(''), 2600); return () => clearTimeout(x); } }, [t]);
  return [t ? <div className="toast" role="status">{t}</div> : null, setT] as const;
}
const Field = ({ label, children }: { label: string; children: ReactNode }) => (<div><label className="f">{label}</label>{children}</div>);
const Check = ({ label, checked, onChange }: { label: string; checked: boolean; onChange: (v: boolean) => void }) => (
  <label className="row small" style={{ marginTop: 14 }}><input type="checkbox" checked={checked} onChange={(e) => onChange(e.target.checked)} /> {label}</label>
);
const confirmDel = (what: string) => confirm(`Delete ${what}? This cannot be undone.`);

/* ---------- Overview ---------- */
export function Overview() {
  const r = useLoad(() => api.get('/api/admin/stats'));
  const qs = useLoad(() => api.get('/api/admin/question-stats'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const t = r.data.totals;
  const stat = (n: any, l: string, to?: string) => (<div className="card stat"><b>{n ?? 0}</b><span>{to ? <Link to={to}>{l}</Link> : l}</span></div>);
  return (
    <div className="stack">
      <h1>Overview</h1>
      <div className="grid g4">
        {stat(t.learners, 'Active learners', '/users')}{stat(t.active7, 'Learning in last 7 days')}{stat(t.courses, 'Courses', '/courses')}{stat(t.lessons, 'Lessons')}
        {stat(t.questions, 'Questions in bank')}{stat(t.avg_score != null ? t.avg_score + '%' : '—', 'Average quiz score')}{stat(t.certs, 'Certificates issued')}
      </div>
      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card"><h2>Most-studied courses</h2>{!r.data.topCourses.length ? <div className="muted">No activity yet.</div> : r.data.topCourses.map((c: any) => <div key={c.code} className="row between lesson-row"><span>{c.title}</span><b>{c.learners}</b></div>)}</div>
        <div className="card"><h2>Weakest quizzes</h2><div className="muted small">Lowest average score (3+ attempts) — review these questions.</div>{r.data.weakQuizzes.map((c: any) => <div key={c.title} className="row between lesson-row"><span>{c.title}</span><b>{c.avg}%</b></div>)}</div>
      </div>
      {qs.data?.stats?.length > 0 && (
        <div className="card">
          <h2>Question-level accuracy (lowest pass rate)</h2>
          <div className="tscroll"><table className="t"><thead><tr><th>Question</th><th>Course</th><th>Tries</th><th>Pass rate</th></tr></thead><tbody>
            {qs.data.stats.slice(0, 10).map((q: any) => (
              <tr key={q.id}><td className="small">{q.question.slice(0, 110)}</td><td><span className="badge">{q.course_code}</span></td><td>{q.total_tries}</td><td><span className={'badge ' + (q.pass_rate < 50 ? 'r' : 'w')}>{q.pass_rate}%</span></td></tr>
            ))}
          </tbody></table></div>
        </div>
      )}
      <div className="card"><h2>Recent quiz attempts</h2>
        <div className="tscroll"><table className="t"><thead><tr><th>Learner</th><th>Quiz</th><th>Score</th><th>When</th></tr></thead><tbody>
          {r.data.recent.map((a: any, i: number) => <tr key={i}><td>{a.name}<div className="muted small">{a.email}</div></td><td>{a.title}</td><td><span className={'badge ' + (a.passed ? 'g' : 'r')}>{a.pct}%</span></td><td>{fmtDateTime(a.created_at)}</td></tr>)}
        </tbody></table></div></div>
    </div>
  );
}

/* ---------- Users ---------- */
export const TEAMS = ['MF Onboarding', 'MF Digital', 'MF Silver', 'MF Gold', 'MF Platinum', 'Equity Onboarding', 'Equity Regular', 'Customer Support', 'Training & Quality'];
const TeamSelect = ({ value, onChange, teams }: { value: string; onChange: (e: any) => void; teams: string[] }) => (
  <select value={value} onChange={onChange}><option value="">— no team (learners need a team) —</option>{teams.map((t) => <option key={t} value={t}>{t}</option>)}</select>
);
export function UsersPage() {
  const r = useLoad(() => api.get('/api/admin/users'));
  const tm = useLoad(() => api.get('/api/admin/teams'));
  const teamNames: string[] = (tm.data?.teams || []).map((x: any) => x.name);
  const [roleTab, setRoleTab] = useState<'learner' | 'head' | 'trainer' | 'admin'>('learner');
  const [q, setQ] = useState('');
  const [modal, setModal] = useState<null | 'add' | 'bulk' | any>(null);
  const [creds, setCreds] = useState<{ email: string; password: string }[] | null>(null);
  const [progFor, setProgFor] = useState<any>(null);
  const [toast, say] = useToast();
  const { me } = useStaff();
  const allUsers: any[] = r.data?.users || [];
  const counts = {
    learner: allUsers.filter((u) => u.role === 'learner').length,
    head: allUsers.filter((u) => u.role === 'head').length,
    trainer: allUsers.filter((u) => u.role === 'trainer').length,
    admin: allUsers.filter((u) => u.role === 'admin').length,
  };
  const users = allUsers.filter((u) => u.role === roleTab && (!q || (u.name + u.email + (u.emp_id || '') + (u.team || '')).toLowerCase().includes(q.toLowerCase())));
  const roleLabel = roleTab === 'learner' ? 'Learner' : roleTab === 'head' ? 'Team Head' : roleTab === 'trainer' ? 'Trainer' : 'Admin';

  async function act(fn: () => Promise<any>, ok: string) { try { await fn(); say(ok); r.reload(); } catch (e: any) { alert(e.message); } }
  async function reset(u: any) {
    if (!confirm(`Reset password for ${u.email}? They will be signed out.`)) return;
    try { const x = await api.post(`/api/admin/users/${u.id}/reset`); setCreds([{ email: u.email, password: x.password }]); } catch (e: any) { alert(e.message); }
  }
  return (
    <div className="stack">
      {toast}
      <div className="row between wrap">
        <div><h1>Users & access</h1><p className="muted" style={{ margin: 0 }}>Manage Learners, Team Heads (1 team each), Trainers, and Administrators separately.</p></div>
        <div className="row"><button className="btn primary" onClick={() => setModal('add')}>＋ Add {roleLabel}</button>{roleTab === 'learner' && <button className="btn" onClick={() => setModal('bulk')}>⬆ Bulk add (CSV)</button>}</div>
      </div>
      <div className="tabs">
        <button className={roleTab === 'learner' ? 'on' : ''} onClick={() => setRoleTab('learner')}>👥 Learners ({counts.learner})</button>
        <button className={roleTab === 'head' ? 'on' : ''} onClick={() => setRoleTab('head')}>🧑‍💼 Team Heads ({counts.head})</button>
        <button className={roleTab === 'trainer' ? 'on' : ''} onClick={() => setRoleTab('trainer')}>🎓 Trainers ({counts.trainer})</button>
        <button className={roleTab === 'admin' ? 'on' : ''} onClick={() => setRoleTab('admin')}>🛡️ Admins ({counts.admin})</button>
      </div>
      <input placeholder={`Search ${roleLabel.toLowerCase()}s by name, e-mail, ID, or team…`} value={q} onChange={(e) => setQ(e.target.value)} aria-label="Search users" />
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} /> : (
        <div className="card tscroll"><table className="t"><thead><tr><th>User</th><th>{roleTab === 'head' ? 'Managed team' : 'Team / Access'}</th><th>Status</th><th>Progress</th><th>Last login</th><th></th></tr></thead><tbody>
          {users.map((u: any) => (
            <tr key={u.id}>
              <td><b>{u.name}</b><div className="muted small">{u.email}{u.emp_id ? ` · ID ${u.emp_id}` : ''}{u.department ? ` · ${u.department}` : ''}</div></td>
              <td>{u.role === 'admin' ? <span className="badge r">100% Full Access</span> : u.role === 'trainer' ? <span className="badge w">All Content</span> : (u.team ? <span className="badge">{u.team}</span> : <span className="badge r">No team</span>)}{u.totp_enabled ? <span className="badge g" style={{ marginLeft: 6 }}>2FA</span> : null}</td>
              <td><span className={'badge ' + (u.status === 'active' ? 'g' : u.status === 'pending' ? 'w' : 'r')}>{u.status}</span></td>
              <td className="small">{u.lessons} lessons · {u.avg_score ?? '—'}% avg · {u.certs} cert</td>
              <td className="small">{fmtDateTime(u.last_login)}</td>
              <td className="row wrap" style={{ justifyContent: 'flex-end' }}>
                {u.status === 'pending' && <button className="btn sm good" onClick={() => act(() => api.put('/api/admin/users/' + u.id, { ...u, empId: u.emp_id, status: 'active' }), 'Approved')}>Approve</button>}
                {u.role === 'learner' && <button className="btn sm" onClick={() => setProgFor(u)}>Progress</button>}
                <button className="btn sm" onClick={() => setModal(u)}>Edit</button>
                <button className="btn sm" onClick={() => reset(u)}>Reset pw</button>
                {u.id !== me.id && <button className="btn sm danger" onClick={() => prompt(`This permanently erases ${u.name}'s account AND all their learning data.\n\nTo continue, type their e-mail: ${u.email}`) === u.email && act(() => api.del('/api/admin/users/' + u.id), 'Deleted')}>Delete</button>}
              </td>
            </tr>))}
        </tbody></table>{!users.length && <div className="muted" style={{ padding: 16 }}>No {roleLabel.toLowerCase()}s yet.</div>}</div>)}

      {progFor && <UserProgress u={progFor} onClose={() => setProgFor(null)} />}
      {modal === 'add' && <AddUser defaultRole={roleTab} teams={teamNames} onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal === 'bulk' && <BulkUsers teams={teamNames} onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal && typeof modal === 'object' && <EditUser u={modal} teams={teamNames} self={modal.id === me.id} onClose={() => setModal(null)} onDone={() => { setModal(null); say('Saved'); r.reload(); }} />}
      {creds && (
        <Modal title="Temporary passwords" onClose={() => setCreds(null)}>
          <div className="alert warn">Shown <b>once</b>. Share securely; users must change it at first sign-in.</div>
          <textarea readOnly rows={Math.min(12, creds.length + 1)} value={creds.map((c) => `${c.email}\t${c.password}`).join('\n')} onFocus={(e) => e.target.select()} />
          <div className="row wrap" style={{ marginTop: 12 }}>
            <button className="btn primary" onClick={() => navigator.clipboard?.writeText(creds.map((c) => `${c.email}\t${c.password}`).join('\n'))}>Copy</button>
            <button className="btn" onClick={() => {
              const csv = 'email,temporary_password\n' + creds.map((c) => `${c.email},${c.password}`).join('\n');
              const a = document.createElement('a');
              a.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }));
              a.download = 'fundsindia-temp-credentials.csv';
              a.click();
            }}>⬇ Download CSV</button>
            <button className="btn" onClick={() => setCreds(null)}>Done</button>
          </div>
        </Modal>)}
    </div>
  );
}
function UserProgress({ u, onClose }: { u: any; onClose: () => void }) {
  const r = useLoad(() => api.get(`/api/admin/users/${u.id}/progress`));
  return (
    <Modal title={u.name + ' — progress'} onClose={onClose} wide>
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} /> : (<div className="stack">
        <div><h3>Courses</h3>{!r.data.courses.length ? <div className="muted">No activity yet.</div> : r.data.courses.map((c: any) => <div key={c.code} className="row between lesson-row"><span>{c.title}</span><b>{c.done}/{c.total}</b></div>)}</div>
        <div><h3>Quiz attempts</h3>{!r.data.attempts.length ? <div className="muted">None.</div> : r.data.attempts.map((a: any, i: number) => <div key={i} className="row between lesson-row"><span>{a.title}</span><span><span className={'badge ' + (a.passed ? 'g' : 'r')}>{a.pct}%</span> <span className="muted small">{fmtDate(a.created_at)}</span></span></div>)}</div>
        <div><h3>Certificates</h3>{!r.data.certificates.length ? <div className="muted">None.</div> : r.data.certificates.map((c: any) => (
          <div key={c.id} className="row between lesson-row">
            <span>🏅 {c.title} — {c.pct}% · <code>{c.id}</code> {c.revoked ? <span className="badge r">Revoked</span> : <span className="badge g">Active</span>}</span>
            <button className={'btn sm ' + (c.revoked ? 'good' : 'danger')} onClick={async () => { await api.post(`/api/admin/certificates/${c.id}/${c.revoked ? 'reissue' : 'revoke'}`); r.reload(); }}>
              {c.revoked ? 'Re-issue' : 'Revoke'}
            </button>
          </div>
        ))}</div>
      </div>)}
    </Modal>
  );
}
function AddUser({ defaultRole, teams, onClose, onDone }: { defaultRole: string; teams: string[]; onClose: () => void; onDone: (c: any[]) => void }) {
  const [f, setF] = useState({ name: '', email: '', empId: '', department: '', team: '', role: defaultRole });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) { e.preventDefault(); try { const r = await api.post('/api/admin/users', f); if (!r.created.length) throw new Error('Could not create (duplicate or invalid e-mail).'); onDone(r.created); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title={`Add ${defaultRole === 'head' ? 'Team Head' : defaultRole}`} onClose={onClose}><form onSubmit={go}>
      <Field label="Full name"><input value={f.name} onChange={set('name')} required /></Field>
      <Field label="E-mail"><input type="email" value={f.email} onChange={set('email')} required /></Field>
      <div className="grid g2"><Field label="User ID (used to sign in)"><input value={f.empId} onChange={set('empId')} placeholder="e.g. FI1023" /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      <Field label={f.role === 'head' ? 'Team they manage (1 team only)' : 'Team (decides what learners can access)'}><TeamSelect teams={teams} value={f.team} onChange={set('team')} /></Field>
      <Field label="Role"><select value={f.role} onChange={set('role')}><option value="learner">Learner</option><option value="head">Team Head (manage 1 team)</option><option value="trainer">Trainer (edit content)</option><option value="admin">Admin (100% full control)</option></select></Field>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Create & generate password</button>
    </form></Modal>
  );
}
function BulkUsers({ teams, onClose, onDone }: { teams: string[]; onClose: () => void; onDone: (c: any[]) => void }) {
  const [txt, setTxt] = useState('');
  const [err, setErr] = useState('');
  function parseRows(raw: string) {
    return raw.split(/\r?\n/).map((l) => l.trim()).filter(Boolean).filter((l, i) => !(i === 0 && /^email[,\t;]/i.test(l))).map((l) => {
      const [email, name, empId, department, team, role] = l.split(/[,\t;]/).map((x) => x.replace(/^"|"$/g, '').trim());
      return { email, name, empId, department, team, role: ['learner', 'head', 'trainer', 'admin'].includes((role || '').toLowerCase()) ? role.toLowerCase() : 'learner' };
    });
  }
  const preview = parseRows(txt);
  function onFile(e: any) {
    const f = e.target.files?.[0];
    if (!f) return;
    const reader = new FileReader();
    reader.onload = () => setTxt(String(reader.result || ''));
    reader.readAsText(f);
  }
  function dlTemplate() {
    const csv = 'email,name,empId,department,team,role\nasha.rao@fundsindia.com,Asha Rao,FI1023,Sales,MF Silver,learner\n';
    const a = document.createElement('a');
    a.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }));
    a.download = 'bulk-users-template.csv';
    a.click();
  }
  async function go() {
    setErr('');
    if (!preview.length) return setErr('Paste rows or upload a CSV file first.');
    try { const r = await api.post('/api/admin/users', { users: preview }); if (r.skipped.length) alert('Skipped (duplicate/invalid): ' + r.skipped.join(', ')); onDone(r.created); } catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title="Bulk add users (CSV / Excel)" onClose={onClose} wide>
      <p className="muted small">Upload a <code>.csv</code> / <code>.tsv</code> exported from Excel, or paste lines: <code>email, full name, user id, department, team, role</code> (teams: {teams.join(' / ')}). Up to 500 rows.</p>
      <div className="row wrap" style={{ marginBottom: 10 }}>
        <label className="btn sm" style={{ cursor: 'pointer' }}>⬆ Upload CSV / TSV<input type="file" accept=".csv,.tsv,.txt" hidden onChange={onFile} /></label>
        <button type="button" className="btn sm" onClick={dlTemplate}>⬇ Download CSV Template</button>
        {preview.length > 0 && <span className="badge g">{preview.length} row(s) detected</span>}
      </div>
      <textarea rows={10} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder="asha@fundsindia.com, Asha Rao, FI1023, Sales, MF Silver, learner" />
      {err && <div className="alert err">{err}</div>}
      <button className="btn primary" style={{ marginTop: 12 }} onClick={go}>Create {preview.length || ''} account(s)</button>
    </Modal>
  );
}
function EditUser({ u, teams, self, onClose, onDone }: { u: any; teams: string[]; self: boolean; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ name: u.name, empId: u.emp_id || '', department: u.department || '', team: u.team || '', role: u.role, status: u.status });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) { e.preventDefault(); try { await api.put('/api/admin/users/' + u.id, f); onDone(); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title={'Edit ' + u.email} onClose={onClose}><form onSubmit={go}>
      <Field label="Name"><input value={f.name} onChange={set('name')} required /></Field>
      <div className="grid g2"><Field label="User ID (used to sign in)"><input value={f.empId} onChange={set('empId')} /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      <Field label="Team (decides what learners can access)"><TeamSelect teams={teams} value={f.team} onChange={set('team')} /></Field>
      <div className="grid g2"><Field label="Role"><select value={f.role} onChange={set('role')} disabled={self}><option value="learner">Learner</option><option value="head">Team Head</option><option value="trainer">Trainer</option><option value="admin">Admin</option></select></Field>
        <Field label="Status"><select value={f.status} onChange={set('status')} disabled={self}><option value="active">Active</option><option value="pending">Pending</option><option value="suspended">Suspended</option></select></Field></div>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Save</button>
    </form></Modal>
  );
}

/* ---------- Courses ---------- */
/* ---------- Team access ---------- */
export function TeamAccessPage() {
  const r = useLoad(() => api.get('/api/admin/teams'));
  const [team, setTeam] = useState('');
  const [sel, setSel] = useState<Set<string>>(new Set());
  const [msg, setMsg] = useState('');
  useEffect(() => {
    if (r.data?.teams?.length) {
      const target = team && r.data.teams.some((t: any) => t.name === team) ? team : r.data.teams[0].name;
      if (target !== team) setTeam(target);
      setSel(new Set(r.data.teams.find((t: any) => t.name === target)?.courses || []));
    }
  }, [r.data, team]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const cats = Array.from(new Set<string>(r.data.courses.map((c: any) => c.category)));
  const toggle = (id: string) => { const n = new Set(sel); if (n.has(id)) n.delete(id); else n.add(id); setSel(n); };
  async function save() { try { await api.put('/api/admin/teams/' + encodeURIComponent(team), { courses: [...sel] }); setMsg('Saved ✓ — applies immediately'); r.reload(); setTimeout(() => setMsg(''), 2500); } catch (e: any) { alert(e.message); } }
  async function createTeam() {
    const name = prompt('New team name');
    if (!name) return;
    try { const res = await api.post('/api/admin/teams', { name }); setTeam(res.name); r.reload(); } catch (e: any) { alert(e.message); }
  }
  async function deleteTeam() {
    if (!confirmDel(`team "${team}" (members will become unassigned)`)) return;
    try { await api.del('/api/admin/teams/' + encodeURIComponent(team)); setTeam(''); r.reload(); } catch (e: any) { alert(e.message); }
  }
  const cur = r.data.teams.find((t: any) => t.name === team);
  const full = !!cur?.full;
  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>Team access</h1><p className="muted" style={{ margin: 0 }}>Create/delete teams and choose which courses each team can see.</p></div>
        <button className="btn primary" onClick={createTeam}>＋ New team</button>
      </div>
      {r.data.unassigned > 0 && <div className="alert warn">{r.data.unassigned} learner account(s) have no team yet and cannot sign in. Assign teams under <b>Users & access</b>.</div>}
      <div className="row wrap">{r.data.teams.map((t: any) => <button key={t.name} className={'chip' + (team === t.name ? ' on' : '')} onClick={() => setTeam(t.name)}>{t.name} <span className="muted small">({t.learners || 0})</span></button>)}</div>
      {cur && <div className="card">
        <div className="row between wrap"><h2 style={{ margin: 0 }}>{team}</h2><span className="small muted">{cur?.learners || 0} learner(s) · {sel.size} course(s) selected</span></div>
        {cats.map((cat) => (
          <div key={cat} style={{ marginTop: 14 }}>
            <div className="small muted" style={{ fontWeight: 800, textTransform: 'uppercase', letterSpacing: '.06em' }}>{CATEGORIES[cat] || cat}</div>
            {r.data.courses.filter((c: any) => c.category === cat).map((c: any) => (
              <label key={c.id} className="lesson-row" style={{ cursor: 'pointer' }}>
                <input type="checkbox" checked={full || sel.has(c.id)} disabled={full} onChange={() => toggle(c.id)} style={{ width: 18, height: 18, flex: 'none' }} />
                <span className="grow"><b>{c.title}</b> <span className="muted small">{c.code}</span></span>
              </label>))}
          </div>))}
        {full && <div className="alert ok" style={{ marginTop: 14 }}>{team} always has full access to every course (including courses added later). Nothing to configure.</div>}
        {!full && <div className="row wrap" style={{ marginTop: 18 }}><button className="btn primary" onClick={save}>Save access for {team}</button><button className="btn" onClick={() => setSel(new Set(r.data.courses.map((c: any) => c.id)))}>Select all</button><button className="btn" onClick={() => setSel(new Set())}>Clear</button><span className="grow" /><button className="btn danger" onClick={deleteTeam}>Delete team</button>{msg && <span className="badge g">{msg}</span>}</div>}
      </div>}
    </div>
  );
}

export function CoursesPage() {
  const r = useLoad(() => api.get('/api/admin/courses'));
  const [show, setShow] = useState(false);
  const nav = useNavigate();
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  return (
    <div className="stack">
      <div className="row between"><h1>Courses & lessons</h1><button className="btn primary" onClick={() => setShow(true)}>＋ New course</button></div>
      <div className="card tscroll"><table className="t"><thead><tr><th>Course</th><th>Category</th><th>Videos</th><th>Lessons</th><th>Quizzes / Qs</th><th>Status</th><th></th></tr></thead><tbody>
        {r.data.courses.map((c: any) => (
          <tr key={c.id}><td><b>{c.title}</b><div className="muted small">{c.code} — {c.subtitle}</div></td><td>{CATEGORIES[c.category] || c.category}</td><td>{c.playlists.length}</td><td>{c.lessons}</td><td>{c.quizzes} / {c.questions}</td>
            <td><span className={'badge ' + (c.published ? 'g' : 'm')}>{c.published ? 'Published' : 'Draft'}</span></td><td><Link className="btn sm" to={'/courses/' + c.id}>Edit</Link></td></tr>))}
      </tbody></table></div>
      {show && <NewCourse onClose={() => setShow(false)} onDone={(id) => nav('/courses/' + id)} />}
    </div>
  );
}
function NewCourse({ onClose, onDone }: { onClose: () => void; onDone: (id: string) => void }) {
  const [f, setF] = useState({ code: '', title: '', subtitle: '', category: 'nism', published: false });
  const [err, setErr] = useState('');
  async function go(e: FormEvent) { e.preventDefault(); try { const r = await api.post('/api/admin/courses', f); onDone(r.id); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title="New course" onClose={onClose}><form onSubmit={go}>
      <Field label="Code (e.g. NISM XIV)"><input value={f.code} onChange={(e) => setF({ ...f, code: e.target.value })} required /></Field>
      <Field label="Title"><input value={f.title} onChange={(e) => setF({ ...f, title: e.target.value })} required /></Field>
      <Field label="Subtitle"><input value={f.subtitle} onChange={(e) => setF({ ...f, subtitle: e.target.value })} /></Field>
      <Field label="Category"><select value={f.category} onChange={(e) => setF({ ...f, category: e.target.value })}>{Object.entries(CATEGORIES).map(([k, v]) => <option key={k} value={k}>{v}</option>)}</select></Field>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Create draft</button>
    </form></Modal>
  );
}

export function CourseEditor() {
  const { id } = useParams();
  const [sp, setSp] = useSearchParams();
  const tab = sp.get('tab') || 'content';
  const r = useLoad(() => api.get('/api/admin/courses/' + id), [id]);
  const [toast, say] = useToast();
  const [preview, setPreview] = useState(false);
  const nav = useNavigate();
  const { me } = useStaff();
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const { course, modules, lessons, quizzes } = r.data;
  const setTab = (t: string) => setSp({ tab: t });

  async function addModule() { const t = prompt('Module / chapter title'); if (t) { await api.post('/api/admin/modules', { course_id: id, title: t }); r.reload(); } }
  async function renameModule(m: any) { const t = prompt('Rename module', m.title); if (t) { await api.put('/api/admin/modules/' + m.id, { title: t, weight: m.weight }); r.reload(); } }
  async function delModule(m: any) { if (confirmDel(`module "${m.title}" (its lessons will be kept but unassigned)`)) { await api.del('/api/admin/modules/' + m.id); r.reload(); } }
  async function newLesson(moduleId: string | null) {
    const t = prompt('Lesson title'); if (!t) return;
    const x = await api.post('/api/admin/lessons', { course_id: id, module_id: moduleId, title: t, kind: 'note', body: `# ${t}\n\nWrite your notes here…`, published: false });
    nav('/lesson/' + x.id);
  }
  async function move(list: any[], table: string, i: number, d: number) {
    const ids = list.map((x) => x.id); const j = i + d; if (j < 0 || j >= ids.length) return;
    [ids[i], ids[j]] = [ids[j], ids[i]];
    // Persist the new order for the whole course so the learner sees the same sequence.
    const all = table === 'lessons' ? modules.flatMap((m: any) => (m.id === list[0]?.module_id ? ids : lessons.filter((l: any) => l.module_id === m.id).map((l: any) => l.id))) : ids;
    const rest = table === 'lessons' ? lessons.filter((l: any) => !modules.some((m: any) => m.id === l.module_id)).map((l: any) => l.id) : [];
    await api.post('/api/admin/order/' + table, { ids: [...all, ...rest] }); r.reload();
  }
  async function newQuiz() { const t = prompt('Quiz title'); if (!t) return; const x = await api.post('/api/admin/quizzes', { course_id: id, title: t, published: false }); nav('/quiz/' + x.id); }

  return (
    <div className="stack">
      {toast}
      <div className="small muted"><Link to="/courses">Courses</Link> / {course.code}</div>
      <div className="row between wrap"><h1>{course.title}</h1><div className="row"><button className="btn sm" onClick={() => setPreview(true)}>👁 Draft preview</button><span className={'badge ' + (course.published ? 'g' : 'm')}>{course.published ? 'Published' : 'Draft'}</span></div></div>
      {preview && (
        <Modal title={`Learner Preview — ${course.title}`} onClose={() => setPreview(false)} wide>
          <div className="stack">
            <p className="muted">{course.description}</p>
            {modules.map((m: any) => (
              <div className="card flat" key={m.id}>
                <h3 style={{ marginTop: 0 }}>{m.title}</h3>
                {lessons.filter((l: any) => l.module_id === m.id).map((l: any) => (
                  <div key={l.id} className="lesson-row">
                    <span>{l.kind === 'video' ? '▶' : '📄'}</span>
                    <span className="grow">{l.title} {!l.published && <span className="badge w">Draft</span>}</span>
                    <span className="muted small">{l.minutes ? l.minutes + ' min' : ''}</span>
                  </div>
                ))}
              </div>
            ))}
          </div>
        </Modal>
      )}
      <div className="tabs"><button className={tab === 'content' ? 'on' : ''} onClick={() => setTab('content')}>Syllabus & lessons</button><button className={tab === 'videos' ? 'on' : ''} onClick={() => setTab('videos')}>Add videos & links</button><button className={tab === 'quizzes' ? 'on' : ''} onClick={() => setTab('quizzes')}>Quizzes ({quizzes.length})</button><button className={tab === 'details' ? 'on' : ''} onClick={() => setTab('details')}>Details</button></div>

      {tab === 'content' && (
        <div className="stack">
          <div className="row"><button className="btn" onClick={addModule}>＋ Module / chapter</button><button className="btn" onClick={() => newLesson(null)}>＋ Lesson</button></div>
          {modules.map((m: any) => {
            const ls = lessons.filter((l: any) => l.module_id === m.id);
            return (
              <div className="card" key={m.id}>
                <div className="row between"><h3 style={{ margin: 0 }}>{m.title}</h3><div className="row"><button className="btn sm" onClick={() => newLesson(m.id)}>＋ Lesson</button><button className="btn sm" onClick={() => renameModule(m)}>Rename</button><button className="btn sm danger" onClick={() => delModule(m)}>Delete</button></div></div>
                {ls.map((l: any, i: number) => (
                  <div key={l.id} className="lesson-row"><span className="grow">{l.title} {!l.published && <span className="badge m">draft</span>} {l.kind !== 'note' && <span className="badge">{l.kind}</span>}</span>
                    <button className="btn sm ghost" onClick={() => move(ls, 'lessons', i, -1)} aria-label="Move up">↑</button><button className="btn sm ghost" onClick={() => move(ls, 'lessons', i, 1)} aria-label="Move down">↓</button>
                    <Link className="btn sm" to={'/lesson/' + l.id}>Edit</Link></div>))}
                {!ls.length && <div className="muted small" style={{ marginTop: 8 }}>No lessons.</div>}
              </div>);
          })}
          {lessons.some((l: any) => !modules.some((m: any) => m.id === l.module_id)) && (
            <div className="card"><h3>Unassigned lessons</h3>{lessons.filter((l: any) => !modules.some((m: any) => m.id === l.module_id)).map((l: any) => <div key={l.id} className="lesson-row"><span className="grow">{l.title}</span><Link className="btn sm" to={'/lesson/' + l.id}>Edit</Link></div>)}</div>)}
        </div>)}

      {tab === 'videos' && <VideosTab course={course} onSaved={() => { say('Saved'); r.reload(); }} />}

      {tab === 'quizzes' && (
        <div className="stack"><button className="btn" onClick={newQuiz}>＋ New quiz</button>
          <div className="card tscroll"><table className="t"><thead><tr><th>Quiz</th><th>Questions</th><th>Pass</th><th>Type</th><th></th></tr></thead><tbody>
            {quizzes.map((q: any) => <tr key={q.id}><td>{q.title} {!q.published && <span className="badge m">draft</span>}</td><td>{q.questions}</td><td>{q.pass_pct}%</td><td>{q.is_exam ? <span className="badge w">Final exam</span> : 'Practice'}</td><td><Link className="btn sm" to={'/quiz/' + q.id}>Edit</Link></td></tr>)}
          </tbody></table></div></div>)}

      {tab === 'details' && <DetailsTab course={course} canDelete={me.role === 'admin'} onSaved={() => { say('Saved'); r.reload(); }} onDeleted={() => nav('/courses')} />}
    </div>
  );
}

function DetailsTab({ course, onSaved, onDeleted, canDelete }: { course: any; onSaved: () => void; onDeleted: () => void; canDelete: boolean }) {
  const [f, setF] = useState({ ...course });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function save(e: FormEvent) { e.preventDefault(); try { await api.put('/api/admin/courses/' + course.id, f); onSaved(); } catch (x: any) { setErr(x.message); } }
  return (
    <form className="card" onSubmit={save} style={{ maxWidth: 760 }}>
      <div className="grid g2"><Field label="Code"><input value={f.code} onChange={set('code')} required /></Field><Field label="Level"><input value={f.level || ''} onChange={set('level')} /></Field></div>
      <Field label="Title"><input value={f.title} onChange={set('title')} required /></Field>
      <Field label="Subtitle"><input value={f.subtitle || ''} onChange={set('subtitle')} /></Field>
      <Field label="Category"><select value={f.category} onChange={set('category')}>{Object.entries(CATEGORIES).map(([k, v]) => <option key={k} value={k}>{v}</option>)}</select></Field>
      <Field label="Description"><textarea style={{ fontFamily: 'inherit' }} value={f.description || ''} onChange={set('description')} /></Field>
      <div className="row wrap"><Check label="Published (visible to learners)" checked={!!f.published} onChange={(v) => setF({ ...f, published: v ? 1 : 0 })} /><Check label="Show as popular" checked={!!f.popular} onChange={(v) => setF({ ...f, popular: v ? 1 : 0 })} /></div>
      {err && <div className="alert err">{err}</div>}
      <div className="row" style={{ marginTop: 16 }}><button className="btn primary">Save</button>{canDelete && <button type="button" className="btn danger" onClick={async () => { if (confirmDel(`course "${course.title}" with ALL its lessons, quizzes and learner progress`)) { await api.del('/api/admin/courses/' + course.id); onDeleted(); } }}>Delete course</button>}</div>
    </form>
  );
}

function VideosTab({ course, onSaved }: { course: any; onSaved: () => void }) {
  const [links, setLinks] = useState<any[]>(course.links);
  const [one, setOne] = useState({ url: '', title: '', minutes: 5 });
  const [pl, setPl] = useState({ url: '', module: '', channel: '', fresh: true });
  const [err, setErr] = useState('');
  const [msg, setMsg] = useState('');
  const [busy, setBusy] = useState(false);
  async function addOne() {
    setErr(''); setMsg(''); setBusy(true);
    try { const r = await api.post(`/api/admin/courses/${course.id}/import-video`, one); setMsg(`Added “${r.title}” as a lesson (draft order: end of course).`); setOne({ url: '', title: '', minutes: 5 }); onSaved(); }
    catch (x: any) { setErr(x.message); } finally { setBusy(false); }
  }
  async function addList() {
    setErr(''); setMsg(''); setBusy(true);
    try { const r = await api.post(`/api/admin/courses/${course.id}/import-playlist`, { url: pl.url, module: pl.module, channel: pl.channel, maxAgeDays: pl.fresh ? 364 : 0 }); setMsg(`Imported ${r.added} videos as a new module.`); setPl({ ...pl, url: '' }); onSaved(); }
    catch (x: any) { setErr(x.message); } finally { setBusy(false); }
  }
  async function save() {
    try { await api.put('/api/admin/courses/' + course.id, { ...course, links }); onSaved(); setErr(''); } catch (x: any) { setErr(x.message); }
  }
  return (
    <div className="stack">
      {err && <div className="alert err">{err}</div>}{msg && <div className="alert ok">{msg}</div>}
      <div className="card">
        <h2>Add a single video</h2>
        <p className="muted small">Paste a video link. The title and presenter are filled in automatically; videos that are private, removed or cannot be embedded are rejected. Learners watch it inside the hub with the portal's own player.</p>
        <div className="grid g2"><Field label="Video link or ID"><input value={one.url} onChange={(e) => setOne({ ...one, url: e.target.value })} placeholder="https://…" /></Field><Field label="Title (optional)"><input value={one.title} onChange={(e) => setOne({ ...one, title: e.target.value })} /></Field></div>
        <div className="row" style={{ marginTop: 14 }}><div style={{ width: 120 }}><input type="number" min={1} value={one.minutes} onChange={(e) => setOne({ ...one, minutes: +e.target.value })} aria-label="Minutes" /></div><span className="muted small">minutes</span><button className="btn primary" disabled={busy || !one.url} onClick={addOne}>＋ Add video</button></div>
      </div>
      <div className="card">
        <h2>Import a whole video series</h2>
        <p className="muted small">Paste a playlist link to create one lesson per video, in order, in a new module. Keep “recent only” ticked to skip anything older than ~12 months so outdated videos never reach learners. Reorder or delete lessons afterwards under <i>Syllabus & lessons</i>.</p>
        <div className="grid g2"><Field label="Playlist link"><input value={pl.url} onChange={(e) => setPl({ ...pl, url: e.target.value })} placeholder="https://…/playlist?list=…" /></Field><Field label="New module title"><input value={pl.module} onChange={(e) => setPl({ ...pl, module: e.target.value })} /></Field></div>
        <Field label="Presenter / channel credit (shown on each video)"><input value={pl.channel} onChange={(e) => setPl({ ...pl, channel: e.target.value })} /></Field>
        <div className="row wrap" style={{ marginTop: 6 }}><Check label="Recent videos only (last ~12 months)" checked={pl.fresh} onChange={(v) => setPl({ ...pl, fresh: v })} /><button className="btn primary" disabled={busy || !pl.url} onClick={addList}>{busy ? 'Importing…' : '⬇ Import series'}</button></div>
      </div>
      <div className="card">
        <h2>Official resource links</h2>
        {links.map((l, i) => (<div key={i} className="row wrap" style={{ marginTop: 8 }}><input style={{ flex: 1, minWidth: 160 }} placeholder="Title" value={l.title} onChange={(e) => setLinks(links.map((x, k) => (k === i ? { ...x, title: e.target.value } : x)))} /><input style={{ flex: 2, minWidth: 220 }} placeholder="https://…" value={l.url} onChange={(e) => setLinks(links.map((x, k) => (k === i ? { ...x, url: e.target.value } : x)))} /><button className="btn sm danger" onClick={() => setLinks(links.filter((_, k) => k !== i))}>✕</button></div>))}
        <button className="btn" style={{ marginTop: 12 }} onClick={() => setLinks([...links, { title: '', url: 'https://' }])}>＋ Add link</button>
        <div style={{ marginTop: 14 }}><button className="btn primary" onClick={save}>Save links</button></div>
      </div>
    </div>
  );
}

/* ---------- Learning paths ---------- */
export function PathsPage() {
  const r = useLoad(() => api.get('/api/admin/paths'));
  const nav = useNavigate();
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  async function create() {
    const title = prompt('Path title'); if (!title) return;
    try { const x = await api.post('/api/admin/paths', { title }); nav('/paths/' + x.id); } catch (e: any) { alert(e.message); }
  }
  return (
    <div className="stack">
      <div className="row between"><h1>Learning paths</h1><button className="btn primary" onClick={create}>＋ New path</button></div>
      <p className="muted">A path is an ordered, step-by-step journey made of lessons (videos and notes) from any course.</p>
      <div className="card tscroll"><table className="t"><thead><tr><th>Path</th><th>Level</th><th>Steps</th><th>Status</th><th></th></tr></thead><tbody>
        {r.data.paths.map((p: any) => <tr key={p.id}><td>{p.icon} <b>{p.title}</b></td><td>{p.level}</td><td>{p.steps}</td><td><span className={'badge ' + (p.published ? 'g' : 'm')}>{p.published ? 'Published' : 'Draft'}</span></td><td><Link className="btn sm" to={'/paths/' + p.id}>Edit</Link></td></tr>)}
      </tbody></table></div>
    </div>
  );
}

export function PathEditor() {
  const { id } = useParams();
  const nav = useNavigate();
  const r = useLoad(() => api.get('/api/admin/paths/' + id), [id]);
  const courses = useLoad(() => api.get('/api/admin/courses'));
  const [f, setF] = useState<any>(null);
  const [items, setItems] = useState<any[]>([]);
  const [pick, setPick] = useState({ course: '', lesson: '' });
  const [lessons, setLessons] = useState<any[]>([]);
  const [msg, setMsg] = useState('');
  useEffect(() => { if (r.data) { setF(r.data.path); setItems(r.data.items); } }, [r.data]);
  useEffect(() => { if (pick.course) api.get('/api/admin/courses/' + pick.course).then((c) => setLessons(c.lessons)); else setLessons([]); }, [pick.course]);
  if (r.loading || !f) return r.error ? <ErrorBox error={r.error} /> : <Spinner />;
  const move = (i: number, d: number) => { const a = [...items]; const j = i + d; if (j < 0 || j >= a.length) return; [a[i], a[j]] = [a[j], a[i]]; setItems(a); };
  async function save() { try { await api.put('/api/admin/paths/' + id, { ...f, items: items.map((x) => x.id) }); setMsg('Saved ✓'); setTimeout(() => setMsg(''), 2000); } catch (e: any) { alert(e.message); } }
  const add = () => { const l = lessons.find((x) => x.id === pick.lesson); if (l && !items.some((x) => x.id === l.id)) setItems([...items, { id: l.id, title: l.title, kind: l.kind, course: courses.data?.courses.find((c: any) => c.id === pick.course)?.title }]); };
  return (
    <div className="stack">
      <div className="small muted"><Link to="/paths">← All paths</Link></div>
      <div className="row between wrap"><h1>Edit path</h1><div className="row">{msg && <span className="badge g">{msg}</span>}<button className="btn primary" onClick={save}>Save path</button></div></div>
      <div className="card">
        <div className="grid g3"><Field label="Title"><input value={f.title} onChange={(e) => setF({ ...f, title: e.target.value })} /></Field><Field label="Level"><input value={f.level || ''} onChange={(e) => setF({ ...f, level: e.target.value })} /></Field><Field label="Icon (emoji)"><input value={f.icon || ''} onChange={(e) => setF({ ...f, icon: e.target.value })} maxLength={4} /></Field></div>
        <Field label="Description"><textarea style={{ fontFamily: 'inherit', minHeight: 80 }} value={f.description || ''} onChange={(e) => setF({ ...f, description: e.target.value })} /></Field>
        <Check label="Published (visible to learners)" checked={!!f.published} onChange={(v) => setF({ ...f, published: v ? 1 : 0 })} />
      </div>
      <div className="card"><h2>Steps ({items.length})</h2>
        {items.map((it, i) => <div key={it.id} className="lesson-row"><span className="badge">{i + 1}</span><span className="grow">{it.title}<div className="muted small">{it.kind} · {it.course}</div></span>
          <button className="btn sm ghost" onClick={() => move(i, -1)}>↑</button><button className="btn sm ghost" onClick={() => move(i, 1)}>↓</button><button className="btn sm danger" onClick={() => setItems(items.filter((x) => x.id !== it.id))}>✕</button></div>)}
        <div className="inset" style={{ marginTop: 16 }}><b>Add a step</b>
          <div className="grid g2"><select value={pick.course} onChange={(e) => setPick({ course: e.target.value, lesson: '' })}><option value="">Choose course…</option>{courses.data?.courses.map((c: any) => <option key={c.id} value={c.id}>{c.title}</option>)}</select>
            <select value={pick.lesson} onChange={(e) => setPick({ ...pick, lesson: e.target.value })}><option value="">Choose lesson…</option>{lessons.map((l) => <option key={l.id} value={l.id}>{l.kind === 'video' ? '▶ ' : '📄 '}{l.title}</option>)}</select></div>
          <button className="btn" style={{ marginTop: 12 }} disabled={!pick.lesson} onClick={add}>＋ Add to path</button></div>
      </div>
      <div><button className="btn danger" onClick={async () => { if (confirmDel('this learning path')) { await api.del('/api/admin/paths/' + id); nav('/paths'); } }}>Delete path</button></div>
    </div>
  );
}
/* ---------- Lesson editor ---------- */
export function LessonEditor() {
  const { id } = useParams();
  const nav = useNavigate();
  const r = useLoad(() => api.get('/api/admin/lessons/' + id), [id]);
  const [f, setF] = useState<any>(null);
  const [mods, setMods] = useState<any[]>([]);
  const [msg, setMsg] = useState('');
  const [err, setErr] = useState('');
  useEffect(() => { if (r.data) { const l = r.data.lesson; setF({ ...l, video_id: l.video_id || '' }); api.get('/api/admin/courses/' + l.course_id).then((c) => setMods(c.modules)); } }, [r.data]);
  if (r.loading || !f) return r.error ? <ErrorBox error={r.error} /> : <Spinner />;
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function save() { setErr(''); try { await api.put('/api/admin/lessons/' + id, f); setMsg('Saved ✓'); setTimeout(() => setMsg(''), 2000); } catch (x: any) { setErr(x.message); } }
  return (
    <div className="stack">
      <div className="small muted"><Link to={'/courses/' + f.course_id}>← Back to course</Link></div>
      <div className="row between wrap"><h1>Edit lesson</h1><div className="row">{msg && <span className="badge g">{msg}</span>}<button className="btn primary" onClick={save}>Save</button></div></div>
      {err && <div className="alert err">{err}</div>}
      <div className="card">
        <div className="grid g3">
          <Field label="Title"><input value={f.title} onChange={set('title')} /></Field>
          <Field label="Type"><select value={f.kind} onChange={set('kind')}><option value="note">Notes (markdown)</option><option value="video">Single YouTube video + notes</option><option value="link">External link + notes</option></select></Field>
          <Field label="Module"><select value={f.module_id || ''} onChange={(e) => setF({ ...f, module_id: e.target.value || null })}><option value="">— none —</option>{mods.map((m) => <option key={m.id} value={m.id}>{m.title}</option>)}</select></Field>
        </div>
        {f.kind === 'video' && <Field label="YouTube video URL or ID"><input value={f.video_id} onChange={set('video_id')} placeholder="https://www.youtube.com/watch?v=…" /></Field>}
        {f.kind === 'link' && <Field label="Link (https only)"><input value={f.url || ''} onChange={set('url')} placeholder="https://…" /></Field>}
        <div className="row wrap"><div style={{ width: 120 }}><Field label="Minutes"><input type="number" min={0} value={f.minutes || 0} onChange={(e) => setF({ ...f, minutes: +e.target.value })} /></Field></div><Check label="Published" checked={!!f.published} onChange={(v) => setF({ ...f, published: v ? 1 : 0 })} /></div>
      </div>
      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card"><label className="f" style={{ marginTop: 0 }}>Notes — Markdown (tables, lists, **bold**, &gt; callouts)</label><textarea style={{ minHeight: 480 }} value={f.body || ''} onChange={set('body')} /></div>
        <div className="card"><label className="f" style={{ marginTop: 0 }}>Live preview</label><Markdown text={f.body || ''} /></div>
      </div>
      <div><button className="btn danger" onClick={async () => { if (confirmDel('this lesson')) { await api.del('/api/admin/lessons/' + id); nav('/courses/' + f.course_id); } }}>Delete lesson</button></div>
    </div>
  );
}

/* ---------- Quiz editor ---------- */
export function QuizEditor() {
  const { id } = useParams();
  const nav = useNavigate();
  const r = useLoad(() => api.get('/api/admin/quizzes/' + id), [id]);
  const [f, setF] = useState<any>(null);
  const [edit, setEdit] = useState<any>(null);
  const [bulk, setBulk] = useState(false);
  const [toast, say] = useToast();
  useEffect(() => { if (r.data) setF(r.data.quiz); }, [r.data]);
  if (r.loading || !f) return r.error ? <ErrorBox error={r.error} /> : <Spinner />;
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function save() { try { await api.put('/api/admin/quizzes/' + id, f); say('Saved'); } catch (x: any) { alert(x.message); } }
  return (
    <div className="stack">{toast}
      <div className="small muted"><Link to={'/courses/' + f.course_id + '?tab=quizzes'}>← Back to course</Link></div>
      <div className="row between wrap"><h1>Quiz</h1><button className="btn primary" onClick={save}>Save settings</button></div>
      <div className="card"><div className="grid g4">
        <Field label="Title"><input value={f.title} onChange={set('title')} /></Field>
        <Field label="Time (minutes)"><input type="number" min={1} value={f.minutes} onChange={(e) => setF({ ...f, minutes: +e.target.value })} /></Field>
        <Field label="Pass mark %"><input type="number" min={1} max={100} value={f.pass_pct} onChange={(e) => setF({ ...f, pass_pct: +e.target.value })} /></Field>
        <Field label="Negative marking"><select value={f.negative} onChange={(e) => setF({ ...f, negative: +e.target.value })}><option value={0}>None</option><option value={0.25}>25% per wrong (NISM style)</option><option value={0.33}>33%</option><option value={0.5}>50%</option></select></Field>
      </div><div className="row wrap"><Check label="Final exam (awards a certificate on pass)" checked={!!f.is_exam} onChange={(v) => setF({ ...f, is_exam: v ? 1 : 0 })} /><Check label="Published" checked={!!f.published} onChange={(v) => setF({ ...f, published: v ? 1 : 0 })} /></div></div>

      <div className="row between wrap"><h2 style={{ margin: 0 }}>Questions ({r.data.questions.length})</h2><div className="row"><button className="btn" onClick={() => setEdit({ question: '', options: ['', '', '', ''], answer: 0, explanation: '' })}>＋ Add question</button><button className="btn" onClick={() => setBulk(true)}>⬆ Bulk import (JSON)</button></div></div>
      {r.data.questions.map((q: any, i: number) => (
        <div className="card" key={q.id}>
          <div className="row between"><b>{i + 1}. {q.question}</b><div className="row"><button className="btn sm" onClick={() => setEdit(q)}>Edit</button><button className="btn sm danger" onClick={async () => { if (confirmDel('this question')) { await api.del('/api/admin/questions/' + q.id); r.reload(); } }}>Delete</button></div></div>
          <ol type="A" style={{ margin: '8px 0 0' }}>{q.options.map((o: string, k: number) => <li key={k} style={{ color: k === q.answer ? 'var(--acc)' : undefined, fontWeight: k === q.answer ? 700 : 400 }}>{o}</li>)}</ol>
        </div>))}
      {edit && <QuestionModal q={edit} quizId={id!} onClose={() => setEdit(null)} onDone={() => { setEdit(null); r.reload(); }} />}
      {bulk && <BulkQuestions quizId={id!} onClose={() => setBulk(false)} onDone={(n) => { setBulk(false); say(`${n} questions added`); r.reload(); }} />}
      <div><button className="btn danger" onClick={async () => { if (confirmDel('this quiz and its questions')) { await api.del('/api/admin/quizzes/' + id); nav('/courses/' + f.course_id + '?tab=quizzes'); } }}>Delete quiz</button></div>
    </div>
  );
}
function QuestionModal({ q, quizId, onClose, onDone }: { q: any; quizId: string; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ ...q, options: [...q.options] });
  const [err, setErr] = useState('');
  async function go(e: FormEvent) {
    e.preventDefault();
    try { f.id ? await api.put('/api/admin/questions/' + f.id, f) : await api.post(`/api/admin/quizzes/${quizId}/questions`, f); onDone(); } catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title={f.id ? 'Edit question' : 'New question'} onClose={onClose} wide><form onSubmit={go}>
      <Field label="Question"><textarea style={{ fontFamily: 'inherit', minHeight: 80 }} value={f.question} onChange={(e) => setF({ ...f, question: e.target.value })} required /></Field>
      <label className="f">Options — select the correct one</label>
      {f.options.map((o: string, i: number) => (
        <div className="row" key={i} style={{ marginTop: 6 }}><input type="radio" name="ans" checked={f.answer === i} onChange={() => setF({ ...f, answer: i })} aria-label={`Option ${i + 1} is correct`} /><input value={o} onChange={(e) => setF({ ...f, options: f.options.map((x: string, k: number) => (k === i ? e.target.value : x)) })} placeholder={`Option ${String.fromCharCode(65 + i)}`} /></div>))}
      <Field label="Explanation (shown after submit; markdown ok)"><textarea style={{ fontFamily: 'inherit', minHeight: 80 }} value={f.explanation || ''} onChange={(e) => setF({ ...f, explanation: e.target.value })} /></Field>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 14 }}>Save question</button>
    </form></Modal>
  );
}
function BulkQuestions({ quizId, onClose, onDone }: { quizId: string; onClose: () => void; onDone: (n: number) => void }) {
  const [txt, setTxt] = useState('');
  const [err, setErr] = useState('');
  const [copied, setCopied] = useState(false);

  function parseCsvQuestions(raw: string) {
    const lines = raw.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);
    const out: any[] = [];
    for (let i = 0; i < lines.length; i++) {
      if (i === 0 && /^question[,\t]/i.test(lines[i])) continue;
      const parts = lines[i].split(/\t|,(?=(?:[^"]*"[^"]*")*[^"]*$)/).map((s) => s.replace(/^"|"$/g, '').replace(/""/g, '"').trim());
      if (parts.length < 4) continue;
      // Format: question, optA, optB, optC, optD, answerIndex(0-3 or A-D), explanation
      const [question, a, b, c, d, ansRaw, explanation] = parts;
      const opts = [a, b, c, d].filter(Boolean);
      let ans = parseInt(ansRaw, 10);
      if (Number.isNaN(ans)) ans = ['A', 'B', 'C', 'D'].indexOf((ansRaw || '').toUpperCase());
      if (question && opts.length >= 2 && ans >= 0 && ans < opts.length) {
        out.push({ question, options: opts, answer: ans, explanation: explanation || '' });
      }
    }
    return out;
  }

  function onFile(e: any) {
    const f = e.target.files?.[0];
    if (!f) return;
    const reader = new FileReader();
    reader.onload = () => setTxt(String(reader.result || ''));
    reader.readAsText(f);
  }

  function dlTemplate(kind: 'json' | 'csv') {
    const content = kind === 'json'
      ? JSON.stringify([{ question: 'What is the minimum investment for a Specialised Investment Fund (SIF) in India?', options: ['₹1 Lakh', '₹10 Lakh', '₹25 Lakh', '₹50 Lakh'], answer: 1, explanation: 'SEBI mandates a ₹10 Lakh minimum investment per PAN for SIFs.' }], null, 2)
      : 'question,optionA,optionB,optionC,optionD,answer(0-3 or A-D),explanation\n"What is the minimum investment for SIF?",₹1 Lakh,₹10 Lakh,₹25 Lakh,₹50 Lakh,1,"SEBI mandates ₹10 Lakh per PAN for SIFs."\n';
    const a = document.createElement('a');
    a.href = URL.createObjectURL(new Blob([content], { type: kind === 'json' ? 'application/json' : 'text/csv' }));
    a.download = `quiz-questions-template.${kind}`;
    a.click();
  }

  function copyAiPrompt() {
    const prompt = `Generate 15 NISM-style multiple-choice questions on [TOPIC] as a strict JSON array. Each item must have: "question" (string), "options" (4 strings), "answer" (0-based integer index 0..3), and "explanation" (1-2 sentence rationale). Return ONLY valid JSON.`;
    navigator.clipboard?.writeText(prompt);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  async function go() {
    setErr('');
    try {
      const trimmed = txt.trim();
      const questions = trimmed.startsWith('[') || trimmed.startsWith('{')
        ? (() => { const parsed = JSON.parse(trimmed); return Array.isArray(parsed) ? parsed : parsed.questions; })()
        : parseCsvQuestions(trimmed);
      if (!questions?.length) throw new Error('No valid questions parsed. Check JSON or CSV format.');
      const r = await api.post(`/api/admin/quizzes/${quizId}/questions`, { questions });
      onDone(r.added);
    } catch (x: any) { setErr(x.message); }
  }

  return (
    <Modal title="Bulk import questions (JSON / CSV / AI Template)" onClose={onClose} wide>
      <p className="muted small">Upload a CSV/JSON file, paste CSV rows, or paste an AI-generated JSON array (up to 500 questions).</p>
      <div className="row wrap" style={{ marginBottom: 10 }}>
        <label className="btn sm" style={{ cursor: 'pointer' }}>⬆ Upload JSON / CSV<input type="file" accept=".json,.csv,.tsv,.txt" hidden onChange={onFile} /></label>
        <button type="button" className="btn sm" onClick={() => dlTemplate('json')}>⬇ JSON Template</button>
        <button type="button" className="btn sm" onClick={() => dlTemplate('csv')}>⬇ CSV Template</button>
        <button type="button" className="btn sm" onClick={copyAiPrompt}>{copied ? '✓ AI Prompt Copied' : '✨ Copy AI Prompt'}</button>
      </div>
      <textarea rows={13} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder={'[\n  {"question": "…", "options": ["A","B","C","D"], "answer": 1, "explanation": "…"}\n]'} />
      {err && <div className="alert err">{err}</div>}
      <button className="btn primary" style={{ marginTop: 12 }} onClick={go}>Import questions</button>
    </Modal>
  );
}

/* ---------- News ---------- */
export function NewsPage() {
  const r = useLoad(() => api.get('/api/admin/news'));
  const [edit, setEdit] = useState<any>(null);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  return (
    <div className="stack">
      <div className="row between"><h1>Bulletins & news</h1><button className="btn primary" onClick={() => setEdit({ title: '', body: '', category: 'Market update', url: '', pinned: 0, published: 1 })}>＋ New bulletin</button></div>
      <p className="muted">Learners see these on their home page and under Market updates. Live SEBI / market headlines are fetched automatically.</p>
      <div className="card tscroll"><table className="t"><thead><tr><th>Title</th><th>Category</th><th>Date</th><th>Status</th><th></th></tr></thead><tbody>
        {r.data.news.map((n: any) => <tr key={n.id}><td><b>{n.title}</b>{n.pinned ? ' 📌' : ''}<div className="muted small">{n.body?.slice(0, 90)}</div></td><td>{n.category}</td><td>{fmtDate(n.published_at)}</td><td><span className={'badge ' + (n.published ? 'g' : 'm')}>{n.published ? 'Live' : 'Hidden'}</span></td>
          <td className="row"><button className="btn sm" onClick={() => setEdit(n)}>Edit</button><button className="btn sm danger" onClick={async () => { if (confirmDel('this bulletin')) { await api.del('/api/admin/news/' + n.id); r.reload(); } }}>Delete</button></td></tr>)}
      </tbody></table></div>
      {edit && <NewsModal n={edit} onClose={() => setEdit(null)} onDone={() => { setEdit(null); r.reload(); }} />}
    </div>
  );
}
function NewsModal({ n, onClose, onDone }: { n: any; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ ...n, url: n.url || '' });
  const [err, setErr] = useState('');
  async function go(e: FormEvent) { e.preventDefault(); try { f.id ? await api.put('/api/admin/news/' + f.id, f) : await api.post('/api/admin/news', f); onDone(); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title={f.id ? 'Edit bulletin' : 'New bulletin'} onClose={onClose}><form onSubmit={go}>
      <Field label="Headline"><input value={f.title} onChange={(e) => setF({ ...f, title: e.target.value })} required /></Field>
      <Field label="Details"><textarea style={{ fontFamily: 'inherit', minHeight: 100 }} value={f.body || ''} onChange={(e) => setF({ ...f, body: e.target.value })} /></Field>
      <div className="grid g2"><Field label="Category"><select value={f.category} onChange={(e) => setF({ ...f, category: e.target.value })}>{['Market update', 'Regulatory', 'Product', 'Compliance', 'Announcement', 'Training', 'Update'].map((c) => <option key={c}>{c}</option>)}</select></Field>
        <Field label="Link (https, optional)"><input value={f.url} onChange={(e) => setF({ ...f, url: e.target.value })} /></Field></div>
      <div className="row wrap"><Check label="Pin to top" checked={!!f.pinned} onChange={(v) => setF({ ...f, pinned: v ? 1 : 0 })} /><Check label="Visible to learners" checked={!!f.published} onChange={(v) => setF({ ...f, published: v ? 1 : 0 })} /></div>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 14 }}>Save</button>
    </form></Modal>
  );
}

/* ---------- Security & Settings ---------- */
export function SecurityPage() {
  const { me, logout } = useStaff();
  const [setup, setSetup] = useState<{ secret: string; qr: string } | null>(null);
  const [code, setCode] = useState('');
  const [msg, setMsg] = useState<{ t: string; s: string } | null>(null);
  const [pw, setPw] = useState({ current: '', next: '' });
  const [off, setOff] = useState('');
  async function begin() { const r = await api.post('/api/admin/totp/begin'); setSetup({ secret: r.secret, qr: await QRCode.toDataURL(r.uri, { width: 220, margin: 1 }) }); }
  async function enable() { try { await api.post('/api/admin/totp/enable', { code }); setMsg({ t: 'ok', s: '2-step verification is ON. You will be asked for a code at every sign-in.' }); setSetup(null); setTimeout(() => location.reload(), 1200); } catch (x: any) { setMsg({ t: 'err', s: x.message }); } }
  async function disable() { try { await api.post('/api/admin/totp/disable', { password: off }); location.reload(); } catch (x: any) { setMsg({ t: 'err', s: x.message }); } }
  async function change(e: FormEvent) { e.preventDefault(); try { await api.post('/api/admin/password', pw); setMsg({ t: 'ok', s: 'Password changed. Other sessions were signed out.' }); setPw({ current: '', next: '' }); } catch (x: any) { setMsg({ t: 'err', s: x.message }); } }
  return (
    <div className="stack" style={{ maxWidth: 720 }}>
      <h1>Settings & security</h1>
      <div className="card">
        <div className="row between wrap">
          <div><h2 style={{ margin: 0 }}>{me.name}</h2><div className="muted small">{me.email} · {me.role}</div></div>
          <button className="btn danger" onClick={logout}>Sign out</button>
        </div>
      </div>
      {msg && <div className={'alert ' + msg.t}>{msg.s}</div>}
      <div className="card"><h2>Two-step verification (authenticator app)</h2>
        {me.totp ? (<><div className="alert ok">Enabled ✓</div><label className="f">Confirm password to turn off</label><input type="password" value={off} onChange={(e) => setOff(e.target.value)} /><button className="btn danger" style={{ marginTop: 10 }} onClick={disable}>Turn off</button></>)
          : setup ? (<div className="stack"><p>Scan with Google Authenticator, Microsoft Authenticator, Authy, etc. Or type the key manually.</p><img src={setup.qr} alt="TOTP QR code" width={220} height={220} style={{ background: '#fff', borderRadius: 8 }} /><code style={{ display: 'block', wordBreak: 'break-all' }}>{setup.secret}</code>
            <label className="f">Enter the 6-digit code</label><input inputMode="numeric" maxLength={6} value={code} onChange={(e) => setCode(e.target.value)} /><button className="btn primary" onClick={enable}>Verify & enable</button></div>)
            : (<><p className="muted">Strongly recommended for every staff account. Even if your password leaks, nobody can sign in without your phone.</p><button className="btn primary" onClick={begin}>Set up 2-step verification</button></>)}
      </div>
      <form className="card" onSubmit={change}><h2>Change password</h2>
        <label className="f">Current password</label><input type="password" value={pw.current} onChange={(e) => setPw({ ...pw, current: e.target.value })} required autoComplete="current-password" />
        <label className="f">New password (min 10, mixed case + number)</label><input type="password" value={pw.next} onChange={(e) => setPw({ ...pw, next: e.target.value })} required minLength={10} autoComplete="new-password" />
        <button className="btn primary" style={{ marginTop: 12 }}>Change password</button></form>
      <div className="card"><h2>Appearance & UI color</h2><ThemeSettings /></div>
      {me.role === 'admin' && (
        <>
          <div className="card">
            <div className="row between wrap">
              <div><h2 style={{ margin: 0 }}>Login lockouts</h2><div className="small muted">Clear 15-minute brute-force lockouts if a user is locked out.</div></div>
              <button className="btn danger sm" onClick={async () => { await api.del('/api/admin/locks'); setMsg({ t: 'ok', s: 'All login lockouts cleared.' }); }}>Clear all lockouts</button>
            </div>
          </div>
          <CertificateDesigner />
          <SessionMonitor />
        </>
      )}
    </div>
  );
}

function CertificateDesigner() {
  const r = useLoad(() => api.get('/api/admin/settings'));
  const [b, setB] = useState<any>({ title: 'CERTIFICATE OF COMPLETION', subtitle: 'Internal Training & Competency Assessment', signatoryName: 'Rajesh Chakravarthi Rao', signatoryTitle: 'Head of Training & Quality', disclaimer: 'Internal training certificate issued by the FundsIndia Learning Hub. It is not an NISM/SEBI certification.', accentColor: '#1d6ff2' });
  const [saved, setSaved] = useState('');
  useEffect(() => { if (r.data?.settings?.cert_branding) setB((prev: any) => ({ ...prev, ...r.data.settings.cert_branding })); }, [r.data]);
  async function save(e: FormEvent) {
    e.preventDefault();
    await api.put('/api/admin/settings/cert_branding', b);
    setSaved('Certificate branding saved ✓');
    setTimeout(() => setSaved(''), 2500);
  }
  return (
    <form className="card stack" onSubmit={save}>
      <div className="row between wrap">
        <div><h2 style={{ margin: 0 }}>Custom Certificate Designer & Branding</h2><div className="small muted">Customize learner completion certificates and signatory details.</div></div>
        {saved && <span className="badge g">{saved}</span>}
      </div>
      <div className="grid g2">
        <Field label="Header Title"><input value={b.title || ''} onChange={(e) => setB({ ...b, title: e.target.value })} required /></Field>
        <Field label="Subtitle"><input value={b.subtitle || ''} onChange={(e) => setB({ ...b, subtitle: e.target.value })} /></Field>
        <Field label="Signatory Name"><input value={b.signatoryName || ''} onChange={(e) => setB({ ...b, signatoryName: e.target.value })} /></Field>
        <Field label="Signatory Title"><input value={b.signatoryTitle || ''} onChange={(e) => setB({ ...b, signatoryTitle: e.target.value })} /></Field>
      </div>
      <div className="grid g2">
        <Field label="Border & Accent Color"><input type="color" value={b.accentColor || '#1d6ff2'} onChange={(e) => setB({ ...b, accentColor: e.target.value })} style={{ height: 42, padding: 4 }} /></Field>
        <Field label="Footer Disclaimer"><input value={b.disclaimer || ''} onChange={(e) => setB({ ...b, disclaimer: e.target.value })} /></Field>
      </div>
      <div style={{ background: '#fff', color: '#0c1f3d', border: `6px double ${b.accentColor || '#1d6ff2'}`, borderRadius: 8, padding: 18, textAlign: 'center' }}>
        <div style={{ letterSpacing: '.22em', fontSize: '.78rem', fontWeight: 800, color: b.accentColor || '#1d6ff2' }}>{b.title}</div>
        {b.subtitle && <div style={{ fontSize: '.74rem', color: '#65748b', marginTop: 2 }}>{b.subtitle}</div>}
        <div style={{ fontSize: '1.15rem', fontWeight: 800, margin: '10px 0 4px' }}>Asha Rao</div>
        <div style={{ fontSize: '.8rem', color: '#475569' }}>has completed <b>NISM Series V-A Mock Mastery</b> (92%)</div>
        <div style={{ marginTop: 12, fontSize: '.78rem', fontWeight: 700 }}>{b.signatoryName} <span style={{ fontWeight: 400, color: '#65748b' }}>— {b.signatoryTitle}</span></div>
      </div>
      <div><button className="btn primary">Save certificate branding</button></div>
    </form>
  );
}

function SessionMonitor() {
  const r = useLoad(() => api.get('/api/admin/sessions'));
  function parseDevice(ua = '') {
    const browser = /Edg\//.test(ua) ? 'Edge' : /Chrome\//.test(ua) ? 'Chrome' : /Firefox\//.test(ua) ? 'Firefox' : /Safari\//.test(ua) ? 'Safari' : 'Browser';
    const os = /Windows/.test(ua) ? 'Windows' : /Mac OS/.test(ua) ? 'macOS' : /Android/.test(ua) ? 'Android' : /iPhone|iPad/.test(ua) ? 'iOS' : /Linux/.test(ua) ? 'Linux' : 'Device';
    return `${browser} · ${os}`;
  }
  async function revoke(hash: string) {
    await api.del('/api/admin/sessions/' + hash);
    r.reload();
  }
  return (
    <div className="card stack">
      <div className="row between wrap">
        <div><h2 style={{ margin: 0 }}>Session & Device Monitor</h2><div className="small muted">Active signed-in sessions across Learner, Head, and Admin portals.</div></div>
        <button className="btn sm" onClick={r.reload}>↻ Refresh</button>
      </div>
      {r.loading ? <Spinner /> : !(r.data?.sessions || []).length ? <div className="muted">No active sessions.</div> : (
        <div className="tscroll"><table className="t">
          <thead><tr><th>User</th><th>Portal</th><th>Device & IP</th><th>Signed in</th><th></th></tr></thead>
          <tbody>
            {r.data.sessions.map((s: any) => (
              <tr key={s.token_hash}>
                <td><b>{s.name}</b><div className="muted small">{s.email}</div></td>
                <td><span className={'badge ' + (s.kind === 'admin' ? 'r' : s.kind === 'head' ? 'w' : '')}>{s.kind}</span></td>
                <td className="small">{parseDevice(s.ua || '')}<div className="muted">{s.ip || '—'}</div></td>
                <td className="small muted">{fmtDateTime(s.created_at)}</td>
                <td><button className="btn sm danger" onClick={() => revoke(s.token_hash)}>Force Sign Out</button></td>
              </tr>
            ))}
          </tbody>
        </table></div>
      )}
    </div>
  );
}

/* ---------- Feedback & Contact ---------- */
export function FeedbackPage() {
  const r = useLoad(() => api.get('/api/admin/feedback'));
  const [tab, setTab] = useState<'all' | 'feedback' | 'contact' | 'new'>('all');
  const { me } = useStaff();
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const all: any[] = r.data.items || [];
  const items = all.filter((x) => tab === 'all' ? true : tab === 'new' ? x.status === 'new' : x.kind === tab);
  const newCount = all.filter((x) => x.status === 'new').length;
  async function toggleStatus(x: any) {
    await api.put('/api/admin/feedback/' + x.id, { status: x.status === 'new' ? 'reviewed' : 'new' });
    r.reload();
  }
  return (
    <div className="stack">
      <div className="row between wrap">
        <div>
          <h1>Feedback & contact messages</h1>
          <p className="muted" style={{ margin: 0 }}>All page feedback and Contact Us messages submitted by learners.</p>
        </div>
        <span className="badge w">{newCount} new</span>
      </div>
      <div className="tabs">
        <button className={tab === 'all' ? 'on' : ''} onClick={() => setTab('all')}>All ({all.length})</button>
        <button className={tab === 'feedback' ? 'on' : ''} onClick={() => setTab('feedback')}>Page feedback ({all.filter((x) => x.kind === 'feedback').length})</button>
        <button className={tab === 'contact' ? 'on' : ''} onClick={() => setTab('contact')}>Contact messages ({all.filter((x) => x.kind === 'contact').length})</button>
        <button className={tab === 'new' ? 'on' : ''} onClick={() => setTab('new')}>New ({newCount})</button>
      </div>
      {!items.length && <div className="card muted">No submissions yet.</div>}
      {items.map((x) => (
        <div className="card stack" key={x.id} style={{ gap: 10 }}>
          <div className="row between wrap">
            <div className="row wrap" style={{ gap: 8 }}>
              <span className={'badge ' + (x.kind === 'contact' ? 'w' : '')}>{x.kind === 'contact' ? '✉️ Contact' : '💬 Feedback'}</span>
              <span className={'badge ' + (x.status === 'new' ? 'r' : 'g')}>{x.status}</span>
              {x.rating ? <span className="badge">{'★'.repeat(x.rating)}{'☆'.repeat(5 - x.rating)} ({x.rating}/5)</span> : null}
              {x.page && <span className="badge m">{x.page}</span>}
            </div>
            <span className="small muted">{fmtDateTime(x.created_at)}</span>
          </div>
          {x.subject && <div style={{ fontWeight: 700 }}>{x.subject}</div>}
          <div style={{ whiteSpace: 'pre-wrap' }}>{x.message}</div>
          <div className="row between wrap">
            <div className="small muted">From <b>{x.user_name}</b> ({x.user_email}){x.user_team ? ` · ${x.user_team}` : ''}</div>
            <div className="row">
              <button className="btn sm" onClick={() => toggleStatus(x)}>{x.status === 'new' ? '✓ Mark reviewed' : 'Reopen'}</button>
              {me.role === 'admin' && <button className="btn sm danger" onClick={async () => { if (confirmDel('this message')) { await api.del('/api/admin/feedback/' + x.id); r.reload(); } }}>Delete</button>}
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

/* ---------- Audit ---------- */
export function AuditPage() {
  const [actor, setActor] = useState('');
  const [action, setAction] = useState('');
  const r = useLoad(() => api.get(`/api/admin/audit?actor=${encodeURIComponent(actor)}&action=${encodeURIComponent(action)}`), [actor, action]);
  function exportCsv() {
    const rows = (r.data?.log || []).map((l: any) => [l.created_at, `"${l.actor || ''}"`, l.action, `"${(l.detail || '').replace(/"/g, '""')}"`, l.ip].join(','));
    const blob = new Blob([['When,Actor,Action,Detail,IP', ...rows].join('\n')], { type: 'text/csv' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob); a.download = 'audit-log.csv'; a.click();
  }
  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>Audit log</h1><p className="muted" style={{ margin: 0 }}>Sign-ins, user changes, password resets, and content edits.</p></div>
        <button className="btn" onClick={exportCsv}>⬇ Export CSV</button>
      </div>
      <div className="row wrap">
        <input style={{ flex: 1, minWidth: 180 }} placeholder="Filter by actor email…" value={actor} onChange={(e) => setActor(e.target.value)} />
        <input style={{ flex: 1, minWidth: 180 }} placeholder="Filter by action (e.g. login_failed)…" value={action} onChange={(e) => setAction(e.target.value)} />
      </div>
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} /> : (
        <div className="card tscroll"><table className="t"><thead><tr><th>When</th><th>Who</th><th>Action</th><th>Detail</th><th>IP</th></tr></thead><tbody>
          {r.data.log.map((l: any) => <tr key={l.id}><td className="small">{fmtDateTime(l.created_at)}</td><td>{l.actor}</td><td><span className={'badge ' + (l.action.includes('failed') ? 'r' : 'm')}>{l.action}</span></td><td className="small">{l.detail}</td><td className="small">{l.ip}</td></tr>)}
        </tbody></table></div>
      )}
    </div>
  );
}

/* ---------- FAQs Manager ---------- */
export function FaqsPage() {
  const r = useLoad(() => api.get('/api/admin/faqs'));
  const [cat, setCat] = useState('All');
  const [edit, setEdit] = useState<any>(null);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;

  const all: any[] = r.data.faqs || [];
  const cats = ['All', 'Mutual Funds', 'Bonds', 'SIF', 'PMS', 'Insurance'];
  const list = all.filter((f) => cat === 'All' || f.category === cat);

  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>Investment Products FAQ</h1><p className="muted" style={{ margin: 0 }}>Manage the Advisor Edition FAQs shown to learners.</p></div>
        <button className="btn primary" onClick={() => setEdit({ category: 'Mutual Funds', section: '', question: '', answer: '' })}>＋ Add FAQ</button>
      </div>
      <div className="row wrap">{cats.map((c) => <button key={c} className={'chip' + (cat === c ? ' on' : '')} onClick={() => setCat(c)}>{c}</button>)}</div>
      <div className="card tscroll">
        <table className="t">
          <thead><tr><th>Category / Section</th><th>Question</th><th></th></tr></thead>
          <tbody>
            {list.map((f) => (
              <tr key={f.id}>
                <td><span className="badge">{f.category}</span><div className="muted small" style={{ marginTop: 4 }}>{f.section}</div></td>
                <td><b>{f.question}</b><div className="muted small">{f.answer.slice(0, 110)}…</div></td>
                <td className="row">
                  <button className="btn sm" onClick={() => setEdit(f)}>Edit</button>
                  <button className="btn sm danger" onClick={async () => { if (confirmDel('this FAQ')) { await api.del('/api/admin/faqs/' + f.id); r.reload(); } }}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {edit && <FaqModal f={edit} onClose={() => setEdit(null)} onDone={() => { setEdit(null); r.reload(); }} />}
    </div>
  );
}

function FaqModal({ f: init, onClose, onDone }: { f: any; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ ...init });
  const [err, setErr] = useState('');
  async function go(e: FormEvent) {
    e.preventDefault();
    try { f.id ? await api.put('/api/admin/faqs/' + f.id, f) : await api.post('/api/admin/faqs', f); onDone(); }
    catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title={f.id ? 'Edit FAQ' : 'New FAQ'} onClose={onClose} wide>
      <form onSubmit={go}>
        <div className="grid g2">
          <Field label="Category"><select value={f.category} onChange={(e) => setF({ ...f, category: e.target.value })}>{['Mutual Funds', 'Bonds', 'SIF', 'PMS', 'Insurance'].map((c) => <option key={c}>{c}</option>)}</select></Field>
          <Field label="Section"><input value={f.section} onChange={(e) => setF({ ...f, section: e.target.value })} placeholder="e.g. 1.1 Mutual Fund Basics" /></Field>
        </div>
        <Field label="Question"><input value={f.question} onChange={(e) => setF({ ...f, question: e.target.value })} required /></Field>
        <Field label="Answer"><textarea style={{ fontFamily: 'inherit', minHeight: 110 }} value={f.answer} onChange={(e) => setF({ ...f, answer: e.target.value })} required /></Field>
        {err && <div className="alert err">{err}</div>}
        <button className="btn primary" style={{ marginTop: 14 }}>Save FAQ</button>
      </form>
    </Modal>
  );
}

/* ------------------------------------------------------------------ Push Notifications */
export function NotificationsPage() {
  const r = useLoad(() => api.get('/api/admin/notifications'));
  const t = useLoad(() => api.get('/api/admin/teams'));
  const u = useLoad(() => api.get('/api/admin/users'));
  const [targetType, setTargetType] = useState<'all' | 'team' | 'user'>('all');
  const [team, setTeam] = useState('');
  const [userId, setUserId] = useState('');
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<{ t: 'ok' | 'err'; s: string } | null>(null);

  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;

  const teams: any[] = t.data?.teams || [];
  const learners: any[] = (u.data?.users || []).filter((x: any) => x.role === 'learner' && x.status === 'active');

  async function send(e: FormEvent) {
    e.preventDefault();
    setMsg(null);
    setBusy(true);
    try {
      const payload: any = { title, body };
      if (targetType === 'all') payload.team = '__ALL__';
      else if (targetType === 'team') payload.team = team || teams[0]?.name;
      else payload.userId = userId || learners[0]?.id;
      await api.post('/api/admin/notifications', payload);
      setTitle('');
      setBody('');
      setMsg({ t: 'ok', s: 'Notification pushed! Learners will see it immediately as a popup.' });
      r.reload();
    } catch (x: any) {
      setMsg({ t: 'err', s: x.message });
    } finally {
      setBusy(false);
    }
  }

  async function del(id: string) {
    await api.del('/api/admin/notifications/' + id).catch(() => {});
    r.reload();
  }

  return (
    <div className="stack">
      <div>
        <h1 style={{ marginBottom: 4 }}>Push notifications & system banner</h1>
        <p className="muted" style={{ margin: 0 }}>Broadcast popup notifications or configure a top-of-screen announcement / maintenance banner.</p>
      </div>
      <SystemBannerCard />
      <div className="card">
        <div className="brandbar" />
        <h2 style={{ marginTop: 0 }}>Send new notification</h2>
        <form onSubmit={send} className="stack">
          <div className="grid g2">
            <Field label="Target audience">
              <select value={targetType} onChange={(e) => setTargetType(e.target.value as any)}>
                <option value="all">All learners (Broadcast)</option>
                <option value="team">Specific team</option>
                <option value="user">Specific learner</option>
              </select>
            </Field>
            {targetType === 'team' && (
              <Field label="Select team">
                <select value={team || teams[0]?.name || ''} onChange={(e) => setTeam(e.target.value)}>
                  {teams.map((tm) => <option key={tm.id} value={tm.name}>{tm.name}</option>)}
                </select>
              </Field>
            )}
            {targetType === 'user' && (
              <Field label="Select learner">
                <select value={userId || learners[0]?.id || ''} onChange={(e) => setUserId(e.target.value)}>
                  {learners.map((lr) => <option key={lr.id} value={lr.id}>{lr.name} ({lr.email})</option>)}
                </select>
              </Field>
            )}
          </div>
          <Field label="Notification title">
            <input value={title} onChange={(e) => setTitle(e.target.value)} placeholder="e.g. Mandatory NISM V-A Mock Assessment this Friday" required maxLength={160} />
          </Field>
          <Field label="Message details (optional)">
            <textarea style={{ fontFamily: 'inherit', minHeight: 90 }} value={body} onChange={(e) => setBody(e.target.value)} placeholder="Add details, links, or deadlines for the learners…" maxLength={1500} />
          </Field>
          {msg && <div className={'alert ' + msg.t}>{msg.s}</div>}
          <div><button className="btn primary" disabled={busy || title.trim().length < 2}>{busy ? 'Sending…' : 'Push notification'}</button></div>
        </form>
      </div>

      <div className="card">
        <h2 style={{ marginTop: 0 }}>Sent notifications ({(r.data?.notifications || []).length})</h2>
        {!(r.data?.notifications || []).length ? <div className="muted">No notifications sent yet.</div> : (
          <div className="stack">
            {(r.data.notifications as any[]).map((n) => (
              <div key={n.id} className="lesson-row" style={{ alignItems: 'flex-start' }}>
                <div className="grow">
                  <div className="row wrap" style={{ gap: 8 }}>
                    <b>{n.title}</b>
                    <span className="badge m">{n.team === '__ALL__' ? 'All learners' : n.team ? `Team: ${n.team}` : `User: ${n.user_id}`}</span>
                    <span className="muted small">{fmtDateTime(n.created_at)}</span>
                  </div>
                  {n.body && <div className="muted small" style={{ marginTop: 4, whiteSpace: 'pre-wrap' }}>{n.body}</div>}
                </div>
                <button className="btn sm danger" onClick={() => del(n.id)}>Delete</button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

function SystemBannerCard() {
  const s = useLoad(() => api.get('/api/admin/settings'));
  const [bn, setBn] = useState({ active: false, level: 'info', message: '', expiresAt: '' });
  const [saved, setSaved] = useState('');
  useEffect(() => { if (s.data?.settings?.banner) setBn((prev) => ({ ...prev, ...s.data.settings.banner })); }, [s.data]);
  async function save(e: FormEvent) {
    e.preventDefault();
    await api.put('/api/admin/settings/banner', bn);
    setSaved('Banner settings saved ✓');
    setTimeout(() => setSaved(''), 2500);
  }
  return (
    <form className="card stack" onSubmit={save}>
      <div className="row between wrap">
        <div><h2 style={{ margin: 0 }}>Scheduled Maintenance / Announcement Banner</h2><div className="small muted">Shown as a top alert bar across Learner and Head portals.</div></div>
        {saved && <span className="badge g">{saved}</span>}
      </div>
      <div className="grid g3">
        <Field label="Banner Status"><select value={bn.active ? '1' : '0'} onChange={(e) => setBn({ ...bn, active: e.target.value === '1' })}><option value="0">Off (Hidden)</option><option value="1">Active (Visible)</option></select></Field>
        <Field label="Severity"><select value={bn.level} onChange={(e) => setBn({ ...bn, level: e.target.value })}><option value="info">Info (Blue)</option><option value="warn">Warning / Maintenance (Amber)</option><option value="danger">Urgent / Critical (Red)</option></select></Field>
        <Field label="Auto-hide after date (optional)"><input type="date" value={bn.expiresAt || ''} onChange={(e) => setBn({ ...bn, expiresAt: e.target.value })} /></Field>
      </div>
      <Field label="Banner Message"><input value={bn.message} onChange={(e) => setBn({ ...bn, message: e.target.value })} placeholder="e.g. Scheduled maintenance Sunday 2:00–3:00 AM IST · NISM Batch 14 closes Friday 5 PM" /></Field>
      <div><button className="btn primary">Save banner</button></div>
    </form>
  );
}

/* ------------------------------------------------------------------ Regulatory & Product Changelog */
export function ChangelogPage() {
  const r = useLoad(() => api.get('/api/admin/changelog'));
  const [edit, setEdit] = useState<any>(null);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1 style={{ marginBottom: 4 }}>Regulatory & Product Changelog</h1><p className="muted" style={{ margin: 0 }}>Maintain "Old Rule vs. New Rule" updates so advisors always quote current SEBI, AMFI, and tax rules.</p></div>
        <button className="btn primary" onClick={() => setEdit({ category: 'Regulatory', title: '', effective_date: new Date().toISOString().slice(0, 10), old_rule: '', new_rule: '', impact: '', published: 1 })}>＋ New change entry</button>
      </div>
      <div className="stack">
        {(r.data?.items || []).map((it: any) => (
          <div key={it.id} className="card stack" style={{ gap: 10 }}>
            <div className="row between wrap">
              <div className="row wrap" style={{ gap: 8 }}>
                <span className="badge m">{it.category}</span>
                <b>{it.title}</b>
                <span className="muted small">Effective: {it.effective_date}</span>
                {!it.published && <span className="badge w">Draft</span>}
              </div>
              <div className="row">
                <button className="btn sm" onClick={() => setEdit(it)}>Edit</button>
                <button className="btn sm danger" onClick={async () => { if (confirmDel('this changelog entry')) { await api.del('/api/admin/changelog/' + it.id); r.reload(); } }}>Delete</button>
              </div>
            </div>
            <div className="grid g2">
              <div className="inset" style={{ borderLeft: '3px solid var(--err)' }}><div className="small muted">OLD RULE</div><div className="small" style={{ marginTop: 4 }}>{it.old_rule}</div></div>
              <div className="inset" style={{ borderLeft: '3px solid var(--acc)' }}><div className="small muted">NEW RULE</div><div className="small" style={{ marginTop: 4 }}>{it.new_rule}</div></div>
            </div>
            {it.impact && <div className="small muted"><b>Advisor Action:</b> {it.impact}</div>}
          </div>
        ))}
      </div>
      {edit && <ChangelogModal item={edit} onClose={() => setEdit(null)} onDone={() => { setEdit(null); r.reload(); }} />}
    </div>
  );
}

function ChangelogModal({ item, onClose, onDone }: { item: any; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ ...item });
  const [err, setErr] = useState('');
  async function go(e: FormEvent) {
    e.preventDefault();
    try { f.id ? await api.put('/api/admin/changelog/' + f.id, f) : await api.post('/api/admin/changelog', f); onDone(); }
    catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title={f.id ? 'Edit regulatory change' : 'New regulatory change'} onClose={onClose} wide>
      <form onSubmit={go}>
        <div className="grid g3">
          <Field label="Category"><select value={f.category} onChange={(e) => setF({ ...f, category: e.target.value })}>{['Regulatory', 'Taxation', 'Product', 'Compliance', 'Operations'].map((c) => <option key={c}>{c}</option>)}</select></Field>
          <Field label="Effective Date"><input type="date" value={f.effective_date} onChange={(e) => setF({ ...f, effective_date: e.target.value })} required /></Field>
          <Field label="Status"><select value={f.published ? '1' : '0'} onChange={(e) => setF({ ...f, published: e.target.value === '1' ? 1 : 0 })}><option value="1">Published</option><option value="0">Draft</option></select></Field>
        </div>
        <Field label="Title"><input value={f.title} onChange={(e) => setF({ ...f, title: e.target.value })} required /></Field>
        <div className="grid g2">
          <Field label="Old Rule"><textarea style={{ fontFamily: 'inherit', minHeight: 90 }} value={f.old_rule} onChange={(e) => setF({ ...f, old_rule: e.target.value })} required /></Field>
          <Field label="New Rule"><textarea style={{ fontFamily: 'inherit', minHeight: 90 }} value={f.new_rule} onChange={(e) => setF({ ...f, new_rule: e.target.value })} required /></Field>
        </div>
        <Field label="Advisor Action / Impact"><input value={f.impact || ''} onChange={(e) => setF({ ...f, impact: e.target.value })} placeholder="What advisors should do differently on client calls" /></Field>
        {err && <div className="alert err">{err}</div>}
        <button className="btn primary" style={{ marginTop: 14 }}>Save entry</button>
      </form>
    </Modal>
  );
}

