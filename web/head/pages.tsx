import { FormEvent, ReactNode, useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { api } from '../shared/api';
import { CATEGORIES, ErrorBox, Markdown, Spinner, ThemeSettings, fmtDate, fmtDateTime, useLoad } from '../shared/components';
import { Player } from '../shared/Player';
import { useHead } from './App';

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
const Field = ({ label, children }: { label: string; children: ReactNode }) => (<div><label className="f">{label}</label>{children}</div>);

/* ---------- Content Browser (read-only) ---------- */
export function ContentBrowser() {
  const r = useLoad(() => api.get('/api/head/courses'));
  const [q, setQ] = useState('');
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const courses = (r.data.courses || []).filter((c: any) => !q || (c.title + c.code + (c.subtitle || '')).toLowerCase().includes(q.toLowerCase()));
  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>Content library</h1><p className="muted" style={{ margin: 0 }}>Browse all published courses, lessons, and assessments.</p></div>
        <input style={{ maxWidth: 280 }} placeholder="Filter courses…" value={q} onChange={(e) => setQ(e.target.value)} />
      </div>
      <div className="grid g3">
        {courses.map((c: any) => (
          <Link key={c.id} to={'/courses/' + c.id} className="card link">
            <div className="cover" />
            <div className="row between"><span className="badge">{c.code}</span><span className="badge m">{CATEGORIES[c.category] || c.category}</span></div>
            <h3 style={{ marginTop: 12 }}>{c.title}</h3>
            <div className="muted small" style={{ minHeight: 22 }}>{c.subtitle}</div>
            <div className="row wrap small muted" style={{ marginTop: 10 }}><span>📄 {c.lessons} lessons</span><span>✅ {c.quizzes} quizzes</span></div>
          </Link>
        ))}
      </div>
    </div>
  );
}

