// node seed/tools/find-playlist.mjs "query1" "query2" ...
// Finds playlists and reports how many videos are <=365 days old (fresh).
import { page, collect, ageDays } from './yt.mjs';
const seen = new Set();
for (const q of process.argv.slice(2)) {
  const { data } = await page(`https://www.youtube.com/results?search_query=${encodeURIComponent(q)}&sp=EgIQAw%253D%253D`);
  const found = [];
  const walk = (o) => {
    if (!o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    const l = o.lockupViewModel;
    if (l && /^PL[\w-]{30,}$/.test(l.contentId || '') && /PLAYLIST|COURSE/.test(l.contentType)) {
      const md = l.metadata?.lockupMetadataViewModel;
      const rows = (md?.metadata?.contentMetadataViewModel?.metadataRows || []).flatMap((r) => (r.metadataParts || []).map((p) => p.text?.content));
      found.push({ id: l.contentId, title: md?.title?.content, by: rows[0] });
    }
    for (const k in o) walk(o[k]);
  };
  walk(data);
  console.log('=== ' + q);
  for (const p of found.slice(0, 6)) {
    if (seen.has(p.id)) continue;
    seen.add(p.id);
    const v = (await collect(`https://www.youtube.com/playlist?list=${p.id}`, 120)).map((x) => ({ ...x, age: ageDays(x.when) }));
    const fresh = v.filter((x) => x.age !== null && x.age <= 365).length;
    const newest = Math.min(...v.map((x) => x.age ?? 9e9));
    console.log(`${p.id} fresh ${String(fresh).padStart(2)}/${String(v.length).padStart(2)} newest ${newest}d | ${(p.by || '').slice(0, 20)} | ${(p.title || '').slice(0, 70)}`);
  }
}
