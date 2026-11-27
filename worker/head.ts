import { Ctx, audit, fail, isEmail, json, newId, str } from './lib';
import { hashPassword, randomToken } from './security';
import type { Route } from './router';
import { allowedCourses, onlyAllowed } from './teams';

const H = 'head' as const;

function requireHeadTeam(c: Ctx): string {
  const u = c.user!;
  if (!u.team) fail(403, 'No team assigned to your Head account. Contact your administrator.');
  return u.team!;
}

export const headRoutes: Route[] = [
  // ---------- View content (only courses Admin granted to this Head's team) ----------
  ['GET', '/api/head/courses', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const o = onlyAllowed(await allowedCourses({ ...c, user: { ...c.user!, role: 'learner', team } }), 'c.id');
    const r = await c.env.DB.prepare(
      `SELECT c.id,c.code,c.title,c.subtitle,c.category,c.level,c.popular,
              (SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) AS lessons,
              (SELECT COUNT(*) FROM quizzes q WHERE q.course_id=c.id AND q.published=1) AS quizzes
         FROM courses c WHERE c.published=1${o.sql} ORDER BY c.sort, c.title`,
    ).bind(...o.args).all();
    return json({ courses: r.results });
  }],
  ['GET', '/api/head/courses/:id', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const allowed = await allowedCourses({ ...c, user: { ...c.user!, role: 'learner', team } });
    const id = c.params[0], db = c.env.DB;
    if (allowed && !allowed.has(id)) fail(404, 'Course not found.');
    const course = await db.prepare(`SELECT * FROM courses WHERE id=? AND published=1`).bind(id).first<any>();
    if (!course) return fail(404, 'Course not found.');
    const [m, l, q] = await Promise.all([
      db.prepare(`SELECT id,title,weight,sort FROM modules WHERE course_id=? ORDER BY sort`).bind(id).all(),
      db.prepare(`SELECT id,module_id,title,kind,minutes,author,sort FROM lessons WHERE course_id=? AND published=1 ORDER BY sort`).bind(id).all(),
      db.prepare(`SELECT q.id,q.title,q.minutes,q.pass_pct,q.is_exam,q.mock,(SELECT COUNT(*) FROM questions x WHERE x.quiz_id=q.id) AS questions FROM quizzes q WHERE q.course_id=? AND q.published=1 ORDER BY q.sort`).bind(id).all(),
    ]);
    return json({ course: { ...course, links: JSON.parse(course.links || '[]') }, modules: m.results, lessons: l.results, quizzes: q.results });
  }],
  ['GET', '/api/head/lessons/:id', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const l = await c.env.DB.prepare(`SELECT * FROM lessons WHERE id=? AND published=1`).bind(c.params[0]).first<any>();
    if (!l) return fail(404, 'Lesson not found.');
    const allowed = await allowedCourses({ ...c, user: { ...c.user!, role: 'learner', team } });
    if (allowed && !allowed.has(l.course_id)) fail(404, 'Lesson not found.');
    return json({ lesson: l });
  }],

  // ---------- My Team (read-only: Admin decides team & course access) ----------
  ['GET', '/api/head/teams', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const db = c.env.DB;
    const [teamRow, rows, courses, cnt] = await Promise.all([
      db.prepare(`SELECT name, description, full_access FROM teams WHERE name=?`).bind(team).first<{ name: string; description: string | null; full_access: number }>(),
      db.prepare(`SELECT course_id FROM team_access WHERE team=?`).bind(team).all<{ course_id: string }>(),
      db.prepare(`SELECT id, code, title, category FROM courses WHERE published=1 ORDER BY sort, title`).all(),
      db.prepare(`SELECT COUNT(*) n FROM users WHERE role='learner' AND team=?`).bind(team).first<{ n: number }>(),
    ]);
    const full = !!teamRow?.full_access;
    return json({
      teams: [{
        name: team,
        description: teamRow?.description || '',
        learners: cnt?.n || 0,
        full,
        courses: full ? courses.results.map((x: any) => x.id) : rows.results.map((r) => r.course_id),
      }],
      courses: courses.results,
      unassigned: 0,
    });
  }],
  ['POST', '/api/head/teams', H, () => fail(403, 'Only administrators can create teams.')],
  ['PUT', '/api/head/teams/:team', H, () => fail(403, 'Only administrators decide team course access.')],

  // ---------- People & team management (strictly scoped to Head's 1 team) ----------
  ['GET', '/api/head/users', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const r = await c.env.DB.prepare(
      `SELECT u.id,u.email,u.name,u.emp_id,u.department,u.team,u.role,u.status,u.must_change,u.created_at,u.last_login,
              (SELECT COUNT(*) FROM progress p WHERE p.user_id=u.id) lessons,
              (SELECT ROUND(AVG(pct),1) FROM attempts a WHERE a.user_id=u.id) avg_score,
              (SELECT COUNT(*) FROM certificates ce WHERE ce.user_id=u.id AND ce.revoked=0) certs
         FROM users u WHERE u.role='learner' AND u.team=? ORDER BY u.created_at DESC LIMIT 2000`,
    ).bind(team).all();
    return json({ users: r.results });
  }],
  ['POST', '/api/head/users', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const b = await c.body();
    const rows = Array.isArray(b.users) ? b.users.slice(0, 500) : [b];
    const created: { email: string; password: string }[] = [], skipped: string[] = [];
    for (const r of rows as any[]) {
      const email = str(r.email, 120).toLowerCase(), name = str(r.name, 80);
      if (!isEmail(email) || name.length < 2) { skipped.push(email || '(blank)'); continue; }
      const temp = randomToken(9) + 'Aa1';
      try {
        await c.env.DB.prepare(`INSERT INTO users (id,email,name,emp_id,department,team,role,status,pw_hash,must_change) VALUES (?,?,?,?,?,?,'learner','active',?,1)`)
          .bind(newId(12), email, name, str(r.empId, 30) || null, str(r.department, 60) || null, team, await hashPassword(temp)).run();
        created.push({ email, password: temp });
      } catch { skipped.push(email); }
    }
    await audit(c.env, c.user!.email, 'head_users_created', `${team}: ${created.length} created, ${skipped.length} skipped`, c.ip);
    return json({ created, skipped });
  }],
  ['PUT', '/api/head/users/:id', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const b = await c.body();
    const id = c.params[0];
    const cur = await c.env.DB.prepare(`SELECT role,status,team FROM users WHERE id=?`).bind(id).first<any>();
    if (!cur) return fail(404, 'User not found.');
    if (cur.role !== 'learner' || cur.team !== team) fail(403, `You can only manage learners in ${team}.`);
    const status = ['active', 'pending', 'suspended'].includes(b.status) ? b.status : cur.status;
    try {
      await c.env.DB.prepare(`UPDATE users SET name=COALESCE(NULLIF(?,''),name), emp_id=?, department=?, status=? WHERE id=?`)
        .bind(str(b.name, 80), str(b.empId, 30) || null, str(b.department, 60) || null, status, id).run();
    } catch { fail(409, 'That User ID is already used by another account.'); }
    if (status !== 'active') await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id=?`).bind(id).run();
    await audit(c.env, c.user!.email, 'head_user_updated', `${id} (${team}) status=${status}`, c.ip);
    return json({ ok: true });
  }],
  ['POST', '/api/head/users/:id/reset', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const cur = await c.env.DB.prepare(`SELECT role,team FROM users WHERE id=?`).bind(c.params[0]).first<{ role: string; team: string | null }>();
    if (!cur) return fail(404, 'User not found.');
    if (cur.role !== 'learner' || cur.team !== team) fail(403, `You can only reset passwords for learners in ${team}.`);
    const temp = randomToken(9) + 'Aa1';
    await c.env.DB.prepare(`UPDATE users SET pw_hash=?, must_change=1 WHERE id=?`).bind(await hashPassword(temp), c.params[0]).run();
    await c.env.DB.prepare(`DELETE FROM sessions WHERE user_id=?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'head_password_reset', c.params[0], c.ip);
    return json({ password: temp });
  }],
  ['GET', '/api/head/users/:id/progress', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const db = c.env.DB, id = c.params[0];
    const u = await db.prepare(`SELECT role,team FROM users WHERE id=?`).bind(id).first<{ role: string; team: string | null }>();
    if (!u || u.role !== 'learner' || u.team !== team) fail(403, `You can only view progress for learners in ${team}.`);
    const [courses, attempts, certs] = await Promise.all([
      db.prepare(`SELECT c.title,c.code,COUNT(p.lesson_id) done,(SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) total, MAX(p.completed_at) last FROM progress p JOIN courses c ON c.id=p.course_id WHERE p.user_id=? GROUP BY c.id ORDER BY last DESC`).bind(id).all(),
      db.prepare(`SELECT q.title,a.pct,a.passed,a.created_at FROM attempts a JOIN quizzes q ON q.id=a.quiz_id WHERE a.user_id=? ORDER BY a.created_at DESC LIMIT 30`).bind(id).all(),
      db.prepare(`SELECT ce.id,c.title,ce.pct,ce.issued_at FROM certificates ce JOIN courses c ON c.id=ce.course_id WHERE ce.user_id=?`).bind(id).all(),
    ]);
    return json({ courses: courses.results, attempts: attempts.results, certificates: certs.results });
  }],

  // ---------- Team Compliance Matrix, Assignments & Analytics (strictly Head's team) ----------
  ['GET', '/api/head/matrix', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const db = c.env.DB;
    const o = onlyAllowed(await allowedCourses({ ...c, user: { ...c.user!, role: 'learner', team } }), 'c.id');
    const [users, courses, prog] = await Promise.all([
      db.prepare(`SELECT id,name,email,emp_id,team FROM users WHERE role='learner' AND status='active' AND team=? ORDER BY name LIMIT 300`).bind(team).all(),
      db.prepare(`SELECT id,code,title,(SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) AS total FROM courses c WHERE c.published=1${o.sql} ORDER BY c.sort, c.title`).bind(...o.args).all(),
      db.prepare(`SELECT p.user_id,p.course_id,COUNT(*) AS done FROM progress p JOIN users u ON u.id=p.user_id WHERE u.team=? GROUP BY p.user_id,p.course_id`).bind(team).all(),
    ]);
    return json({ users: users.results, courses: courses.results, progress: prog.results });
  }],
  ['GET', '/api/head/analytics', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const db = c.env.DB;
    const [byTeam, weak] = await Promise.all([
      db.prepare(`SELECT u.team, COUNT(DISTINCT u.id) AS learners, COUNT(a.id) AS attempts, ROUND(AVG(a.pct),1) AS avg_score FROM users u LEFT JOIN attempts a ON a.user_id=u.id WHERE u.role='learner' AND u.team=? GROUP BY u.team`).bind(team).all(),
      db.prepare(`SELECT q.title, COUNT(*) AS tries, ROUND(AVG(a.pct),1) AS avg FROM attempts a JOIN users u ON u.id=a.user_id JOIN quizzes q ON q.id=a.quiz_id WHERE u.team=? GROUP BY q.id HAVING tries>=1 ORDER BY avg ASC LIMIT 10`).bind(team).all(),
    ]);
    return json({ byTeam: byTeam.results, weakQuizzes: weak.results });
  }],
  ['GET', '/api/head/assignments', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const r = await c.env.DB.prepare(`SELECT * FROM assignments WHERE team=? ORDER BY due_date ASC LIMIT 200`).bind(team).all();
    return json({ assignments: r.results });
  }],
  ['POST', '/api/head/assignments', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    const b = await c.body();
    const targetKind = b.targetKind === 'path' ? 'path' : 'course';
    const targetId = str(b.targetId, 80);
    const dueDate = str(b.dueDate, 20);
    if (!targetId || !dueDate) fail(400, 'Select a course/path and due date.');
    const row = targetKind === 'path'
      ? await c.env.DB.prepare(`SELECT title FROM paths WHERE id=?`).bind(targetId).first<{ title: string }>()
      : await c.env.DB.prepare(`SELECT title FROM courses WHERE id=?`).bind(targetId).first<{ title: string }>();
    if (!row) return fail(404, 'Course or path not found.');
    const id = newId(12);
    await c.env.DB.batch([
      c.env.DB.prepare(`INSERT INTO assignments (id,team,target_kind,target_id,title,due_date,assigned_by) VALUES (?,?,?,?,?,?,?)`).bind(id, team, targetKind, targetId, row.title, dueDate, c.user!.email),
      c.env.DB.prepare(`INSERT INTO notifications (id,team,title,body,link) VALUES (?,?,?,?,?)`).bind(newId(12), team, `New deadline: ${row.title}`, `Due by ${dueDate} (assigned by ${c.user!.name})`, targetKind === 'path' ? `/paths/${targetId}` : `/courses/${targetId}`),
    ]);
    await audit(c.env, c.user!.email, 'assignment_created', `${team}: ${row.title} (due ${dueDate})`, c.ip);
    return json({ ok: true, id });
  }],
  ['DELETE', '/api/head/assignments/:id', H, async (c: Ctx) => {
    const team = requireHeadTeam(c);
    await c.env.DB.prepare(`DELETE FROM assignments WHERE id=? AND team=?`).bind(c.params[0], team).run();
    return json({ ok: true });
  }],
];
