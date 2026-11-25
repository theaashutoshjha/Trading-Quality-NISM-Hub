import { FormEvent, ReactNode, useEffect, useState } from 'react';
import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom';
import QRCode from 'qrcode';
import { api } from '../shared/api';
import { CATEGORIES, ErrorBox, Markdown, Spinner, fmtDate, fmtDateTime, useLoad } from '../shared/components';
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
      <div className="card"><h2>Recent quiz attempts</h2>
        <div className="tscroll"><table className="t"><thead><tr><th>Learner</th><th>Quiz</th><th>Score</th><th>When</th></tr></thead><tbody>
          {r.data.recent.map((a: any, i: number) => <tr key={i}><td>{a.name}<div className="muted small">{a.email}</div></td><td>{a.title}</td><td><span className={'badge ' + (a.passed ? 'g' : 'r')}>{a.pct}%</span></td><td>{fmtDateTime(a.created_at)}</td></tr>)}
        </tbody></table></div></div>
    </div>
  );
}

/* ---------- Users ---------- */
export const TEAMS = ['MF Onboarding', 'MF Digital', 'MF Silver', 'MF Gold', 'MF Platinum', 'Equity Onboarding', 'Equity Regular', 'Customer Support', 'Training & Quality'];
const TeamSelect = ({ value, onChange }: { value: string; onChange: (e: any) => void }) => (
  <select value={value} onChange={onChange}><option value="">— no team (cannot sign in) —</option>{TEAMS.map((t) => <option key={t} value={t}>{t}</option>)}</select>
);
export function UsersPage() {
  const r = useLoad(() => api.get('/api/admin/users'));
  const [q, setQ] = useState('');
  const [modal, setModal] = useState<null | 'add' | 'bulk' | any>(null);
  const [creds, setCreds] = useState<{ email: string; password: string }[] | null>(null);
  const [progFor, setProgFor] = useState<any>(null);
  const [toast, say] = useToast();
  const { me } = useStaff();
  const users = (r.data?.users || []).filter((u: any) => !q || (u.name + u.email + (u.emp_id || '')).toLowerCase().includes(q.toLowerCase()));

  async function act(fn: () => Promise<any>, ok: string) { try { await fn(); say(ok); r.reload(); } catch (e: any) { alert(e.message); } }
  async function reset(u: any) {
    if (!confirm(`Reset password for ${u.email}? They will be signed out.`)) return;
    try { const x = await api.post(`/api/admin/users/${u.id}/reset`); setCreds([{ email: u.email, password: x.password }]); } catch (e: any) { alert(e.message); }
  }
  return (
    <div className="stack">
      {toast}
      <div className="row between wrap"><h1>Users & access</h1><div className="row"><button className="btn primary" onClick={() => setModal('add')}>＋ Add user</button><button className="btn" onClick={() => setModal('bulk')}>⬆ Bulk add (CSV)</button></div></div>
      <div className="alert ok">🔒 Only administrators can create or delete accounts — there is no self-registration. A learner's progress, resume points, quiz history and certificates are stored against their account and are kept every time they sign out and back in. Prefer <b>Suspend</b> (Edit → Status) over Delete: deleting an account permanently erases that person's learning data.</div>
      <input placeholder="Search name, e-mail, user ID…" value={q} onChange={(e) => setQ(e.target.value)} aria-label="Search users" />
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} /> : (
        <div className="card tscroll"><table className="t"><thead><tr><th>User</th><th>Role</th><th>Status</th><th>Progress</th><th>Last login</th><th></th></tr></thead><tbody>
          {users.map((u: any) => (
            <tr key={u.id}>
              <td><b>{u.name}</b><div className="muted small">{u.email}{u.emp_id ? ` · ID ${u.emp_id}` : ''}{u.department ? ` · ${u.department}` : ''}</div>{u.role === 'learner' && (u.team ? <span className="badge" style={{ marginTop: 4 }}>{u.team}</span> : <span className="badge r" style={{ marginTop: 4 }}>No team</span>)}</td>
              <td><span className={'badge ' + (u.role === 'admin' ? 'r' : u.role === 'trainer' ? 'w' : 'm')}>{u.role}</span>{u.totp_enabled ? <span className="badge g" title="2-step on" style={{ marginLeft: 4 }}>2FA</span> : null}</td>
              <td><span className={'badge ' + (u.status === 'active' ? 'g' : u.status === 'pending' ? 'w' : 'r')}>{u.status}</span></td>
              <td className="small">{u.lessons} lessons · {u.avg_score ?? '—'}% avg · {u.certs} cert</td>
              <td className="small">{fmtDateTime(u.last_login)}</td>
              <td className="row wrap" style={{ justifyContent: 'flex-end' }}>
                {u.status === 'pending' && <button className="btn sm good" onClick={() => act(() => api.put('/api/admin/users/' + u.id, { ...u, empId: u.emp_id, status: 'active' }), 'Approved')}>Approve</button>}
                <button className="btn sm" onClick={() => setProgFor(u)}>Progress</button>
                <button className="btn sm" onClick={() => setModal(u)}>Edit</button>
                <button className="btn sm" onClick={() => reset(u)}>Reset pw</button>
                {u.id !== me.id && <button className="btn sm danger" onClick={() => prompt(`This permanently erases ${u.name}'s account AND all their learning data (progress, quiz history, certificates).\n\nTo continue, type their e-mail: ${u.email}`) === u.email && act(() => api.del('/api/admin/users/' + u.id), 'Deleted')}>Delete</button>}
              </td>
            </tr>))}
        </tbody></table>{!users.length && <div className="muted" style={{ padding: 16 }}>No users.</div>}</div>)}

      {progFor && <UserProgress u={progFor} onClose={() => setProgFor(null)} />}
      {modal === 'add' && <AddUser onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal === 'bulk' && <BulkUsers onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal && typeof modal === 'object' && <EditUser u={modal} self={modal.id === me.id} onClose={() => setModal(null)} onDone={() => { setModal(null); say('Saved'); r.reload(); }} />}
      {creds && (
        <Modal title="Temporary passwords" onClose={() => setCreds(null)}>
          <div className="alert warn">Shown <b>once</b>. Share securely; users must change it at first sign-in.</div>
          <textarea readOnly rows={Math.min(12, creds.length + 1)} value={creds.map((c) => `${c.email}\t${c.password}`).join('\n')} onFocus={(e) => e.target.select()} />
          <div className="row" style={{ marginTop: 12 }}><button className="btn primary" onClick={() => navigator.clipboard?.writeText(creds.map((c) => `${c.email}\t${c.password}`).join('\n'))}>Copy</button><button className="btn" onClick={() => setCreds(null)}>Done</button></div>
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
        <div><h3>Certificates</h3>{!r.data.certificates.length ? <div className="muted">None.</div> : r.data.certificates.map((c: any) => <div key={c.id} className="lesson-row">🏅 {c.title} — {c.pct}% · {c.id}</div>)}</div>
      </div>)}
    </Modal>
  );
}
function AddUser({ onClose, onDone }: { onClose: () => void; onDone: (c: any[]) => void }) {
  const [f, setF] = useState({ name: '', email: '', empId: '', department: '', team: '', role: 'learner' });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) { e.preventDefault(); try { const r = await api.post('/api/admin/users', f); if (!r.created.length) throw new Error('Could not create (duplicate or invalid e-mail).'); onDone(r.created); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title="Add user" onClose={onClose}><form onSubmit={go}>
      <Field label="Full name"><input value={f.name} onChange={set('name')} required /></Field>
      <Field label="E-mail"><input type="email" value={f.email} onChange={set('email')} required /></Field>
      <div className="grid g2"><Field label="User ID (used to sign in)"><input value={f.empId} onChange={set('empId')} placeholder="e.g. FI1023" /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      <Field label="Team (decides what they can access)"><TeamSelect value={f.team} onChange={set('team')} /></Field>
      <Field label="Role"><select value={f.role} onChange={set('role')}><option value="learner">Learner</option><option value="trainer">Trainer (can edit content)</option><option value="admin">Admin (full access)</option></select></Field>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Create & generate password</button>
    </form></Modal>
  );
}
function BulkUsers({ onClose, onDone }: { onClose: () => void; onDone: (c: any[]) => void }) {
  const [txt, setTxt] = useState('');
  const [err, setErr] = useState('');
  async function go() {
    const users = txt.split('\n').map((l) => l.trim()).filter(Boolean).map((l) => { const [email, name, empId, department, team] = l.split(/[,\t]/).map((x) => x.trim()); return { email, name, empId, department, team, role: 'learner' }; });
    try { const r = await api.post('/api/admin/users', { users }); if (r.skipped.length) alert('Skipped (duplicate/invalid): ' + r.skipped.join(', ')); onDone(r.created); } catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title="Bulk add learners" onClose={onClose}>
      <p className="muted small">One per line: <code>email, full name, user id, department, team</code> (user id, department and team are optional; team must be exactly one of: {TEAMS.join(' / ')}). Up to 500 lines.</p>
      <textarea rows={10} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder="asha@company.com, Asha Rao, FI1023, Sales, MF Digital" />
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 12 }} onClick={go}>Create accounts</button>
    </Modal>
  );
}
function EditUser({ u, self, onClose, onDone }: { u: any; self: boolean; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ name: u.name, empId: u.emp_id || '', department: u.department || '', team: u.team || '', role: u.role, status: u.status });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) { e.preventDefault(); try { await api.put('/api/admin/users/' + u.id, f); onDone(); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title={'Edit ' + u.email} onClose={onClose}><form onSubmit={go}>
      <Field label="Name"><input value={f.name} onChange={set('name')} required /></Field>
      <div className="grid g2"><Field label="User ID (used to sign in)"><input value={f.empId} onChange={set('empId')} /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      <Field label="Team (decides what they can access)"><TeamSelect value={f.team} onChange={set('team')} /></Field>
      <div className="grid g2"><Field label="Role"><select value={f.role} onChange={set('role')} disabled={self}><option value="learner">Learner</option><option value="trainer">Trainer</option><option value="admin">Admin</option></select></Field>
        <Field label="Status"><select value={f.status} onChange={set('status')} disabled={self}><option value="active">Active</option><option value="pending">Pending</option><option value="suspended">Suspended</option></select></Field></div>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Save</button>
    </form></Modal>
  );
}

