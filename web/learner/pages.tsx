import { FormEvent, useEffect, useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom';
import { api } from '../shared/api';
import { CATEGORIES, ErrorBox, Markdown, Progress, Spinner, ago, fmtDate, useLoad } from '../shared/components';
import { Player, thumb } from '../shared/Player';
import { FlipBook } from '../shared/FlipBook';
import { useAuth } from './App';

const hrs = (m: number) => (m >= 60 ? `${Math.round((m / 60) * 10) / 10} h` : `${m} min`);
const kindIcon = (k: string) => (k === 'video' ? '▶' : k === 'link' ? '🔗' : '📄');

/* ------------------------------------------------------------------ Login */
export function Login() {
  const { setUser } = useAuth();
  const TEAMS = ['MF Onboarding', 'MF Digital', 'MF Silver', 'MF Gold', 'MF Platinum', 'Equity Onboarding', 'Equity Regular', 'Customer Support', 'Training & Quality'];
  const [f, setF] = useState(() => { let team = ''; try { team = localStorage.getItem('fi_team') || ''; } catch { /* private mode */ } return { userId: '', password: '', team }; });
  const [err, setErr] = useState('');
  const [busy, setBusy] = useState(false);
  const [show, setShow] = useState(false);
  const set = (k: string) => (e: any) => setF({ ...f, [k]: e.target.value });

  async function submit(e: FormEvent) {
    e.preventDefault();
    setErr(''); setBusy(true);
    try {
      const r = await api.post('/api/auth/login', { userId: f.userId, password: f.password, team: f.team });
      try { localStorage.setItem('fi_team', f.team); } catch { /* ignore */ }
      const me = await api.get('/api/auth/me').catch(() => null);
      setUser(me?.user ? { ...me.user, cats: me.cats } : r.user);
    } catch (x: any) { setErr(x.message); } finally { setBusy(false); }
  }

  return (
    <div className="auth">
      <div className="art" style={{ backgroundImage: 'url(/login-hero.jpg)' }}>
        <div className="brandbar" style={{ width: 80 }} />
        <h1>Learn. Certify. Advise with confidence.</h1>
        <p style={{ maxWidth: 460, opacity: .92 }}>NISM preparation, FundsIndia Academy videos, sales & service skills, Zoho CRM and Tata Tele guides, and daily market updates — in one place for the FundsIndia team.</p>
      </div>
      <div className="form">
        <form className="box stack" onSubmit={submit} autoComplete="on">
          <img src="/logo.png" alt="FundsIndia" style={{ height: 44 }} />
          <div><h1 style={{ marginBottom: 4 }}>Learner sign-in</h1>
            <div className="muted small">Accounts are created by your administrator. Sign in with your User ID, password and the team you belong to — what you see depends on your team.</div></div>
          <div><label className="f" htmlFor="uid">User ID</label><input id="uid" value={f.userId} onChange={set('userId')} required autoComplete="username" placeholder="Employee ID or work e-mail" autoCapitalize="none" spellCheck={false} /></div>
          <div><label className="f">Password</label>
            <div style={{ position: 'relative' }}>
              <input type={show ? 'text' : 'password'} value={f.password} onChange={set('password')} required autoComplete="current-password" />
              <button type="button" className="btn sm ghost" style={{ position: 'absolute', right: 6, top: 6 }} onClick={() => setShow(!show)}>{show ? 'Hide' : 'Show'}</button>
            </div>
          </div>
          <div><label className="f" htmlFor="team">Team</label>
            <select id="team" value={f.team} onChange={set('team')} required><option value="" disabled>Select your team</option>{TEAMS.map((t) => <option key={t} value={t}>{t}</option>)}</select></div>
          {err && <div className="alert err" role="alert">{err}</div>}
          <button className="btn primary" style={{ width: '100%', padding: 14 }} disabled={busy || !f.team}>{busy ? 'Please wait…' : 'Sign in'}</button>
          <div className="muted small center">🔒 Internal use only. Your progress and data are private to your account and are kept when you sign out.</div>
        </form>
      </div>
    </div>
  );
}
export function ChangePasswordGate() {
  const { setUser, user, logout } = useAuth();
  return (
    <div className="auth" style={{ gridTemplateColumns: '1fr' }}>
      <div className="form"><div className="box stack">
        <img src="/logo.png" alt="FundsIndia" style={{ height: 40 }} />
        <h1>Set a new password</h1>
        <div className="alert warn">Hi {user?.name}. For security you must choose your own password before continuing.</div>
        <PasswordForm onDone={() => setUser({ ...user!, mustChange: false })} />
        <button className="btn ghost" onClick={logout}>Sign out</button>
      </div></div>
    </div>
  );
}

function PasswordForm({ onDone }: { onDone?: () => void }) {
  const [f, setF] = useState({ current: '', next: '', again: '' });
  const [msg, setMsg] = useState<{ t: 'ok' | 'err'; s: string } | null>(null);
  const [busy, setBusy] = useState(false);
  async function go(e: FormEvent) {
    e.preventDefault(); setMsg(null);
    if (f.next !== f.again) return setMsg({ t: 'err', s: 'New passwords do not match.' });
    setBusy(true);
    try { await api.post('/api/auth/password', { current: f.current, next: f.next }); setMsg({ t: 'ok', s: 'Password updated.' }); setF({ current: '', next: '', again: '' }); onDone?.(); }
    catch (x: any) { setMsg({ t: 'err', s: x.message }); } finally { setBusy(false); }
  }
  return (
    <form onSubmit={go}>
      <label className="f">Current password</label><input type="password" value={f.current} onChange={(e) => setF({ ...f, current: e.target.value })} required autoComplete="current-password" />
      <label className="f">New password</label><input type="password" value={f.next} onChange={(e) => setF({ ...f, next: e.target.value })} required minLength={10} autoComplete="new-password" />
      <label className="f">Repeat new password</label><input type="password" value={f.again} onChange={(e) => setF({ ...f, again: e.target.value })} required autoComplete="new-password" />
      <div className="muted small" style={{ marginTop: 6 }}>At least 10 characters, with upper-case, lower-case and a number.</div>
      {msg && <div className={'alert ' + msg.t}>{msg.s}</div>}
      <button className="btn primary" style={{ marginTop: 14 }} disabled={busy}>Update password</button>
    </form>
  );
}

/* ------------------------------------------------------------------ Dashboard (everything here is the signed-in user's own data) */
function Ring({ pct, size }: { pct: number; size?: number }) {
  return <div className="ring" style={{ ['--p' as any]: Math.round(pct), width: size, height: size }}><span>{Math.round(pct)}%</span></div>;
}

export function CourseCard({ c }: { c: any }) {
  if (c.category === 'process') {
    return (
      <Link to={'/courses/' + c.id} className="card link">
        <div className="cover" />
        <div className="row between"><span className="badge">{c.code}</span><span className="badge m">Reference</span></div>
        <h3 style={{ marginTop: 12 }}>{c.title}</h3>
        <div className="muted small" style={{ minHeight: 22 }}>{c.subtitle}</div>
        <div className="row wrap small muted" style={{ margin: '12px 0' }}><span>📑 {c.lesson_count} documents</span></div>
        <span className="btn sm primary">Open documents →</span>
      </Link>
    );
  }
  const pct = c.lesson_count ? (c.done / c.lesson_count) * 100 : 0;
  return (
    <Link to={'/courses/' + c.id} className="card link">
      <div className="cover" />
      <div className="row between"><span className="badge">{c.code}</span>{c.popular ? <span className="badge w">★ Popular</span> : null}</div>
      <h3 style={{ marginTop: 12 }}>{c.title}</h3>
      <div className="muted small" style={{ minHeight: 22 }}>{c.subtitle}</div>
      <div className="row wrap small muted" style={{ margin: '12px 0' }}>
        {c.video_count > 0 && <span>▶ {c.video_count} videos</span>}
        {c.lesson_count - c.video_count > 0 && <span>📄 {c.lesson_count - c.video_count} notes</span>}
        {c.quiz_count > 0 && <span>✅ {c.quiz_count} quizzes</span>}
      </div>
      {c.lesson_count > 0 ? <><Progress value={pct} label="Progress" /><div className="small muted" style={{ marginTop: 6 }}>{c.done}/{c.lesson_count} complete</div></> : <div className="small muted">Coming soon</div>}
    </Link>
  );
}

export function Dashboard() {
  const { user } = useAuth();
  const d = useLoad(() => api.get('/api/dashboard'));
  const cs = useLoad(() => api.get('/api/courses'));
  const hour = new Date().getHours();
  if (d.loading || cs.loading) return <Spinner />;
  if (d.error) return <ErrorBox error={d.error} retry={d.reload} />;
  const s = d.data.stats;
  const popular = (cs.data?.courses || []).filter((c: any) => c.popular).slice(0, 4);
  const tiles: [string, any, string][] = [
    ['🔥', s.streak, 'Day streak'], ['✅', s.lessons, 'Lessons completed'], ['⏱', hrs(s.watch_minutes || 0), 'Time learning'], ['📝', s.avg_score != null ? s.avg_score + '%' : '—', 'Avg quiz score'], ['🏅', s.certs, 'Certificates'],
  ];
  return (
    <div className="stack">
      <div className="hero">
        <div className="brandbar" />
        <h1>{hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening'}, {user?.name.split(' ')[0]} 👋</h1>
        <p>{s.streak > 1 ? `You're on a ${s.streak}-day learning streak — keep it going!` : 'A little learning every day compounds. Pick up where you left off, or start a learning path.'}</p>
        <div className="row wrap" style={{ marginTop: 18 }}>
          {d.data.watching[0] ? <Link className="btn primary" to={'/lessons/' + d.data.watching[0].id}>▶ Resume: {d.data.watching[0].title.slice(0, 46)}</Link> : <Link className="btn primary" to="/paths">🧭 Start a learning path</Link>}
          <Link className="btn" to="/courses">Browse library</Link>
        </div>
      </div>

      <div className="grid g4">{tiles.map(([ic, n, l]) => <div key={l} className="card stat"><div className="ic">{ic}</div><div><b>{n}</b><span>{l}</span></div></div>)}</div>

      {d.data.watching.length > 0 && (
        <div><h2>Continue watching</h2>
          <div className="grid g4">{d.data.watching.map((w: any) => (
            <Link key={w.id} to={'/lessons/' + w.id} className="card link flat" style={{ padding: 12 }}>
              <div className="thumb" style={{ backgroundImage: `url(${thumb(w.id.split('-v-')[1] || '')})` }}><div className="playico">▶</div><div className="bar"><div style={{ width: `${(w.seconds / w.duration) * 100}%` }} /></div></div>
              <div style={{ fontWeight: 700, margin: '10px 4px 2px', fontSize: '.9rem' }}>{w.title}</div><div className="muted small" style={{ margin: '0 4px' }}>{w.course_title}</div>
            </Link>))}</div></div>)}

      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card">
          <div className="row between"><h2>My learning paths</h2><Link to="/paths" className="small">All paths →</Link></div>
          {d.data.paths.active.map((p: any) => (
            <Link key={p.id} to={'/paths/' + p.id} className="lesson-row"><Ring pct={(p.done / p.total) * 100} size={52} /><span className="grow"><b>{p.icon} {p.title}</b><div className="muted small">{p.done} of {p.total} steps</div></span><span className="btn sm">Continue</span></Link>))}
          {!d.data.paths.active.length && <div className="muted small" style={{ marginBottom: 8 }}>You haven't started a path yet. Suggested for you:</div>}
          {!d.data.paths.active.length && d.data.paths.suggested.map((p: any) => (
            <Link key={p.id} to={'/paths/' + p.id} className="lesson-row"><span className="kind">{p.icon}</span><span className="grow"><b>{p.title}</b><div className="muted small">{p.total} steps</div></span><span className="btn sm primary">Start</span></Link>))}
          {d.data.paths.finished > 0 && <div className="badge g" style={{ marginTop: 10 }}>🎉 {d.data.paths.finished} path(s) completed</div>}
        </div>
        <div className="card">
          <h2>Courses in progress</h2>
          {d.data.started.length === 0 && <div className="muted">Nothing started yet — pick a course below.</div>}
          {d.data.started.map((c: any) => (
            <Link key={c.id} to={'/courses/' + c.id} className="lesson-row" style={{ display: 'block' }}>
              <div className="row between"><b>{c.title}</b><span className="small muted">{c.done}/{c.total}</span></div>
              <Progress value={c.total ? (c.done / c.total) * 100 : 0} />
            </Link>))}
        </div>
      </div>

      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card">
          <div className="row between"><h2>Latest bulletins</h2><Link to="/updates" className="small">All updates →</Link></div>
          {d.data.news.length === 0 && <div className="muted">No bulletins yet.</div>}
          {d.data.news.map((n: any) => (
            <div key={n.id} className="news-item">
              <span className="badge m">{n.category}</span> {n.pinned ? <span className="badge w">Pinned</span> : null}
              <div style={{ fontWeight: 700, marginTop: 6 }}>{n.url ? <a href={n.url} target="_blank" rel="noopener noreferrer">{n.title}</a> : n.title}</div>
              <div className="muted small">{ago(n.published_at)}</div>
            </div>))}
        </div>
        <div className="card">
          <h2>Recent quiz results</h2>
          {!d.data.attempts.length && <div className="muted">Take a practice quiz to see your scores here.</div>}
          {d.data.attempts.map((a: any, i: number) => <div key={i} className="lesson-row"><span className={'badge ' + (a.passed ? 'g' : 'r')}>{a.pct}%</span><span className="grow">{a.title}</span><span className="muted small">{ago(a.created_at)}</span></div>)}
        </div>
      </div>

      {popular.length > 0 && (<div>
        <div className="row between"><h2>Popular courses</h2><Link to="/courses" className="small">Browse all →</Link></div>
        <div className="grid g4">{popular.map((c: any) => <CourseCard key={c.id} c={c} />)}</div></div>)}
    </div>
  );
}

/* ------------------------------------------------------------------ Learning paths */
export function Paths() {
  const r = useLoad(() => api.get('/api/paths'));
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  return (
    <div className="stack">
      <div><h1>Learning paths</h1><p className="muted" style={{ margin: 0 }}>Step-by-step journeys: each path puts videos and notes in the right order so you always know what to learn next.</p></div>
      <div className="grid g3">
        {r.data.paths.map((p: any) => (
          <Link key={p.id} to={'/paths/' + p.id} className="card link">
            <div className="row between"><span className="kind" style={{ width: 48, height: 48, fontSize: 24 }}>{p.icon}</span><Ring pct={p.total ? (p.done / p.total) * 100 : 0} /></div>
            <h3 style={{ marginTop: 14 }}>{p.title}</h3>
            <div className="muted small" style={{ minHeight: 64 }}>{p.description}</div>
            <div className="row wrap small muted" style={{ marginTop: 10 }}><span className="badge">{p.level}</span><span>{p.total} steps</span><span>⏱ {hrs(p.minutes)}</span></div>
          </Link>))}
      </div>
    </div>
  );
}

export function PathView() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/paths/' + id), [id]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const { path, items } = r.data;
  const done = items.filter((i: any) => i.done).length;
  const next = items.find((i: any) => !i.done) || items[0];
  return (
    <div className="stack" style={{ maxWidth: 900 }}>
      <div className="small muted"><Link to="/paths">Learning paths</Link> / {path.title}</div>
      <div className="card">
        <div className="row wrap"><span className="kind" style={{ width: 56, height: 56, fontSize: 28 }}>{path.icon}</span><div className="grow"><h1 style={{ margin: 0 }}>{path.title}</h1><span className="badge">{path.level}</span></div><Ring pct={items.length ? (done / items.length) * 100 : 0} size={72} /></div>
        <p className="muted">{path.description}</p>
        <Progress value={items.length ? (done / items.length) * 100 : 0} />
        <div className="row between wrap" style={{ marginTop: 10 }}><span className="small muted">{done} of {items.length} steps complete · ⏱ {hrs(items.reduce((a: number, i: any) => a + (i.minutes || 0), 0))}</span>
          {next && <Link className="btn primary" to={`/lessons/${next.id}?path=${path.id}`}>{done ? '▶ Continue' : '▶ Start path'}</Link>}</div>
      </div>
      <div className="card">
        {items.map((it: any, i: number) => (
          <Link key={it.id} to={`/lessons/${it.id}?path=${path.id}`} className={'lesson-row step' + (it.done ? ' done' : '')}>
            <span className="n">{it.done ? '✓' : i + 1}</span>
            <span><b>{it.title}</b><div className="muted small">{kindIcon(it.kind)} {it.kind === 'video' ? 'Video' : 'Notes'} · {it.course}{it.module ? ` · ${it.module}` : ''}{it.seconds > 5 && !it.done && it.duration ? ` · resume at ${Math.round(it.seconds / 60)} min` : ''}</div></span>
            <span className="muted small">{it.minutes ? it.minutes + ' min' : ''}</span>
          </Link>))}
      </div>
    </div>
  );
}

/* ------------------------------------------------------------------ Courses */
export function Courses() {
  const [sp, setSp] = useSearchParams();
  const cat = sp.get('cat') || 'all';
  const [q, setQ] = useState('');
  const r = useLoad(() => api.get('/api/courses'));
  const list = useMemo(() => (r.data?.courses || []).filter((c: any) => (cat === 'all' || c.category === cat) && (!q || (c.title + c.code + (c.subtitle || '')).toLowerCase().includes(q.toLowerCase()))), [r.data, cat, q]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const order = Object.keys(CATEGORIES);
  const cats = ['all', ...order.filter((k) => r.data.courses.some((c: any) => c.category === k))];
  const grouped = order.map((k) => [k, list.filter((c: any) => c.category === k)] as const).filter(([, v]) => v.length);
  return (
    <div className="stack">
      <h1>Course library</h1>
      <div className="row wrap">
        {cats.map((k) => <button key={k} className={'chip' + (cat === k ? ' on' : '')} onClick={() => setSp(k === 'all' ? {} : { cat: k })}>{k === 'all' ? 'All' : CATEGORIES[k]}</button>)}
        <span className="grow" /><input style={{ maxWidth: 260 }} placeholder="Filter…" value={q} onChange={(e) => setQ(e.target.value)} aria-label="Filter courses" />
      </div>
      {!list.length ? <div className="muted">No courses match.</div> : grouped.map(([k, cs]) => (
        <div key={k}><h2>{CATEGORIES[k]}</h2><div className="grid g3">{cs.map((c: any) => <CourseCard key={c.id} c={c} />)}</div></div>))}
    </div>
  );
}

export function CourseView() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/courses/' + id), [id]);
  const [tab, setTab] = useState('contents');
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const { course, modules, lessons, quizzes, done, best, certificate, watching } = r.data;
  const doneSet = new Set<string>(done);
  const watch = new Map<string, any>(watching.map((w: any) => [w.lesson_id, w]));
  const pct = lessons.length ? (doneSet.size / lessons.length) * 100 : 0;
  const bestOf = (qid: string) => best.find((b: any) => b.quiz_id === qid);
  const unassigned = lessons.filter((l: any) => !modules.some((m: any) => m.id === l.module_id));
  const first = lessons.find((l: any) => !doneSet.has(l.id)) || lessons[0];
  const videos = lessons.filter((l: any) => l.kind === 'video').length;
  const mins = lessons.reduce((a: number, l: any) => a + (l.minutes || 0), 0);
  const mocks = quizzes.filter((q: any) => q.mock);
  const practice = quizzes.filter((q: any) => !q.mock);
  const workbookFile = `/workbooks/NISM-Series-${String(course.code).replace(/^NISM\s*/i, '').replace(/\s+/g, '-')}.pdf`;

  if (course.category === 'process') return <DocLibrary course={course} modules={modules} lessons={lessons} />;

  const lessonRow = (l: any) => {
    const w = watch.get(l.id);
    return (
      <Link key={l.id} to={'/lessons/' + l.id} className="lesson-row">
        <span className={'tick' + (doneSet.has(l.id) ? ' on' : '')}>{doneSet.has(l.id) ? '✓' : ''}</span>
        <span className="kind">{kindIcon(l.kind)}</span>
        <span className="grow">{l.title}{l.author && l.kind === 'video' && <div className="muted small">{l.author}</div>}{w && !doneSet.has(l.id) && w.duration > 0 && <div style={{ maxWidth: 160, marginTop: 4 }}><Progress value={(w.seconds / w.duration) * 100} /></div>}</span>
        <span className="muted small">{l.minutes ? l.minutes + ' min' : ''}</span>
      </Link>
    );
  };

  return (
    <div className="stack">
      <div className="card">
        <div className="brandbar" />
        <div className="row wrap"><span className="badge">{course.code}</span>{course.level && <span className="badge m">{course.level}</span>}<span className="badge m">{CATEGORIES[course.category] || course.category}</span></div>
        <h1 style={{ marginTop: 12 }}>{course.title} <span className="muted" style={{ fontWeight: 500 }}>— {course.subtitle}</span></h1>
        <p className="muted" style={{ marginTop: 0, maxWidth: 820 }}>{course.description}</p>
        <div className="row wrap small muted" style={{ marginBottom: 14 }}>{videos > 0 && <span>▶ {videos} videos</span>}{lessons.length - videos > 0 && <span>📄 {lessons.length - videos} notes</span>}{quizzes.length > 0 && <span>✅ {quizzes.length} quizzes</span>}{mins > 0 && <span>⏱ {hrs(mins)}</span>}</div>
        {lessons.length > 0 && <div className="row wrap" style={{ gap: 20 }}><div style={{ flex: 1, minWidth: 240, maxWidth: 420 }}><Progress value={pct} /><div className="small muted" style={{ marginTop: 6 }}>{doneSet.size} of {lessons.length} complete ({Math.round(pct)}%)</div></div>
          {first && <Link className="btn primary" to={'/lessons/' + first.id}>{doneSet.size ? '▶ Continue learning' : '▶ Start course'}</Link>}</div>}
        {certificate && <div className="alert ok" style={{ marginTop: 14 }}>🎉 Certificate earned ({certificate.pct}%) — <Link to={'/certificate/' + certificate.id}>view / print</Link></div>}
      </div>

      <div className="tabs" role="tablist">
        <button role="tab" className={tab === 'contents' ? 'on' : ''} onClick={() => setTab('contents')}>📚 Course contents</button>
        {practice.length > 0 && <button role="tab" className={tab === 'quiz' ? 'on' : ''} onClick={() => setTab('quiz')}>✅ Practice & exams ({practice.length})</button>}
        {mocks.length > 0 && <button role="tab" className={tab === 'mock' ? 'on' : ''} onClick={() => setTab('mock')}>📝 Mock tests ({mocks.length})</button>}
        {course.category === 'nism' && <button role="tab" className={tab === 'book' ? 'on' : ''} onClick={() => setTab('book')}>📖 Workbook</button>}
        {course.links.length > 0 && <button role="tab" className={tab === 'res' ? 'on' : ''} onClick={() => setTab('res')}>🔗 Official resources</button>}
      </div>

      {tab === 'contents' && (
        <div className="stack">
          {!lessons.length && <div className="card muted">Content for this course is being prepared.</div>}
          {modules.map((m: any) => {
            const ls = lessons.filter((l: any) => l.module_id === m.id);
            if (!ls.length) return null;
            const md = ls.filter((l: any) => doneSet.has(l.id)).length;
            return (
              <div className="card" key={m.id}>
                <div className="row between"><h3 style={{ margin: 0 }}>{m.title}</h3><span className="small muted">{m.weight ? `${m.weight}% weight · ` : ''}{md}/{ls.length}</span></div>
                <div style={{ marginTop: 10 }}>{ls.map(lessonRow)}</div>
              </div>);
          })}
          {unassigned.length > 0 && <div className="card"><h3>More lessons</h3>{unassigned.map(lessonRow)}</div>}
        </div>
      )}

      {tab === 'mock' && (
        <div className="stack">
          <div className="card">
            <h3 style={{ marginTop: 0 }}>{mocks.length} full-length mock tests</h3>
            <div className="row wrap small muted">
              <span className="badge g">{mocks[0].questions} questions each</span>
              <span className="badge">Pass mark {mocks[0].pass_pct}%</span>
              <span className={'badge ' + (mocks[0].negative > 0 ? 'r' : 'm')}>{mocks[0].negative > 0 ? `Negative marking: −${mocks[0].negative} per wrong answer` : 'No negative marking'}</span>
              <span className="badge m">⏱ {mocks[0].minutes} min</span>
            </div>
            <p className="muted small" style={{ marginBottom: 0 }}>Every mock follows this series' exam rules. Unanswered questions score zero. Answers and explanations appear after you submit. Mock tests do not issue certificates.</p>
          </div>
          <div className="grid g4">
            {mocks.map((q: any, i: number) => {
              const b = bestOf(q.id);
              return (
                <Link key={q.id} to={'/quiz/' + q.id} className="card link flat" style={{ padding: 16 }}>
                  <div className="row between"><b>Mock Test {i + 1}</b>{b && <span className={'badge ' + (b.best >= q.pass_pct ? 'g' : 'r')}>{b.best}%</span>}</div>
                  <div className="small muted" style={{ marginTop: 6 }}>{q.questions} questions · {q.minutes} min</div>
                  <div className="small" style={{ marginTop: 8, color: b ? undefined : 'var(--mut)' }}>{b ? `${b.tries} attempt${b.tries > 1 ? 's' : ''}` : 'Not attempted'}</div>
                </Link>
              );
            })}
          </div>
        </div>
      )}

      {tab === 'book' && <WorkbookTab file={workbookFile} code={course.code} />}

      {tab === 'quiz' && (
        <div className="grid g2">
          {practice.map((q: any) => {
            const b = bestOf(q.id);
            return (
              <div className="card" key={q.id}>
                <div className="row between"><h3 style={{ margin: 0 }}>{q.title}</h3>{q.is_exam ? <span className="badge w">Final exam</span> : <span className="badge m">Practice</span>}</div>
                <div className="small muted" style={{ margin: '10px 0' }}>{q.questions} questions in bank · {q.minutes} min · pass {q.pass_pct}%</div>
                {b ? <div className="small">Best: <b>{b.best}%</b> · {b.tries} attempt{b.tries > 1 ? 's' : ''}</div> : <div className="small muted">Not attempted</div>}
                <Link className="btn primary sm" style={{ marginTop: 12 }} to={'/quiz/' + q.id}>{b ? 'Retake' : 'Start'}</Link>
              </div>
            );
          })}
        </div>
      )}

      {tab === 'res' && (
        <div className="card">
          <h3>Official resources</h3>
          {course.links.map((l: any) => <div key={l.url} className="lesson-row"><span className="kind">🔗</span><a href={l.url} target="_blank" rel="noopener noreferrer">{l.title}</a></div>)}
        </div>
      )}
    </div>
  );
}

/* ------------------------------------------------------------------ Workbook (page-turning PDF) */
function WorkbookTab({ file, code }: { file: string; code: string }) {
  const [ok, setOk] = useState<boolean | null>(null);
  useEffect(() => {
    let dead = false;
    fetch(file, { method: 'HEAD' }).then((r) => !dead && setOk(r.ok && (r.headers.get('content-type') || '').includes('pdf'))).catch(() => !dead && setOk(false));
    return () => { dead = true; };
  }, [file]);
  if (ok === null) return <Spinner />;
  if (!ok) return (
    <div className="card stack">
      <h3 style={{ margin: 0 }}>📖 {code} workbook</h3>
      <p className="muted" style={{ margin: 0 }}>The official workbook has not been added to the Learning Hub yet. Ask your administrator to add <code>{file.replace('/workbooks/', '')}</code>, or read it on the NISM site.</p>
      <div><a className="btn" href="https://www.nism.ac.in/publication/" target="_blank" rel="noopener noreferrer">NISM publications ↗</a></div>
    </div>
  );
  return (
    <div className="card stack">
      <div className="row between wrap"><h3 style={{ margin: 0 }}>📖 {code} workbook</h3><span className="small muted">Drag a page corner, use ‹ › or the arrow keys to turn pages</span></div>
      <FlipBook src={file} />
    </div>
  );
}

/* ------------------------------------------------------------------ Process documents (plain reference pages) */
function DocLibrary({ course, modules, lessons }: { course: any; modules: any[]; lessons: any[] }) {
  const [q, setQ] = useState('');
  const match = (l: any) => !q.trim() || l.title.toLowerCase().includes(q.trim().toLowerCase());
  const groups = modules.map((m: any) => ({ m, items: lessons.filter((l: any) => l.module_id === m.id && match(l)) })).filter((g) => g.items.length);
  return (
    <div className="stack" style={{ maxWidth: 960 }}>
      <div className="small muted"><Link to="/courses?cat=process">Process documents</Link> / {course.title}</div>
      <div className="card">
        <div className="brandbar" />
        <h1 style={{ marginTop: 0 }}>{course.title}</h1>
        <p className="muted" style={{ marginTop: 0 }}>{course.description}</p>
        <div className="row wrap" style={{ gap: 12 }}>
          <span className="badge">📑 {lessons.length} documents</span>
          <span className="grow" />
          <input style={{ maxWidth: 300 }} placeholder="Search documents…" value={q} onChange={(e) => setQ(e.target.value)} aria-label="Search documents" />
        </div>
      </div>
      {!groups.length && <div className="card muted">No documents match “{q}”.</div>}
      {groups.map(({ m, items }) => (
        <div className="card" key={m.id}>
          <h2 style={{ marginTop: 0 }}>{m.title}</h2>
          {items.map((l: any) => (
            <Link key={l.id} to={'/lessons/' + l.id} className="lesson-row">
              <span className="kind">📄</span>
              <span className="grow"><b>{l.title}</b></span>
              <span className="muted small">Open →</span>
            </Link>
          ))}
        </div>
      ))}
    </div>
  );
}

function DocPage({ lesson, course, module, prev, next, side }: { lesson: any; course: any; module: any; prev: any; next: any; side: any }) {
  const groups: { title: string; items: any[] }[] = [];
  if (side?.kind === 'course') side.modules.forEach((m: any) => { const items = side.lessons.filter((x: any) => x.module_id === m.id); if (items.length) groups.push({ title: m.title, items }); });
  return (
    <div className="stack">
      <div className="small muted no-print"><Link to="/courses?cat=process">Process documents</Link> / <Link to={'/courses/' + course.id}>{course.title}</Link>{module && <> / {module.title}</>}</div>
      <div className="lesson-grid">
        <div className="stack" style={{ minWidth: 0 }}>
          <div className="card">
            <div className="row between wrap no-print" style={{ marginBottom: 8 }}>
              <span className="badge">{module ? module.title : course.title}</span>
              <button className="btn sm" onClick={() => window.print()}>🖨 Print / save as PDF</button>
            </div>
            <Markdown text={lesson.body && lesson.body.startsWith('# ') ? lesson.body : `# ${lesson.title}\n\n${lesson.body || ''}`} />
          </div>
          <div className="row wrap between no-print">
            {prev ? <Link className="btn" to={'/lessons/' + prev.id}>← {prev.title.length > 38 ? prev.title.slice(0, 38) + '…' : prev.title}</Link> : <span />}
            {next ? <Link className="btn primary" to={'/lessons/' + next.id}>{next.title.length > 38 ? next.title.slice(0, 38) + '…' : next.title} →</Link> : <Link className="btn" to={'/courses/' + course.id}>Back to all documents</Link>}
          </div>
        </div>
        <aside className="card contents no-print" aria-label="Documents">
          <h3 style={{ padding: '0 10px' }}>{course.title}</h3>
          {!side && <Spinner />}
          {groups.map((g) => (
            <div key={g.title}>
              <div className="mod">{g.title}</div>
              {g.items.map((x: any) => (
                <Link key={x.id} to={'/lessons/' + x.id} className={'lesson-row' + (x.id === lesson.id ? ' cur' : '')}>
                  <span className="grow small" style={{ fontWeight: x.id === lesson.id ? 700 : 500 }}>{x.title}</span>
                </Link>
              ))}
            </div>
          ))}
        </aside>
      </div>
    </div>
  );
}

/* ------------------------------------------------------------------ Lesson */
export function LessonView() {
  const { id } = useParams();
  const [sp] = useSearchParams();
  const pathId = sp.get('path');
  const r = useLoad(() => api.get(`/api/lessons/${id}${pathId ? '?path=' + pathId : ''}`), [id, pathId]);
  const side = useLoad(() => (pathId ? api.get('/api/paths/' + pathId).then((x) => ({ kind: 'path', ...x })) : r.data ? api.get('/api/courses/' + r.data.course.id).then((x) => ({ kind: 'course', ...x })) : Promise.resolve(null)), [pathId, r.data?.course?.id]);
  const [done, setDone] = useState(false);
  const nav = useNavigate();
  const lastSent = useRef(0);
  useEffect(() => { if (r.data) setDone(r.data.completed); window.scrollTo(0, 0); }, [r.data]);
  if (r.loading) return <Spinner />;
  if (r.error) return <ErrorBox error={r.error} retry={r.reload} />;
  const { lesson: l, course, module, prev, next, position, total, resume, path } = r.data;
  if (course.category === 'process') return <DocPage lesson={l} course={course} module={module} prev={prev} next={next} side={side.data} />;
  const q = pathId ? `?path=${pathId}` : '';

  async function toggle(go = false) {
    const nd = go ? true : !done;
    await api.post(`/api/lessons/${l.id}/complete`, { done: nd });
    setDone(nd);
    if (go && next) nav(`/lessons/${next.id}${q}`);
  }
  function progress(seconds: number, duration: number) {
    if (Date.now() - lastSent.current < 4000 && seconds < duration - 2) return;
    lastSent.current = Date.now();
    api.post(`/api/lessons/${l.id}/position`, { seconds, duration }).then((x) => x.completed && setDone(true)).catch(() => {});
  }

  // sidebar: current path or course contents
  const items: { id: string; title: string; kind: string; minutes: number; mod?: string; done: boolean }[] = [];
  if (side.data?.kind === 'path') side.data.items.forEach((i: any) => items.push({ id: i.id, title: i.title, kind: i.kind, minutes: i.minutes, mod: i.course, done: !!i.done }));
  if (side.data?.kind === 'course') {
    const dn = new Set<string>(side.data.done);
    side.data.modules.forEach((m: any) => side.data.lessons.filter((x: any) => x.module_id === m.id).forEach((x: any) => items.push({ id: x.id, title: x.title, kind: x.kind, minutes: x.minutes, mod: m.title, done: dn.has(x.id) })));
  }
  let lastMod = '';

  return (
    <div className="stack">
      <div className="small muted">{path ? <><Link to="/paths">Learning paths</Link> / <Link to={'/paths/' + path.id}>{path.title}</Link></> : <><Link to="/courses">Courses</Link> / <Link to={'/courses/' + course.id}>{course.title}</Link>{module && <> / {module.title}</>}</>}</div>
      <div className="lesson-grid">
        <div className="stack" style={{ minWidth: 0 }}>
          {l.kind === 'video' && l.video_id && (
            <Player key={l.id} videoId={l.video_id} title={l.title} start={resume} onProgress={progress} onEnded={() => { setDone(true); api.post(`/api/lessons/${l.id}/complete`, { done: true }).catch(() => {}); }}
              nextLabel="Next lesson" onNext={next ? () => nav(`/lessons/${next.id}${q}`) : undefined} />
          )}
          <div className="card">
            <div className="row wrap between"><div className="grow"><h1 style={{ fontSize: '1.35rem', marginBottom: 4 }}>{l.title}</h1>
              <div className="small muted">{course.title}{l.kind === 'video' && l.author ? ` · Presented by ${l.author}` : ''}{l.minutes ? ` · ${l.minutes} min` : ''}</div></div>
              <button className={'btn ' + (done ? 'good' : '')} onClick={() => toggle()}>{done ? '✓ Completed' : 'Mark complete'}</button></div>
            {l.kind === 'link' && l.url && <p><a className="btn primary" href={l.url} target="_blank" rel="noopener noreferrer">Open resource ↗</a></p>}
            {l.body && <div style={{ marginTop: 18 }}><Markdown text={l.kind === 'note' && !l.body.startsWith('# ') ? `# ${l.title}\n\n${l.body}` : l.body} /></div>}
          </div>
          <div className="row wrap between">
            <span className="muted small">Step {position} of {total}</span>
            <div className="row wrap">
              {prev && <Link className="btn" to={`/lessons/${prev.id}${q}`}>← Previous</Link>}
              {next ? <button className="btn primary" onClick={() => toggle(true)}>Complete & next →</button> : <Link className="btn primary" to={path ? '/paths/' + path.id : '/courses/' + course.id}>{path ? 'Back to path' : 'Back to course'}</Link>}
            </div>
          </div>
        </div>
        <aside className="card contents" aria-label="Course contents">
          <h3 style={{ padding: '0 10px' }}>{path ? path.title : 'Course contents'}</h3>
          {side.loading && <Spinner />}
          {items.map((it, i) => {
            const head = it.mod !== lastMod ? (lastMod = it.mod || '', <div className="mod" key={'m' + i}>{it.mod}</div>) : null;
            return <div key={it.id}>{head}<Link to={`/lessons/${it.id}${q}`} className={'lesson-row' + (it.id === l.id ? ' cur' : '')}><span className={'tick' + (it.done ? ' on' : '')}>{it.done ? '✓' : ''}</span><span className="grow small" style={{ fontWeight: it.id === l.id ? 700 : 500 }}>{it.title}</span><span className="muted small">{it.kind === 'video' ? '▶' : '📄'}</span></Link></div>;
          })}
        </aside>
      </div>
    </div>
  );
}

/* ------------------------------------------------------------------ Quiz */
const mmss = (s: number) => `${Math.floor(s / 60)}:${String(s % 60).padStart(2, '0')}`;

export function QuizRunner() {
  const { id } = useParams();
  const [sess, setSess] = useState<any>(null);
  const [cur, setCur] = useState(0);
  const [ans, setAns] = useState<Record<string, number>>({});
  const [left, setLeft] = useState(0);
  const [result, setResult] = useState<any>(null);
  const [err, setErr] = useState('');
  const [busy, setBusy] = useState(false);
  const [flags, setFlags] = useState<Record<string, boolean>>({});
  const submitted = useRef(false);

  async function start(n?: number) {
    setErr(''); setBusy(true);
    try {
      const r = await api.post(`/api/quizzes/${id}/start${n ? '?n=' + n : ''}`);
      setSess(r); setAns({}); setFlags({}); setCur(0); setResult(null); submitted.current = false;
      setLeft(r.quiz.minutes * 60);
    } catch (x: any) { setErr(x.message); } finally { setBusy(false); }
  }
  async function submit() {
    if (submitted.current || !sess) return;
    submitted.current = true; setBusy(true);
    try { setResult(await api.post(`/api/quizzes/${id}/submit`, { sessionId: sess.sessionId, answers: ans })); }
    catch (x: any) { setErr(x.message); submitted.current = false; } finally { setBusy(false); }
  }
  useEffect(() => {
    if (!sess || result) return;
    const t = setInterval(() => setLeft((s) => s - 1), 1000);
    return () => clearInterval(t);
  }, [sess, result]);
  useEffect(() => { if (sess && !result && left <= 0) submit(); /* auto-submit */ }, [left]); // eslint-disable-line

  if (result) return <QuizResult r={result} retake={() => start()} id={id!} />;
  if (!sess) {
    return (
      <div className="card stack" style={{ maxWidth: 640 }}>
        <div className="brandbar" /><h1>Ready to begin?</h1>
        <ul className="muted">
          <li>Practice quizzes draw random questions from the bank; mock tests serve the full paper in random order.</li>
          <li>The timer starts immediately and the quiz auto-submits at zero.</li>
          <li>Where an exam carries negative marking it is shown on the results page — unanswered questions always score zero.</li><li>Use ⚑ Mark for review to flag questions and come back to them before submitting.</li>
          <li>Correct answers and explanations are shown after you submit.</li>
        </ul>
        {err && <ErrorBox error={err} />}
        <div className="row"><button className="btn primary" disabled={busy} onClick={() => start()}>{busy ? 'Starting…' : 'Start quiz'}</button><button className="btn" onClick={() => history.back()}>Cancel</button></div>
      </div>
    );
  }
  const q = sess.questions[cur];
  const answered = Object.keys(ans).length;
  return (
    <div className="grid" style={{ gridTemplateColumns: 'minmax(0,1fr) 270px', alignItems: 'start' }}>
      <div className="card stack">
        <div className="row between wrap"><b>{sess.quiz.title}</b><span className={'badge ' + (left < 60 ? 'r' : '')} aria-live="off">⏱ {mmss(Math.max(0, left))}</span></div>
        <div className="muted small">Question {cur + 1} of {sess.questions.length}</div>
        <h2 style={{ fontWeight: 600 }}>{q.question}</h2>
        <div role="radiogroup">
          {q.options.map((o: string, i: number) => (
            <button key={i} role="radio" aria-checked={ans[q.id] === i} className={'opt' + (ans[q.id] === i ? ' sel' : '')} onClick={() => setAns({ ...ans, [q.id]: i })}>
              <b>{String.fromCharCode(65 + i)}.</b><span>{o}</span>
            </button>
          ))}
        </div>
        <div className="row">{ans[q.id] !== undefined && <button className="btn sm ghost" onClick={() => { const a = { ...ans }; delete a[q.id]; setAns(a); }}>Clear answer</button>}<button className={'btn sm ' + (flags[q.id] ? 'good' : 'ghost')} onClick={() => setFlags({ ...flags, [q.id]: !flags[q.id] })}>⚑ {flags[q.id] ? 'Marked for review' : 'Mark for review'}</button></div>
        {err && <ErrorBox error={err} />}
        <div className="row between">
          <button className="btn" disabled={cur === 0} onClick={() => setCur(cur - 1)}>← Previous</button>
          {cur < sess.questions.length - 1 ? <button className="btn primary" onClick={() => setCur(cur + 1)}>Next →</button>
            : <button className="btn good" disabled={busy} onClick={() => { if (answered === sess.questions.length || confirm(`${sess.questions.length - answered} question(s) unanswered. Submit anyway?`)) submit(); }}>Submit</button>}
        </div>
      </div>
      <div className="card">
        <b>Questions</b><div className="muted small" style={{ margin: '4px 0 12px' }}>{answered}/{sess.questions.length} answered{Object.values(flags).filter(Boolean).length ? ` · ${Object.values(flags).filter(Boolean).length} flagged` : ''}{sess.quiz.negative > 0 ? ` · −${sess.quiz.negative} per wrong answer` : ''}</div>
        <div className="qnav">{sess.questions.map((x: any, i: number) => <button key={x.id} className={(ans[x.id] !== undefined ? 'done ' : '') + (flags[x.id] ? 'flag ' : '') + (i === cur ? 'cur' : '')} onClick={() => setCur(i)}>{i + 1}</button>)}</div>
        <button className="btn good" style={{ width: '100%', marginTop: 16 }} disabled={busy} onClick={() => { if (confirm('Submit your answers now?')) submit(); }}>Submit quiz</button>
      </div>
    </div>
  );
}

function QuizResult({ r, retake, id }: { r: any; retake: () => void; id: string }) {
  const [filter, setFilter] = useState<'all' | 'wrong'>('all');
  const x = r.result;
  const items = r.review.filter((q: any) => filter === 'all' || q.given !== q.answer);
  return (
    <div className="stack" style={{ maxWidth: 860 }}>
      <div className="card" style={{ textAlign: 'center' }}>
        <div className={'badge ' + (x.passed ? 'g' : 'r')} style={{ fontSize: '.9rem' }}>{x.passed ? 'PASSED' : 'NOT PASSED'}</div>
        <div style={{ fontSize: '3.2rem', fontWeight: 800 }}>{x.pct}%</div>
        <div className="muted">Pass mark {x.pass_pct}%{x.negative > 0 ? ` · negative marking −${x.negative}` : ''} · score {x.score}/{x.total} · {x.correct} correct · {x.wrong} wrong · {x.unattempted} skipped · {Math.round(x.seconds / 60)} min</div>
        {r.certificate && <div className="alert ok">🎉 Certificate issued — <Link to={'/certificate/' + r.certificate}>view & print</Link></div>}
        <div className="row wrap" style={{ justifyContent: 'center', marginTop: 14 }}><button className="btn primary" onClick={retake}>Try again</button><button className="btn" onClick={() => history.back()}>Back</button></div>
      </div>
      <div className="row"><h2 className="grow" style={{ margin: 0 }}>Review</h2>
        <button className={'chip' + (filter === 'all' ? ' on' : '')} onClick={() => setFilter('all')}>All</button>
        <button className={'chip' + (filter === 'wrong' ? ' on' : '')} onClick={() => setFilter('wrong')}>Missed</button></div>
      {items.map((q: any) => (
        <div className="card" key={q.id}>
          <div className="small muted">{q.given === q.answer ? '✅ Correct' : q.given < 0 ? '⚪ Skipped' : '❌ Incorrect'}</div>
          <div style={{ fontWeight: 700, margin: '6px 0' }}>{q.question}</div>
          {q.options.map((o: string, k: number) => <div key={k} className={'opt ' + (k === q.answer ? 'right' : k === q.given ? 'bad' : '')} style={{ cursor: 'default' }}><b>{String.fromCharCode(65 + k)}.</b><span>{o}</span></div>)}
          {q.explanation && <div style={{ marginTop: 14 }}><Markdown text={q.explanation} /></div>}
        </div>
      ))}
      {!items.length && <div className="muted">Nothing to show — great job!</div>}
      <span hidden>{id}</span>
    </div>
  );
}

/* ------------------------------------------------------------------ Updates */
export function Updates() {
  const [tab, setTab] = useState<'live' | 'hub'>('live');
  const [cat, setCat] = useState('All');
  const feeds = useLoad(() => api.get('/api/feeds'));
  const hub = useLoad(() => api.get('/api/news'));
  const cats = ['All', ...Array.from(new Set<string>((feeds.data?.items || []).map((i: any) => i.source)))];
  const items = (feeds.data?.items || []).filter((i: any) => cat === 'All' || i.source === cat);
  return (
    <div className="stack">
      <h1>Market updates</h1>
      <div className="tabs"><button className={tab === 'live' ? 'on' : ''} onClick={() => setTab('live')}>📡 Live headlines</button><button className={tab === 'hub' ? 'on' : ''} onClick={() => setTab('hub')}>📣 Company bulletins</button></div>
      {tab === 'live' && (<>
        <div className="row wrap">{cats.map((c) => <button key={c} className={'chip' + (cat === c ? ' on' : '')} onClick={() => setCat(c)}>{c}</button>)}</div>
        <div className="muted small">Key sources: SEBI, RBI, Economic Times (Mutual Funds & Markets) and Business Standard. Refreshed about every 20 minutes — verify against the primary source before advising a client.</div>
        {feeds.loading ? <Spinner /> : feeds.error ? <ErrorBox error={feeds.error} retry={feeds.reload} /> : !items.length ? <div className="muted">No headlines available right now.</div> : (
          <div className="card">{items.map((i: any, k: number) => (
            <div className="news-item" key={k}>
              <span className="badge">{i.source}</span> <span className="muted small">{ago(i.published)}</span>
              <div style={{ fontWeight: 700, marginTop: 6 }}><a href={i.link} target="_blank" rel="noopener noreferrer">{i.title}</a></div>
            </div>))}</div>
        )}
      </>)}
      {tab === 'hub' && (hub.loading ? <Spinner /> : hub.error ? <ErrorBox error={hub.error} /> : (
        <div className="card">{!hub.data.news.length && <div className="muted">No bulletins yet.</div>}
          {hub.data.news.map((n: any) => (
            <div className="news-item" key={n.id}>
              <span className="badge m">{n.category}</span> {n.pinned ? <span className="badge w">Pinned</span> : null} <span className="muted small">{fmtDate(n.published_at)}</span>
              <div style={{ fontWeight: 700, marginTop: 6 }}>{n.url ? <a href={n.url} target="_blank" rel="noopener noreferrer">{n.title}</a> : n.title}</div>
              {n.body && <div className="muted">{n.body}</div>}
            </div>))}
        </div>
      ))}
    </div>
  );
}

/* ------------------------------------------------------------------ Account */
export function Account() {
  const { user } = useAuth();
  const certs = useLoad(() => api.get('/api/certificates'));
  const att = useLoad(() => api.get('/api/attempts'));
  return (
    <div className="stack">
      <h1>Profile & certificates</h1>
      <div className="grid g2" style={{ alignItems: 'start' }}>
        <div className="card"><div className="brandbar" /><h2>{user?.name}</h2><div className="muted">{user?.email}</div>
          {user?.empId && <div className="small">Employee ID: {user.empId}</div>}{user?.department && <div className="small">Department: {user.department}</div>}{user?.team && <div className="small">Team: <b>{user.team}</b></div>}
          <div className="alert ok" style={{ marginTop: 16 }}>🔒 Your progress, quiz scores and certificates are private to your account.</div></div>
        <div className="card"><h2>Change password</h2><PasswordForm /></div>
      </div>
      <div className="card"><h2>Certificates</h2>
        {!certs.data?.certificates.length ? <div className="muted">Pass a final exam to earn a certificate.</div> :
          certs.data.certificates.map((c: any) => <div key={c.id} className="lesson-row"><span className="kind">🏅</span><span className="grow"><b>{c.title}</b><div className="small muted">{c.id} · {c.pct}% · {fmtDate(c.issued_at)}</div></span><Link className="btn sm" to={'/certificate/' + c.id}>View</Link></div>)}
      </div>
      <div className="card"><h2>Quiz history</h2>
        {!att.data?.attempts.length ? <div className="muted">No attempts yet.</div> : (
          <div className="tscroll"><table className="t"><thead><tr><th>Quiz</th><th>Course</th><th>Score</th><th>Result</th><th>Date</th></tr></thead><tbody>
            {att.data.attempts.map((a: any) => <tr key={a.id}><td>{a.title}</td><td>{a.code}</td><td>{a.pct}%</td><td><span className={'badge ' + (a.passed ? 'g' : 'r')}>{a.passed ? 'Pass' : 'Fail'}</span></td><td>{fmtDate(a.created_at)}</td></tr>)}
          </tbody></table></div>)}
      </div>
    </div>
  );
}

export function CertificateView() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/certificates'));
  if (r.loading) return <Spinner />;
  const c = r.data?.certificates.find((x: any) => x.id === id);
  if (!c) return <ErrorBox error="Certificate not found." />;
  return (
    <div className="stack">
      <div className="no-print row"><button className="btn primary" onClick={() => window.print()}>🖨 Print / save as PDF</button><Link className="btn" to="/account">Back</Link></div>
      <div className="cert">
        <img src="/logo.png" alt="FundsIndia" style={{ height: 56 }} />
        <div style={{ letterSpacing: '.3em', color: '#1d6ff2', marginTop: 24 }}>CERTIFICATE OF COMPLETION</div>
        <div style={{ margin: '28px 0 8px' }}>This is to certify that</div>
        <div style={{ fontSize: '2.4rem', fontWeight: 700 }}>{r.data.holder}</div>
        <div style={{ margin: '16px 0 4px' }}>has successfully completed</div>
        <div style={{ fontSize: '1.5rem', fontWeight: 700 }}>{c.title}</div>
        <div style={{ margin: '6px 0 28px' }}>with a score of <b>{c.pct}%</b> on {fmtDate(c.issued_at)}</div>
        <div className="small">Certificate ID: <b>{c.id}</b><br />Verify at {location.origin}/verify/{c.id}</div>
        <div className="small" style={{ marginTop: 18, color: '#65748b' }}>Internal training certificate issued by the FundsIndia Learning Hub. It is not an NISM/SEBI certification.</div>
      </div>
    </div>
  );
}

export function Verify() {
  const { id } = useParams();
  const r = useLoad(() => api.get('/api/verify/' + id), [id]);
  return (
    <div className="auth" style={{ gridTemplateColumns: '1fr' }}><div className="form"><div className="box stack">
      <img src="/logo.png" alt="FundsIndia" style={{ height: 40 }} /><h1>Certificate verification</h1>
      {r.loading ? <Spinner /> : r.data?.valid ? (
        <div className="alert ok"><b>✓ Valid certificate</b><br />{r.data.name}<br />{r.data.course}<br />Score {r.data.pct}% · Issued {fmtDate(r.data.issued)}</div>
      ) : <div className="alert err">No valid certificate found for “{id}”.</div>}
    </div></div></div>
  );
}

