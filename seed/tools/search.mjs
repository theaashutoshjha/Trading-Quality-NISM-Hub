// node seed/tools/search.mjs "query" [maxAgeDays]  -> videos uploaded this year, sorted by relevance
import { page, harvest } from './yt.mjs';
const [, , q, maxAge = '400'] = process.argv;
const { data } = await page(`https://www.youtube.com/results?search_query=${encodeURIComponent(q)}&sp=EgQIBRAB`);
const { vids } = harvest(data);
for (const v of vids.filter((x) => x.age !== null && x.age <= +maxAge && x.dur > 150).slice(0, 25))
  console.log(`${v.id} ${String(Math.round(v.dur / 60)).padStart(3)}m ${String(v.age).padStart(4)}d | ${(v.channel || '').slice(0, 22).padEnd(22)} | ${v.title.slice(0, 95)}`);
