import {
  Ctx, Kind, User, audit, checkLock, clearFails, cookieHeader, createSession, destroySession, fail, int, isEmail, json, newId, recordFail, str,
} from './lib';
import { dummyVerify, hashPassword, newTotpSecret, passwordProblem, totpUri, verifyPassword, verifyTotp } from './security';
import type { Route } from './router';
import { allowedCourses } from './teams';

type Row = User & { pw_hash: string; totp_secret: string | null };

async function login(c: Ctx, kind: Kind) {
  const b = await c.body();
  // "User ID" is the employee ID; the work e-mail address also works (b.email is accepted for older clients).
  const email = str(b.userId ?? b.email, 120).toLowerCase();
  const password = typeof b.password === 'string' ? b.password.slice(0, 200) : '';
  if (!email || !password) fail(400, kind === 'learner' ? 'Enter your User ID and password.' : 'Enter your e-mail and password.');

  const keys = [`${kind}:u:${email}`, `${kind}:ip:${c.ip}`];
  await checkLock(c.env, keys);

  const u = await c.env.DB.prepare(`SELECT * FROM users WHERE email = ? OR emp_id = ? COLLATE NOCASE ORDER BY (email = ?) DESC LIMIT 1`).bind(email, email, email).first<Row>();
  const genericFail = async (why: string): Promise<never> => {
    await recordFail(c.env, keys);
    await audit(c.env, email, `login_failed_${kind}`, why, c.ip);
    return fail(401, kind === 'learner' ? 'Invalid User ID or password.' : 'Invalid e-mail or password.');
  };

  if (!u) {
    await dummyVerify(password);
    return genericFail('unknown user');
  }
  if (!(await verifyPassword(password, u.pw_hash))) return genericFail('bad password');
  if (kind === 'admin' && u.role !== 'admin' && u.role !== 'trainer') return genericFail('not staff');
  if (kind === 'head' && u.role !== 'head' && u.role !== 'admin') return genericFail('not head');
  if (kind === 'learner' && u.role === 'learner' && !u.team) {
    fail(403, 'Your account has not been assigned to a team yet. Contact your administrator or team head.');
  }

  if ((kind === 'admin' || kind === 'head') && u.totp_enabled && u.totp_secret) {
    const code = str(b.code, 8);
    if (!code) return json({ needCode: true }, 200);
    if (!(await verifyTotp(u.totp_secret, code))) return genericFail('bad totp');
  }

  if (u.status === 'pending') fail(403, 'Your account is awaiting approval by an administrator.');
  if (u.status !== 'active') fail(403, 'This account has been disabled. Contact your administrator.');

  await clearFails(c.env, keys);
  const token = await createSession(c.env, c.req, u.id, kind);
  const nextCount = (u.login_count || 0) + 1;
  await c.env.DB.prepare(`UPDATE users SET last_login = datetime('now'), login_count = ? WHERE id = ?`).bind(nextCount, u.id).run();
  u.login_count = nextCount;
  await audit(c.env, u.email, `login_${kind}`, '', c.ip);
  return json({ ok: true, user: pub(u), mustChange: !!u.must_change }, 200, { 'Set-Cookie': cookieHeader(c.env, kind, token) });
}

const pub = (u: User) => ({ id: u.id, email: u.email, name: u.name, role: u.role, empId: u.emp_id, department: u.department, team: u.team, mustChange: !!u.must_change, totp: !!u.totp_enabled, loginCount: u.login_count || 0 });

async function logout(c: Ctx, kind: Kind) {
  await destroySession(c.env, c.req, kind);
  return json({ ok: true }, 200, { 'Set-Cookie': cookieHeader(c.env, kind, '', true) });
}

