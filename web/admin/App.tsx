import { createContext, ReactNode, useContext, useEffect, useState } from 'react';
import { NavLink, Navigate, Route, Routes } from 'react-router-dom';
import { api } from '../shared/api';
import { CommandPalette, Icon, Spinner, UserGuide } from '../shared/components';
import { AuditPage, ChangelogPage, CourseEditor, CoursesPage, FaqsPage, FeedbackPage, LessonEditor, NewsPage, NotificationsPage, Overview, PathEditor, PathsPage, QuizEditor, SecurityPage, TeamAccessPage, UsersPage } from './pages';
import { NismCertsPage } from './nismCertsPage';

export interface Staff { id: string; email: string; name: string; role: 'admin' | 'trainer'; totp: boolean; loginCount?: number }
const Ctx = createContext<{ me: Staff; logout: () => void }>(null as any);
export const useStaff = () => useContext(Ctx);

export function App() {
  const [me, setMe] = useState<Staff | null>(null);
  const [ready, setReady] = useState(false);
  const [open, setOpen] = useState(false);
  const [collapsed, setCollapsed] = useState(false);
  useEffect(() => {
    api.get('/api/admin/me').then((r) => setMe(r.user)).catch(() => {}).finally(() => setReady(true));
    const f = () => location.reload(); // session expired -> server shows the login page
    window.addEventListener('session-expired', f);
    return () => window.removeEventListener('session-expired', f);
  }, []);
  const logout = async () => { await api.post('/api/admin/logout').catch(() => {}); location.reload(); };
  if (!ready) return <Spinner />;
  if (!me) { location.reload(); return <Spinner />; }
  const isAdmin = me.role === 'admin';
  const toggleMenu = () => {
    if (window.innerWidth <= 900) setOpen((v) => !v);
    else setCollapsed((v) => !v);
  };
  const item = (to: string, icon: ReactNode, label: string) => (
    <NavLink to={to} end={to === '/'} onClick={() => setOpen(false)} className={({ isActive }) => 'nav' + (isActive ? ' active' : '')}><span className="ico" aria-hidden>{icon}</span>{label}</NavLink>
  );
  return (
    <Ctx.Provider value={{ me, logout }}>
      <div className={'shell' + (collapsed ? ' collapsed' : '')}>
        <div className={'side-backdrop' + (open ? ' open' : '')} onClick={() => setOpen(false)} />
        <aside className={'side' + (open ? ' open' : '')}>
          <div className="panel">
            <div className="brand"><img src="/logo.png" alt="FundsIndia" /><div><b>FundsIndia</b><small>Admin Portal</small></div></div>
            {item('/', <Icon name="chart" />, 'Overview')}
            <div className="sec">Content</div>
            {item('/courses', <Icon name="book" />, 'Courses & videos')}
            {item('/paths', <Icon name="compass" />, 'Learning paths')}
            {item('/news', <Icon name="megaphone" />, 'Bulletins & news')}
            {item('/changelog', <Icon name="trend" />, 'Regulatory changelog')}
            {item('/notifications', <Icon name="bell" />, 'Push notifications')}
            {item('/faqs', <Icon name="help" />, 'Product FAQs')}
            {item('/nism-certs', <Icon name="award" />, 'NISM Certificates')}
            {item('/feedback', <Icon name="message" />, 'Feedback & contact')}
            {isAdmin && (<><div className="sec">People</div>{item('/users', <Icon name="users" />, 'Users & access')}{item('/teams', <Icon name="layers" />, 'Team access')}</>)}
            <div className="sec">System</div>
            {item('/security', <Icon name="settings" />, 'Settings & security')}
            {isAdmin && item('/audit', <Icon name="shield" />, 'Audit log')}
          </div>
        </aside>
        <div className="main">
          <header className="top"><button className="btn sm menu-btn" onClick={toggleMenu} aria-label="Toggle sidebar" title="Hide / show sidebar">☰</button><b>FundsIndia Learning Hub — Administration</b><span className="grow" />
            <CommandPalette items={[
              { label: 'Overview', to: '/', group: 'Main' },
              { label: 'Courses & videos', to: '/courses', group: 'Content' },
              { label: 'Learning paths', to: '/paths', group: 'Content' },
              { label: 'Bulletins & news', to: '/news', group: 'Content' },
              { label: 'Regulatory changelog', to: '/changelog', group: 'Content' },
              { label: 'Push notifications', to: '/notifications', group: 'Content' },
              { label: 'Product FAQs', to: '/faqs', group: 'Content' },
              { label: 'NISM Certificates (Drive)', to: '/nism-certs', group: 'Compliance' },
              { label: 'Feedback & contact', to: '/feedback', group: 'Support' },
              { label: 'Users & access', to: '/users', group: 'People' },
              { label: 'Team access', to: '/teams', group: 'People' },
              { label: 'Settings & security', to: '/security', group: 'System' },
              { label: 'Audit log', to: '/audit', group: 'System' },
            ]} />
            {!me.totp && <NavLink to="/security" className="badge w">⚠ Enable 2-step verification</NavLink>}
            <NavLink to="/security" className="badge" style={{ textDecoration: 'none', gap: 6 }}><Icon name="settings" size={14} /> Settings</NavLink></header>
          <main className="page">
            <UserGuide portal="admin" loginCount={me.loginCount} />
            <Routes>
              <Route path="/" element={<Overview />} />
              <Route path="/courses" element={<CoursesPage />} />
              <Route path="/courses/:id" element={<CourseEditor />} />
              <Route path="/lesson/:id" element={<LessonEditor />} />
              <Route path="/quiz/:id" element={<QuizEditor />} />
              <Route path="/paths" element={<PathsPage />} />
              <Route path="/paths/:id" element={<PathEditor />} />
              <Route path="/news" element={<NewsPage />} />
              <Route path="/changelog" element={<ChangelogPage />} />
              <Route path="/notifications" element={<NotificationsPage />} />
              <Route path="/faqs" element={<FaqsPage />} />
              <Route path="/nism-certs" element={<NismCertsPage />} />
              <Route path="/feedback" element={<FeedbackPage />} />
              <Route path="/users" element={isAdmin ? <UsersPage /> : <Navigate to="/" />} />
              <Route path="/teams" element={isAdmin ? <TeamAccessPage /> : <Navigate to="/" />} />
              <Route path="/security" element={<SecurityPage />} />
              <Route path="/audit" element={isAdmin ? <AuditPage /> : <Navigate to="/" />} />
              <Route path="*" element={<Navigate to="/" />} />
            </Routes>
          </main>
        </div>
      </div>
    </Ctx.Provider>
  );
}
