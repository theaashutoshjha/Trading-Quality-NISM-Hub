import { Ctx, audit, fail, flag, int, isEmail, json, newId, slugify, str } from './lib';
import { hashPassword, passwordProblem, randomToken } from './security';
import type { Route } from './router';
import { fetchPlaylist, oembed } from './youtube';
import { isTeamDb } from './teams';

const A = 'admin' as const;
const OWNER = 'admin-only' as const;

const YT_ID = /^[A-Za-z0-9_-]{11}$/;
const YT_LIST = /^(PL|UU|OL|FL|RD)[A-Za-z0-9_-]{10,60}$/;

/** Accepts a YouTube URL or raw id and returns the video id (or ''). */
export function ytVideoId(v: string) {
  const s = v.trim();
  if (YT_ID.test(s)) return s;
  try {
    const u = new URL(s);
    if (u.hostname === 'youtu.be') return YT_ID.test(u.pathname.slice(1)) ? u.pathname.slice(1) : '';
    const id = u.searchParams.get('v') || u.pathname.split('/').pop() || '';
    return /youtube(-nocookie)?\.com$/.test(u.hostname.replace(/^www\./, '')) && YT_ID.test(id) ? id : '';
  } catch {
    return '';
  }
}
export function ytPlaylistId(v: string) {
  const s = v.trim();
  if (YT_LIST.test(s)) return s;
  try {
    const id = new URL(s).searchParams.get('list') || '';
    return YT_LIST.test(id) ? id : '';
  } catch {
    return '';
  }
}

