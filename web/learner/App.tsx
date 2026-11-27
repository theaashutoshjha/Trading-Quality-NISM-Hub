import { createContext, useCallback, useContext, useEffect, useRef, useState, ReactNode } from 'react';
import { Link, NavLink, Navigate, Route, Routes, useLocation, useNavigate } from 'react-router-dom';
import { api } from '../shared/api';
import { CommandPalette, Icon, Spinner, UserGuide } from '../shared/components';
import { Account, ChangePasswordGate, CertificateView, ChangelogPage, CourseView, Courses, Dashboard, FaqPage, LessonView, Login, PathView, Paths, QuizRunner, RevisionQuiz, Updates, Verify } from './pages';

export interface Me { id: string; email: string; name: string; role: string; empId?: string; department?: string; team?: string | null; mustChange: boolean; loginCount?: number; cats?: string[] }
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

function NotificationBell() {
  const [open, setOpen] = useState(false);
  const [popupDismissed, setPopupDismissed] = useState(false);
  const [items, setItems] = useState<any[]>([]);
  useEffect(() => {
    api.get('/api/notifications').then((r) => setItems(r.notifications || [])).catch(() => {});
  }, []);
  const unreadList = items.filter((n) => !n.is_read);
  const unread = unreadList.length;
  async function markRead() {
    await api.post('/api/notifications/read').catch(() => {});
    setItems((prev) => prev.map((x) => ({ ...x, is_read: 1 })));
  }
  async function dismissPopup() {
    setPopupDismissed(true);
    await markRead();
  }
  return (
    <div style={{ position: 'relative' }}>
      <button className="btn sm" onClick={() => { setOpen((v) => !v); if (!open && unread) markRead(); }} aria-label="Notifications" style={{ gap: 6 }}>
        <Icon name="bell" size={16} />
        {unread > 0 && <span className="badge r">{unread}</span>}
      </button>
      {open && (
        <div className="card stack" style={{ position: 'absolute', right: 0, top: 44, width: 340, maxHeight: 400, overflow: 'auto', zIndex: 45, padding: 14, gap: 8 }}>
          <div className="row between"><b>Notifications</b><button className="btn sm ghost" onClick={() => setOpen(false)}>✕</button></div>
          {!items.length ? <div className="muted small">No notifications yet.</div> : items.map((n) => (
            <div key={n.id} className="news-item" style={{ padding: '8px 0' }}>
              <div style={{ fontWeight: 700, fontSize: '.9rem' }}>{n.title}</div>
              {n.body && <div className="muted small">{n.body}</div>}
            </div>
          ))}
        </div>
      )}
      {unread > 0 && !popupDismissed && (
        <div className="modal-bg" role="dialog" aria-modal="true" style={{ zIndex: 90 }}>
          <div className="card stack" style={{ maxWidth: 480, width: '92%', padding: 22, gap: 14, boxShadow: '0 24px 60px rgba(0,0,0,.28)' }}>
            <div className="row between">
              <div className="row" style={{ gap: 10 }}>
                <span className="kind" style={{ width: 38, height: 38, background: 'rgba(29,111,242,.12)', color: 'var(--brand, #1d6ff2)' }}>
                  <Icon name="bell" size={20} />
                </span>
                <div>
                  <h2 style={{ margin: 0, fontSize: '1.15rem' }}>New notification from Admin</h2>
                  <div className="muted small">{unread} unread message{unread > 1 ? 's' : ''}</div>
                </div>
              </div>
              <button className="btn sm ghost" onClick={dismissPopup} aria-label="Close">✕</button>
            </div>
            <div className="stack" style={{ gap: 10, maxHeight: 280, overflowY: 'auto' }}>
              {unreadList.map((n) => (
                <div key={n.id} style={{ padding: '12px 14px', borderRadius: 10, background: 'var(--bg-soft, rgba(29,111,242,.06))', border: '1px solid var(--line, rgba(0,0,0,.08))' }}>
                  <div style={{ fontWeight: 700, fontSize: '.96rem' }}>{n.title}</div>
                  {n.body && <div className="small muted" style={{ marginTop: 4, whiteSpace: 'pre-wrap' }}>{n.body}</div>}
                </div>
              ))}
            </div>
            <div className="row" style={{ justifyContent: 'flex-end' }}>
              <button className="btn primary" onClick={dismissPopup}>Got it</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function SystemBanner() {
  const [b, setB] = useState<any>(null);
  const [hidden, setHidden] = useState(false);
  useEffect(() => {
    api.get('/api/banner').then((r) => setB(r.banner || null)).catch(() => {});
  }, []);
  if (!b || hidden) return null;
  return (
    <div className={`sys-banner ${b.level || 'info'}`} role="status">
      <span>{b.message}</span>
      <button className="btn sm ghost" onClick={() => setHidden(true)} aria-label="Dismiss banner">✕</button>
    </div>
  );
}

function Layout({ children }: { children: ReactNode }) {
  const { user } = useAuth();
  const [open, setOpen] = useState(false);
  const [collapsed, setCollapsed] = useState(false);
  const loc = useLocation();
  useEffect(() => setOpen(false), [loc.pathname, loc.search]);
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.ctrlKey || e.metaKey) && ['p', 's', 'u'].includes(e.key.toLowerCase())) e.preventDefault();
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'c') {
        const tag = (e.target as HTMLElement)?.tagName;
        if (tag !== 'INPUT' && tag !== 'TEXTAREA') e.preventDefault();
      }
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, []);
  const toggleMenu = () => {
    if (window.innerWidth <= 900) setOpen((v) => !v);
    else setCollapsed((v) => !v);
  };
  const item = (to: string, icon: ReactNode, label: string, end = false) => {
    const [path, qs] = to.split('?');
    // Category shortcuts share a path; highlight by query string so only one entry is active.
    const active = qs ? loc.pathname === path && loc.search === '?' + qs
      : path === '/courses' ? loc.pathname.startsWith('/courses') && !loc.search
      : end ? loc.pathname === path : loc.pathname.startsWith(path);
    return <NavLink to={to} className={'nav' + (active ? ' active' : '')}><span className="ico" aria-hidden>{icon}</span>{label}</NavLink>;
  };
  return (
    <div className={'shell' + (collapsed ? ' collapsed' : '')}>
      <div className={'side-backdrop' + (open ? ' open' : '')} onClick={() => setOpen(false)} />
      <aside className={'side' + (open ? ' open' : '')}>
        <div className="panel">
          <div className="brand"><img src="/logo.png" alt="FundsIndia" /><div><b>FundsIndia</b><small>Learning Hub</small></div></div>
          {item('/', <Icon name="home" />, 'Home', true)}
          {item('/paths', <Icon name="compass" />, 'Learning paths')}
          {item('/courses', <Icon name="book" />, 'Course library')}
          {item('/updates', <Icon name="news" />, 'Market updates')}
          <div className="sec">Browse</div>
          {(!user?.cats || user.cats.includes('academy')) && item('/courses?cat=academy', <Icon name="sprout" />, 'FundsIndia Academy')}
          {(!user?.cats || user.cats.includes('nism')) && item('/courses?cat=nism', <Icon name="award" />, 'NISM certifications')}
          {(!user?.cats || user.cats.includes('sales')) && item('/courses?cat=sales', <Icon name={user?.team === 'Customer Support' ? 'wrench' : 'briefcase'} />, user?.team === 'Customer Support' ? 'Support workflows' : 'Sales & service')}
          {(!user?.cats || user.cats.includes('tools')) && item('/courses?cat=tools', <Icon name="wrench" />, 'Zoho & Tata Tele')}
          {(!user?.cats || user.cats.includes('process')) && item('/courses?cat=process', <Icon name="file" />, 'Process documents')}
          <div className="sec">My space</div>
          {item('/faq', <Icon name="help" />, 'Product FAQs')}
          {item('/changelog', <Icon name="trend" />, 'What changed')}
          {item('/account', <Icon name="settings" />, 'Settings & Contact')}
        </div>
      </aside>
      <div className="main">
        <SystemBanner />
        <header className="top">
          <button className="btn sm menu-btn" onClick={toggleMenu} aria-label="Toggle sidebar" title="Hide / show sidebar">☰</button>
          <Search />
          <span className="grow" />
          <CommandPalette items={[
            { label: 'Home / Dashboard', to: '/', group: 'Nav' },
            { label: 'Learning paths', to: '/paths', group: 'Nav' },
            { label: 'Course library', to: '/courses', group: 'Nav' },
            { label: 'Market updates', to: '/updates', group: 'Nav' },
            { label: 'Missed questions revision', to: '/revision', group: 'Study' },
            { label: 'Investment Products FAQ', to: '/faq', group: 'Reference' },
            { label: 'What changed (Regulatory log)', to: '/changelog', group: 'Reference' },
            { label: 'Settings, Contact & Certificates', to: '/account', group: 'Space' },
          ]} />
          <NotificationBell />
          <Link to="/account" className="badge" style={{ textDecoration: 'none', gap: 6 }}><Icon name="settings" size={14} /> Settings</Link>
        </header>
        <main
          className="page protected-content"
          onContextMenu={(e) => e.preventDefault()}
          onCopy={(e) => { const t = (e.target as HTMLElement)?.tagName; if (t !== 'INPUT' && t !== 'TEXTAREA') e.preventDefault(); }}
          onCut={(e) => { const t = (e.target as HTMLElement)?.tagName; if (t !== 'INPUT' && t !== 'TEXTAREA') e.preventDefault(); }}
          onDragStart={(e) => e.preventDefault()}
        >
          <UserGuide portal="learner" loginCount={user?.loginCount} />
          {children}
        </main>
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
          <Route path="/revision" element={<RevisionQuiz />} />
          <Route path="/updates" element={<Updates />} />
          <Route path="/faq" element={<FaqPage />} />
          <Route path="/changelog" element={<ChangelogPage />} />
          <Route path="/contact" element={<Navigate to="/account" replace />} />
          <Route path="/account" element={<Account />} />
          <Route path="/settings" element={<Account />} />
          <Route path="/certificate/:id" element={<CertificateView />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Layout>
    </Ctx.Provider>
  );
}
