// node seed/tools/list-playlists.mjs <channel-playlists-url>   -> prints every playlist on a channel (id | title)
import { playlistsOf, page, more } from './yt.mjs';
const url = process.argv[2];
const { data, key, ver } = await page(url);
const out = new Map();
const tokens = [];
const walk = (o) => {
  if (!o || typeof o !== 'object') return;
  if (Array.isArray(o)) return o.forEach(walk);
  const l = o.lockupViewModel;
  if (l && /PLAYLIST|COURSE/.test(l.contentType || '')) out.set(l.contentId, l.metadata?.lockupMetadataViewModel?.title?.content);
  const gp = o.gridPlaylistRenderer; if (gp?.playlistId) out.set(gp.playlistId, gp.title?.runs?.[0]?.text || gp.title?.simpleText);
  const t = o.continuationItemRenderer?.continuationEndpoint?.continuationCommand?.token; if (t) tokens.push(t);
  for (const k in o) walk(o[k]);
};
walk(data);
for (let g = 0; tokens.length && g < 15; g++) { walk(await more(tokens.shift(), key, ver)); }
for (const [id, t] of out) console.log(id + ' | ' + t);
console.log('TOTAL', out.size);
