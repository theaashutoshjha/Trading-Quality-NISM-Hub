import { Env, randomNonce, sessionUser } from './lib';
import { adminLoginPage } from './adminLogin';
import { headLoginPage } from './headLogin';
import { authRoutes } from './auth';
import { learnerRoutes } from './learner';
import { headRoutes } from './head';
import { adminRoutes } from './admin';
import { makeRouter } from './router';

const api = makeRouter([...authRoutes, ...learnerRoutes, ...headRoutes, ...adminRoutes]);

const baseHeaders = (nonce?: string): Record<string, string> => ({
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
  'Content-Security-Policy': [
    "default-src 'self'",
    `script-src 'self' 'wasm-unsafe-eval' https://www.youtube.com https://accounts.google.com https://cdn.jsdelivr.net${nonce ? ` 'nonce-${nonce}'` : ''}`,
    "worker-src 'self' blob:",
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
    "font-src 'self' https://fonts.gstatic.com",
    "img-src 'self' data: blob: https://i.ytimg.com",
    'frame-src https://www.youtube-nocookie.com https://www.youtube.com https://accounts.google.com',
    "connect-src 'self' blob: data: https://www.googleapis.com https://oauth2.googleapis.com https://gmail.googleapis.com https://accounts.google.com https://cdn.jsdelivr.net https://tessdata.projectnaptha.com",
    "object-src 'none'",
    "base-uri 'self'",
    "frame-ancestors 'none'",
    "form-action 'self'",
  ].join('; '),
});

function withHeaders(res: Response, extra: Record<string, string>) {
  const r = new Response(res.body, res);
  for (const [k, v] of Object.entries(extra)) r.headers.set(k, v);
  return r;
}

export default {
  async fetch(req: Request, env: Env, ex: ExecutionContext): Promise<Response> {
    const url = new URL(req.url);
    if (
      env.COOKIE_SECURE !== '0' &&
      url.protocol === 'http:' &&
      ['fundsindia.lmslearning.online', 'www.fundsindia.lmslearning.online'].includes(url.hostname)
    ) {
      url.protocol = 'https:';
      return Response.redirect(url.toString(), 308);
    }
    const path = url.pathname.replace(/\/+$/, '') || '/';
    const adminPath = (env.ADMIN_PATH || '/staff-console').replace(/\/+$/, '');

    // ---- JSON API ----
    if (path.startsWith('/api/')) return withHeaders(await api(req, env, ex, url), baseHeaders());

    // ---- Hidden Admin Portal ----
    if (path === adminPath || path.startsWith(adminPath + '/')) {
      const admin = await sessionUser(env, req, 'admin');
      if (!admin) {
        const nonce = randomNonce();
        return new Response(adminLoginPage(nonce, adminPath), {
          status: 200,
          headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store', 'X-Robots-Tag': 'noindex, nofollow', ...baseHeaders(nonce) },
        });
      }
      const page = await env.ASSETS.fetch(new Request(new URL('/admin-app/', url), { headers: req.headers }));
      return withHeaders(page, { 'Cache-Control': 'no-store', 'X-Robots-Tag': 'noindex, nofollow', ...baseHeaders() });
    }

    // Admin bundle: served only to signed-in staff. Everyone else gets a plain 404.
    if (path.startsWith('/admin-app')) {
      const admin = await sessionUser(env, req, 'admin');
      if (!admin) return new Response('Not found', { status: 404 });
      return withHeaders(await env.ASSETS.fetch(req), { 'Cache-Control': 'private, no-store', ...baseHeaders() });
    }

    // ---- Head Portal (/head) ----
    if (path === '/head' || path.startsWith('/head/')) {
      const head = await sessionUser(env, req, 'head');
      if (!head) {
        const nonce = randomNonce();
        return new Response(headLoginPage(nonce), {
          status: 200,
          headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store', 'X-Robots-Tag': 'noindex, nofollow', ...baseHeaders(nonce) },
        });
      }
      const page = await env.ASSETS.fetch(new Request(new URL('/head-app/', url), { headers: req.headers }));
      return withHeaders(page, { 'Cache-Control': 'no-store', 'X-Robots-Tag': 'noindex, nofollow', ...baseHeaders() });
    }

    // Head bundle: served only to signed-in heads/admins. Everyone else gets 404.
    if (path.startsWith('/head-app')) {
      const head = await sessionUser(env, req, 'head');
      if (!head) return new Response('Not found', { status: 404 });
      return withHeaders(await env.ASSETS.fetch(req), { 'Cache-Control': 'private, no-store', ...baseHeaders() });
    }

    // ---- Learner SPA + static files ----
    const res = await env.ASSETS.fetch(req);
    const isHtml = (res.headers.get('Content-Type') || '').includes('text/html');
    return withHeaders(res, { ...baseHeaders(), 'Cache-Control': isHtml ? 'no-cache' : res.headers.get('Cache-Control') || 'public, max-age=3600' });
  },
  async scheduled(_controller: ScheduledController, env: Env): Promise<void> {
    const now = new Date().toISOString();
    const stmts: D1PreparedStatement[] = [
      env.DB.prepare(`DELETE FROM sessions WHERE expires_at < ?`).bind(now),
      env.DB.prepare(`INSERT INTO audit_log (actor, action, detail, ip) VALUES ('system-cron', 'weekly_compliance_check', 'Expired sessions pruned; scheduled NISM compliance check executed', 'cron')`),
    ];
    try {
      const row = await env.DB.prepare(`SELECT value FROM system_settings WHERE key='nism_schedule'`).first<{ value: string }>();
      if (row?.value) {
        const cfg = JSON.parse(row.value);
        if (cfg.enabled) {
          if (cfg.webhookUrl && /^https:\/\//.test(cfg.webhookUrl)) {
            await fetch(cfg.webhookUrl, {
              method: 'POST',
              headers: { 'content-type': 'application/json' },
              body: JSON.stringify({ event: 'nism_scheduled_compliance', recipient: cfg.recipient || 'qaudits@fundsindia.com', thresholdDays: cfg.thresholdDays || 30, timestamp: now }),
            }).catch(() => {});
          }
          cfg.lastSentAt = now;
          stmts.push(env.DB.prepare(`UPDATE system_settings SET value=?, updated_at=datetime('now') WHERE key='nism_schedule'`).bind(JSON.stringify(cfg)));
        }
      }
    } catch { /* ignore */ }
    await env.DB.batch(stmts);
  },
} satisfies ExportedHandler<Env>;