async function changePassword(c: Ctx, kind: Kind) {
  const b = await c.body();
  const u = c.user!;
  const row = await c.env.DB.prepare(`SELECT pw_hash FROM users WHERE id = ?`).bind(u.id).first<{ pw_hash: string }>();
  if (!row || !(await verifyPassword(String(b.current || ''), row.pw_hash))) fail(400, 'Current password is incorrect.');
  const next = String(b.next || '');
  const problem = passwordProblem(next);
  if (problem) fail(400, problem);
  if (next === b.current) fail(400, 'New password must differ from the current one.');
  await c.env.DB.prepare(`UPDATE users SET pw_hash = ?, must_change = 0 WHERE id = ?`).bind(await hashPassword(next), u.id).run();
  // sign out every other session
  await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id = ? AND kind = ?`).bind(u.id, kind).run();
  const token = await createSession(c.env, c.req, u.id, kind);
  await audit(c.env, u.email, 'password_changed', kind, c.ip);
  return json({ ok: true }, 200, { 'Set-Cookie': cookieHeader(c.env, kind, token) });
}

export const authRoutes: Route[] = [
  // ---------- Learner ----------
  ['POST', '/api/auth/login', 'none', (c) => login(c, 'learner')],
  ['POST', '/api/auth/logout', 'none', (c) => logout(c, 'learner')],
  ['GET', '/api/auth/me', 'learner', async (c) => {
    // Course categories this user can open (drives the sidebar), plus the team list for the sign-in form.
    const allowed = await allowedCourses(c);
    const rows = await c.env.DB.prepare(`SELECT id, category FROM courses WHERE published = 1`).all<{ id: string; category: string }>();
    const cats = [...new Set(rows.results.filter((r) => allowed === null || allowed.has(r.id)).map((r) => r.category))];
    return json({ user: pub(c.user!), cats });
  }],
  ['GET', '/api/auth/teams', 'none', async (c) => {
    const r = await c.env.DB.prepare(`SELECT name, description, full_access FROM teams ORDER BY full_access DESC, name`).all();
    return json({ teams: r.results.map((x: any) => x.name), list: r.results });
  }],
  ['POST', '/api/auth/password', 'learner', (c) => changePassword(c, 'learner')],

  // ---------- Head portal ----------
  ['POST', '/api/head/login', 'none', (c) => login(c, 'head')],
  ['POST', '/api/head/logout', 'none', (c) => logout(c, 'head')],
  ['GET', '/api/head/me', 'head', (c) => json({ user: pub(c.user!) })],
  ['POST', '/api/head/password', 'head', (c) => changePassword(c, 'head')],

  // ---------- Admin portal ----------
  ['GET', '/api/admin/status', 'none', async (c) => {
    const r = await c.env.DB.prepare(`SELECT COUNT(*) n FROM users WHERE role = 'admin'`).first<{ n: number }>();
    return json({ needsSetup: !r || r.n === 0 });
  }],
  ['POST', '/api/admin/setup', 'none', async (c) => {
    // One-time bootstrap of the first administrator. Requires the SETUP_TOKEN secret.
    const n = await c.env.DB.prepare(`SELECT COUNT(*) n FROM users WHERE role = 'admin'`).first<{ n: number }>();
    if (n && n.n > 0) fail(403, 'Setup already completed.');
    await checkLock(c.env, [`setup:ip:${c.ip}`]);
    const b = await c.body();
    const expected = c.env.SETUP_TOKEN;
    if (!expected || expected.length < 16) fail(503, 'SETUP_TOKEN secret is not configured on the server.');
    const given = String(b.token || '');
    if (given !== expected) {
      await recordFail(c.env, [`setup:ip:${c.ip}`]);
      fail(403, 'Invalid setup token.');
    }
    const email = str(b.email, 120).toLowerCase();
    const name = str(b.name, 80) || 'Administrator';
    const pw = String(b.password || '');
    if (!isEmail(email)) fail(400, 'Enter a valid e-mail address.');
    const problem = passwordProblem(pw);
    if (problem || pw.length < 12) fail(400, problem || 'Admin password must be at least 12 characters.');
    await c.env.DB.prepare(`INSERT INTO users (id,email,name,role,status,pw_hash) VALUES (?,?,?,'admin','active',?)`).bind(newId(12), email, name, await hashPassword(pw)).run();
    await audit(c.env, email, 'admin_bootstrap', '', c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/admin/login', 'none', (c) => login(c, 'admin')],
  ['POST', '/api/admin/logout', 'none', (c) => logout(c, 'admin')],
  ['GET', '/api/admin/me', 'admin', (c) => json({ user: pub(c.user!) })],
  ['POST', '/api/admin/password', 'admin', (c) => changePassword(c, 'admin')],

  // ---------- Two-factor (TOTP) for staff ----------
  ['POST', '/api/admin/totp/begin', 'admin', async (c) => {
    const secret = newTotpSecret();
    await c.env.DB.prepare(`UPDATE users SET totp_secret = ?, totp_enabled = 0 WHERE id = ?`).bind(secret, c.user!.id).run();
    return json({ secret, uri: totpUri(secret, c.user!.email) });
  }],
  ['POST', '/api/admin/totp/enable', 'admin', async (c) => {
    const b = await c.body();
    const r = await c.env.DB.prepare(`SELECT totp_secret FROM users WHERE id = ?`).bind(c.user!.id).first<{ totp_secret: string | null }>();
    if (!r?.totp_secret || !(await verifyTotp(r.totp_secret, str(b.code, 8)))) fail(400, 'That code is not valid. Check your authenticator app clock and try again.');
    await c.env.DB.prepare(`UPDATE users SET totp_enabled = 1 WHERE id = ?`).bind(c.user!.id).run();
    await audit(c.env, c.user!.email, 'totp_enabled', '', c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/admin/totp/disable', 'admin', async (c) => {
    const b = await c.body();
    const r = await c.env.DB.prepare(`SELECT pw_hash FROM users WHERE id = ?`).bind(c.user!.id).first<{ pw_hash: string }>();
    if (!r || !(await verifyPassword(String(b.password || ''), r.pw_hash))) fail(400, 'Password is incorrect.');
    await c.env.DB.prepare(`UPDATE users SET totp_enabled = 0, totp_secret = NULL WHERE id = ?`).bind(c.user!.id).run();
    await audit(c.env, c.user!.email, 'totp_disabled', '', c.ip);
    return json({ ok: true });
  }],
];

export { int };
