import { useCallback, useEffect, useRef, useState } from 'react';

// The portal's own player chrome: custom controls, resume, speed, fullscreen and an end card.
// The underlying media stream is delivered by an embedded player that is kept non-interactive
// (all clicks go to our overlay), so learners only ever see the Learning Hub interface.

declare global { interface Window { YT?: any; onYouTubeIframeAPIReady?: () => void } }

let apiPromise: Promise<any> | null = null;
function loadApi(): Promise<any> {
  if (window.YT?.Player) return Promise.resolve(window.YT);
  if (!apiPromise) {
    apiPromise = new Promise((resolve, reject) => {
      const prev = window.onYouTubeIframeAPIReady;
      window.onYouTubeIframeAPIReady = () => { prev?.(); resolve(window.YT); };
      const s = document.createElement('script');
      s.src = 'https://www.youtube.com/iframe_api';
      s.onerror = () => { apiPromise = null; reject(new Error('player blocked')); };
      document.head.appendChild(s);
    });
  }
  return apiPromise;
}

const fmt = (s: number) => {
  s = Math.max(0, Math.floor(s));
  const h = Math.floor(s / 3600), m = Math.floor((s % 3600) / 60), x = s % 60;
  return (h ? h + ':' + String(m).padStart(2, '0') : m) + ':' + String(x).padStart(2, '0');
};

interface Props {
  videoId: string;
  title: string;
  start?: number;
  /** called every ~10s while playing and on pause/end */
  onProgress?: (seconds: number, duration: number) => void;
  onEnded?: () => void;
  nextLabel?: string;
  onNext?: () => void;
}

