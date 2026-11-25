import { Ctx, audit, fail, int, json, newId } from './lib';
import type { Route } from './router';
import { allowedCourses } from './teams';

const CATEGORIES = ['issue', 'content', 'access', 'suggestion', 'other'];
const STATUSES = ['new', 'read', 'resolved'];

/** Plain text only: trims, drops control characters and caps the length. The admin UI renders it as text, never HTML. */
const text = (v: unknown, max: number) =>
  (typeof v === 'string' ? v : '').replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F]/g, '').trim().slice(0, max);

/** At most `limit` submissions of this kind per learner per hour (protects the database and the admin inbox). */
async function throttle(c: Ctx, kind: 'content' | 'contact', limit: number) {
  const r = await c.env.DB.prepare(`SELECT COUNT(*) n FROM feedback WHERE user_id = ? AND kind = ? AND created_at > datetime('now','-1 hour')`)
    .bind(c.user!.id, kind).first<{ n: number }>();
  if ((r?.n || 0) >= limit) fail(429, 'You have sent a lot of messages in the last hour. Please try again a little later.');
}

export const feedbackRoutes: Route[] = [
  // ---------- learner ----------
  ['POST', '/api/feedback', 'learner', async (c) => {
    const b = await c.body();
    const rating = int(b.rating, 0);
    if (rating < 1 || rating > 5) fail(400, 'Please choose a rating from 1 to 5.');
    const message = text(b.message, 1500);
    const allowed = await allowedCourses(c);
    const db = c.env.DB;
    let courseId = '', lessonId = '', title = '', target = '';
    if (typeof b.lessonId === 'string' && b.lessonId) {
      const l = await db.prepare(`SELECT l.id,l.title,l.course_id FROM lessons l WHERE l.id = ? AND l.published = 1`).bind(text(b.lessonId, 80)).first<any>();
      if (!l || (allowed && !allowed.has(l.course_id))) fail(404, 'Content not found.');
      courseId = l.course_id; lessonId = l.id; title = l.title; target = l.id;
    } else if (typeof b.courseId === 'string' && b.courseId) {
      const co = await db.prepare(`SELECT id,title FROM courses WHERE id = ? AND published = 1`).bind(text(b.courseId, 80)).first<any>();
      if (!co || (allowed && !allowed.has(co.id))) fail(404, 'Content not found.');
      courseId = co.id; title = co.title; target = 'course:' + co.id;
    } else fail(400, 'Missing content.');
    await throttle(c, 'content', 30);
    const u = c.user!;
    await db.prepare(
      `INSERT INTO feedback (id,kind,user_id,user_name,user_email,team,target,course_id,lesson_id,target_title,rating,message)
       VALUES (?,'content',?,?,?,?,?,?,?,?,?,?)
       ON CONFLICT(user_id, target) WHERE kind = 'content' AND user_id IS NOT NULL
       DO UPDATE SET rating = excluded.rating, message = excluded.message, status = 'new', target_title = excluded.target_title, updated_at = datetime('now')`,
    ).bind(newId(12), u.id, u.name, u.email, u.team, target, courseId, lessonId || null, title, rating, message).run();
    return json({ ok: true });
  }],

  ['POST', '/api/contact', 'learner', async (c) => {
    const b = await c.body();
    const subject = text(b.subject, 120), message = text(b.message, 2000);
    const category = CATEGORIES.includes(b.category) ? b.category : 'other';
    if (subject.length < 3) fail(400, 'Please add a short subject.');
    if (message.length < 5) fail(400, 'Please write your message.');
    await throttle(c, 'contact', 5);
    const u = c.user!;
    await c.env.DB.prepare(`INSERT INTO feedback (id,kind,user_id,user_name,user_email,team,category,subject,message) VALUES (?,'contact',?,?,?,?,?,?,?)`)
      .bind(newId(12), u.id, u.name, u.email, u.team, category, subject, message).run();
    return json({ ok: true });
  }],

  // ---------- admin & trainers ----------
  ['GET', '/api/admin/feedback/summary', 'admin', async (c) => {
    const r = await c.env.DB.prepare(`SELECT COUNT(*) n FROM feedback WHERE status = 'new'`).first<{ n: number }>();
    return json({ new: r?.n || 0 });
  }],
  ['GET', '/api/admin/feedback', 'admin', async (c) => {
    const kind = c.url.searchParams.get('kind'), status = c.url.searchParams.get('status');
    const q = text(c.url.searchParams.get('q'), 60).replace(/[%_]/g, '');
    const where: string[] = [], args: string[] = [];
    if (kind === 'content' || kind === 'contact') { where.push('kind = ?'); args.push(kind); }
    if (STATUSES.includes(status || '')) { where.push('status = ?'); args.push(status!); }
    if (q.length >= 2) { where.push('(user_name LIKE ? OR user_email LIKE ? OR subject LIKE ? OR message LIKE ? OR target_title LIKE ?)'); args.push(...Array(5).fill(`%${q}%`)); }
    const rows = await c.env.DB.prepare(`SELECT * FROM feedback ${where.length ? 'WHERE ' + where.join(' AND ') : ''} ORDER BY (status = 'new') DESC, created_at DESC LIMIT 300`).bind(...args).all();
    const counts = await c.env.DB.prepare(
      `SELECT COUNT(*) total, SUM(status='new') new_count, SUM(kind='content') content, SUM(kind='contact') contact, ROUND(AVG(CASE WHEN kind='content' THEN rating END),2) avg_rating FROM feedback`,
    ).first();
    return json({ items: rows.results, counts });
  }],
  ['PUT', '/api/admin/feedback/:id', 'admin', async (c) => {
    const b = await c.body();
    const status = STATUSES.includes(b.status) ? b.status : 'read';
    await c.env.DB.prepare(`UPDATE feedback SET status = ?, admin_note = ?, updated_at = datetime('now') WHERE id = ?`)
      .bind(status, text(b.adminNote, 1000) || null, c.params[0]).run();
    await audit(c.env, c.user!.email, 'feedback_updated', `${c.params[0]} -> ${status}`, c.ip);
    return json({ ok: true });
  }],
  ['DELETE', '/api/admin/feedback/:id', 'admin-only', async (c) => {
    await c.env.DB.prepare(`DELETE FROM feedback WHERE id = ?`).bind(c.params[0]).run();
    await audit(c.env, c.user!.email, 'feedback_deleted', c.params[0], c.ip);
    return json({ ok: true });
  }],
];
