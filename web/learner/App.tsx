import { createContext, useCallback, useContext, useEffect, useRef, useState, ReactNode } from 'react';
import { Link, NavLink, Navigate, Route, Routes, useLocation, useNavigate } from 'react-router-dom';
import { api } from '../shared/api';
import { Spinner } from '../shared/components';
import { Account, ChangePasswordGate, CertificateView, CourseView, Courses, Dashboard, LessonView, Login, PathView, Paths, QuizRunner, Updates, Verify } from './pages';

export interface Me { id: string; email: string; name: string; role: string; empId?: string; department?: string; team?: string | null; mustChange: boolean; cats?: string[] }
interface AuthCtx { user: Me | null; setUser: (u: Me | null) => void; logout: () => Promise<void> }
const Ctx = createContext<AuthCtx>({ user: null, setUser: () => {}, logout: async () => {} });
export const useAuth = () => useContext(Ctx);

function Search() {
  const [q, setQ] = useState('');
  const [res, setRes] = useState<any>(null);
  const t = useRef<number>(0);
  const nav = useNavigate();
  useEffect(() => {
    window.clearTimeout(t.current);
    if (q.trim().length < 2) { setRes(null); return; }
    t.current = window.setTimeout(() => api.get('/api/search?q=' + encodeURIComponent(q.trim())).then(setRes).catch(() => {}), 250);
  }, [q]);
  const go = (to: string) => { setQ(''); setRes(null); nav(to); };
  return (
    <div style={{ position: 'relative', flex: 1, maxWidth: 520 }}>
      <input value={q} onChange={(e) => setQ(e.target.value)} placeholder="🔍  Search courses, videos and notes…" aria-label="Search" />
      {res && (
        <div className="card" style={{ position: 'absolute', top: 54, left: 0, right: 0, padding: 10, maxHeight: 400, overflow: 'auto', zIndex: 30 }}>
          {!res.courses.length && !res.lessons.length && <div className="muted small" style={{ padding: 10 }}>No results.</div>}
          {res.courses.map((c: any) => (<div key={c.id} className="lesson-row" style={{ cursor: 'pointer' }} onClick={() => go('/courses/' + c.id)}><span className="badge">Course</span><b>{c.title}</b></div>))}
          {res.lessons.map((l: any) => (<div key={l.id} className="lesson-row" style={{ cursor: 'pointer' }} onClick={() => go('/lessons/' + l.id)}><span className="badge m">{l.kind === 'video' ? 'Video' : 'Notes'}</span><span className="grow">{l.title}<div className="muted small">{l.course}</div></span></div>))}
        </div>
      )}
    </div>
  );
}

function Layout({ children }: { children: ReactNode }) {
  const { user, logout } = useAuth();
  const [open, setOpen] = useState(false);
  const loc = useLocation();
  useEffect(() => setOpen(false), [loc.pathname, loc.search]);
  const item = (to: string, icon: string, label: string, end = false) => {
    const [path, qs] = to.split('?');
    // Category shortcuts share a path; highlight by query string so only one entry is active.
    const active = qs ? loc.pathname === path && loc.search === '?' + qs
      : path === '/courses' ? loc.pathname.startsWith('/courses') && !loc.search
      : end ? loc.pathname === path : loc.pathname.startsWith(path);
    return <NavLink to={to} className={'nav' + (active ? ' active' : '')}><span className="ico" aria-hidden>{icon}</span>{label}</NavLink>;
  };
  return (
    <div className="shell">
      <aside className={'side' + (open ? ' open' : '')}>
        <div className="panel">
          <div className="brand"><img src="/logo.png" alt="FundsIndia" /><div><small>Learning Hub</small></div></div>
          {item('/', '🏠', 'Home', true)}
          {item('/paths', '🧭', 'Learning paths')}
          {item('/courses', '📚', 'Course library')}
          {item('/updates', '📰', 'Market updates')}
          <div className="sec">Browse</div>
          {(!user?.cats || user.cats.includes('academy')) && item('/courses?cat=academy', '🌱', 'FundsIndia Academy')}
          {(!user?.cats || user.cats.includes('nism')) && item('/courses?cat=nism', '🎓', 'NISM certifications')}
          {(!user?.cats || user.cats.includes('sales')) && item('/courses?cat=sales', '💼', 'Sales & service')}
          {(!user?.cats || user.cats.includes('tools')) && item('/courses?cat=tools', '🛠️', 'Zoho & Tata Tele')}
          <div className="sec">My space</div>
          {item('/account', '👤', 'Profile & certificates')}
        </div>
        <div className="foot">
          <b>{user?.name}</b>
          {user?.team && <div className="small"><span className="badge">{user.team}</span></div>}
          <div className="small muted" style={{ wordBreak: 'break-all' }}>{user?.email}</div>
          <button className="btn sm" style={{ marginTop: 10, width: '100%' }} onClick={logout}>Sign out</button>
        </div>
      </aside>
      <div className="main">
        <header className="top">
          <button className="btn sm menu-btn" onClick={() => setOpen(!open)} aria-label="Menu">☰</button>
          <Search />
          <span className="grow" />
          <Link to="/account" className="badge" style={{ textDecoration: 'none' }}>👤 {user?.name.split(' ')[0]}</Link>
        </header>
        <main className="page">{children}</main>
      </div>
    </div>
  );
}

export function App() {
  const [user, setUser] = useState<Me | null>(null);
  const [ready, setReady] = useState(false);
  const loc = useLocation();

  useEffect(() => {
    api.get('/api/auth/me').then((r) => setUser(r.user ? { ...r.user, cats: r.cats } : null)).catch(() => setUser(null)).finally(() => setReady(true));
    const onExpired = () => setUser(null);
    window.addEventListener('session-expired', onExpired);
    return () => window.removeEventListener('session-expired', onExpired);
  }, []);

  const logout = useCallback(async () => {
    await api.post('/api/auth/logout').catch(() => {});
    setUser(null);
  }, []);

  if (loc.pathname.startsWith('/verify/')) return <Routes><Route path="/verify/:id" element={<Verify />} /></Routes>;
  if (!ready) return <Spinner />;
  if (!user) return <Ctx.Provider value={{ user, setUser, logout }}><Login /></Ctx.Provider>;
  if (user.mustChange) return <Ctx.Provider value={{ user, setUser, logout }}><ChangePasswordGate /></Ctx.Provider>;

  return (
    <Ctx.Provider value={{ user, setUser, logout }}>
      <Layout>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/paths" element={<Paths />} />
          <Route path="/paths/:id" element={<PathView />} />
          <Route path="/courses" element={<Courses />} />
          <Route path="/courses/:id" element={<CourseView />} />
          <Route path="/lessons/:id" element={<LessonView />} />
          <Route path="/quiz/:id" element={<QuizRunner />} />
          <Route path="/updates" element={<Updates />} />
          <Route path="/account" element={<Account />} />
          <Route path="/certificate/:id" element={<CertificateView />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Layout>
    </Ctx.Provider>
  );
}
