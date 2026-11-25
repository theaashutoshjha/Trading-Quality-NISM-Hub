import type { Ctx } from './lib';

/** The teams a learner can belong to (shown on the sign-in page). */
export const TEAMS = [
  'MF Onboarding',
  'MF Digital',
  'MF Silver',
  'MF Gold',
  'MF Platinum',
  'Equity Onboarding',
  'Equity Regular',
  'Customer Support',
] as const;
export type Team = (typeof TEAMS)[number];

export const isTeam = (v: unknown): v is Team => typeof v === 'string' && (TEAMS as readonly string[]).includes(v);

/**
 * Course ids this signed-in user may open, or null for "everything" (admins and trainers).
 * A learner with no team sees nothing; their team's rows in team_access decide the rest.
 */
export async function allowedCourses(c: Ctx): Promise<Set<string> | null> {
  const u = c.user!;
  if (u.role !== 'learner') return null;
  const cached = (c as any)._allowed as Set<string> | undefined;
  if (cached) return cached;
  const set = new Set<string>();
  if (u.team) {
    const r = await c.env.DB.prepare(
      `SELECT ta.course_id FROM team_access ta JOIN courses co ON co.id = ta.course_id AND co.published = 1 WHERE ta.team = ?`,
    ).bind(u.team).all<{ course_id: string }>();
    r.results.forEach((x) => set.add(x.course_id));
  }
  (c as any)._allowed = set;
  return set;
}

/** SQL fragment + bindings restricting `col` to the allowed courses ('' when unrestricted). */
export function onlyAllowed(allowed: Set<string> | null, col: string): { sql: string; args: string[] } {
  if (allowed === null) return { sql: '', args: [] };
  const ids = [...allowed];
  if (!ids.length) return { sql: ` AND 0 `, args: [] };
  return { sql: ` AND ${col} IN (${ids.map(() => '?').join(',')}) `, args: ids };
}
