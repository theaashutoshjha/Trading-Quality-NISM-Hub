import { Ctx, fail, flag, int, json, newId, str } from './lib';
import { loadFeeds } from './feeds';
import type { Route } from './router';
import { allowedCourses, onlyAllowed } from './teams';

const parseCourse = (c: any) => ({ ...c, links: JSON.parse(c.links || '[]') });

const shuffle = <T,>(a: T[]) => {
  const x = [...a];
  for (let i = x.length - 1; i > 0; i--) {
    const j = crypto.getRandomValues(new Uint32Array(1))[0] % (i + 1);
    [x[i], x[j]] = [x[j], x[i]];
  }
  return x;
};

async function courseList(c: Ctx) {
  const o = onlyAllowed(await allowedCourses(c), 'c.id');
  const r = await c.env.DB.prepare(
    `SELECT c.id,c.code,c.title,c.subtitle,c.category,c.description,c.level,c.hours,c.popular,
       (SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) AS lesson_count,
       (SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1 AND l.kind='video') AS video_count,
       (SELECT COUNT(*) FROM progress p JOIN lessons l ON l.id=p.lesson_id AND l.published=1 WHERE p.user_id=? AND p.course_id=c.id) AS done,
       (SELECT COUNT(*) FROM quizzes q WHERE q.course_id=c.id AND q.published=1) AS quiz_count
     FROM courses c WHERE c.published=1${o.sql} ORDER BY c.sort, c.title`,
  ).bind(c.user!.id, ...o.args).all<any>();
  return json({ courses: r.results });
}

async function courseDetail(c: Ctx) {
  const id = c.params[0];
  const db = c.env.DB, uid = c.user!.id;
  const course = await db.prepare(`SELECT * FROM courses WHERE id=? AND published=1`).bind(id).first<any>();
  if (!course) fail(404, 'Course not found.');
  const allowedC = await allowedCourses(c);
  if (allowedC && !allowedC.has(id)) fail(404, 'Course not found.');
  const [mods, lessons, quizzes, done, best, cert, vp] = await Promise.all([
    db.prepare(`SELECT id,title,weight,sort FROM modules WHERE course_id=? ORDER BY sort`).bind(id).all(),
    db.prepare(`SELECT id,module_id,title,kind,minutes,author,sort FROM lessons WHERE course_id=? AND published=1 ORDER BY sort`).bind(id).all(),
    db.prepare(`SELECT q.id,q.module_id,q.title,q.minutes,q.pass_pct,q.negative,q.is_exam,q.mock,(SELECT COUNT(*) FROM questions x WHERE x.quiz_id=q.id) AS questions FROM quizzes q WHERE q.course_id=? AND q.published=1 ORDER BY q.sort`).bind(id).all(),
    db.prepare(`SELECT lesson_id FROM progress WHERE user_id=? AND course_id=?`).bind(uid, id).all<{ lesson_id: string }>(),
    db.prepare(`SELECT quiz_id, MAX(pct) AS best, COUNT(*) AS tries FROM attempts WHERE user_id=? AND course_id=? GROUP BY quiz_id`).bind(uid, id).all(),
    db.prepare(`SELECT id,pct,issued_at FROM certificates WHERE user_id=? AND course_id=? AND revoked=0`).bind(uid, id).first(),
    db.prepare(`SELECT vp.lesson_id, vp.seconds, vp.duration FROM video_progress vp JOIN lessons l ON l.id=vp.lesson_id WHERE vp.user_id=? AND l.course_id=?`).bind(uid, id).all(),
  ]);
  return json({
    course: parseCourse(course),
    modules: mods.results,
    lessons: lessons.results,
    quizzes: quizzes.results,
    done: done.results.map((d) => d.lesson_id),
    best: best.results,
    certificate: cert || null,
    watching: vp.results,
  });
}

