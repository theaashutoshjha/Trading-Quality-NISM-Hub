// Dumps every public video of the FundsIndia channel to seed/data/fi-channel.json
import { collect } from './yt.mjs';
import { mkdirSync, writeFileSync } from 'node:fs';
mkdirSync(new URL('../data/', import.meta.url), { recursive: true });
const vids = await collect('https://www.youtube.com/@FundsIndia/videos', 2000);
console.log('channel videos:', vids.length);
writeFileSync(new URL('../data/fi-channel.json', import.meta.url), JSON.stringify(vids, null, 1));
const byAge = (a, b) => (a.age ?? 9e9) - (b.age ?? 9e9);
console.log(vids.sort(byAge).filter((_, i) => i % 12 === 0).map((v) => `${v.when} | ${Math.round(v.dur / 60)}m | ${v.title}`).join('\n'));
