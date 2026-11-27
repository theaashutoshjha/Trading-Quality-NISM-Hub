import { createContext, ReactNode, useContext, useEffect, useState } from 'react';
import { NavLink, Navigate, Route, Routes } from 'react-router-dom';
import { api } from '../shared/api';
import { CommandPalette, Icon, Spinner, UserGuide } from '../shared/components';
import { AnalyticsPage, AssignmentsPage, ContentBrowser, CourseViewer, LessonViewer, MatrixPage, SettingsPage, TeamsPage, UsersPage } from './pages';

export interface HeadUser { id: string; email: string; name: string; role: 'head' | 'admin'; empId?: string; team?: string | null; loginCount?: number }
const Ctx = createContext<{ me: HeadUser; logout: () => void }>(null as any);
export const useHead = () => useContext(Ctx);

export function App() {
  const [me, setMe] = useState<HeadUser | null>(null);
  const [ready, setReady] = useState(false);
  const [open, setOpen] = useState(false);
  const [collapsed, setCollapsed] = useState(false);
  const [banner, setBanner] = useState<any>(null);

  useEffect(() => {
    api.get('/api/head/me').then((r) => setMe(r.user)).catch(() => {}).finally(() => setReady(true));
    api.get('/api/banner').then((r) => setBanner(r.banner || null)).catch(() => {});
    const f = () => location.reload();
    window.addEventListener('session-expired', f);
    return () => window.removeEventListener('session-expired', f);
  }, []);

  const logout = async () => { await api.post('/api/head/logout').catch(() => {}); location.reload(); };
  if (!ready) return <Spinner />;
  if (!me) { location.reload(); return <Spinner />; }

  const toggleMenu = () => {
    if (window.innerWidth <= 900) setOpen((v) => !v);
    else setCollapsed((v) => !v);
  };
  const item = (to: string, icon: ReactNode, label: string) => (
    <NavLink to={to} end={to === '/'} onClick={() => setOpen(false)} className={({ isActive }) => 'nav' + (isActive ? ' active' : '')}>
      <span className="ico" aria-hidden>{icon}</span>{label}
    </NavLink>
  );

  return (
    <Ctx.Provider value={{ me, logout }}>
      <div className={'shell' + (collapsed ? ' collapsed' : '')}>
        <div className={'side-backdrop' + (open ? ' open' : '')} onClick={() => setOpen(false)} />
        <aside className={'side' + (open ? ' open' : '')}>
          <div className="panel">
            <div className="brand"><img src="/logo.png" alt="FundsIndia" /><div><b>FundsIndia</b><small>Head Portal</small></div></div>
            <div className="sec">Content</div>
            {item('/', <Icon name="book" />, 'Content library')}
            <div className="sec">Team management</div>
            {item('/teams', <Icon name="layers" />, 'Teams & access')}
            {item('/users', <Icon name="users" />, 'People & members')}
            {item('/matrix', <Icon name="chart" />, 'Compliance matrix')}
            {item('/assignments', <Icon name="clock" />, 'Assign deadlines')}
            {item('/analytics', <Icon name="trend" />, 'Team analytics')}
            <div className="sec">Account</div>
            {item('/settings', <Icon name="settings" />, 'Settings')}
          </div>
        </aside>
        <div className="main">
          {banner && <div className={`sys-banner ${banner.level || 'info'}`} role="status"><span>{banner.message}</span><button className="btn sm ghost" onClick={() => setBanner(null)}>✕</button></div>}
          <header className="top">
            <button className="btn sm menu-btn" onClick={toggleMenu} aria-label="Toggle sidebar" title="Hide / show sidebar">☰</button>
            <b>FundsIndia Learning Hub — Team Head</b>
            <span className="grow" />
            <CommandPalette items={[
              { label: 'Content library', to: '/', group: 'Content' },
              { label: 'Teams & access', to: '/teams', group: 'Team' },
              { label: 'People & members', to: '/users', group: 'Team' },
              { label: 'Compliance matrix', to: '/matrix', group: 'Reports' },
              { label: 'Assign deadlines', to: '/assignments', group: 'Team' },
              { label: 'Team analytics', to: '/analytics', group: 'Reports' },
              { label: 'Settings', to: '/settings', group: 'Account' },
            ]} />
            <NavLink to="/settings" className="badge" style={{ textDecoration: 'none', gap: 6 }}><Icon name="settings" size={14} /> Settings</NavLink>
          </header>
          <main className="page">
            <UserGuide portal="head" loginCount={me.loginCount} />
            <Routes>
              <Route path="/" element={<ContentBrowser />} />
              <Route path="/courses/:id" element={<CourseViewer />} />
              <Route path="/lessons/:id" element={<LessonViewer />} />
              <Route path="/teams" element={<TeamsPage />} />
              <Route path="/users" element={<UsersPage />} />
              <Route path="/matrix" element={<MatrixPage />} />
              <Route path="/assignments" element={<AssignmentsPage />} />
              <Route path="/analytics" element={<AnalyticsPage />} />
              <Route path="/settings" element={<SettingsPage />} />
              <Route path="*" element={<Navigate to="/" />} />
            </Routes>
          </main>
        </div>
      </div>
    </Ctx.Provider>
  );
}
