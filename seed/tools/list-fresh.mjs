import { readFileSync } from 'node:fs';
import { ageDays } from './yt.mjs';
const v = JSON.parse(readFileSync(new URL('../data/fi-channel.json', import.meta.url)));
const maxDays = +process.argv[2] || 730;
const fresh = v.map((x) => ({ ...x, age: ageDays(x.when) })).filter((x) => x.age !== null && x.age <= maxDays).sort((a, b) => a.age - b.age);
console.log('fresh', fresh.length, 'of', v.length);
for (const x of fresh) console.log(`${x.id} ${String(Math.round(x.dur / 60)).padStart(3)}m ${String(x.age).padStart(4)}d | ${x.title}`);
