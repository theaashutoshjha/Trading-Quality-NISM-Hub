// Creates / updates administrator accounts directly in D1 (bypasses the UI's password policy on purpose).
//
//   ADMIN_PASSWORD='...' node scripts/create-admins.mjs --local   [email1 email2 ...]
//   ADMIN_PASSWORD='...' node scripts/create-admins.mjs --remote  [email1 email2 ...]
//
// The password is read from the environment so it is never written into the repository.
// Passwords are stored as PBKDF2-SHA256 (100k iterations) - identical to the Worker's format.
import { pbkdf2Sync, randomBytes, randomUUID } from 'node:crypto';
import { mkdtempSync, writeFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const target = process.argv.includes('--remote') ? '--remote' : '--local';
const emails = process.argv.slice(2).filter((a) => a.includes('@'));
const password = process.env.ADMIN_PASSWORD;
if (!password) { console.error('Set ADMIN_PASSWORD in the environment.'); process.exit(1); }
if (!emails.length) { console.error('Pass at least one admin e-mail address.'); process.exit(1); }

const titleCase = (s) => s.charAt(0).toUpperCase() + s.slice(1);
const nameOf = (e) => e.split('@')[0].split(/[._-]/).map(titleCase).join(' ');
const hash = () => {
  const salt = randomBytes(16);
  return `pbkdf2$100000$${salt.toString('base64')}$${pbkdf2Sync(password, salt, 100000, 32, 'sha256').toString('base64')}`;
};
const q = (v) => `'${String(v).replace(/'/g, "''")}'`;

const sql = emails.map((e) => {
  const email = e.toLowerCase();
  const id = randomUUID().replace(/-/g, '').slice(0, 12);
  // Existing accounts keep their id (and therefore all their data); password/role are refreshed.
  return `INSERT INTO users (id,email,name,role,status,pw_hash,must_change) VALUES (${q(id)},${q(email)},${q(nameOf(email))},'admin','active',${q(hash())},0)
 ON CONFLICT(email) DO UPDATE SET role='admin', status='active', pw_hash=excluded.pw_hash, must_change=0;
DELETE FROM sessions WHERE user_id IN (SELECT id FROM users WHERE email=${q(email)});`;
}).join('\n');

const dir = mkdtempSync(join(tmpdir(), 'fi-admins-'));
const file = join(dir, 'admins.sql');
writeFileSync(file, sql);
const r = spawnSync('npx', ['wrangler', 'd1', 'execute', 'fundsindia-hub', target, '--yes', '--file', file], { stdio: 'inherit', shell: true });
rmSync(dir, { recursive: true, force: true });
if (r.status !== 0) process.exit(r.status ?? 1);
console.log(`\nAdmin accounts ready (${target.slice(2)}): ${emails.join(', ')}`);