export function CourseViewer() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/head/courses/' + id), [id]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const { course, modules, lessons, quizzes } = r.data;
  return (
    <div className="stack">
      <div className="small muted"><Link to="/">← Content library</Link> / {course.code}</div>
      <div className="card">
        <div className="brandbar" />
        <span className="badge">{course.code}</span>
        <h1 style={{ marginTop: 10 }}>{course.title}</h1>
        <p className="muted" style={{ margin: 0 }}>{course.description}</p>
      </div>
      {modules.map((m: any) => {
        const ls = lessons.filter((l: any) => l.module_id === m.id);
        if (!ls.length) return null;
        return (
          <div className="card" key={m.id}>
            <h3 style={{ marginTop: 0 }}>{m.title}</h3>
            {ls.map((l: any) => (
              <Link key={l.id} to={'/lessons/' + l.id} className="lesson-row">
                <span className="kind">{l.kind === 'video' ? '▶' : '📄'}</span>
                <span className="grow">{l.title}</span>
                <span className="muted small">{l.minutes ? l.minutes + ' min' : ''}</span>
              </Link>
            ))}
          </div>
        );
      })}
      {quizzes.length > 0 && (
        <div className="card">
          <h3 style={{ marginTop: 0 }}>Quizzes & assessments ({quizzes.length})</h3>
          {quizzes.map((q: any) => (
            <div key={q.id} className="lesson-row">
              <span className="kind">✅</span>
              <span className="grow"><b>{q.title}</b><div className="muted small">{q.questions} questions · {q.minutes} min · pass {q.pass_pct}%</div></span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export function LessonViewer() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/head/lessons/' + id), [id]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const l = r.data.lesson;
  return (
    <div className="stack" style={{ maxWidth: 920 }}>
      <div className="small muted"><Link to={'/courses/' + l.course_id}>← Back to course</Link></div>
      {l.kind === 'video' && l.video_id && <Player videoId={l.video_id} title={l.title} />}
      <div className="card">
        <h1>{l.title}</h1>
        {l.body && <Markdown text={l.body} />}
      </div>
    </div>
  );
}

/* ---------- My Team & Assigned Courses (read-only: Admin decides access) ---------- */
export function TeamsPage() {
  const r = useLoad(() => api.get('/api/head/teams'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const cur = r.data.teams[0];
  const allowedSet = new Set<string>(cur?.courses || []);
  const allowedCourses = (r.data.courses || []).filter((c: any) => cur?.full || allowedSet.has(c.id));

  return (
    <div className="stack">
      <div>
        <h1>My team: {cur?.name}</h1>
        <p className="muted" style={{ margin: 0 }}>You manage <b>{cur?.name}</b> ({cur?.learners || 0} members). Course access for your team is configured by your Administrator.</p>
      </div>
      <div className="card stack">
        <div className="row between wrap"><h2 style={{ margin: 0 }}>Courses assigned to {cur?.name}</h2><span className="badge g">{allowedCourses.length} course(s)</span></div>
        {allowedCourses.map((c: any) => (
          <Link key={c.id} to={'/courses/' + c.id} className="lesson-row">
            <span className="badge">{c.code}</span>
            <span className="grow"><b>{c.title}</b></span>
            <span className="muted small">{CATEGORIES[c.category] || c.category}</span>
          </Link>
        ))}
      </div>
    </div>
  );
}

/* ---------- People & Team Members (Head's 1 team only) ---------- */
export function UsersPage() {
  const { me } = useHead();
  const r = useLoad(() => api.get('/api/head/users'));
  const [q, setQ] = useState('');
  const [modal, setModal] = useState<null | 'add' | 'bulk' | any>(null);
  const [creds, setCreds] = useState<{ email: string; password: string }[] | null>(null);
  const [progFor, setProgFor] = useState<any>(null);

  const users = (r.data?.users || []).filter((u: any) =>
    !q || (u.name + u.email + (u.emp_id || '')).toLowerCase().includes(q.toLowerCase()),
  );

  async function reset(u: any) {
    if (!confirm(`Reset password for ${u.email}? They will be signed out.`)) return;
    try { const x = await api.post(`/api/head/users/${u.id}/reset`); setCreds([{ email: u.email, password: x.password }]); } catch (e: any) { alert(e.message); }
  }

  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>{me.team} — Members</h1><p className="muted" style={{ margin: 0 }}>Add and manage learners in your assigned team.</p></div>
        <div className="row"><button className="btn primary" onClick={() => setModal('add')}>＋ Add member</button><button className="btn" onClick={() => setModal('bulk')}>⬆ Bulk add (CSV)</button></div>
      </div>
      <input placeholder="Search name, e-mail, user ID…" value={q} onChange={(e) => setQ(e.target.value)} />
      {r.loading ? <Spinner /> : r.error ? <ErrorBox error={r.error} /> : (
        <div className="card tscroll"><table className="t"><thead><tr><th>Member</th><th>Team</th><th>Status</th><th>Progress</th><th>Last login</th><th></th></tr></thead><tbody>
          {users.map((u: any) => (
            <tr key={u.id}>
              <td><b>{u.name}</b><div className="muted small">{u.email}{u.emp_id ? ` · ID ${u.emp_id}` : ''}{u.department ? ` · ${u.department}` : ''}</div></td>
              <td><span className="badge">{u.team}</span></td>
              <td><span className={'badge ' + (u.status === 'active' ? 'g' : u.status === 'pending' ? 'w' : 'r')}>{u.status}</span></td>
              <td className="small">{u.lessons} lessons · {u.avg_score ?? '—'}% avg · {u.certs} cert</td>
              <td className="small">{fmtDateTime(u.last_login)}</td>
              <td className="row wrap" style={{ justifyContent: 'flex-end' }}>
                <button className="btn sm" onClick={() => setProgFor(u)}>Progress</button>
                <button className="btn sm" onClick={() => setModal(u)}>Edit</button>
                <button className="btn sm" onClick={() => reset(u)}>Reset pw</button>
              </td>
            </tr>
          ))}
        </tbody></table>{!users.length && <div className="muted" style={{ padding: 16 }}>No members in {me.team} yet.</div>}</div>
      )}
      {progFor && <MemberProgress u={progFor} onClose={() => setProgFor(null)} />}
      {modal === 'add' && <AddMember team={me.team || ''} onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal === 'bulk' && <BulkMembers team={me.team || ''} onClose={() => setModal(null)} onDone={(c) => { setModal(null); setCreds(c); r.reload(); }} />}
      {modal && typeof modal === 'object' && <EditMember u={modal} onClose={() => setModal(null)} onDone={() => { setModal(null); r.reload(); }} />}
      {creds && (
        <Modal title="Temporary passwords" onClose={() => setCreds(null)}>
          <div className="alert warn">Shown <b>once</b>. Users must change it at first sign-in.</div>
          <textarea readOnly rows={Math.min(12, creds.length + 1)} value={creds.map((c) => `${c.email}\t${c.password}`).join('\n')} onFocus={(e) => e.target.select()} />
          <div className="row" style={{ marginTop: 12 }}><button className="btn" onClick={() => setCreds(null)}>Done</button></div>
        </Modal>
      )}
    </div>
  );
}

function MemberProgress({ u, onClose }: { u: any; onClose: () => void }) {
  const r = useLoad(() => api.get(`/api/head/users/${u.id}/progress`));
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

function AddMember({ team, onClose, onDone }: { team: string; onClose: () => void; onDone: (c: any[]) => void }) {
  const [f, setF] = useState({ name: '', email: '', empId: '', department: '' });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) {
    e.preventDefault();
    try { const r = await api.post('/api/head/users', f); if (!r.created.length) throw new Error('Could not create (duplicate or invalid e-mail).'); onDone(r.created); }
    catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title={`Add member to ${team}`} onClose={onClose}><form onSubmit={go}>
      <Field label="Full name"><input value={f.name} onChange={set('name')} required /></Field>
      <Field label="E-mail"><input type="email" value={f.email} onChange={set('email')} required /></Field>
      <div className="grid g2"><Field label="User ID"><input value={f.empId} onChange={set('empId')} placeholder="e.g. FI1023" /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Create & generate password</button>
    </form></Modal>
  );
}

function BulkMembers({ team, onClose, onDone }: { team: string; onClose: () => void; onDone: (c: any[]) => void }) {
  const [txt, setTxt] = useState('');
  const [err, setErr] = useState('');
  async function go() {
    const users = txt.split('\n').map((l) => l.trim()).filter(Boolean).map((l) => { const [email, name, empId, department] = l.split(/[,\t]/).map((x) => x.trim()); return { email, name, empId, department }; });
    try { const r = await api.post('/api/head/users', { users }); if (r.skipped.length) alert('Skipped: ' + r.skipped.join(', ')); onDone(r.created); } catch (x: any) { setErr(x.message); }
  }
  return (
    <Modal title={`Bulk add to ${team}`} onClose={onClose}>
      <p className="muted small">One per line: <code>email, full name, user id, department</code>. All added members are placed in <b>{team}</b>.</p>
      <textarea rows={10} value={txt} onChange={(e) => setTxt(e.target.value)} placeholder="asha@company.com, Asha Rao, FI1023, Sales" />
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 12 }} onClick={go}>Create accounts</button>
    </Modal>
  );
}

function EditMember({ u, onClose, onDone }: { u: any; onClose: () => void; onDone: () => void }) {
  const [f, setF] = useState({ name: u.name, empId: u.emp_id || '', department: u.department || '', status: u.status });
  const [err, setErr] = useState('');
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });
  async function go(e: FormEvent) { e.preventDefault(); try { await api.put('/api/head/users/' + u.id, f); onDone(); } catch (x: any) { setErr(x.message); } }
  return (
    <Modal title={'Edit ' + u.email} onClose={onClose}><form onSubmit={go}>
      <Field label="Name"><input value={f.name} onChange={set('name')} required /></Field>
      <div className="grid g2"><Field label="User ID"><input value={f.empId} onChange={set('empId')} /></Field><Field label="Department"><input value={f.department} onChange={set('department')} /></Field></div>
      <Field label="Status"><select value={f.status} onChange={set('status')}><option value="active">Active</option><option value="pending">Pending</option><option value="suspended">Suspended</option></select></Field>
      {err && <div className="alert err">{err}</div>}<button className="btn primary" style={{ marginTop: 16 }}>Save</button>
    </form></Modal>
  );
}

/* ---------- Settings ---------- */
export function SettingsPage() {
  const { me, logout } = useHead();
  const [pw, setPw] = useState({ current: '', next: '' });
  const [msg, setMsg] = useState<{ t: string; s: string } | null>(null);
  async function change(e: FormEvent) {
    e.preventDefault();
    try { await api.post('/api/head/password', pw); setMsg({ t: 'ok', s: 'Password updated.' }); setPw({ current: '', next: '' }); }
    catch (x: any) { setMsg({ t: 'err', s: x.message }); }
  }
  return (
    <div className="stack" style={{ maxWidth: 720 }}>
      <h1>Settings</h1>
      <div className="card">
        <div className="row between wrap">
          <div><h2 style={{ margin: 0 }}>{me.name}</h2><div className="muted small">{me.email} · {me.role}</div></div>
          <button className="btn danger" onClick={logout}>Sign out</button>
        </div>
      </div>
      <div className="card"><h2>Appearance & UI color</h2><ThemeSettings /></div>
      <form className="card" onSubmit={change}>
        <h2>Change password</h2>
        <label className="f">Current password</label><input type="password" value={pw.current} onChange={(e) => setPw({ ...pw, current: e.target.value })} required />
        <label className="f">New password (min 10, mixed case + number)</label><input type="password" value={pw.next} onChange={(e) => setPw({ ...pw, next: e.target.value })} required minLength={10} />
        {msg && <div className={'alert ' + msg.t}>{msg.s}</div>}
        <button className="btn primary" style={{ marginTop: 12 }}>Update password</button>
      </form>
    </div>
  );
}

/* ---------- Compliance Matrix ---------- */
export function MatrixPage() {
  const { me } = useHead();
  const r = useLoad(() => api.get('/api/head/matrix'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;

  const users: any[] = r.data.users || [];
  const courses: any[] = (r.data.courses || []).slice(0, 12);
  const progMap = new Map<string, number>();
  (r.data.progress || []).forEach((p: any) => progMap.set(`${p.user_id}:${p.course_id}`, p.done));

  function exportCsv() {
    const header = ['Name', 'Email', 'Team', ...courses.map((c) => c.code)].join(',');
    const rows = users.map((u) => [
      `"${u.name}"`, u.email, `"${u.team || ''}"`,
      ...courses.map((c) => `${progMap.get(`${u.id}:${c.id}`) || 0}/${c.total}`),
    ].join(','));
    const blob = new Blob([[header, ...rows].join('\n')], { type: 'text/csv' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = `compliance-matrix-${me.team || 'team'}.csv`;
    a.click();
  }

  return (
    <div className="stack">
      <div className="row between wrap">
        <div><h1>{me.team} — Compliance matrix</h1><p className="muted" style={{ margin: 0 }}>Completion progress across your team members.</p></div>
        <button className="btn primary" onClick={exportCsv}>⬇ Export CSV</button>
      </div>
      <div className="card tscroll">
        <table className="t">
          <thead><tr><th>Member</th><th>Team</th>{courses.map((c) => <th key={c.id}>{c.code}</th>)}</tr></thead>
          <tbody>
            {users.map((u) => (
              <tr key={u.id}>
                <td><b>{u.name}</b><div className="muted small">{u.emp_id || u.email}</div></td>
                <td><span className="badge">{u.team || '—'}</span></td>
                {courses.map((c) => {
                  const done = progMap.get(`${u.id}:${c.id}`) || 0;
                  const pct = c.total ? Math.round((done / c.total) * 100) : 0;
                  return <td key={c.id}><span className={'badge ' + (pct >= 100 ? 'g' : pct > 0 ? 'w' : 'm')}>{pct}%</span></td>;
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

/* ---------- Assign Deadlines ---------- */
export function AssignmentsPage() {
  const { me } = useHead();
  const cs = useLoad(() => api.get('/api/head/courses'));
  const r = useLoad(() => api.get('/api/head/assignments'));
  const [f, setF] = useState({ targetKind: 'course', targetId: '', dueDate: '' });
  const [err, setErr] = useState('');

  async function add(e: FormEvent) {
    e.preventDefault();
    setErr('');
    try {
      await api.post('/api/head/assignments', f);
      setF({ targetKind: 'course', targetId: '', dueDate: '' });
      r.reload();
    } catch (x: any) { setErr(x.message); }
  }

  return (
    <div className="stack">
      <div><h1>Assign deadlines ({me.team})</h1><p className="muted" style={{ margin: 0 }}>Assign a due date to your team members and notify them automatically.</p></div>
      <form className="card stack" onSubmit={add}>
        <div className="grid g2">
          <Field label="Course">
            <select value={f.targetId} onChange={(e) => setF({ ...f, targetId: e.target.value })} required>
              <option value="">Choose course…</option>
              {(cs.data?.courses || []).map((c: any) => <option key={c.id} value={c.id}>{c.title}</option>)}
            </select>
          </Field>
          <Field label="Due date">
            <input type="date" value={f.dueDate} onChange={(e) => setF({ ...f, dueDate: e.target.value })} required />
          </Field>
        </div>
        {err && <div className="alert err">{err}</div>}
        <div><button className="btn primary">Assign &amp; notify {me.team}</button></div>
      </form>
      <div className="card tscroll">
        <table className="t">
          <thead><tr><th>Team</th><th>Assigned item</th><th>Due date</th><th>Assigned by</th><th></th></tr></thead>
          <tbody>
            {(r.data?.assignments || []).map((a: any) => (
              <tr key={a.id}>
                <td><span className="badge">{a.team}</span></td>
                <td><b>{a.title}</b></td>
                <td>{fmtDate(a.due_date)}</td>
                <td className="small muted">{a.assigned_by}</td>
                <td><button className="btn sm danger" onClick={async () => { await api.del('/api/head/assignments/' + a.id); r.reload(); }}>Remove</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

/* ---------- Team Analytics ---------- */
export function AnalyticsPage() {
  const r = useLoad(() => api.get('/api/head/analytics'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  return (
    <div className="stack">
      <h1>Team analytics</h1>
      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card">
          <h2 style={{ marginTop: 0 }}>Team quiz performance</h2>
          {(r.data.byTeam || []).map((t: any) => (
            <div key={t.team} className="row between lesson-row">
              <span><b>{t.team}</b><div className="muted small">{t.learners} learners · {t.attempts} attempts</div></span>
              <span className="badge">{t.avg_score != null ? t.avg_score + '%' : '—'}</span>
            </div>
          ))}
        </div>
        <div className="card">
          <h2 style={{ marginTop: 0 }}>Lowest-scoring quizzes</h2>
          {(r.data.weakQuizzes || []).map((q: any) => (
            <div key={q.title} className="row between lesson-row">
              <span>{q.title}<div className="muted small">{q.tries} attempts</div></span>
              <span className={'badge ' + (q.avg < 60 ? 'r' : 'w')}>{q.avg}%</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
