import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { marked } from 'marked';
import DOMPurify from 'dompurify';
import { COLOR_PRESETS, ThemeMode, applyTheme, getSavedTheme } from './theme';

marked.setOptions({ gfm: true, breaks: false });

DOMPurify.addHook('afterSanitizeAttributes', (node) => {
  if (node.tagName === 'A') {
    node.setAttribute('target', '_blank');
    node.setAttribute('rel', 'noopener noreferrer');
  }
});

export function Icon({ name, size = 18 }: { name: string; size?: number }) {
  const paths: Record<string, string> = {
    home: 'M3 10.5L12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1v-9.5z',
    compass: 'M12 22a10 10 0 1 0 0-20 10 10 0 0 0 0 20zm3.5-13.5-2 5.5-5.5 2 2-5.5 5.5-2z',
    book: 'M4 19.5A2.5 2.5 0 0 1 6.5 17H20M4 19.5V5a2 2 0 0 1 2-2h14v18H6.5a2.5 2.5 0 0 1-2.5-1.5z',
    news: 'M4 5h16v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V5zm4 4h8m-8 4h8m-8 4h5',
    sprout: 'M12 21V10m0 0C12 6 15 4 19 4c0 4-2 7-7 6zm0 0C12 7 9 5 5 5c0 4 2 6 7 5z',
    award: 'M12 15a6 6 0 1 0 0-12 6 6 0 0 0 0 12zm-3 0-1 7 4-2 4 2-1-7',
    briefcase: 'M3 7h18v12a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7zm6-3h6v3H9V4z',
    wrench: 'M14.7 6.3a4 4 0 0 0-5.4 5.4L3 18l3 3 6.3-6.3a4 4 0 0 0 5.4-5.4l-2.3 2.3-2-2 2.3-2.3z',
    file: 'M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8l-6-6zm0 0v6h6m-10 5h8m-8 4h6',
    help: 'M12 22a10 10 0 1 0 0-20 10 10 0 0 0 0 20zm-2-11a2 2 0 1 1 3 1.7c-.7.4-1 .9-1 1.8v.5m0 3h.01',
    settings: 'M12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.4-2a7.5 7.5 0 0 0 0-2l2-1.5-2-3.5-2.3.8a7.4 7.4 0 0 0-1.7-1L15 3h-6l-.4 2.8a7.4 7.4 0 0 0-1.7 1L4.6 6l-2 3.5 2 1.5a7.5 7.5 0 0 0 0 2l-2 1.5 2 3.5 2.3-.8a7.4 7.4 0 0 0 1.7 1L9 21h6l.4-2.8a7.4 7.4 0 0 0 1.7-1l2.3.8 2-3.5-2-1.5z',
    chart: 'M3 3v18h18M9 17V9m4 8V5m4 12v-4',
    megaphone: 'M3 11v2a1 1 0 0 0 1 1h2l5 4V6L6 10H4a1 1 0 0 0-1 1zm13-3a5 5 0 0 1 0 8',
    bell: 'M18 8a6 6 0 1 0-12 0c0 7-3 9-3 9h18s-3-2-3-9zm-4.3 13a2 2 0 0 1-3.4 0',
    message: 'M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10z',
    users: 'M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2m8-10a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm14 10v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75',
    layers: 'M12 2 2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5',
    shield: 'M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z',
    clock: 'M12 22a10 10 0 1 0 0-20 10 10 0 0 0 0 20zm0-14v4l3 2',
    grid: 'M3 3h7v7H3V3zm11 0h7v7h-7V3zM3 14h7v7H3v-7zm11 0h7v7h-7v-7z',
    trend: 'M23 6l-9.5 9.5-5-5L1 18m22-12h-6m6 0v6',
  };
  const d = paths[name] || paths.book;
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.9" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d={d} />
    </svg>
  );
}

export function Markdown({ text }: { text: string }) {
  const html = useMemo(() => DOMPurify.sanitize(marked.parse(text || '', { async: false }) as string), [text]);
  return <div className="prose" dangerouslySetInnerHTML={{ __html: html }} />;
}

export function Progress({ value, label }: { value: number; label?: string }) {
  const v = Math.max(0, Math.min(100, Math.round(value)));
  return (
    <div className="progress" role="progressbar" aria-valuenow={v} aria-valuemin={0} aria-valuemax={100} aria-label={label}>
      <div style={{ width: `${v}%` }} />
    </div>
  );
}

export function Spinner({ text = 'Loading…' }: { text?: string }) {
  return (
    <div className="center muted" style={{ padding: 40 }}>
      <div className="spin" /> {text}
    </div>
  );
}

export function ErrorBox({ error, retry }: { error: string; retry?: () => void }) {
  return (
    <div className="alert err" role="alert">
      {error} {retry && <button className="btn sm" onClick={retry}>Retry</button>}
    </div>
  );
}