/* ---------- Courses ---------- */
/* ---------- Team access ---------- */
export function TeamAccessPage() {
  const r = useLoad(() => api.get('/api/admin/teams'));
  const [team, setTeam] = useState(TEAMS[0]);
  const [sel, setSel] = useState<Set<string>>(new Set());
  const [msg, setMsg] = useState('');
  useEffect(() => { if (r.data) setSel(new Set(r.data.teams.find((t: any) => t.name === team)?.courses || [])); }, [r.data, team]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const cats = Array.from(new Set<string>(r.data.courses.map((c: any) => c.category)));
  const toggle = (id: string) => { const n = new Set(sel); if (n.has(id)) n.delete(id); else n.add(id); setSel(n); };
  async function save() { try { await api.put('/api/admin/teams/' + encodeURIComponent(team), { courses: [...sel] }); setMsg('Saved ✓ — applies immediately'); r.reload(); setTimeout(() => setMsg(''), 2500); } catch (e: any) { alert(e.message); } }
  const cur = r.data.teams.find((t: any) => t.name === team);
  const full = !!cur?.full;
  return (
    <div className="stack">
      <div><h1>Team access</h1><p className="muted" style={{ margin: 0 }}>Choose which courses each team can see. Learners sign in with their User ID, password and team; they only ever see the courses ticked here. Admins and trainers see everything.</p></div>
      {r.data.unassigned > 0 && <div className="alert warn">{r.data.unassigned} learner account(s) have no team yet and cannot sign in. Assign teams under <b>Users & access</b>.</div>}
      <div className="row wrap">{TEAMS.map((t) => { const x = r.data.teams.find((y: any) => y.name === t); return <button key={t} className={'chip' + (team === t ? ' on' : '')} onClick={() => setTeam(t)}>{t} <span className="muted small">({x?.learners || 0})</span></button>; })}</div>
      <div className="card">
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
        {!full && <div className="row" style={{ marginTop: 18 }}><button className="btn primary" onClick={save}>Save access for {team}</button><button className="btn" onClick={() => setSel(new Set(r.data.courses.map((c: any) => c.id)))}>Select all</button><button className="btn" onClick={() => setSel(new Set())}>Clear</button>{msg && <span className="badge g">{msg}</span>}</div>}
      </div>
    </div>
  );
}

export function CoursesPage() {
  const r = useLoad(() => api.get('/api/admin/courses'));
  const [show, setShow] = useState(false);
  const [cat, setCat] = useState('all');
  const nav = useNavigate();
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const courses: any[] = r.data.courses;
  // Every category is shown as its own section (Sales & Service, NISM, Academy, ...), in the same order learners see them.
  const order = Object.keys(CATEGORIES);
  const present = order.filter((k) => courses.some((c) => c.category === k)).concat(Array.from(new Set(courses.map((c) => c.category))).filter((k) => !order.includes(k as string)) as string[]);
  const shown = present.filter((k) => cat === 'all' || cat === k);
  return (
    <div className="stack">
      <div className="row between wrap"><h1>Courses & videos</h1><button className="btn primary" onClick={() => setShow(true)}>＋ New course</button></div>
      <div className="row wrap" role="tablist" aria-label="Category">
        <button className={'chip' + (cat === 'all' ? ' on' : '')} onClick={() => setCat('all')}>All ({courses.length})</button>
        {present.map((k) => <button key={k} className={'chip' + (cat === k ? ' on' : '')} onClick={() => setCat(k)}>{CATEGORIES[k] || k} ({courses.filter((c) => c.category === k).length})</button>)}
      </div>
      {shown.map((k) => {
        const list = courses.filter((c) => c.category === k);
        return (
          <div className="card" key={k}>
            <div className="row between wrap"><h2 style={{ margin: 0 }}>{CATEGORIES[k] || k}</h2><span className="small muted">{list.length} course{list.length === 1 ? '' : 's'} · {list.reduce((n, c) => n + c.lessons, 0)} lessons</span></div>
            <div className="tscroll" style={{ marginTop: 10 }}><table className="t"><thead><tr><th>Course</th><th>Lessons</th><th>Quizzes / Qs</th><th>Status</th><th></th></tr></thead><tbody>
              {list.map((c: any) => (
                <tr key={c.id}><td><b>{c.title}</b><div className="muted small">{c.code} — {c.subtitle}</div></td><td>{c.lessons}</td><td>{c.quizzes} / {c.questions}</td>
                  <td><span className={'badge ' + (c.published ? 'g' : 'm')}>{c.published ? 'Published' : 'Draft'}</span></td><td><Link className="btn sm" to={'/courses/' + c.id}>Edit</Link></td></tr>))}
            </tbody></table></div>
          </div>
        );
      })}
      {show && <NewCourse onClose={() => setShow(false)} onDone={(id) => nav('/courses/' + id)} />}
    </div>
  );
}

/* ---------- Feedback & messages from learners ---------- */
const CAT_LABEL: Record<string, string> = { issue: 'Problem', content: 'Content', access: 'Access', suggestion: 'Suggestion', other: 'Other' };
export function FeedbackPage() {
  const [kind, setKind] = useState('');
  const [status, setStatus] = useState('');
  const [q, setQ] = useState('');
  const r = useLoad(() => api.get('/api/admin/feedback?' + new URLSearchParams({ ...(kind ? { kind } : {}), ...(status ? { status } : {}), ...(q.trim().length >= 2 ? { q: q.trim() } : {}) }).toString()), [kind, status, q]);
  const [notes, setNotes] = useState<Record<string, string>>({});
  async function setState(it: any, st: string) {
    try { await api.put('/api/admin/feedback/' + it.id, { status: st, adminNote: notes[it.id] ?? it.admin_note ?? '' }); r.reload(); } catch (e: any) { alert(e.message); }
  }
  const { me } = useStaff();
  async function del(it: any) { if (!confirm('Delete this item permanently?')) return; try { await api.del('/api/admin/feedback/' + it.id); r.reload(); } catch (e: any) { alert(e.message); } }
  const counts = r.data?.counts;
  const stars = (n: number) => '★'.repeat(n) + '☆'.repeat(5 - n);
  return (
    <div className="stack">
      <div><h1>Feedback & messages</h1><p className="muted" style={{ margin: 0 }}>What learners send from the "Was this helpful?" box under every lesson and from <b>Contact us</b>.</p></div>
      {counts && (
        <div className="grid g4">
          <div className="card stat"><div className="ic">📥</div><div><b>{counts.new_count || 0}</b><span>New</span></div></div>
          <div className="card stat"><div className="ic">⭐</div><div><b>{counts.avg_rating ?? '—'}</b><span>Average rating</span></div></div>
          <div className="card stat"><div className="ic">💬</div><div><b>{counts.content || 0}</b><span>Content feedback</span></div></div>
          <div className="card stat"><div className="ic">✉️</div><div><b>{counts.contact || 0}</b><span>Contact messages</span></div></div>
        </div>)}
      <div className="row wrap">
        {[['', 'All'], ['contact', 'Contact messages'], ['content', 'Content feedback']].map(([k, l]) => <button key={k} className={'chip' + (kind === k ? ' on' : '')} onClick={() => setKind(k)}>{l}</button>)}
        <span className="grow" />
        {[['', 'Any status'], ['new', 'New'], ['read', 'Read'], ['resolved', 'Resolved']].map(([k, l]) => <button key={k} className={'chip' + (status === k ? ' on' : '')} onClick={() => setStatus(k)}>{l}</button>)}
      </div>
      <input placeholder="Search learner, subject, message or lesson…" value={q} onChange={(e) => setQ(e.target.value)} aria-label="Search feedback" />
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} retry={r.reload} /> : !r.data.items.length ? <div className="card muted">Nothing here yet.</div> : r.data.items.map((it: any) => (
        <div className="card" key={it.id}>
          <div className="row wrap between">
            <div className="row wrap" style={{ gap: 8 }}>
              <span className={'badge ' + (it.kind === 'contact' ? '' : 'm')}>{it.kind === 'contact' ? '✉️ Contact' : '💬 Content'}</span>
              <span className={'badge ' + (it.status === 'new' ? 'w' : it.status === 'resolved' ? 'g' : 'm')}>{it.status}</span>
              {it.kind === 'contact' && it.category && <span className="badge m">{CAT_LABEL[it.category] || it.category}</span>}
              {it.kind === 'content' && <span style={{ color: '#f5a524', letterSpacing: 2 }} title={it.rating + ' of 5'}>{stars(it.rating || 0)}</span>}
            </div>
            <span className="small muted">{fmtDateTime(it.updated_at || it.created_at)}</span>
          </div>
          <div style={{ margin: '10px 0 4px' }}><b>{it.user_name}</b> <span className="muted small">· {it.user_email}{it.team ? ' · ' + it.team : ''}</span></div>
          {it.kind === 'contact' ? <div style={{ fontWeight: 700 }}>{it.subject}</div> : <div className="small muted">On: {it.lesson_id ? <Link to={'/lesson/' + it.lesson_id}>{it.target_title}</Link> : <Link to={'/courses/' + it.course_id}>{it.target_title}</Link>}</div>}
          {it.message ? <p style={{ whiteSpace: 'pre-wrap', margin: '8px 0 0' }}>{it.message}</p> : <p className="muted small" style={{ margin: '8px 0 0' }}>(rating only, no comment)</p>}
          <div className="row wrap" style={{ marginTop: 12, gap: 8 }}>
            <input style={{ flex: 1, minWidth: 200 }} placeholder="Internal note (optional)" maxLength={1000} defaultValue={it.admin_note || ''} onChange={(e) => setNotes({ ...notes, [it.id]: e.target.value })} aria-label="Internal note" />
            {it.status !== 'read' && <button className="btn sm" onClick={() => setState(it, 'read')}>Mark read</button>}
            {it.status !== 'resolved' && <button className="btn sm good" onClick={() => setState(it, 'resolved')}>Resolve</button>}
            {it.status === 'resolved' && <button className="btn sm" onClick={() => setState(it, 'new')}>Reopen</button>}
            {me.role === 'admin' && <button className="btn sm danger" onClick={() => del(it)}>Delete</button>}
          </div>
        </div>))}
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
      <div className="row between wrap"><h1>{course.title}</h1><span className={'badge ' + (course.published ? 'g' : 'm')}>{course.published ? 'Published' : 'Draft'}</span></div>
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
  async function go() {
    try { const questions = JSON.parse(txt); const r = await api.post(`/api/admin/quizzes/${quizId}/questions`, { questions: Array.isArray(questions) ? questions : questions.questions }); onDone(r.added); }
    catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title="Bulk import questions" onClose={onClose} wide>
      <p className="muted small">Paste a JSON array. <code>answer</code> is the zero-based index of the correct option. Up to 500 per import. Tip: ask an AI assistant to produce questions from your official NISM workbook in this format — then review them.</p>
      <textarea rows={14} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder={'[\n  {"question": "…", "options": ["A","B","C","D"], "answer": 1, "explanation": "…"}\n]'} />
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 12 }} onClick={go}>Import</button>
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

/* ---------- Security ---------- */
export function SecurityPage() {
  const { me } = useStaff();
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
      <h1>My security</h1>
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
    </div>
  );
}

/* ---------- Audit ---------- */
export function AuditPage() {
  const r = useLoad(() => api.get('/api/admin/audit'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} />;
  return (
    <div className="stack"><h1>Audit log</h1><p className="muted">Sign-ins (including failures), user changes, password resets and content edits. Latest 300 events.</p>
      <div className="card tscroll"><table className="t"><thead><tr><th>When</th><th>Who</th><th>Action</th><th>Detail</th><th>IP</th></tr></thead><tbody>
        {r.data.log.map((l: any) => <tr key={l.id}><td className="small">{fmtDateTime(l.created_at)}</td><td>{l.actor}</td><td><span className={'badge ' + (l.action.includes('failed') ? 'r' : 'm')}>{l.action}</span></td><td className="small">{l.detail}</td><td className="small">{l.ip}</td></tr>)}
      </tbody></table></div></div>
  );
}