function cleanPlaylists(v: unknown) {
  if (!Array.isArray(v)) return '[]';
  const out = v.slice(0, 20).map((p: any) => ({
    id: ytPlaylistId(String(p?.id || '')),
    title: str(p?.title, 160),
    channel: str(p?.channel, 80),
    lang: str(p?.lang, 20) || 'English',
    note: str(p?.note, 200),
  })).filter((p) => p.id);
  return JSON.stringify(out);
}
function cleanLinks(v: unknown) {
  if (!Array.isArray(v)) return '[]';
  return JSON.stringify(v.slice(0, 20).map((l: any) => ({ title: str(l?.title, 120), url: str(l?.url, 400) })).filter((l) => /^https:\/\//.test(l.url) && l.title));
}

async function setOrder(c: Ctx, table: string, col = 'sort') {
  const b = await c.body();
  const ids = Array.isArray(b.ids) ? b.ids.map(String).slice(0, 2000) : [];
  await c.env.DB.batch(ids.map((id, i) => c.env.DB.prepare(`UPDATE ${table} SET ${col}=? WHERE id=?`).bind(i, id)));
  return json({ ok: true });
}

export const adminRoutes: Route[] = [
  // ---------- Overview ----------
  ['GET', '/api/admin/stats', A, async (c) => {
    const db = c.env.DB;
    const [t, recent, top, weak] = await Promise.all([
      db.prepare(`SELECT (SELECT COUNT(*) FROM users WHERE role='learner' AND status='active') learners,
                         (SELECT COUNT(*) FROM users WHERE status='pending') pending,
                         (SELECT COUNT(*) FROM courses) courses,
                         (SELECT COUNT(*) FROM lessons) lessons,
                         (SELECT COUNT(*) FROM questions) questions,
                         (SELECT COUNT(DISTINCT user_id) FROM progress WHERE completed_at > datetime('now','-7 days')) active7,
                         (SELECT COUNT(*) FROM certificates WHERE revoked=0) certs,
                         (SELECT ROUND(AVG(pct),1) FROM attempts) avg_score`).first(),
      db.prepare(`SELECT u.name,u.email,a.pct,a.passed,a.created_at,q.title FROM attempts a JOIN users u ON u.id=a.user_id JOIN quizzes q ON q.id=a.quiz_id ORDER BY a.created_at DESC LIMIT 8`).all(),
      db.prepare(`SELECT c.title,c.code,COUNT(DISTINCT p.user_id) learners FROM progress p JOIN courses c ON c.id=p.course_id GROUP BY c.id ORDER BY learners DESC LIMIT 6`).all(),
      db.prepare(`SELECT q.title,COUNT(*) tries,ROUND(AVG(a.pct),1) avg FROM attempts a JOIN quizzes q ON q.id=a.quiz_id GROUP BY q.id HAVING tries>=3 ORDER BY avg ASC LIMIT 5`).all(),
    ]);
    return json({ totals: t, recent: recent.results, topCourses: top.results, weakQuizzes: weak.results });
  }],

  // ---------- Users (admin only) ----------
  ['GET', '/api/admin/users', OWNER, async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT u.id,u.email,u.name,u.emp_id,u.department,u.team,u.role,u.status,u.must_change,u.totp_enabled,u.created_at,u.last_login,
              (SELECT COUNT(*) FROM progress p WHERE p.user_id=u.id) lessons,
              (SELECT ROUND(AVG(pct),1) FROM attempts a WHERE a.user_id=u.id) avg_score,
              (SELECT COUNT(*) FROM certificates ce WHERE ce.user_id=u.id AND ce.revoked=0) certs
         FROM users u ORDER BY u.created_at DESC LIMIT 2000`,
    ).all();
    return json({ users: r.results });
  }],
  ['POST', '/api/admin/users', OWNER, async (c) => {
    const b = await c.body();
    const rows = Array.isArray(b.users) ? b.users.slice(0, 500) : [b];
    const created: { email: string; password: string }[] = [], skipped: string[] = [];
    for (const r of rows as any[]) {
      const email = str(r.email, 120).toLowerCase(), name = str(r.name, 80);
      if (!isEmail(email) || name.length < 2) { skipped.push(email || '(blank)'); continue; }
      const role = ['learner', 'head', 'trainer', 'admin'].includes(r.role) ? r.role : 'learner';
      if (role === 'admin' && c.user!.role !== 'admin') continue;
      const team = await isTeamDb(c.env.DB, r.team);
      const temp = randomToken(9) + 'Aa1'; // shown once to the admin, learner must change on first login
      try {
        await c.env.DB.prepare(`INSERT INTO users (id,email,name,emp_id,department,team,role,status,pw_hash,must_change) VALUES (?,?,?,?,?,?,?,'active',?,1)`)
          .bind(newId(12), email, name, str(r.empId, 30) || null, str(r.department, 60) || null, team, role, await hashPassword(temp)).run();
        created.push({ email, password: temp });
      } catch { skipped.push(email); }
    }
    await audit(c.env, c.user!.email, 'users_created', `${created.length} created, ${skipped.length} skipped`, c.ip);
    return json({ created, skipped });
  }],
  ['PUT', '/api/admin/users/:id', OWNER, async (c) => {
    const b = await c.body();
    const id = c.params[0];
    if (id === c.user!.id && (b.status && b.status !== 'active' || b.role && b.role !== c.user!.role)) fail(400, 'You cannot demote or disable your own account.');
    const cur = await c.env.DB.prepare(`SELECT role,status,team FROM users WHERE id=?`).bind(id).first<any>();
    if (!cur) fail(404, 'User not found.');
    const role = ['learner', 'head', 'trainer', 'admin'].includes(b.role) ? b.role : cur.role;
    const status = ['active', 'pending', 'suspended'].includes(b.status) ? b.status : cur.status;
    const team = b.team === undefined ? cur.team : await isTeamDb(c.env.DB, b.team);
    try {
      await c.env.DB.prepare(`UPDATE users SET name=COALESCE(NULLIF(?,''),name), emp_id=?, department=?, team=?, role=?, status=? WHERE id=?`)
        .bind(str(b.name, 80), str(b.empId, 30) || null, str(b.department, 60) || null, team, role, status, id).run();
    } catch { fail(409, 'That User ID is already used by another account.'); }
    if (status !== 'active' || role !== cur.role) await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id=?`).bind(id).run();
    await audit(c.env, c.user!.email, 'user_updated', `${id} role=${role} status=${status} team=${team || '-'}`, c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/admin/users/:id/reset', OWNER, async (c) => {
    const temp = randomToken(9) + 'Aa1';
    await c.env.DB.prepare(`UPDATE users SET pw_hash=?, must_change=1 WHERE id=?`).bind(await hashPassword(temp), c.params[0]).run();
    await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'password_reset', c.params[0], c.ip);
    return json({ password: temp });
  }],
  ['DELETE', '/api/admin/users/:id', OWNER, async (c) => {
    if (c.params[0] === c.user!.id) fail(400, 'You cannot delete your own account.');
    await c.env.DB.prepare(`DELETE FROM users WHERE id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'user_deleted', c.params[0], c.ip);
    return json({ ok: true });
  }],
  // ---------- Teams: create, delete, and which courses each team can open ----------
  ['GET', '/api/admin/teams', OWNER, async (c) => {
    const db = c.env.DB;
    const [teamRows, rows, courses, counts] = await Promise.all([
      db.prepare(`SELECT name, description, full_access FROM teams ORDER BY full_access DESC, name`).all<{ name: string; description: string | null; full_access: number }>(),
      db.prepare(`SELECT team, course_id FROM team_access`).all<{ team: string; course_id: string }>(),
      db.prepare(`SELECT id, code, title, category FROM courses ORDER BY sort, title`).all(),
      db.prepare(`SELECT team, COUNT(*) n FROM users WHERE role='learner' AND team IS NOT NULL GROUP BY team`).all<{ team: string; n: number }>(),
    ]);
    const n = new Map(counts.results.map((x) => [x.team, x.n]));
    const unassigned = await db.prepare(`SELECT COUNT(*) n FROM users WHERE role='learner' AND team IS NULL`).first<{ n: number }>();
    return json({
      teams: teamRows.results.map((t) => ({
        name: t.name,
        description: t.description || '',
        learners: n.get(t.name) || 0,
        full: !!t.full_access,
        courses: t.full_access ? courses.results.map((x: any) => x.id) : rows.results.filter((r) => r.team === t.name).map((r) => r.course_id),
      })),
      courses: courses.results,
      unassigned: unassigned?.n || 0,
    });
  }],
  ['POST', '/api/admin/teams', OWNER, async (c) => {
    const b = await c.body();
    const name = str(b.name, 60);
    if (name.length < 2) fail(400, 'Team name must be at least 2 characters.');
    const exists = await c.env.DB.prepare(`SELECT 1 FROM teams WHERE name=? COLLATE NOCASE`).bind(name).first();
    if (exists) fail(409, 'A team with this name already exists.');
    const desc = str(b.description, 200);
    const full = b.full ? 1 : 0;
    const ids: string[] = Array.isArray(b.courses) ? [...new Set<string>(b.courses.map(String))].slice(0, 200) : [];
    await c.env.DB.batch([
      c.env.DB.prepare(`INSERT INTO teams (name, description, full_access, created_by) VALUES (?,?,?,?)`).bind(name, desc || null, full, c.user!.email),
      ...(full ? [] : ids.map((id) => c.env.DB.prepare(`INSERT OR IGNORE INTO team_access (team,course_id) SELECT ?, id FROM courses WHERE id=?`).bind(name, id))),
    ]);
    await audit(c.env, c.user!.email, 'team_created', name, c.ip);
    return json({ ok: true, name });
  }],
  ['PUT', '/api/admin/teams/:team', OWNER, async (c) => {
    const team = c.params[0];
    const row = await c.env.DB.prepare(`SELECT name, full_access FROM teams WHERE name=?`).bind(team).first<{ name: string; full_access: number }>();
    if (!row) return fail(404, 'Unknown team.');
    if (row.full_access) fail(400, `${team} always has access to every course.`);
    const b = await c.body();
    const ids: string[] = Array.isArray(b.courses) ? [...new Set<string>(b.courses.map(String))].slice(0, 200) : [];
    const db = c.env.DB;
    await db.batch([
      db.prepare(`DELETE FROM team_access WHERE team=?`).bind(team),
      ...ids.map((id) => db.prepare(`INSERT OR IGNORE INTO team_access (team,course_id) SELECT ?, id FROM courses WHERE id=?`).bind(team, id)),
    ]);
    await audit(c.env, c.user!.email, 'team_access_updated', `${team}: ${ids.length} courses`, c.ip);
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/teams/:team', OWNER, async (c) => {
    const team = c.params[0];
    const row = await c.env.DB.prepare(`SELECT full_access FROM teams WHERE name=?`).bind(team).first<{ full_access: number }>();
    if (!row) return fail(404, 'Unknown team.');
    if (row.full_access) fail(400, 'Cannot delete full-access team.');
    await c.env.DB.batch([
      c.env.DB.prepare(`UPDATE users SET team=NULL WHERE team=?`).bind(team),
      c.env.DB.prepare(`DELETE FROM team_access WHERE team=?`).bind(team),
      c.env.DB.prepare(`DELETE FROM teams WHERE name=?`).bind(team),
    ]);
    await audit(c.env, c.user!.email, 'team_deleted', team, c.ip);
    return json({ ok: true });
  }],
  ['GET', '/api/admin/locks', OWNER, async (c) => {
    const r = await c.env.DB.prepare(`SELECT key, fails, locked_until, updated_at FROM login_attempts ORDER BY updated_at DESC LIMIT 200`).all();
    return json({ locks: r.results });
  }],
  ['DELETE', '/api/admin/locks', OWNER, async (c) => {
    await c.env.DB.prepare(`DELETE FROM login_attempts`).run();
    await audit(c.env, c.user!.email, 'locks_cleared', 'All login lockouts cleared', c.ip);
    return json({ ok: true });
  }],
  ['GET', '/api/admin/audit', OWNER, async (c) => {
    const actor = str(c.url.searchParams.get('actor'), 80);
    const action = str(c.url.searchParams.get('action'), 60);
    const where: string[] = [];
    const args: string[] = [];
    if (actor) { where.push(`actor LIKE ?`); args.push(`%${actor}%`); }
    if (action) { where.push(`action LIKE ?`); args.push(`%${action}%`); }
    const sql = `SELECT id,actor,action,detail,ip,created_at FROM audit_log${where.length ? ' WHERE ' + where.join(' AND ') : ''} ORDER BY id DESC LIMIT 500`;
    const r = await c.env.DB.prepare(sql).bind(...args).all();
    return json({ log: r.results });
  }],
  ['GET', '/api/admin/question-stats', A, async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT q.id, q.question, qz.title AS quiz_title, co.code AS course_code, s.total_tries, s.correct_tries,
              ROUND((s.correct_tries * 100.0) / s.total_tries, 1) AS pass_rate
         FROM question_stats s JOIN questions q ON q.id=s.question_id JOIN quizzes qz ON qz.id=q.quiz_id JOIN courses co ON co.id=qz.course_id
        WHERE s.total_tries > 0 ORDER BY pass_rate ASC, s.total_tries DESC LIMIT 100`,
    ).all();
    return json({ stats: r.results });
  }],
  ['POST', '/api/admin/certificates/:id/revoke', OWNER, async (c) => {
    await c.env.DB.prepare(`UPDATE certificates SET revoked=1 WHERE id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'certificate_revoked', c.params[0], c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/admin/certificates/:id/reissue', OWNER, async (c) => {
    await c.env.DB.prepare(`UPDATE certificates SET revoked=0 WHERE id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'certificate_reissued', c.params[0], c.ip);
    return json({ ok: true });
  }],

  // ---------- Courses ----------
  ['GET', '/api/admin/courses', A, async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT c.*, (SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id) lessons,
              (SELECT COUNT(*) FROM quizzes q WHERE q.course_id=c.id) quizzes,
              (SELECT COUNT(*) FROM questions x JOIN quizzes q ON q.id=x.quiz_id WHERE q.course_id=c.id) questions
         FROM courses c ORDER BY c.sort, c.title`,
    ).all<any>();
    return json({ courses: r.results.map((x) => ({ ...x, playlists: JSON.parse(x.playlists), links: JSON.parse(x.links) })) });
  }],
  ['GET', '/api/admin/courses/:id', A, async (c) => {
    const id = c.params[0], db = c.env.DB;
    const course = await db.prepare(`SELECT * FROM courses WHERE id=?`).bind(id).first<any>();
    if (!course) fail(404, 'Not found.');
    const [m, l, q] = await Promise.all([
      db.prepare(`SELECT * FROM modules WHERE course_id=? ORDER BY sort`).bind(id).all(),
      db.prepare(`SELECT id,module_id,title,kind,minutes,published,sort FROM lessons WHERE course_id=? ORDER BY sort`).bind(id).all(),
      db.prepare(`SELECT q.*, (SELECT COUNT(*) FROM questions x WHERE x.quiz_id=q.id) questions FROM quizzes q WHERE q.course_id=? ORDER BY q.sort`).bind(id).all(),
    ]);
    return json({ course: { ...course, playlists: JSON.parse(course.playlists), links: JSON.parse(course.links) }, modules: m.results, lessons: l.results, quizzes: q.results });
  }],
  ['POST', '/api/admin/courses', A, async (c) => {
    const b = await c.body();
    const title = str(b.title, 160);
    if (!title) fail(400, 'Title is required.');
    const code = str(b.code, 40) || title;
    const id = slugify(str(b.id, 60) || code);
    if (!id) fail(400, 'Invalid course code.');
    if (await c.env.DB.prepare(`SELECT 1 FROM courses WHERE id=?`).bind(id).first()) fail(409, 'A course with this code already exists.');
    await c.env.DB.prepare(`INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,999)`)
      .bind(id, code, title, str(b.subtitle, 200), str(b.category, 40) || 'general', str(b.description, 4000), str(b.level, 30), Number(b.hours) || 0, cleanPlaylists(b.playlists), cleanLinks(b.links), flag(b.published ?? 1), flag(b.popular)).run();
    await audit(c.env, c.user!.email, 'course_created', id, c.ip);
    return json({ id });
  }],
  ['PUT', '/api/admin/courses/:id', A, async (c) => {
    const b = await c.body();
    await c.env.DB.prepare(`UPDATE courses SET code=?,title=?,subtitle=?,category=?,description=?,level=?,hours=?,playlists=?,links=?,published=?,popular=?,updated_at=datetime('now') WHERE id=?`)
      .bind(str(b.code, 40), str(b.title, 160), str(b.subtitle, 200), str(b.category, 40), str(b.description, 4000), str(b.level, 30), Number(b.hours) || 0, cleanPlaylists(b.playlists), cleanLinks(b.links), flag(b.published), flag(b.popular), c.params[0]).run();
    await audit(c.env, c.user!.email, 'course_updated', c.params[0], c.ip);
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/courses/:id', OWNER, async (c) => {
    await c.env.DB.prepare(`DELETE FROM courses WHERE id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'course_deleted', c.params[0], c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/admin/order/:table', A, async (c) => {
    const t = c.params[0];
    if (!['courses', 'modules', 'lessons', 'quizzes'].includes(t)) fail(400, 'Bad table.');
    return setOrder(c, t);
  }],

  // ---------- Modules ----------
  ['POST', '/api/admin/modules', A, async (c) => {
    const b = await c.body();
    const id = newId(10);
    const n = await c.env.DB.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM modules WHERE course_id=?`).bind(str(b.course_id, 80)).first<{ n: number }>();
    await c.env.DB.prepare(`INSERT INTO modules (id,course_id,title,weight,sort) VALUES (?,?,?,?,?)`).bind(id, str(b.course_id, 80), str(b.title, 160) || 'New module', Number(b.weight) || null, n!.n).run();
    return json({ id });
  }],
  ['PUT', '/api/admin/modules/:id', A, async (c) => {
    const b = await c.body();
    await c.env.DB.prepare(`UPDATE modules SET title=?, weight=? WHERE id=?`).bind(str(b.title, 160), Number(b.weight) || null, c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/modules/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM modules WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- Video import ----------
  ['POST', '/api/admin/courses/:id/import-video', A, async (c) => {
    const b = await c.body();
    const vid = ytVideoId(str(b.url, 300));
    if (!vid) fail(400, 'Enter a valid video URL.');
    const meta = await oembed(vid).catch(() => null);
    if (!meta) fail(400, 'That video is private, removed or cannot be embedded.');
    const title = str(b.title, 200) || meta!.title;
    const n = await c.env.DB.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM lessons WHERE course_id=?`).bind(c.params[0]).first<{ n: number }>();
    const id = newId(10);
    await c.env.DB.prepare(`INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES (?,?,?,?,'video',?,'',?,?,1,?)`)
      .bind(id, c.params[0], str(b.module_id, 80) || null, title, vid, int(b.minutes, 5), meta!.author, n!.n).run();
    await audit(c.env, c.user!.email, 'video_added', `${c.params[0]} ${vid}`, c.ip);
    return json({ id, title });
  }],
  ['POST', '/api/admin/courses/:id/import-playlist', A, async (c) => {
    // Turns a playlist into one lesson per video. Skips videos older than maxAgeDays (default: no limit).
    const b = await c.body();
    const list = ytPlaylistId(str(b.url, 300));
    if (!list) fail(400, 'Enter a valid playlist URL.');
    let vids;
    try { vids = await fetchPlaylist(list, 200); } catch (e: any) { return fail(502, e.message || 'Could not read the playlist.'); }
    const maxAge = int(b.maxAgeDays, 0);
    if (maxAge > 0) vids = vids.filter((v) => v.ageDays !== null && v.ageDays <= maxAge);
    if (!vids.length) fail(400, 'No videos found (or all are older than the age limit).');
    const db = c.env.DB, course = c.params[0];
    const modId = newId(10);
    const mn = await db.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM modules WHERE course_id=?`).bind(course).first<{ n: number }>();
    const ln = await db.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM lessons WHERE course_id=?`).bind(course).first<{ n: number }>();
    const author = str(b.channel, 80);
    const stmts = [db.prepare(`INSERT INTO modules (id,course_id,title,sort) VALUES (?,?,?,?)`).bind(modId, course, str(b.module, 160) || 'Imported videos', mn!.n)];
    vids.forEach((v, i) => stmts.push(db.prepare(`INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES (?,?,?,?, 'video',?,'',?,?,1,?)`)
      .bind(newId(12), course, modId, v.title.slice(0, 200), v.id, v.mins, author, ln!.n + i)));
    await db.batch(stmts);
    await audit(c.env, c.user!.email, 'playlist_imported', `${course} ${list} (${vids.length})`, c.ip);
    return json({ added: vids.length });
  }],

  // ---------- Learning paths ----------
  ['GET', '/api/admin/paths', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT p.*, (SELECT COUNT(*) FROM path_items i WHERE i.path_id=p.id) steps FROM paths p ORDER BY p.sort`).all();
    return json({ paths: r.results });
  }],
  ['GET', '/api/admin/paths/:id', A, async (c) => {
    const p = await c.env.DB.prepare(`SELECT * FROM paths WHERE id=?`).bind(c.params[0]).first();
    if (!p) fail(404, 'Not found.');
    const items = await c.env.DB.prepare(`SELECT l.id,l.title,l.kind,c.title AS course FROM path_items i JOIN lessons l ON l.id=i.lesson_id JOIN courses c ON c.id=l.course_id WHERE i.path_id=? ORDER BY i.sort`).bind(c.params[0]).all();
    return json({ path: p, items: items.results });
  }],
  ['POST', '/api/admin/paths', A, async (c) => {
    const b = await c.body();
    const title = str(b.title, 120);
    if (!title) fail(400, 'Title is required.');
    const id = 'path-' + (slugify(title) || newId(6));
    if (await c.env.DB.prepare(`SELECT 1 FROM paths WHERE id=?`).bind(id).first()) fail(409, 'A path with this title already exists.');
    await c.env.DB.prepare(`INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES (?,?,?,?,?,0,999)`).bind(id, title, str(b.description, 600), str(b.level, 40), str(b.icon, 4) || '🎯').run();
    return json({ id });
  }],
  ['PUT', '/api/admin/paths/:id', A, async (c) => {
    const b = await c.body();
    const ids: string[] = Array.isArray(b.items) ? [...new Set<string>(b.items.map(String))].slice(0, 300) : [];
    const db = c.env.DB;
    await db.batch([
      db.prepare(`UPDATE paths SET title=?,description=?,level=?,icon=?,published=? WHERE id=?`).bind(str(b.title, 120), str(b.description, 600), str(b.level, 40), str(b.icon, 4) || '🎯', flag(b.published), c.params[0]),
      db.prepare(`DELETE FROM path_items WHERE path_id=?`).bind(c.params[0]),
      ...ids.map((lid, i) => db.prepare(`INSERT OR IGNORE INTO path_items (path_id,lesson_id,sort) VALUES (?,?,?)`).bind(c.params[0], lid, i)),
    ]);
    await audit(c.env, c.user!.email, 'path_updated', c.params[0], c.ip);
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/paths/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM paths WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- One learner's progress (admin only) ----------
  ['GET', '/api/admin/users/:id/progress', OWNER, async (c) => {
    const db = c.env.DB, id = c.params[0];
    const [courses, attempts, certs] = await Promise.all([
      db.prepare(`SELECT c.title,c.code,COUNT(p.lesson_id) done,(SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) total, MAX(p.completed_at) last FROM progress p JOIN courses c ON c.id=p.course_id WHERE p.user_id=? GROUP BY c.id ORDER BY last DESC`).bind(id).all(),
      db.prepare(`SELECT q.title,a.pct,a.passed,a.created_at FROM attempts a JOIN quizzes q ON q.id=a.quiz_id WHERE a.user_id=? ORDER BY a.created_at DESC LIMIT 30`).bind(id).all(),
      db.prepare(`SELECT ce.id,c.title,ce.pct,ce.issued_at,ce.revoked FROM certificates ce JOIN courses c ON c.id=ce.course_id WHERE ce.user_id=?`).bind(id).all(),
    ]);
    return json({ courses: courses.results, attempts: attempts.results, certificates: certs.results });
  }],

  // ---------- Lessons ----------
  ['GET', '/api/admin/lessons/:id', A, async (c) => {
    const l = await c.env.DB.prepare(`SELECT * FROM lessons WHERE id=?`).bind(c.params[0]).first();
    if (!l) fail(404, 'Not found.');
    return json({ lesson: l });
  }],
  ['POST', '/api/admin/lessons', A, async (c) => {
    const b = await c.body();
    const course = str(b.course_id, 80);
    const kind = ['note', 'video', 'link'].includes(b.kind) ? b.kind : 'note';
    const vid = kind === 'video' ? ytVideoId(str(b.video_id, 300)) : null;
    if (kind === 'video' && !vid) fail(400, 'Enter a valid YouTube video URL or ID.');
    const id = newId(10);
    const n = await c.env.DB.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM lessons WHERE course_id=?`).bind(course).first<{ n: number }>();
    await c.env.DB.prepare(`INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,url,body,minutes,published,sort) VALUES (?,?,?,?,?,?,?,?,?,?,?)`)
      .bind(id, course, str(b.module_id, 80) || null, str(b.title, 200) || 'Untitled lesson', kind, vid, /^https:\/\//.test(str(b.url, 400)) ? str(b.url, 400) : null, str(b.body, 200000), int(b.minutes), flag(b.published ?? 1), n!.n).run();
    await audit(c.env, c.user!.email, 'lesson_created', id, c.ip);
    return json({ id });
  }],
  ['PUT', '/api/admin/lessons/:id', A, async (c) => {
    const b = await c.body();
    const kind = ['note', 'video', 'link'].includes(b.kind) ? b.kind : 'note';
    const vid = kind === 'video' ? ytVideoId(str(b.video_id, 300)) : null;
    if (kind === 'video' && !vid) fail(400, 'Enter a valid YouTube video URL or ID.');
    await c.env.DB.prepare(`UPDATE lessons SET module_id=?,title=?,kind=?,video_id=?,url=?,body=?,minutes=?,published=?,updated_at=datetime('now') WHERE id=?`)
      .bind(str(b.module_id, 80) || null, str(b.title, 200), kind, vid, /^https:\/\//.test(str(b.url, 400)) ? str(b.url, 400) : null, str(b.body, 200000), int(b.minutes), flag(b.published), c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/lessons/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM lessons WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- Quizzes + questions ----------
  ['GET', '/api/admin/quizzes/:id', A, async (c) => {
    const q = await c.env.DB.prepare(`SELECT * FROM quizzes WHERE id=?`).bind(c.params[0]).first();
    if (!q) fail(404, 'Not found.');
    const qs = await c.env.DB.prepare(`SELECT * FROM questions WHERE quiz_id=? ORDER BY sort`).bind(c.params[0]).all<any>();
    return json({ quiz: q, questions: qs.results.map((x) => ({ ...x, options: JSON.parse(x.options) })) });
  }],
  ['POST', '/api/admin/quizzes', A, async (c) => {
    const b = await c.body();
    const id = newId(10);
    await c.env.DB.prepare(`INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,published,sort) VALUES (?,?,?,?,?,?,?,?,?,999)`)
      .bind(id, str(b.course_id, 80), str(b.module_id, 80) || null, str(b.title, 160) || 'New quiz', int(b.minutes, 30), int(b.pass_pct, 60), Number(b.negative) || 0, flag(b.is_exam), flag(b.published ?? 1)).run();
    return json({ id });
  }],
  ['PUT', '/api/admin/quizzes/:id', A, async (c) => {
    const b = await c.body();
    await c.env.DB.prepare(`UPDATE quizzes SET module_id=?,title=?,minutes=?,pass_pct=?,negative=?,is_exam=?,published=? WHERE id=?`)
      .bind(str(b.module_id, 80) || null, str(b.title, 160), int(b.minutes, 30), Math.min(100, Math.max(1, int(b.pass_pct, 60))), Number(b.negative) || 0, flag(b.is_exam), flag(b.published), c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/quizzes/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM quizzes WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],
  ['POST', '/api/admin/quizzes/:id/questions', A, async (c) => {
    // Accepts one question or {questions:[...]} for bulk import.
    const b = await c.body();
    const list: any[] = Array.isArray(b.questions) ? b.questions.slice(0, 500) : [b];
    const n = await c.env.DB.prepare(`SELECT COALESCE(MAX(sort),-1)+1 n FROM questions WHERE quiz_id=?`).bind(c.params[0]).first<{ n: number }>();
    let sort = n!.n, added = 0;
    const stmts: D1PreparedStatement[] = [];
    for (const q of list) {
      const opts = Array.isArray(q.options) ? q.options.map((o: unknown) => str(o, 400)).filter(Boolean).slice(0, 6) : [];
      const ans = int(q.answer, -1);
      if (!str(q.question, 1200) || opts.length < 2 || ans < 0 || ans >= opts.length) continue;
      stmts.push(c.env.DB.prepare(`INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES (?,?,?,?,?,?,?)`).bind(newId(12), c.params[0], str(q.question, 1200), JSON.stringify(opts), ans, str(q.explanation, 2000), sort++));
      added++;
    }
    if (stmts.length) await c.env.DB.batch(stmts);
    if (!added) fail(400, 'No valid questions found. Each needs text, 2+ options and a correct answer index.');
    return json({ added });
  }],
  ['PUT', '/api/admin/questions/:id', A, async (c) => {
    const b = await c.body();
    const opts = Array.isArray(b.options) ? b.options.map((o: unknown) => str(o, 400)).filter(Boolean).slice(0, 6) : [];
    const ans = int(b.answer, -1);
    if (!str(b.question, 1200) || opts.length < 2 || ans < 0 || ans >= opts.length) fail(400, 'Question needs text, 2+ options and a valid correct answer.');
    await c.env.DB.prepare(`UPDATE questions SET question=?,options=?,answer=?,explanation=? WHERE id=?`).bind(str(b.question, 1200), JSON.stringify(opts), ans, str(b.explanation, 2000), c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/questions/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM questions WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- News / bulletins ----------
  ['GET', '/api/admin/news', A, async (c) => json({ news: (await c.env.DB.prepare(`SELECT * FROM news ORDER BY published_at DESC LIMIT 300`).all()).results })],
  ['POST', '/api/admin/news', A, async (c) => {
    const b = await c.body();
    const title = str(b.title, 200);
    if (!title) fail(400, 'Title is required.');
    const url = /^https:\/\//.test(str(b.url, 400)) ? str(b.url, 400) : null;
    await c.env.DB.prepare(`INSERT INTO news (id,title,body,category,url,pinned,published) VALUES (?,?,?,?,?,?,?)`).bind(newId(10), title, str(b.body, 5000), str(b.category, 30) || 'Update', url, flag(b.pinned), flag(b.published ?? 1)).run();
    await audit(c.env, c.user!.email, 'news_posted', title, c.ip);
    return json({ ok: true });
  }],
  ['PUT', '/api/admin/news/:id', A, async (c) => {
    const b = await c.body();
    const url = /^https:\/\//.test(str(b.url, 400)) ? str(b.url, 400) : null;
    await c.env.DB.prepare(`UPDATE news SET title=?,body=?,category=?,url=?,pinned=?,published=? WHERE id=?`).bind(str(b.title, 200), str(b.body, 5000), str(b.category, 30) || 'Update', url, flag(b.pinned), flag(b.published), c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/news/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM news WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- Learner feedback & contact messages ----------
  ['GET', '/api/admin/feedback', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT * FROM feedback ORDER BY created_at DESC LIMIT 500`).all();
    return json({ items: r.results });
  }],
  ['PUT', '/api/admin/feedback/:id', A, async (c) => {
    const b = await c.body();
    const status = b.status === 'reviewed' ? 'reviewed' : 'new';
    await c.env.DB.prepare(`UPDATE feedback SET status=? WHERE id=?`).bind(status, c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/feedback/:id', OWNER, async (c) => {
    await c.env.DB.prepare(`DELETE FROM feedback WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- FAQs ----------
  ['GET', '/api/admin/faqs', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT * FROM faqs ORDER BY sort, id`).all();
    return json({ faqs: r.results });
  }],
  ['POST', '/api/admin/faqs', A, async (c) => {
    const b = await c.body();
    const question = str(b.question, 600), answer = str(b.answer, 4000);
    if (!question || !answer) fail(400, 'Question and answer are required.');
    const n = await c.env.DB.prepare(`SELECT COALESCE(MAX(sort),0)+1 n FROM faqs`).first<{ n: number }>();
    const id = 'faq-' + newId(8);
    await c.env.DB.prepare(`INSERT INTO faqs (id,category,section,question,answer,sort) VALUES (?,?,?,?,?,?)`)
      .bind(id, str(b.category, 60) || 'Mutual Funds', str(b.section, 100) || 'General', question, answer, n!.n).run();
    await audit(c.env, c.user!.email, 'faq_created', question.slice(0, 80), c.ip);
    return json({ id });
  }],
  ['PUT', '/api/admin/faqs/:id', A, async (c) => {
    const b = await c.body();
    const question = str(b.question, 600), answer = str(b.answer, 4000);
    if (!question || !answer) fail(400, 'Question and answer are required.');
    await c.env.DB.prepare(`UPDATE faqs SET category=?,section=?,question=?,answer=?,updated_at=datetime('now') WHERE id=?`)
      .bind(str(b.category, 60) || 'Mutual Funds', str(b.section, 100) || 'General', question, answer, c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/faqs/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM faqs WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- Push Notifications ----------
  ['GET', '/api/admin/notifications', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT * FROM notifications ORDER BY created_at DESC LIMIT 100`).all();
    return json({ notifications: r.results });
  }],
  ['POST', '/api/admin/notifications', A, async (c) => {
    const b = await c.body();
    const title = str(b.title, 160);
    if (!title) fail(400, 'Notification title is required.');
    const body = str(b.body, 2000) || null;
    const link = str(b.link, 200) || null;
    const target = str(b.team, 60) || '__ALL__';
    const userId = str(b.userId, 40) || null;
    const id = newId(12);
    await c.env.DB.prepare(`INSERT INTO notifications (id,user_id,team,title,body,link,is_read) VALUES (?,?,?,?,?,?,0)`)
      .bind(id, userId, userId ? null : target, title, body, link).run();
    await audit(c.env, c.user!.email, 'notification_pushed', `${userId || target}: ${title}`, c.ip);
    return json({ ok: true, id });
  }],
  ['DELETE', '/api/admin/notifications/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM notifications WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- System Settings (Certificate Branding, Banner, Scheduled NISM) ----------
  ['GET', '/api/admin/settings', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT key,value,updated_at FROM system_settings`).all<{ key: string; value: string; updated_at: string }>();
    const out: Record<string, any> = {};
    for (const row of r.results) {
      try { out[row.key] = JSON.parse(row.value); } catch { out[row.key] = row.value; }
    }
    return json({ settings: out });
  }],
  ['PUT', '/api/admin/settings/:key', OWNER, async (c) => {
    const key = c.params[0];
    if (!['cert_branding', 'banner', 'nism_schedule'].includes(key)) fail(400, 'Unknown setting key.');
    const b = await c.body();
    await c.env.DB.prepare(
      `INSERT INTO system_settings (key,value,updated_at) VALUES (?,?,datetime('now')) ON CONFLICT(key) DO UPDATE SET value=excluded.value, updated_at=datetime('now')`,
    ).bind(key, JSON.stringify(b)).run();
    await audit(c.env, c.user!.email, 'setting_updated', key, c.ip);
    return json({ ok: true });
  }],

  // ---------- Session & Device Monitor ----------
  ['GET', '/api/admin/sessions', OWNER, async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT s.token_hash,s.user_id,s.kind,s.ip,s.ua,s.created_at,s.expires_at,u.email,u.name,u.role,u.team
         FROM sessions s JOIN users u ON u.id=s.user_id
        WHERE s.expires_at > ?
        ORDER BY s.created_at DESC LIMIT 300`,
    ).bind(new Date().toISOString()).all();
    return json({ sessions: r.results });
  }],
  ['DELETE', '/api/admin/sessions/user/:userId', OWNER, async (c) => {
    await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'sessions_revoked_user', c.params[0], c.ip);
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/sessions/:tokenHash', OWNER, async (c) => {
    await c.env.DB.prepare(`DELETE FROM sessions WHERE token_hash=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'session_revoked', c.params[0].slice(0, 12), c.ip);
    return json({ ok: true });
  }],

  // ---------- "What Changed" Regulatory & Product Change Log ----------
  ['GET', '/api/admin/changelog', A, async (c) => {
    const r = await c.env.DB.prepare(`SELECT * FROM regulatory_changes ORDER BY effective_date DESC, created_at DESC`).all();
    return json({ items: r.results });
  }],
  ['POST', '/api/admin/changelog', A, async (c) => {
    const b = await c.body();
    const title = str(b.title, 200), oldRule = str(b.old_rule, 2000), newRule = str(b.new_rule, 2000);
    if (!title || !oldRule || !newRule) fail(400, 'Title, Old Rule, and New Rule are required.');
    const id = 'rc-' + newId(8);
    await c.env.DB.prepare(
      `INSERT INTO regulatory_changes (id,category,title,effective_date,old_rule,new_rule,impact,published) VALUES (?,?,?,?,?,?,?,?)`,
    ).bind(id, str(b.category, 50) || 'Regulatory', title, str(b.effective_date, 20) || new Date().toISOString().slice(0, 10), oldRule, newRule, str(b.impact, 1000) || null, flag(b.published ?? 1)).run();
    await audit(c.env, c.user!.email, 'changelog_created', title, c.ip);
    return json({ ok: true, id });
  }],
  ['PUT', '/api/admin/changelog/:id', A, async (c) => {
    const b = await c.body();
    await c.env.DB.prepare(
      `UPDATE regulatory_changes SET category=?,title=?,effective_date=?,old_rule=?,new_rule=?,impact=?,published=? WHERE id=?`,
    ).bind(str(b.category, 50) || 'Regulatory', str(b.title, 200), str(b.effective_date, 20), str(b.old_rule, 2000), str(b.new_rule, 2000), str(b.impact, 1000) || null, flag(b.published ?? 1), c.params[0]).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/changelog/:id', A, async (c) => {
    await c.env.DB.prepare(`DELETE FROM regulatory_changes WHERE id=?`).bind(c.params[0]).run();
    return json({ ok: true });
  }],

  // ---------- NISM Compliance Email Relay (Resend or Apps Script Webhook fallback) ----------
  ['POST', '/api/admin/nism-send-mail', A, async (c) => {
    const b = await c.body();
    const rawTo = str(b.to, 500);
    const recipients = rawTo.split(/[,;]+/).map((s) => s.trim().toLowerCase()).filter(Boolean);
    if (!recipients.length || recipients.some((e) => !isEmail(e))) fail(400, 'Enter valid recipient email address(es).');
    const subject = str(b.subject, 240);
    const htmlBody = typeof b.htmlBody === 'string' ? b.htmlBody.slice(0, 400_000) : '';
    const plainBody = typeof b.plainBody === 'string' ? b.plainBody.slice(0, 100_000) : '';
    if (!subject || (!htmlBody && !plainBody)) fail(400, 'Subject and email content are required.');

    if (c.env.RESEND_API_KEY) {
      const from = c.env.MAIL_FROM || 'FundsIndia Compliance <onboarding@resend.dev>';
      const r = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: { Authorization: `Bearer ${c.env.RESEND_API_KEY}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ from, to: recipients, subject, html: htmlBody || undefined, text: plainBody || undefined }),
      });
      if (!r.ok) {
        const errText = await r.text().catch(() => '');
        fail(502, `Resend mail delivery failed (${r.status}): ${errText.slice(0, 300)}`);
      }
      await audit(c.env, c.user!.email, 'nism_audit_mail_sent', `via=resend to=${recipients.join(',')}`, c.ip);
      return json({ ok: true, via: 'resend', to: recipients });
    }

    let webhookUrl = str(b.webhookUrl, 500);
    if (!webhookUrl) {
      const row = await c.env.DB.prepare(`SELECT value FROM system_settings WHERE key='nism_schedule'`).first<{ value: string }>();
      if (row?.value) {
        try { webhookUrl = str(JSON.parse(row.value)?.webhookUrl, 500); } catch { /* ignore */ }
      }
    }
    if (!webhookUrl) fail(400, 'No mail webhook configured. Enable Gmail API in Google Cloud Console or configure an Apps Script Mail Webhook.');
    let parsedUrl: URL;
    try { parsedUrl = new URL(webhookUrl); } catch { return fail(400, 'Invalid webhook URL.'); }
    if (parsedUrl.protocol !== 'https:' || /^(localhost|127\.|10\.|192\.168\.|172\.(1[6-9]|2\d|3[01])\.|169\.254\.)/i.test(parsedUrl.hostname)) {
      fail(400, 'Webhook URL must be a public https:// endpoint.');
    }

    const wr = await fetch(parsedUrl.toString(), {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        event: 'nism_audit_email',
        to: recipients.join(', '),
        subject,
        htmlBody,
        plainBody,
        actionedBy: c.user!.email,
        timestamp: new Date().toISOString(),
      }),
    });
    if (!wr.ok) {
      const errText = await wr.text().catch(() => '');
      fail(502, `Webhook mail delivery failed (${wr.status}): ${errText.slice(0, 300)}`);
    }
    await audit(c.env, c.user!.email, 'nism_audit_mail_sent', `via=webhook to=${recipients.join(',')}`, c.ip);
    return json({ ok: true, via: 'webhook', to: recipients });
  }],
];