/** Loads data with loading/error state. */
export function useLoad<T>(fn: () => Promise<T>, deps: unknown[] = []) {
  const [data, setData] = useState<T | null>(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);
  const [tick, setTick] = useState(0);
  useEffect(() => {
    let live = true;
    setLoading(true);
    setError('');
    fn()
      .then((d) => live && setData(d))
      .catch((e) => live && setError(e.message || 'Failed to load'))
      .finally(() => live && setLoading(false));
    return () => {
      live = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [...deps, tick]);
  return { data, error, loading, reload: () => setTick((t) => t + 1), setData };
}

export const fmtDate = (s?: string | null) => {
  if (!s) return '—';
  const d = new Date(s.includes('T') ? s : s.replace(' ', 'T') + 'Z');
  return isNaN(+d) ? s : d.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
};
export const fmtDateTime = (s?: string | null) => {
  if (!s) return '—';
  const d = new Date(s.includes('T') ? s : s.replace(' ', 'T') + 'Z');
  return isNaN(+d) ? s : d.toLocaleString('en-IN', { day: '2-digit', month: 'short', hour: '2-digit', minute: '2-digit' });
};
export const ago = (s: string) => {
  const d = (Date.now() - +new Date(s.includes('T') ? s : s.replace(' ', 'T') + 'Z')) / 1000;
  if (d < 3600) return `${Math.max(1, Math.round(d / 60))}m ago`;
  if (d < 86400) return `${Math.round(d / 3600)}h ago`;
  return `${Math.round(d / 86400)}d ago`;
};
export const CATEGORIES: Record<string, string> = {
  academy: 'FundsIndia Academy',
  nism: 'NISM Certifications',
  sales: 'Sales & Service',
  tools: 'Tools (Zoho, Tata Tele)',
  process: 'Process documents',
  foundation: 'Foundations & Compliance',
  general: 'General',
};

export function ThemeSettings() {
  const initial = useMemo(() => getSavedTheme(), []);
  const [mode, setMode] = useState<ThemeMode>(initial.mode);
  const [color, setColor] = useState<string>(initial.color);

  const update = (m: ThemeMode, c: string) => {
    setMode(m);
    setColor(c);
    applyTheme(m, c);
  };

  return (
    <div className="stack" style={{ gap: 14 }}>
      <div>
        <label className="f" style={{ marginTop: 0 }}>Appearance mode</label>
        <div className="row wrap">
          {(['system', 'light', 'dark'] as ThemeMode[]).map((m) => (
            <button key={m} type="button" className={'chip' + (mode === m ? ' on' : '')} onClick={() => update(m, color)}>
              {m === 'system' ? '💻 System' : m === 'light' ? '☀️ Light' : '🌙 Dark'}
            </button>
          ))}
        </div>
      </div>
      <div>
        <label className="f">UI Accent Color (saved as your default)</label>
        <div className="row wrap" style={{ gap: 10 }}>
          {COLOR_PRESETS.map((p) => (
            <button
              key={p.color}
              type="button"
              title={p.name}
              aria-label={p.name}
              onClick={() => update(mode, p.color)}
              style={{
                width: 32, height: 32, borderRadius: '50%', border: color.toLowerCase() === p.color.toLowerCase() ? '3px solid var(--tx)' : '2px solid transparent',
                background: p.color, cursor: 'pointer', boxShadow: 'var(--raise-s)',
              }}
            />
          ))}
          <label className="row small muted" style={{ cursor: 'pointer', gap: 6 }}>
            <input type="color" value={color} onChange={(e) => update(mode, e.target.value)} aria-label="Custom UI color" style={{ width: 38, height: 32, padding: 2, borderRadius: 8, cursor: 'pointer' }} />
            Custom
          </label>
        </div>
      </div>
    </div>
  );
}

export function CommandPalette({ items }: { items: { label: string; to: string; group?: string }[] }) {
  const [open, setOpen] = useState(false);
  const [q, setQ] = useState('');
  const nav = useNavigate();

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') {
        e.preventDefault();
        setOpen((v) => !v);
        setQ('');
      } else if (e.key === 'Escape') {
        setOpen(false);
      }
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, []);

  if (!open) return <button className="btn sm" onClick={() => { setOpen(true); setQ(''); }} title="Quick jump (Ctrl+K)">⌘K</button>;

  const filtered = items.filter((x) => !q.trim() || (x.label + (x.group || '')).toLowerCase().includes(q.trim().toLowerCase()));
  return (
    <>
      <button className="btn sm" onClick={() => setOpen(false)}>⌘K</button>
      <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && setOpen(false)}>
        <div className="modal stack" style={{ maxWidth: 520, gap: 12 }}>
          <div className="row between"><h3 style={{ margin: 0 }}>Quick jump</h3><button className="btn sm ghost" onClick={() => setOpen(false)}>Esc</button></div>
          <input autoFocus placeholder="Type a page or section…" value={q} onChange={(e) => setQ(e.target.value)} />
          <div style={{ maxHeight: 320, overflow: 'auto' }}>
            {filtered.map((it) => (
              <div key={it.to + it.label} className="lesson-row" style={{ cursor: 'pointer' }} onClick={() => { setOpen(false); nav(it.to); }}>
                {it.group && <span className="badge m">{it.group}</span>}
                <b className="grow">{it.label}</b>
              </div>
            ))}
            {!filtered.length && <div className="muted small" style={{ padding: 10 }}>No matching pages.</div>}
          </div>
        </div>
      </div>
    </>
  );
}

