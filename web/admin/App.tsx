import { createContext, useContext, useEffect, useState } from 'react';
import { NavLink, Navigate, Route, Routes } from 'react-router-dom';
import { api } from '../shared/api';
import { Spinner } from '../shared/components';
import { AuditPage, CourseEditor, CoursesPage, LessonEditor, NewsPage, Overview, PathEditor, PathsPage, QuizEditor, SecurityPage, TeamAccessPage, UsersPage } from './pages';

export interface Staff { id: string; email: string; name: string; role: 'admin' | 'trainer'; totp: boolean }
const Ctx = createContext<{ me: Staff; logout: () => void }>(null as any);
export const useStaff = () => useContext(Ctx);

export function App() {
  const [me, setMe] = useState<Staff | null>(null);
  const [ready, setReady] = useState(false);
  const [open, setOpen] = useState(false);
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
  const item = (to: string, icon: string, label: string) => (
    <NavLink to={to} end={to === '/'} onClick={() => setOpen(false)} className={({ isActive }) => 'nav' + (isActive ? ' active' : '')}><span className="ico" aria-hidden>{icon}</span>{label}</NavLink>
  );
  return (
    <Ctx.Provider value={{ me, logout }}>
      <div className="shell">
        <aside className={'side' + (open ? ' open' : '')}>
          <div className="panel">
            <div className="brand"><img src="/logo.png" alt="FundsIndia" /><div><small>Admin Portal</small></div></div>
            {item('/', '📊', 'Overview')}
            <div className="sec">Content</div>
            {item('/courses', '📚', 'Courses & videos')}
            {item('/paths', '🧭', 'Learning paths')}
            {item('/news', '📣', 'Bulletins & news')}
            {isAdmin && (<><div className="sec">People</div>{item('/users', '👥', 'Users & access')}{item('/teams', '🧩', 'Team access')}</>)}
            <div className="sec">System</div>
            {item('/security', '🔐', 'My security')}
            {isAdmin && item('/audit', '🧾', 'Audit log')}
          </div>
          <div className="foot">
            <b>{me.name}</b>
            <div className="small muted">{me.email} · {me.role}</div>
            <button className="btn sm" style={{ marginTop: 10, width: '100%' }} onClick={logout}>Sign out</button>
          </div>
        </aside>
        <div className="main">
          <header className="top"><button className="btn sm menu-btn" onClick={() => setOpen(!open)} aria-label="Menu">☰</button><b>FundsIndia Learning Hub — Administration</b><span className="grow" />
            {!me.totp && <NavLink to="/security" className="badge w">⚠ Enable 2-step verification</NavLink>}</header>
          <main className="page">
            <Routes>
              <Route path="/" element={<Overview />} />
              <Route path="/courses" element={<CoursesPage />} />
              <Route path="/courses/:id" element={<CourseEditor />} />
              <Route path="/lesson/:id" element={<LessonEditor />} />
              <Route path="/quiz/:id" element={<QuizEditor />} />
              <Route path="/paths" element={<PathsPage />} />
              <Route path="/paths/:id" element={<PathEditor />} />
              <Route path="/news" element={<NewsPage />} />
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
