// Dumps every playlist of the FundsIndia channel (with its videos) to seed/data/fi-playlists.json,
// so Academy headers mirror the channel's own playlists.   node seed/tools/fetch-fi-playlists.mjs
import { page, more, collect, ageDays } from './yt.mjs';
import { writeFileSync } from 'node:fs';

const { data, key, ver } = await page('https://www.youtube.com/@FundsIndia/playlists');
const lists = new Map(); const tokens = [];
const walk = (o) => {
  if (!o || typeof o !== 'object') return;
  if (Array.isArray(o)) return o.forEach(walk);
  const l = o.lockupViewModel;
  if (l && /PLAYLIST|COURSE/.test(l.contentType || '')) lists.set(l.contentId, l.metadata?.lockupMetadataViewModel?.title?.content);
  const t = o.continuationItemRenderer?.continuationEndpoint?.continuationCommand?.token; if (t) tokens.push(t);
  for (const k in o) walk(o[k]);
};
walk(data);
for (let g = 0; tokens.length && g < 15; g++) walk(await more(tokens.shift(), key, ver));

const out = [];
for (const [id, title] of lists) {
  let vids = [];
  try { vids = (await collect(`https://www.youtube.com/playlist?list=${id}`, 1500)).map((x) => ({ id: x.id, title: x.title, dur: x.dur, when: x.when, age: ageDays(x.when) })); } catch (e) { console.log(id, 'ERR', e.message); }
  console.log(String(vids.length).padStart(4), id, title);
  out.push({ id, title, videos: vids });
}
writeFileSync(new URL('../data/fi-playlists.json', import.meta.url), JSON.stringify(out));
