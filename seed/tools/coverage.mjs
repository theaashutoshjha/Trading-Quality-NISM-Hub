import { readFileSync } from 'node:fs';
import { COURSES } from '../catalog.mjs';
const P = JSON.parse(readFileSync(new URL('../data/playlists.json', import.meta.url)));
const lim = +process.argv[2] || 364;
for (const c of COURSES) {
  const rows = c.playlists.map((p) => {
    const v = P[p.id] || [];
    const f = v.filter((x) => x.age !== null && x.age <= lim);
    return `   ${p.id.slice(0, 12)} fresh ${String(f.length).padStart(2)}/${String(v.length).padStart(2)} | ${p.channel}`;
  });
  console.log(c.id + '\n' + rows.join('\n'));
}
