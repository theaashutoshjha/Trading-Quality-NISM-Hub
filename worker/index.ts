import { Env, randomNonce, sessionUser } from './lib';
import { adminLoginPage } from './adminLogin';
import { authRoutes } from './auth';
import { learnerRoutes } from './learner';
import { adminRoutes } from './admin';
import { makeRouter } from './router';

const api = makeRouter([...authRoutes, ...learnerRoutes, ...adminRoutes]);

const baseHeaders = (nonce?: string): Record<string, string> => ({
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
  'Content-Security-Policy': [
    "default-src 'self'",
    `script-src 'self' https://www.youtube.com${nonce ? ` 'nonce-${nonce}'` : ''}`,
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
    "font-src 'self' https://fonts.gstatic.com",
    "img-src 'self' data: https://i.ytimg.com",
    'frame-src https://www.youtube-nocookie.com https://www.youtube.com',
    "connect-src 'self'",
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
      url.protocol === 'http:' &&
      ['learning-hub.fingtaj.online', 'www.learning-hub.fingtaj.online'].includes(url.hostname)
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

    // ---- Learner SPA + static files ----
    const res = await env.ASSETS.fetch(req);
    const isHtml = (res.headers.get('Content-Type') || '').includes('text/html');
    return withHeaders(res, { ...baseHeaders(), 'Cache-Control': isHtml ? 'no-cache' : res.headers.get('Cache-Control') || 'public, max-age=3600' });
  },
} satisfies ExportedHandler<Env>;
