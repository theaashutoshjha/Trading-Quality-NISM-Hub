// Applies seed/out/*.sql to the D1 database in order.
//   node seed/apply.mjs --local      (wrangler dev database)
//   node seed/apply.mjs --remote     (production Cloudflare D1)
import { readdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

const here = dirname(fileURLToPath(import.meta.url));
const target = process.argv.includes('--remote') ? '--remote' : '--local';
const files = readdirSync(join(here, 'out')).filter((f) => f.endsWith('.sql')).sort();
if (!files.length) { console.error('No seed files. Run: npm run seed:build'); process.exit(1); }

for (const f of files) {
  console.log(`> ${f} (${target})`);
  const r = spawnSync('npx', ['wrangler', 'd1', 'execute', 'fundsindia-hub', target, '--yes', '--file', join(here, 'out', f)], { stdio: 'inherit', shell: true });
  if (r.status !== 0) { console.error('Seed failed on', f); process.exit(r.status ?? 1); }
}
console.log('Seed complete.');
