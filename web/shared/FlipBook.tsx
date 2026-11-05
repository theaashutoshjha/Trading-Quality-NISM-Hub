import { useEffect, useRef, useState } from 'react';
import { PageFlip } from 'page-flip';
import * as pdfjs from 'pdfjs-dist';
import workerUrl from 'pdfjs-dist/build/pdf.worker.min.mjs?url';

pdfjs.GlobalWorkerOptions.workerSrc = workerUrl;

/**
 * Real page-turning book for a PDF workbook (drag a corner or use the arrows / keyboard).
 * Pages are drawn to canvas lazily, only near the page being read, so 300+ page workbooks open fast.
 */
export function FlipBook({ src, height = 640 }: { src: string; height?: number }) {
  const stage = useRef<HTMLDivElement>(null);
  const book = useRef<HTMLDivElement>(null);
  const flip = useRef<PageFlip | null>(null);
  const pdf = useRef<pdfjs.PDFDocumentProxy | null>(null);
  const done = useRef<Set<number>>(new Set());
  const holders = useRef<HTMLDivElement[]>([]);
  const [state, setState] = useState<'loading' | 'ready' | 'error'>('loading');
  const [err, setErr] = useState('');
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const [jump, setJump] = useState('');

  const draw = async (i: number) => {
    const doc = pdf.current, el = holders.current[i];
    if (!doc || !el || i < 0 || i >= doc.numPages || done.current.has(i)) return;
    done.current.add(i);
    const pg = await doc.getPage(i + 1);
    const base = pg.getViewport({ scale: 1 });
    const vp = pg.getViewport({ scale: (Math.max(el.clientWidth, 420) * Math.min(devicePixelRatio || 1, 2)) / base.width });
    const cv = document.createElement('canvas');
    cv.width = vp.width; cv.height = vp.height;
    cv.style.cssText = 'width:100%;height:100%;display:block';
    await pg.render({ canvasContext: cv.getContext('2d')!, viewport: vp }).promise;
    el.innerHTML = ''; el.appendChild(cv);
  };
  const around = (i: number) => { for (let k = i - 1; k <= i + 4; k++) draw(k); };

  useEffect(() => {
    let dead = false;
    setState('loading'); done.current = new Set();
    (async () => {
      try {
        const doc = await pdfjs.getDocument(src).promise;
        if (dead) return;
        pdf.current = doc;
        const vp = (await doc.getPage(1)).getViewport({ scale: 1 });
        const ratio = vp.height / vp.width;
        const host = book.current!, st = stage.current!;
        host.innerHTML = ''; holders.current = [];
        for (let i = 0; i < doc.numPages; i++) {
          const el = document.createElement('div');
          el.className = 'page';
          el.style.cssText = 'background:#fff;overflow:hidden';
          if (i === 0 || i === doc.numPages - 1) el.setAttribute('data-density', 'hard');
          el.innerHTML = `<div style="height:100%;display:flex;align-items:center;justify-content:center;color:#94a3b8;font:12px sans-serif">Page ${i + 1}</div>`;
          host.appendChild(el); holders.current.push(el);
        }
        const aw = st.clientWidth, ah = height - 8;
        const single = aw < 700;
        const w = Math.round(single ? Math.min(aw - 8, ah / ratio) : Math.min(aw / 2, ah / ratio));
        const f = new PageFlip(host, { width: w, height: Math.round(w * ratio), size: 'fixed', showCover: true, maxShadowOpacity: 0.5, flippingTime: 800, usePortrait: single, mobileScrollSupport: false, swipeDistance: 20 });
        f.loadFromHTML(holders.current as unknown as HTMLElement[]);
        f.on('flip', (e: any) => { setPage(e.data); around(e.data); });
        flip.current = f;
        setTotal(doc.numPages); setState('ready'); around(0);
      } catch (e: any) { if (!dead) { setErr(e?.message || 'Could not open this workbook.'); setState('error'); } }
    })();
    return () => { dead = true; try { flip.current?.destroy(); } catch { /* ignore */ } flip.current = null; pdf.current?.destroy(); pdf.current = null; };
  }, [src, height]);

  useEffect(() => {
    const k = (e: KeyboardEvent) => { if ((e.target as HTMLElement)?.tagName === 'INPUT') return; if (e.key === 'ArrowRight') flip.current?.flipNext(); if (e.key === 'ArrowLeft') flip.current?.flipPrev(); };
    window.addEventListener('keydown', k);
    return () => window.removeEventListener('keydown', k);
  }, []);

  const go = (n: number) => { const i = Math.max(0, Math.min(total - 1, n)); flip.current?.turnToPage(i); setPage(i); around(i); };
  const wide = typeof window !== 'undefined' && window.innerWidth >= 700;
  // Cover and back cover are single pages: centre them like a closed book
  const shift = state === 'ready' && wide && total > 1 ? (page === 0 ? 'translateX(-25%)' : page >= total - 1 && total % 2 === 0 ? 'translateX(25%)' : undefined) : undefined;
  const label = page === 0 ? `Cover / ${total}` : `${page + 1}${page % 2 === 1 && page + 2 <= total ? '–' + (page + 2) : ''} / ${total}`;

  return (
    <div className="stack" style={{ gap: 12 }}>
      <div ref={stage} style={{ height, position: 'relative', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden', borderRadius: 'var(--r-s)', background: 'linear-gradient(180deg,#dfe5ef,#c9d2e2)' }}>
        <div ref={book} style={{ transform: shift, transition: 'transform .6s ease', boxShadow: '0 20px 50px #0004' }} />
        {state === 'loading' && <div className="center muted" style={{ position: 'absolute', inset: 0 }}><div className="spin" /> Opening workbook…</div>}
        {state === 'error' && <div className="alert err" style={{ position: 'absolute', left: 20, right: 20, top: 20 }}>{err}</div>}
        {state === 'ready' && <>
          <button className="btn sm" style={{ position: 'absolute', left: 10, top: '50%' }} onClick={() => flip.current?.flipPrev()} aria-label="Previous page">‹</button>
          <button className="btn sm" style={{ position: 'absolute', right: 10, top: '50%' }} onClick={() => flip.current?.flipNext()} aria-label="Next page">›</button>
        </>}
      </div>
      {state === 'ready' && (
        <div className="row" style={{ gap: 10 }}>
          <button className="btn sm" onClick={() => go(0)} aria-label="First page">«</button>
          <button className="btn sm" onClick={() => flip.current?.flipPrev()}>‹</button>
          <input type="range" min={0} max={Math.max(0, total - 1)} value={page} onChange={(e) => go(+e.target.value)} aria-label="Page" style={{ flex: 1 }} />
          <button className="btn sm" onClick={() => flip.current?.flipNext()}>›</button>
          <button className="btn sm" onClick={() => go(total - 1)} aria-label="Last page">»</button>
          <span className="small muted" style={{ minWidth: 96, textAlign: 'center' }}>{label}</span>
          <form onSubmit={(e) => { e.preventDefault(); const n = parseInt(jump, 10); if (!isNaN(n)) go(n - 1); setJump(''); }}>
            <input value={jump} onChange={(e) => setJump(e.target.value.replace(/\D/g, ''))} placeholder="Go to page" style={{ width: 110 }} aria-label="Go to page" />
          </form>
        </div>
      )}
    </div>
  );
}
