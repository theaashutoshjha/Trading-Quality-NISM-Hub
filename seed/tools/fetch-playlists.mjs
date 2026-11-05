// Dumps the video list of every playlist referenced in seed/catalog.mjs to seed/data/playlists.json
import { COURSES } from '../catalog.mjs';
import { collect, ageDays } from './yt.mjs';
import { mkdirSync, writeFileSync } from 'node:fs';

const ids = [...new Set(COURSES.flatMap((c) => c.series.map((p) => p.id)))];
const out = {};
for (const id of ids) {
  try {
    const v = (await collect(`https://www.youtube.com/playlist?list=${id}`, 300)).map((x) => ({ id: x.id, title: x.title, dur: x.dur, when: x.when, age: ageDays(x.when) }));
    out[id] = v;
    const fresh = v.filter((x) => x.age !== null && x.age <= 364).length;
    console.log(`${id} total=${v.length} fresh=${fresh}`);
  } catch (e) { console.log(id, 'ERR', e.message); }
}
mkdirSync(new URL('../data/', import.meta.url), { recursive: true });
writeFileSync(new URL('../data/playlists.json', import.meta.url), JSON.stringify(out));