export function UserGuide({ portal, loginCount }: { portal: 'learner' | 'head' | 'admin'; loginCount?: number }) {
  const [open, setOpen] = useState(false);
  useEffect(() => {
    if (!loginCount || loginCount > 3) return;
    const key = `fi_guide_seen_${portal}_${loginCount}`;
    try {
      if (!sessionStorage.getItem(key)) setOpen(true);
    } catch { setOpen(true); }
  }, [portal, loginCount]);

  function close() {
    try { sessionStorage.setItem(`fi_guide_seen_${portal}_${loginCount}`, '1'); } catch { /* ignore */ }
    setOpen(false);
  }

  if (!open) return null;

  const steps: Record<'learner' | 'head' | 'admin', { title: string; items: [string, string][] }> = {
    learner: {
      title: 'Welcome to FundsIndia Learning Hub',
      items: [
        ['📚 Course Library & Learning Paths', 'Open your assigned courses, watch videos (auto-completes at 90%), and follow step-by-step paths.'],
        ['📝 Quizzes & Revision', 'Take practice quizzes and NISM mocks. Use "Revise missed Qs" on Home to practice questions you missed.'],
        ['🔖 Bookmarks & Notes', 'Save private study notes inside any lesson and find them later in Settings.'],
        ['🎨 Theme & Quick Jump', 'Personalize Dark/Light mode and UI colors in Settings, or press Ctrl+K anytime to jump quickly.'],
      ],
    },
    head: {
      title: 'Welcome to the Team Head Portal',
      items: [
        ['📚 Content Library', 'Browse all published courses, videos, and assessments available in the hub.'],
        ['🧩 Teams & Course Access', 'Create new teams and choose exactly which courses each team can access.'],
        ['👥 People & Compliance Matrix', 'Add team members (single or CSV), assign them to teams, and export CSV compliance reports.'],
        ['⏰ Deadlines & Analytics', 'Assign mandatory course deadlines (notifies learners automatically) and track team quiz scores.'],
      ],
    },
    admin: {
      title: 'Welcome to the Admin Portal',
      items: [
        ['📚 Content & Courses', 'Create courses, import YouTube videos/playlists, edit Markdown notes, and preview drafts before publishing.'],
        ['👥 Users, Heads & Teams', 'Create Learner, Team Head, Trainer, and Admin accounts, manage team access, and revoke/re-issue certificates.'],
        ['🎓 NISM Certificates (Drive)', 'Connect Google Drive to analyse NISM PDFs, match against your employee directory, and email qaudits@fundsindia.com in one click.'],
        ['🔐 Security & Audit', 'Enable 2-step verification, view filtered audit logs, clear login lockouts, and customize UI theme colors.'],
      ],
    },
  };

  const g = steps[portal];
  return (
    <div className="modal-bg" onMouseDown={(e) => e.target === e.currentTarget && close()}>
      <div className="modal stack" style={{ maxWidth: 600 }}>
        <div className="row between">
          <div>
            <span className="badge">Quick Start Guide · Login {loginCount} of 3</span>
            <h2 style={{ margin: '8px 0 0' }}>{g.title}</h2>
          </div>
          <button className="btn sm ghost" onClick={close} aria-label="Close">✕</button>
        </div>
        <p className="muted small" style={{ margin: 0 }}>This guide is shown only for your first 3 logins to help you get started.</p>
        <div className="stack" style={{ gap: 10 }}>
          {g.items.map(([h, d]) => (
            <div key={h} className="inset">
              <b>{h}</b>
              <div className="small muted" style={{ marginTop: 2 }}>{d}</div>
            </div>
          ))}
        </div>
        <div className="row between">
          <span className="small muted">Tip: Press <b>Ctrl + K</b> anytime for Quick Jump</span>
          <button className="btn primary" onClick={close}>Got it, let&apos;s start →</button>
        </div>
      </div>
    </div>
  );
}