async function lessonDetail(c: Ctx) {
  const db = c.env.DB, uid = c.user!.id;
  const l = await db.prepare(`SELECT * FROM lessons WHERE id=? AND published=1`).bind(c.params[0]).first<any>();
  if (!l) fail(404, 'Lesson not found.');
  const allowedL = await allowedCourses(c);
  if (allowedL && !allowedL.has(l.course_id)) fail(404, 'Lesson not found.');
  const pathId = str(c.url.searchParams.get('path'), 80);
  // Navigation order: the learning path being followed, otherwise the course order.
  const sibs = pathId
    ? await db.prepare(`SELECT l.id,l.title,l.kind,l.course_id FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 WHERE i.path_id=? ORDER BY i.sort`).bind(pathId).all<{ id: string; title: string; kind: string; course_id: string }>()
    : await db.prepare(`SELECT id,title,kind FROM lessons WHERE course_id=? AND published=1 ORDER BY sort`).bind(l.course_id).all<{ id: string; title: string; kind: string }>();
  if (allowedL) sibs.results = sibs.results.filter((s: any) => !s.course_id || allowedL.has(s.course_id));
  const i = sibs.results.findIndex((s) => s.id === l.id);
  const [done, course, mod, vp, path] = await Promise.all([
    db.prepare(`SELECT 1 FROM progress WHERE user_id=? AND lesson_id=?`).bind(uid, l.id).first(),
    db.prepare(`SELECT id,title,code,category FROM courses WHERE id=?`).bind(l.course_id).first(),
    l.module_id ? db.prepare(`SELECT id,title FROM modules WHERE id=?`).bind(l.module_id).first() : null,
    db.prepare(`SELECT seconds,duration FROM video_progress WHERE user_id=? AND lesson_id=?`).bind(uid, l.id).first<{ seconds: number; duration: number }>(),
    pathId ? db.prepare(`SELECT id,title FROM paths WHERE id=?`).bind(pathId).first() : null,
  ]);
  return json({
    lesson: l, completed: !!done, course, module: mod, path,
    resume: vp && vp.duration && vp.seconds < vp.duration - 15 ? vp.seconds : 0,
    prev: sibs.results[i - 1] || null, next: sibs.results[i + 1] || null, position: i + 1, total: sibs.results.length,
  });
}

async function startQuiz(c: Ctx) {
  const db = c.env.DB;
  const q = await db.prepare(`SELECT * FROM quizzes WHERE id=? AND published=1`).bind(c.params[0]).first<any>();
  if (!q) fail(404, 'Quiz not found.');
  const allowedQ = await allowedCourses(c);
  if (allowedQ && !allowedQ.has(q.course_id)) fail(404, 'Quiz not found.');
  const rows = await db.prepare(`SELECT id,question,options FROM questions WHERE quiz_id=?`).bind(q.id).all<any>();
  if (!rows.results.length) fail(404, 'This quiz has no questions yet.');
  // Mock tests are fixed full-length papers: every question is served (in random order), so a mock is always the full paper.
  const limit = q.mock ? rows.results.length : Math.min(int(c.url.searchParams.get('n'), 0) || (q.is_exam ? 50 : 30), 100);
  const picked = shuffle(rows.results).slice(0, limit);
  const sid = newId(16);
  await db.prepare(`INSERT INTO quiz_sessions (id,user_id,quiz_id,question_ids) VALUES (?,?,?,?)`).bind(sid, c.user!.id, q.id, JSON.stringify(picked.map((p) => p.id))).run();
  return json({
    sessionId: sid,
    quiz: { id: q.id, title: q.title, minutes: q.minutes, pass_pct: q.pass_pct, negative: q.negative, is_exam: q.is_exam, mock: q.mock, course_id: q.course_id },
    questions: picked.map((p) => ({ id: p.id, question: p.question, options: JSON.parse(p.options) })),
  });
}