export function Player({ videoId, title, start = 0, onProgress, onEnded, nextLabel, onNext }: Props) {
  const host = useRef<HTMLDivElement>(null);
  const wrap = useRef<HTMLDivElement>(null);
  const yt = useRef<any>(null);
  const [ready, setReady] = useState(false);
  const [playing, setPlaying] = useState(false);
  const [ended, setEnded] = useState(false);
  const [error, setError] = useState(false);
  const [cur, setCur] = useState(0);
  const [dur, setDur] = useState(0);
  const [rate, setRate] = useState(1);
  const [muted, setMuted] = useState(false);
  const [seeking, setSeeking] = useState(false);
  const [started, setStarted] = useState(false);
  const [poster, setPoster] = useState('maxresdefault');
  const last = useRef(0);
  const cb = useRef({ onProgress, onEnded });
  cb.current = { onProgress, onEnded };

  const report = useCallback(() => {
    const p = yt.current;
    if (!p?.getCurrentTime) return;
    const d = p.getDuration?.() || 0;
    if (d > 0) cb.current.onProgress?.(Math.floor(p.getCurrentTime()), Math.floor(d));
  }, []);

  useEffect(() => {
    let dead = false;
    setReady(false); setEnded(false); setError(false); setPlaying(false); setStarted(false); setPoster('maxresdefault'); setCur(start || 0); setDur(0);
    loadApi().then((YT) => {
      if (dead || !host.current) return;
      const el = document.createElement('div');
      host.current.innerHTML = '';
      host.current.appendChild(el);
      yt.current = new YT.Player(el, {
        host: 'https://www.youtube-nocookie.com',
        videoId,
        playerVars: { controls: 0, disablekb: 1, fs: 0, rel: 0, modestbranding: 1, iv_load_policy: 3, playsinline: 1, cc_load_policy: 0, start: Math.floor(start), origin: location.origin },
        events: {
          onReady: (e: any) => { if (dead) return; setReady(true); setDur(e.target.getDuration() || 0); },
          onStateChange: (e: any) => {
            if (dead) return;
            const S = YT.PlayerState;
            setPlaying(e.data === S.PLAYING || e.data === S.BUFFERING);
            if (e.data === S.ENDED) { setEnded(true); report(); cb.current.onEnded?.(); }
            if (e.data === S.PAUSED) report();
            if (e.data === S.PLAYING) { setEnded(false); setStarted(true); setDur(e.target.getDuration() || 0); }
          },
          onError: () => !dead && setError(true),
        },
      });
    }).catch(() => !dead && setError(true));
    return () => {
      dead = true;
      try { report(); yt.current?.destroy?.(); } catch { /* ignore */ }
      yt.current = null;
    };
  }, [videoId]); // eslint-disable-line react-hooks/exhaustive-deps

  // poll position while playing
  useEffect(() => {
    if (!ready) return;
    const t = setInterval(() => {
      const p = yt.current;
      if (!p?.getCurrentTime || seeking) return;
      const c = p.getCurrentTime();
      setCur(c);
      if (!dur) setDur(p.getDuration?.() || 0);
      if (playing && Date.now() - last.current > 10000) { last.current = Date.now(); report(); }
    }, 500);
    return () => clearInterval(t);
  }, [ready, playing, seeking, dur, report]);

  const toggle = () => { const p = yt.current; if (!p || !ready) return; if (ended) { p.seekTo(0); } playing ? p.pauseVideo() : p.playVideo(); };
  const seek = (v: number) => { yt.current?.seekTo(v, true); setCur(v); setEnded(false); };
  const skip = (d: number) => seek(Math.max(0, Math.min(dur, (yt.current?.getCurrentTime?.() || 0) + d)));
  const setSpeed = (r: number) => { yt.current?.setPlaybackRate(r); setRate(r); };
  const mute = () => { const p = yt.current; if (!p) return; if (p.isMuted()) { p.unMute(); setMuted(false); } else { p.mute(); setMuted(true); } };
  const full = () => {
    const w = wrap.current; if (!w) return;
    if (document.fullscreenElement) document.exitFullscreen(); else w.requestFullscreen?.();
  };

  return (
    <div className="player" ref={wrap} tabIndex={0} aria-label={`Video: ${title}`}
      onKeyDown={(e) => { if (e.key === ' ' || e.key === 'k') { e.preventDefault(); toggle(); } if (e.key === 'ArrowRight') skip(10); if (e.key === 'ArrowLeft') skip(-10); if (e.key === 'f') full(); }}>
      <div className="frame">
        <div ref={host} aria-hidden />
        {!started && !ended && !error && <img className="poster" alt="" src={`https://i.ytimg.com/vi/${videoId}/${poster}.jpg`} onError={() => setPoster('mqdefault')} />}
        <div className="wm">FundsIndia Learning Hub</div>
        <div className="shield" onClick={toggle} onContextMenu={(e) => e.preventDefault()} />
        {ready && !playing && !ended && !error && <button className="bigplay" aria-hidden tabIndex={-1}>▶</button>}
        {!ready && !error && <div className="center" style={{ position: 'absolute', inset: 0, color: '#fff', zIndex: 3 }}><div className="spin" /> Loading video…</div>}
        {error && <div className="endcard"><div style={{ fontSize: 34 }}>⚠️</div><b>This video is currently unavailable.</b><span style={{ opacity: .75 }}>It may have been removed. Please tell your administrator.</span></div>}
        {ended && !error && (
          <div className="endcard">
            <div style={{ fontSize: 34 }}>✅</div><b style={{ fontSize: '1.15rem' }}>Lesson complete</b>
            <div className="row wrap" style={{ justifyContent: 'center' }}>
              <button className="btn" onClick={() => { seek(0); yt.current?.playVideo(); }}>↺ Replay</button>
              {onNext && <button className="btn primary" onClick={onNext}>{nextLabel || 'Next lesson'} →</button>}
            </div>
          </div>
        )}
      </div>
      <div className="ctl">
        <button onClick={toggle} aria-label={playing ? 'Pause' : 'Play'}>{playing ? '⏸' : '▶'}</button>
        <button onClick={() => skip(-10)} aria-label="Back 10 seconds" title="Back 10s">⟲10</button>
        <button onClick={() => skip(10)} aria-label="Forward 10 seconds" title="Forward 10s">10⟳</button>
        <span className="t">{fmt(cur)}</span>
        <input type="range" min={0} max={Math.max(1, dur)} step={1} value={Math.min(cur, dur || 0)} aria-label="Seek"
          onMouseDown={() => setSeeking(true)} onTouchStart={() => setSeeking(true)}
          onChange={(e) => setCur(+e.target.value)}
          onMouseUp={(e) => { setSeeking(false); seek(+(e.target as HTMLInputElement).value); }} onTouchEnd={(e) => { setSeeking(false); seek(+(e.target as HTMLInputElement).value); }}
          onKeyUp={(e) => seek(+(e.target as HTMLInputElement).value)} />
        <span className="t">{fmt(dur)}</span>
        <select value={rate} onChange={(e) => setSpeed(+e.target.value)} aria-label="Speed">{[0.75, 1, 1.25, 1.5, 1.75, 2].map((r) => <option key={r} value={r}>{r}×</option>)}</select>
        <button onClick={mute} aria-label={muted ? 'Unmute' : 'Mute'}>{muted ? '🔇' : '🔊'}</button>
        <button onClick={full} aria-label="Fullscreen">⛶</button>
      </div>
    </div>
  );
}

export const thumb = (videoId: string) => `https://i.ytimg.com/vi/${videoId}/mqdefault.jpg`;
