import { useEffect, useMemo, useRef, useState } from 'react';
import { marked } from 'marked';
import DOMPurify from 'dompurify';

marked.setOptions({ gfm: true, breaks: false });

DOMPurify.addHook('afterSanitizeAttributes', (node) => {
  if (node.tagName === 'A') {
    node.setAttribute('target', '_blank');
    node.setAttribute('rel', 'noopener noreferrer');
  }
});

export function Markdown({ text }: { text: string }) {
  const html = useMemo(() => DOMPurify.sanitize(marked.parse(text || '', { async: false }) as string), [text]);
  const ref = useRef<HTMLDivElement>(null);
  // Code blocks (e.g. customer reply templates) get a one-click Copy button.
  useEffect(() => {
    const root = ref.current;
    if (!root) return;
    root.querySelectorAll('pre').forEach((pre) => {
      if (pre.parentElement?.classList.contains('copywrap')) return;
      const wrap = document.createElement('div');
      wrap.className = 'copywrap';
      pre.parentNode!.insertBefore(wrap, pre);
      wrap.appendChild(pre);
      const b = document.createElement('button');
      b.type = 'button'; b.className = 'btn sm copybtn'; b.textContent = '📋 Copy';
      b.onclick = async () => {
        let done = false;
        try { await navigator.clipboard.writeText(pre.innerText); done = true; } catch { /* fall back below */ }
        if (!done) {
          // Older browsers / blocked clipboard API: select the text and use the legacy copy command.
          const range = document.createRange(); range.selectNodeContents(pre);
          const sel = window.getSelection(); sel?.removeAllRanges(); sel?.addRange(range);
          try { done = document.execCommand('copy'); } catch { done = false; }
        }
        b.textContent = done ? '✓ Copied' : 'Press Ctrl+C to copy';
        setTimeout(() => { b.textContent = '📋 Copy'; }, 1800);
      };
      wrap.appendChild(b);
    });
  }, [html]);
  return <div className="prose" ref={ref} dangerouslySetInnerHTML={{ __html: html }} />;
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