async function submitQuiz(c: Ctx) {
  const db = c.env.DB, uid = c.user!.id;
  const b = await c.body();
  const s = await db.prepare(`SELECT * FROM quiz_sessions WHERE id=? AND user_id=?`).bind(str(b.sessionId, 40), uid).first<any>();
  if (!s || s.quiz_id !== c.params[0]) fail(404, 'Quiz session not found.');
  if (s.submitted) fail(409, 'This attempt was already submitted.');
  const q = await db.prepare(`SELECT * FROM quizzes WHERE id=?`).bind(s.quiz_id).first<any>();
  const allowedS = await allowedCourses(c);
  if (allowedS && !allowedS.has(q.course_id)) fail(404, 'Quiz not found.');
  const ids: string[] = JSON.parse(s.question_ids);
  const answers: Record<string, number> = typeof b.answers === 'object' && b.answers ? (b.answers as any) : {};
  const qs = await db.prepare(`SELECT id,question,options,answer,explanation FROM questions WHERE id IN (${ids.map(() => '?').join(',')})`).bind(...ids).all<any>();
  const byId = new Map(qs.results.map((x) => [x.id, x]));

  let correct = 0, wrong = 0;
  const review = ids.map((id) => {
    const x = byId.get(id);
    if (!x) return null;
    const given = Number.isInteger(answers[id]) ? answers[id] : -1;
    if (given === x.answer) correct++; else if (given >= 0) wrong++;
    return { id, question: x.question, options: JSON.parse(x.options), answer: x.answer, given, explanation: x.explanation };
  }).filter(Boolean);
  const total = review.length;
  const score = Math.max(0, correct - wrong * q.negative);
  const pct = total ? Math.round((score / total) * 1000) / 10 : 0;
  const passed = pct >= q.pass_pct ? 1 : 0;
  const seconds = Math.max(0, Math.round((Date.now() - new Date(s.started_at + 'Z').getTime()) / 1000));

  const aid = newId(16);
  const statOps: D1PreparedStatement[] = [
    db.prepare(`UPDATE quiz_sessions SET submitted=1 WHERE id=?`).bind(s.id),
    db.prepare(`INSERT INTO attempts (id,user_id,quiz_id,course_id,correct,wrong,total,score,pct,passed,seconds) VALUES (?,?,?,?,?,?,?,?,?,?,?)`).bind(aid, uid, q.id, q.course_id, correct, wrong, total, score, pct, passed, seconds),
  ];
  for (const r of review as any[]) {
    if (!r) continue;
    statOps.push(
      db.prepare(`INSERT INTO question_stats (question_id,total_tries,correct_tries) VALUES (?,1,?) ON CONFLICT(question_id) DO UPDATE SET total_tries=total_tries+1, correct_tries=correct_tries+?`).bind(r.id, r.given === r.answer ? 1 : 0, r.given === r.answer ? 1 : 0),
    );
    if (r.given === r.answer) {
      statOps.push(db.prepare(`DELETE FROM wrong_questions WHERE user_id=? AND question_id=?`).bind(uid, r.id));
    } else if (r.given >= 0) {
      statOps.push(db.prepare(`INSERT INTO wrong_questions (user_id,question_id,quiz_id,updated_at) VALUES (?,?,?,datetime('now')) ON CONFLICT(user_id,question_id) DO UPDATE SET updated_at=datetime('now')`).bind(uid, r.id, q.id));
    }
  }
  await db.batch(statOps);

  let certificate: string | null = null;
  if (passed && q.is_exam) {
    const ex = await db.prepare(`SELECT id FROM certificates WHERE user_id=? AND course_id=? AND revoked=0`).bind(uid, q.course_id).first<{ id: string }>();
    if (ex) certificate = ex.id;
    else {
      certificate = 'FI-' + newId(10).toUpperCase();
      await db.prepare(`INSERT INTO certificates (id,user_id,course_id,quiz_id,pct) VALUES (?,?,?,?,?)`).bind(certificate, uid, q.course_id, q.id, pct).run();
    }
  }
  return json({ result: { correct, wrong, unattempted: total - correct - wrong, total, score, pct, passed: !!passed, seconds, pass_pct: q.pass_pct, negative: q.negative }, review, certificate });
}

