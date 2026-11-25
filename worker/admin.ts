import { Ctx, audit, fail, flag, int, isEmail, json, newId, slugify, str } from './lib';
import { hashPassword, passwordProblem, randomToken } from './security';
import type { Route } from './router';
import { fetchPlaylist, oembed } from './youtube';
import { TEAMS, isTeam } from './teams';

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
      const role = ['learner', 'trainer', 'admin'].includes(r.role) ? r.role : 'learner';
      if (role === 'admin' && c.user!.role !== 'admin') continue;
      const temp = randomToken(9) + 'Aa1'; // shown once to the admin, learner must change on first login
      try {
        await c.env.DB.prepare(`INSERT INTO users (id,email,name,emp_id,department,team,role,status,pw_hash,must_change) VALUES (?,?,?,?,?,?,?,'active',?,1)`)
          .bind(newId(12), email, name, str(r.empId, 30) || null, str(r.department, 60) || null, isTeam(r.team) ? r.team : null, role, await hashPassword(temp)).run();
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
    const role = ['learner', 'trainer', 'admin'].includes(b.role) ? b.role : cur.role;
    const status = ['active', 'pending', 'suspended'].includes(b.status) ? b.status : cur.status;
    const team = b.team === undefined ? cur.team : isTeam(b.team) ? b.team : null;
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
  // ---------- Teams: which courses each team can open ----------
  ['GET', '/api/admin/teams', OWNER, async (c) => {
    const db = c.env.DB;
    const [rows, courses, counts] = await Promise.all([
      db.prepare(`SELECT team, course_id FROM team_access`).all<{ team: string; course_id: string }>(),
      db.prepare(`SELECT id, code, title, category FROM courses ORDER BY sort, title`).all(),
      db.prepare(`SELECT team, COUNT(*) n FROM users WHERE role='learner' AND team IS NOT NULL GROUP BY team`).all<{ team: string; n: number }>(),
    ]);
    const n = new Map(counts.results.map((x) => [x.team, x.n]));
    const unassigned = await db.prepare(`SELECT COUNT(*) n FROM users WHERE role='learner' AND team IS NULL`).first<{ n: number }>();
    return json({
      teams: TEAMS.map((t) => ({ name: t, learners: n.get(t) || 0, courses: rows.results.filter((r) => r.team === t).map((r) => r.course_id) })),
      courses: courses.results,
      unassigned: unassigned?.n || 0,
    });
  }],
  ['PUT', '/api/admin/teams/:team', OWNER, async (c) => {
    const team = c.params[0];
    if (!isTeam(team)) fail(404, 'Unknown team.');
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
  ['GET', '/api/admin/audit', OWNER, async (c) => {
    const r = await c.env.DB.prepare(`SELECT id,actor,action,detail,ip,created_at FROM audit_log ORDER BY id DESC LIMIT 300`).all();
    return json({ log: r.results });
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
      db.prepare(`SELECT ce.id,c.title,ce.pct,ce.issued_at FROM certificates ce JOIN courses c ON c.id=ce.course_id WHERE ce.user_id=?`).bind(id).all(),
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
];
