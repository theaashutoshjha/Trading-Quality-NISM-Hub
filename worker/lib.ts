import { randomToken, sha256Hex } from './security';

export interface Env {
  DB: D1Database;
  ASSETS: Fetcher;
  ADMIN_PATH: string;
  COOKIE_SECURE?: string;
  SETUP_TOKEN?: string; // wrangler secret
  RESEND_API_KEY?: string; // optional wrangler secret for server-side NISM audit emails
  MAIL_FROM?: string; // optional sender address when RESEND_API_KEY is set
}

export interface User {
  id: string;
  email: string;
  name: string;
  emp_id: string | null;
  department: string | null;
  team: string | null;
  role: 'learner' | 'head' | 'trainer' | 'admin';
  status: string;
  must_change: number;
  totp_enabled: number;
  login_count?: number;
}

export interface Ctx {
  req: Request;
  env: Env;
  ex: ExecutionContext;
  url: URL;
  params: string[];
  ip: string;
  body: <T = Record<string, any>>() => Promise<T>;
  user?: User;
}

export class HttpError extends Error {
  constructor(public status: number, msg: string) {
    super(msg);
  }
}

export const json = (data: unknown, status = 200, headers: HeadersInit = {}) =>
  new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store', ...headers } });

export const fail = (status: number, message: string): never => {
  throw new HttpError(status, message);
};

export const COOKIE = { learner: 'fi_l', head: 'fi_h', admin: 'fi_a' } as const;
export type Kind = keyof typeof COOKIE;
const TTL_HOURS: Record<Kind, number> = { learner: 24 * 7, head: 12, admin: 8 };

export function readCookie(req: Request, name: string) {
  const raw = req.headers.get('Cookie') || '';
  for (const part of raw.split(';')) {
    const [k, ...v] = part.trim().split('=');
    if (k === name) return v.join('=');
  }
  return null;
}

export function cookieHeader(env: Env, kind: Kind, value: string, clear = false) {
  const maxAge = clear ? 0 : TTL_HOURS[kind] * 3600;
  const secure = env.COOKIE_SECURE === '0' ? '' : '; Secure';
  return `${COOKIE[kind]}=${value}; HttpOnly; SameSite=Strict; Path=/; Max-Age=${maxAge}${secure}`;
}

export function clientIp(req: Request): string {
  return (
    req.headers.get('CF-Connecting-IP') ||
    req.headers.get('True-Client-IP') ||
    req.headers.get('X-Real-IP') ||
    (req.headers.get('X-Forwarded-For') || '').split(',')[0].trim() ||
    '127.0.0.1'
  ).slice(0, 64);
}

export async function createSession(env: Env, req: Request, userId: string, kind: Kind) {
  const token = randomToken(32);
  const hash = await sha256Hex(token);
  const expires = new Date(Date.now() + TTL_HOURS[kind] * 3600_000).toISOString();
  await env.DB.prepare(
    `INSERT INTO sessions (token_hash, user_id, kind, expires_at, ip, ua) VALUES (?,?,?,?,?,?)`,
  )
    .bind(hash, userId, kind, expires, clientIp(req), (req.headers.get('User-Agent') || '').slice(0, 200))
    .run();
  // opportunistic cleanup
  await env.DB.prepare(`DELETE FROM sessions WHERE expires_at < ?`).bind(new Date().toISOString()).run();
  return token;
}

export async function sessionUser(env: Env, req: Request, kind: Kind): Promise<User | null> {
  const token = readCookie(req, COOKIE[kind]);
  if (!token || token.length < 30) return null;
  const hash = await sha256Hex(token);
  const row = await env.DB.prepare(
    `SELECT u.id,u.email,u.name,u.emp_id,u.department,u.team,u.role,u.status,u.must_change,u.totp_enabled,u.login_count
       FROM sessions s JOIN users u ON u.id = s.user_id
      WHERE s.token_hash = ? AND s.kind = ? AND s.expires_at > ? AND u.status = 'active'`,
  )
    .bind(hash, kind, new Date().toISOString())
    .first<User>();
  if (!row) return null;
  if (kind === 'admin' && row.role !== 'admin' && row.role !== 'trainer') return null;
  if (kind === 'head' && row.role !== 'head' && row.role !== 'admin') return null;
  return row;
}

export async function destroySession(env: Env, req: Request, kind: Kind) {
  const token = readCookie(req, COOKIE[kind]);
  if (token) await env.DB.prepare(`DELETE FROM sessions WHERE token_hash = ?`).bind(await sha256Hex(token)).run();
}

// ---- brute-force protection ----
const MAX_FAILS = 5;
const LOCK_MIN = 15;

export async function checkLock(env: Env, keys: string[]) {
  for (const key of keys) {
    const r = await env.DB.prepare(`SELECT 1 AS locked FROM login_attempts WHERE key = ? AND locked_until > datetime('now')`).bind(key).first();
    if (r) {
      fail(429, `Too many failed attempts. Try again in ${LOCK_MIN} minutes.`);
    }
  }
}
export async function recordFail(env: Env, keys: string[]) {
  for (const key of keys) {
    await env.DB.prepare(
      `INSERT INTO login_attempts (key, fails, updated_at) VALUES (?,1,datetime('now'))
       ON CONFLICT(key) DO UPDATE SET
         fails = CASE WHEN locked_until IS NOT NULL AND locked_until <= datetime('now') THEN 1 ELSE fails + 1 END,
         locked_until = CASE
           WHEN locked_until IS NOT NULL AND locked_until <= datetime('now') THEN NULL
           WHEN fails + 1 >= ${MAX_FAILS} THEN datetime('now','+${LOCK_MIN} minutes')
           ELSE NULL END,
         updated_at = datetime('now')`,
    )
      .bind(key)
      .run();
  }
}
export async function clearFails(env: Env, keys: string[]) {
  for (const key of keys) await env.DB.prepare(`DELETE FROM login_attempts WHERE key = ?`).bind(key).run();
}

export async function audit(env: Env, actor: string | null, action: string, detail = '', ip = '') {
  await env.DB.prepare(`INSERT INTO audit_log (actor, action, detail, ip) VALUES (?,?,?,?)`).bind(actor, action, detail.slice(0, 500), ip).run();
}

export const randomNonce = () => randomToken(16);

export const newId =(n = 8) => randomToken(12).replace(/[-_]/g, '').slice(0, n).toLowerCase();

export const slugify = (s: string) =>
  s
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 60);

export const str = (v: unknown, max = 500) => (typeof v === 'string' ? v.trim().slice(0, max) : '');
export const int = (v: unknown, d = 0) => (Number.isFinite(Number(v)) ? Math.trunc(Number(v)) : d);
export const flag = (v: unknown) => (v === true || v === 1 || v === '1' ? 1 : 0);
export const isEmail = (s: string) => /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(s) && s.length <= 120;