async function pathList(c: Ctx) {
  const o = onlyAllowed(await allowedCourses(c), 'l.course_id');
  const r = await c.env.DB.prepare(
    `SELECT p.id,p.title,p.description,p.level,p.icon,
       (SELECT COUNT(*) FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 WHERE i.path_id=p.id${o.sql}) AS total,
       (SELECT COUNT(*) FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 JOIN progress pr ON pr.lesson_id=i.lesson_id AND pr.user_id=? WHERE i.path_id=p.id${o.sql}) AS done,
       (SELECT COALESCE(SUM(l.minutes),0) FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 WHERE i.path_id=p.id${o.sql}) AS minutes
     FROM paths p WHERE p.published=1 ORDER BY p.sort`,
  ).bind(...o.args, c.user!.id, ...o.args, ...o.args).all();
  // A path with nothing this team can open is hidden.
  r.results = (r.results as any[]).filter((p) => p.total > 0);
  return json({ paths: r.results });
}

async function pathDetail(c: Ctx) {
  const db = c.env.DB, uid = c.user!.id;
  const p = await db.prepare(`SELECT id,title,description,level,icon FROM paths WHERE id=? AND published=1`).bind(c.params[0]).first();
  if (!p) fail(404, 'Learning path not found.');
  const oi = onlyAllowed(await allowedCourses(c), 'l.course_id');
  const items = await db.prepare(
    `SELECT l.id,l.title,l.kind,l.minutes,l.author,c.title AS course, m.title AS module,
            CASE WHEN pr.lesson_id IS NULL THEN 0 ELSE 1 END AS done,
            COALESCE(vp.seconds,0) AS seconds, COALESCE(vp.duration,0) AS duration
       FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1
       JOIN courses c ON c.id=l.course_id LEFT JOIN modules m ON m.id=l.module_id
       LEFT JOIN progress pr ON pr.lesson_id=l.id AND pr.user_id=?
       LEFT JOIN video_progress vp ON vp.lesson_id=l.id AND vp.user_id=?
      WHERE i.path_id=?${oi.sql} ORDER BY i.sort`,
  ).bind(uid, uid, c.params[0], ...oi.args).all();
  if (!items.results.length) fail(404, 'Learning path not found.');
  return json({ path: p, items: items.results });
}

function streakOf(days: string[]) {
  const set = new Set(days);
  let n = 0;
  const d = new Date();
  // Count back from today (or yesterday if nothing yet today)
  if (!set.has(d.toISOString().slice(0, 10))) d.setUTCDate(d.getUTCDate() - 1);
  while (set.has(d.toISOString().slice(0, 10))) { n++; d.setUTCDate(d.getUTCDate() - 1); }
  return n;
}

