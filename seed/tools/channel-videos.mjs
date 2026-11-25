// node seed/tools/channel-videos.mjs <channel-videos-url> <out.json>  -> every public video (id,title,dur,when)
import { collect, ageDays } from './yt.mjs';
import { writeFileSync } from 'node:fs';
const v = (await collect(process.argv[2], 3000)).map((x) => ({ id: x.id, title: x.title, dur: x.dur, when: x.when, age: ageDays(x.when) }));
if (process.argv[3]) writeFileSync(process.argv[3], JSON.stringify(v));
console.log('videos', v.length);
