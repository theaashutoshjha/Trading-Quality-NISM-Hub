import { Ctx, Env, HttpError, fail, json, sessionUser } from './lib';

export type Access = 'none' | 'learner' | 'admin' | 'admin-only';
export type Handler = (c: Ctx) => Promise<Response> | Response;
export type Route = [method: string, pattern: string, access: Access, handler: Handler];

const compile = (p: string) => new RegExp('^' + p.replace(/:[a-zA-Z]+/g, '([^/]+)') + '/?$');

export function makeRouter(routes: Route[]) {
  const table = routes.map(([m, p, a, h]) => ({ m, re: compile(p), a, h }));

  return async function handle(req: Request, env: Env, ex: ExecutionContext, url: URL): Promise<Response> {
    const hit = table.find((r) => r.m === req.method && r.re.test(url.pathname));
    if (!hit) {
      // method mismatch vs unknown route
      return json({ error: 'Not found' }, 404);
    }
    try {
      // CSRF defence in depth: cookies are SameSite=Strict; also reject cross-origin writes.
      if (req.method !== 'GET' && req.method !== 'HEAD') {
        const origin = req.headers.get('Origin');
        if (origin && origin !== url.origin) fail(403, 'Cross-origin request blocked.');
        const ct = req.headers.get('Content-Type') || '';
        if (!ct.startsWith('application/json')) fail(415, 'Expected JSON.');
      }
      const params = (url.pathname.match(hit.re) || []).slice(1).map(decodeURIComponent);
      let cache: any;
      const c: Ctx = {
        req, env, ex, url, params,
        ip: req.headers.get('CF-Connecting-IP') || 'local',
        body: async () => {
          if (cache) return cache;
          const text = await req.text();
          if (text.length > 1_500_000) fail(413, 'Payload too large.');
          try {
            cache = text ? JSON.parse(text) : {};
          } catch {
            fail(400, 'Invalid JSON.');
          }
          if (cache === null || typeof cache !== 'object') fail(400, 'Invalid JSON.');
          return cache;
        },
      };
      if (hit.a !== 'none') {
        const kind = hit.a === 'learner' ? 'learner' : 'admin';
        const user = await sessionUser(env, req, kind);
        if (!user) fail(401, 'Please sign in.');
        if (hit.a === 'admin-only' && user!.role !== 'admin') fail(403, 'Administrator access required.');
        c.user = user!;
      }
      return await hit.h(c);
    } catch (e) {
      if (e instanceof HttpError) return json({ error: e.message }, e.status);
      console.error('API error', e);
      return json({ error: 'Something went wrong. Please try again.' }, 500);
    }
  };
}