export const learnerRoutes: Route[] = [
  ['GET', '/api/courses', 'learner', courseList],
  ['GET', '/api/courses/:id', 'learner', courseDetail],
  ['GET', '/api/lessons/:id', 'learner', lessonDetail],
  ['POST', '/api/lessons/:id/complete', 'learner', async (c) => {
    const b = await c.body();
    const l = await c.env.DB.prepare(`SELECT id,course_id FROM lessons WHERE id=?`).bind(c.params[0]).first<any>();
    if (!l) fail(404, 'Lesson not found.');
    const okC = await allowedCourses(c);
    if (okC && !okC.has(l.course_id)) fail(404, 'Lesson not found.');
    if (flag(b.done)) await c.env.DB.prepare(`INSERT OR IGNORE INTO progress (user_id,lesson_id,course_id) VALUES (?,?,?)`).bind(c.user!.id, l.id, l.course_id).run();
    else await c.env.DB.prepare(`DELETE FROM progress WHERE user_id=? AND lesson_id=?`).bind(c.user!.id, l.id).run();
    return json({ ok: true });
  }],
  // Resume point for videos (per user). Watching >= 90% also marks the lesson complete.
  ['POST', '/api/lessons/:id/position', 'learner', async (c) => {
    const b = await c.body();
    const l = await c.env.DB.prepare(`SELECT id,course_id FROM lessons WHERE id=? AND kind='video'`).bind(c.params[0]).first<any>();
    if (!l) fail(404, 'Lesson not found.');
    const okP = await allowedCourses(c);
    if (okP && !okP.has(l.course_id)) fail(404, 'Lesson not found.');
    const duration = Math.max(0, Math.min(int(b.duration), 86400)), seconds = Math.max(0, Math.min(int(b.seconds), duration || 86400));
    await c.env.DB.prepare(
      `INSERT INTO video_progress (user_id,lesson_id,seconds,duration,updated_at) VALUES (?,?,?,?,datetime('now'))
       ON CONFLICT(user_id,lesson_id) DO UPDATE SET seconds=excluded.seconds, duration=excluded.duration, updated_at=datetime('now')`,
    ).bind(c.user!.id, l.id, seconds, duration).run();
    let completed = false;
    if (duration > 0 && seconds / duration >= 0.9) {
      await c.env.DB.prepare(`INSERT OR IGNORE INTO progress (user_id,lesson_id,course_id) VALUES (?,?,?)`).bind(c.user!.id, l.id, l.course_id).run();
      completed = true;
    }
    return json({ ok: true, completed });
  }],
  ['POST', '/api/quizzes/revision/start', 'learner', async (c) => {
    const rows = await c.env.DB.prepare(
      `SELECT q.id,q.question,q.options FROM wrong_questions w JOIN questions q ON q.id=w.question_id WHERE w.user_id=? ORDER BY w.updated_at DESC LIMIT 25`,
    ).bind(c.user!.id).all<any>();
    if (!rows.results.length) fail(404, 'No missed questions to revise yet!');
    return json({
      questions: rows.results.map((p) => ({ id: p.id, question: p.question, options: JSON.parse(p.options) })),
    });
  }],
  ['POST', '/api/quizzes/revision/submit', 'learner', async (c) => {
    const b = await c.body();
    const answers: Record<string, number> = typeof b.answers === 'object' && b.answers ? b.answers : {};
    const ids = Object.keys(answers).slice(0, 50);
    if (!ids.length) fail(400, 'No answers submitted.');
    const qs = await c.env.DB.prepare(`SELECT id,question,options,answer,explanation FROM questions WHERE id IN (${ids.map(() => '?').join(',')})`).bind(...ids).all<any>();
    const byId = new Map(qs.results.map((x) => [x.id, x]));
    let correct = 0;
    const ops: D1PreparedStatement[] = [];
    const review = ids.map((id) => {
      const x = byId.get(id);
      if (!x) return null;
      const given = Number.isInteger(answers[id]) ? answers[id] : -1;
      if (given === x.answer) {
        correct++;
        ops.push(c.env.DB.prepare(`DELETE FROM wrong_questions WHERE user_id=? AND question_id=?`).bind(c.user!.id, id));
      }
      return { id, question: x.question, options: JSON.parse(x.options), answer: x.answer, given, explanation: x.explanation };
    }).filter(Boolean);
    if (ops.length) await c.env.DB.batch(ops);
    return json({ correct, total: review.length, review });
  }],
  ['POST', '/api/quizzes/:id/start', 'learner', startQuiz],
  ['POST', '/api/quizzes/:id/submit', 'learner', submitQuiz],
  ['GET', '/api/paths', 'learner', pathList],
  ['GET', '/api/paths/:id', 'learner', pathDetail],

  // Everything on this page is the signed-in user's own data.
  ['GET', '/api/dashboard', 'learner', async (c) => {
    const db = c.env.DB, uid = c.user!.id;
    const al = await allowedCourses(c);
    const oL = onlyAllowed(al, 'l.course_id'), oC = onlyAllowed(al, 'c.id');
    const [stats, watching, news, started, attempts, certs, days, paths] = await Promise.all([
      db.prepare(`SELECT (SELECT COUNT(*) FROM progress WHERE user_id=?) lessons,
                         (SELECT ROUND(AVG(pct),1) FROM attempts WHERE user_id=?) avg_score,
                         (SELECT COUNT(*) FROM attempts WHERE user_id=?) attempts,
                         (SELECT COUNT(*) FROM certificates WHERE user_id=? AND revoked=0) certs,
                         (SELECT COALESCE(ROUND(SUM(seconds)/60.0),0) FROM video_progress WHERE user_id=?) watch_minutes`).bind(uid, uid, uid, uid, uid).first(),
      db.prepare(`SELECT l.id,l.title,l.minutes,vp.seconds,vp.duration,c.title AS course_title
                    FROM video_progress vp JOIN lessons l ON l.id=vp.lesson_id JOIN courses c ON c.id=l.course_id
                   WHERE vp.user_id=? AND vp.duration>0 AND vp.seconds>5 AND vp.seconds < vp.duration*0.9${oL.sql}
                   ORDER BY vp.updated_at DESC LIMIT 4`).bind(uid, ...oL.args).all(),
      db.prepare(`SELECT id,title,category,url,published_at,pinned FROM news WHERE published=1 ORDER BY pinned DESC, published_at DESC LIMIT 5`).all(),
      db.prepare(`SELECT c.id,c.code,c.title,COUNT(p.lesson_id) AS done,(SELECT COUNT(*) FROM lessons l WHERE l.course_id=c.id AND l.published=1) AS total
                    FROM progress p JOIN courses c ON c.id=p.course_id WHERE p.user_id=?${oC.sql} GROUP BY c.id ORDER BY MAX(p.completed_at) DESC LIMIT 6`).bind(uid, ...oC.args).all(),
      db.prepare(`SELECT a.pct,a.passed,a.created_at,q.title FROM attempts a JOIN quizzes q ON q.id=a.quiz_id WHERE a.user_id=? ORDER BY a.created_at DESC LIMIT 5`).bind(uid).all(),
      db.prepare(`SELECT ce.id,ce.issued_at,c.title FROM certificates ce JOIN courses c ON c.id=ce.course_id WHERE ce.user_id=? AND ce.revoked=0`).bind(uid).all(),
      db.prepare(`SELECT DISTINCT d FROM (SELECT substr(completed_at,1,10) d FROM progress WHERE user_id=? UNION SELECT substr(updated_at,1,10) FROM video_progress WHERE user_id=? UNION SELECT substr(created_at,1,10) FROM attempts WHERE user_id=?) ORDER BY d DESC LIMIT 400`).bind(uid, uid, uid).all<{ d: string }>(),
      db.prepare(
        `SELECT p.id,p.title,p.icon,
           (SELECT COUNT(*) FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 WHERE i.path_id=p.id${oL.sql}) AS total,
           (SELECT COUNT(*) FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 JOIN progress pr ON pr.lesson_id=i.lesson_id AND pr.user_id=? WHERE i.path_id=p.id${oL.sql}) AS done,
           (SELECT l.id FROM path_items i JOIN lessons l ON l.id=i.lesson_id AND l.published=1 WHERE i.path_id=p.id${oL.sql} AND i.lesson_id NOT IN (SELECT lesson_id FROM progress WHERE user_id=?) ORDER BY i.sort LIMIT 1) AS next_id
         FROM paths p WHERE p.published=1 ORDER BY p.sort`,
      ).bind(...oL.args, uid, ...oL.args, ...oL.args, uid).all<any>(),
    ]);
    const myPaths = paths.results.filter((p: any) => p.total > 0);
    const [assignments, missed] = await Promise.all([
      db.prepare(`SELECT id,target_kind,target_id,title,due_date FROM assignments WHERE (user_id=? OR team=?) ORDER BY due_date ASC LIMIT 20`).bind(uid, c.user!.team || '').all(),
      db.prepare(`SELECT COUNT(*) n FROM wrong_questions WHERE user_id=?`).bind(uid).first<{ n: number }>(),
    ]);
    return json({
      stats: { ...(stats as object), streak: streakOf(days.results.map((x) => x.d)) },
      watching: watching.results,
      news: news.results,
      started: started.results,
      attempts: attempts.results,
      certificates: certs.results,
      assignments: assignments.results,
      missedCount: missed?.n || 0,
      paths: {
        active: myPaths.filter((p: any) => p.done > 0 && p.done < p.total),
        suggested: myPaths.filter((p: any) => p.done === 0).slice(0, 3),
        finished: myPaths.filter((p: any) => p.done >= p.total).length,
      },
    });
  }],

  ['GET', '/api/news', 'learner', async (c) => {
    const r = await c.env.DB.prepare(`SELECT id,title,body,category,url,pinned,published_at FROM news WHERE published=1 ORDER BY pinned DESC, published_at DESC LIMIT 100`).all();
    return json({ news: r.results });
  }],
  ['GET', '/api/faqs', 'learner', async (c) => {
    const r = await c.env.DB.prepare(`SELECT id,category,section,question,answer,sort FROM faqs ORDER BY sort, id`).all();
    return json({ faqs: r.results });
  }],
  ['GET', '/api/feeds', 'learner', async (c) => json({ items: await loadFeeds(c.ex) })],

  ['GET', '/api/search', 'learner', async (c) => {
    const q = str(c.url.searchParams.get('q'), 60).replace(/[%_]/g, '');
    if (q.length < 2) return json({ courses: [], lessons: [] });
    const like = `%${q}%`;
    const al = await allowedCourses(c);
    const oc = onlyAllowed(al, 'id'), ol = onlyAllowed(al, 'l.course_id');
    const [courses, lessons] = await Promise.all([
      c.env.DB.prepare(`SELECT id,code,title,subtitle FROM courses WHERE published=1${oc.sql} AND (title LIKE ? OR code LIKE ? OR subtitle LIKE ?) LIMIT 8`).bind(...oc.args, like, like, like).all(),
      c.env.DB.prepare(`SELECT l.id,l.title,l.kind,c.title AS course FROM lessons l JOIN courses c ON c.id=l.course_id WHERE l.published=1 AND c.published=1${ol.sql} AND (l.title LIKE ? OR l.body LIKE ?) LIMIT 20`).bind(...ol.args, like, like).all(),
    ]);
    return json({ courses: courses.results, lessons: lessons.results });
  }],

  ['GET', '/api/certificates', 'learner', async (c) => {
    const [r, br] = await Promise.all([
      c.env.DB.prepare(
        `SELECT ce.id,ce.pct,ce.issued_at,c.title,c.code FROM certificates ce JOIN courses c ON c.id=ce.course_id WHERE ce.user_id=? AND ce.revoked=0 ORDER BY ce.issued_at DESC`,
      ).bind(c.user!.id).all(),
      c.env.DB.prepare(`SELECT value FROM system_settings WHERE key='cert_branding'`).first<{ value: string }>(),
    ]);
    let branding = null;
    if (br?.value) { try { branding = JSON.parse(br.value); } catch {} }
    return json({ certificates: r.results, holder: c.user!.name, branding });
  }],
  ['GET', '/api/attempts', 'learner', async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT a.id,a.pct,a.passed,a.correct,a.wrong,a.total,a.seconds,a.created_at,q.title,c.code
         FROM attempts a JOIN quizzes q ON q.id=a.quiz_id JOIN courses c ON c.id=a.course_id WHERE a.user_id=? ORDER BY a.created_at DESC LIMIT 100`,
    ).bind(c.user!.id).all();
    return json({ attempts: r.results });
  }],

  // Public certificate verification (minimal fields only)
  ['GET', '/api/verify/:id', 'none', async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT ce.id,ce.pct,ce.issued_at,ce.revoked,u.name,co.title,co.code FROM certificates ce JOIN users u ON u.id=ce.user_id JOIN courses co ON co.id=ce.course_id WHERE ce.id=?`,
    ).bind(c.params[0].toUpperCase().slice(0, 20)).first<any>();
    if (!r) return json({ valid: false });
    return json({ valid: !r.revoked, name: r.name, course: r.title, code: r.code, issued: r.issued_at, pct: r.pct });
  }],

  // Learner feedback (lesson/contact)
  ['POST', '/api/feedback', 'learner', async (c) => {
    const b = await c.body();
    const kind = b.kind === 'contact' ? 'contact' : 'feedback';
    const message = str(b.message, 4000);
    if (message.length < 3) fail(400, 'Please enter a message (at least 3 characters).');
    const subject = str(b.subject, 160) || null;
    if (kind === 'contact' && !subject) fail(400, 'Please enter a subject.');
    const ratingRaw = b.rating === undefined || b.rating === null || b.rating === '' ? null : int(b.rating, 0);
    const rating = ratingRaw && ratingRaw >= 1 && ratingRaw <= 5 ? ratingRaw : null;
    const page = str(b.page, 200) || null;
    const u = c.user!;
    const id = newId(12);
    await c.env.DB.prepare(
      `INSERT INTO feedback (id,kind,user_id,user_name,user_email,user_team,page,rating,subject,message) VALUES (?,?,?,?,?,?,?,?,?,?)`,
    ).bind(id, kind, u.id, u.name, u.email, u.team, page, rating, subject, message).run();
    return json({ ok: true, id });
  }],

  // Bookmarks & private study notes
  ['GET', '/api/bookmarks', 'learner', async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT b.lesson_id,b.note,b.updated_at,l.title,l.kind,co.title AS course FROM bookmarks b JOIN lessons l ON l.id=b.lesson_id JOIN courses co ON co.id=l.course_id WHERE b.user_id=? ORDER BY b.updated_at DESC`,
    ).bind(c.user!.id).all();
    return json({ bookmarks: r.results });
  }],
  ['GET', '/api/bookmarks/:id', 'learner', async (c) => {
    const r = await c.env.DB.prepare(`SELECT lesson_id,note,updated_at FROM bookmarks WHERE user_id=? AND lesson_id=?`).bind(c.user!.id, c.params[0]).first();
    return json({ bookmark: r || null });
  }],
  ['POST', '/api/bookmarks/:id', 'learner', async (c) => {
    const b = await c.body();
    const note = str(b.note, 10000);
    await c.env.DB.prepare(
      `INSERT INTO bookmarks (user_id,lesson_id,note,updated_at) VALUES (?,?,?,datetime('now')) ON CONFLICT(user_id,lesson_id) DO UPDATE SET note=excluded.note, updated_at=datetime('now')`,
    ).bind(c.user!.id, c.params[0], note).run();
    return json({ ok: true });
  }],
  ['DELETE', '/api/bookmarks/:id', 'learner', async (c) => {
    await c.env.DB.prepare(`DELETE FROM bookmarks WHERE user_id=? AND lesson_id=?`).bind(c.user!.id, c.params[0]).run();
    return json({ ok: true });
  }],

  // Notifications (team, user-specific, or broadcast '__ALL__')
  ['GET', '/api/notifications', 'learner', async (c) => {
    const r = await c.env.DB.prepare(
      `SELECT id,title,body,link,is_read,created_at FROM notifications WHERE user_id=? OR team=? OR team='__ALL__' ORDER BY created_at DESC LIMIT 30`,
    ).bind(c.user!.id, c.user!.team || '').all();
    return json({ notifications: r.results });
  }],
  ['POST', '/api/notifications/read', 'learner', async (c) => {
    await c.env.DB.prepare(`UPDATE notifications SET is_read=1 WHERE user_id=? OR team=? OR team='__ALL__'`).bind(c.user!.id, c.user!.team || '').run();
    return json({ ok: true });
  }],

  // Active announcement / maintenance banner (accessible to Learner & Head portals)
  ['GET', '/api/banner', 'none', async (c) => {
    const row = await c.env.DB.prepare(`SELECT value FROM system_settings WHERE key='banner'`).first<{ value: string }>();
    if (!row?.value) return json({ banner: null });
    try {
      const b = JSON.parse(row.value);
      if (!b?.active || !b?.message) return json({ banner: null });
      if (b.expiresAt && b.expiresAt < new Date().toISOString().slice(0, 10)) return json({ banner: null });
      return json({ banner: b });
    } catch { return json({ banner: null }); }
  }],

  // "What Changed" Regulatory & Product Change Log
  ['GET', '/api/changelog', 'learner', async (c) => {
    const r = await c.env.DB.prepare(`SELECT id,category,title,effective_date,old_rule,new_rule,impact FROM regulatory_changes WHERE published=1 ORDER BY effective_date DESC, created_at DESC`).all();
    return json({ items: r.results });
  }],
];
