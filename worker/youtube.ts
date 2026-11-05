// Admin-side helpers to import videos. Uses public YouTube pages / oEmbed (no API key).

const HEAD = {
  'Accept-Language': 'en-IN,en;q=0.9',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36',
  Cookie: 'SOCS=CAI; CONSENT=YES+1',
};

export interface Vid { id: string; title: string; mins: number; ageDays: number | null }

/** Title + channel of a video, or null when it is deleted/private/not embeddable. */
export async function oembed(id: string): Promise<{ title: string; author: string } | null> {
  const r = await fetch(`https://www.youtube.com/oembed?url=${encodeURIComponent('https://www.youtube.com/watch?v=' + id)}&format=json`);
  if (!r.ok) return null;
  const j = (await r.json()) as { title?: string; author_name?: string };
  return { title: j.title || '', author: j.author_name || '' };
}

const txt = (o: any): string => o?.simpleText || o?.runs?.map((r: any) => r.text).join('') || '';
const secs = (t = '') => t.split(':').reverse().reduce((a, v, i) => a + (+v || 0) * 60 ** i, 0);
function age(t = ''): number | null {
  const m = t.match(/(\d+)\s*(second|sec|minute|min|hour|hr|day|week|wk|month|mo|year|yr)s?\s+ago/i);
  if (!m) return null;
  const u = m[2].toLowerCase();
  const d = /^(sec|second|min|minute|hour|hr)/.test(u) ? 0 : /^day/.test(u) ? 1 : /^(wk|week)/.test(u) ? 7 : /^(mo|month)/.test(u) ? 30 : 365;
  return +m[1] * d;
}

function harvest(root: any) {
  const vids: Vid[] = [];
  const tokens: string[] = [];
  const walk = (o: any) => {
    if (!o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    const v = o.playlistVideoRenderer;
    if (v?.videoId) {
      vids.push({ id: v.videoId, title: txt(v.title), mins: Math.max(1, Math.round(secs(txt(v.lengthText)) / 60)), ageDays: age((v.videoInfo?.runs || []).map((r: any) => r.text).join('')) });
    }
    // newer "lockup" model used by playlist pages
    const l = o.lockupViewModel;
    if (l?.contentType === 'LOCKUP_CONTENT_TYPE_VIDEO' && l.contentId) {
      const md = l.metadata?.lockupMetadataViewModel;
      const parts = (md?.metadata?.contentMetadataViewModel?.metadataRows || []).flatMap((r: any) => (r.metadataParts || []).map((p: any) => p.text?.content || ''));
      const dur = JSON.stringify(l.contentImage || {}).match(/"text":"((?:\d+:)?\d+:\d\d)"/)?.[1] || '';
      vids.push({ id: l.contentId, title: md?.title?.content || '', mins: Math.max(1, Math.round(secs(dur) / 60)), ageDays: age(parts.join(' ')) });
    }
    const t = o.continuationItemRenderer?.continuationEndpoint?.continuationCommand?.token;
    if (t) tokens.push(t);
    for (const k in o) walk(o[k]);
  };
  walk(root);
  return { vids, tokens };
}

export async function fetchPlaylist(listId: string, max = 200): Promise<Vid[]> {
  const html = await (await fetch(`https://www.youtube.com/playlist?list=${encodeURIComponent(listId)}`, { headers: HEAD })).text();
  const m = html.match(/var ytInitialData = (\{.*?\});<\/script>/s);
  if (!m) throw new Error('Could not read the playlist page.');
  const key = html.match(/"INNERTUBE_API_KEY":"([^"]+)"/)?.[1];
  const ver = html.match(/"INNERTUBE_CONTEXT_CLIENT_VERSION":"([^"]+)"/)?.[1] || '2.20260101.00.00';
  let { vids, tokens } = harvest(JSON.parse(m[1]));
  const seen = new Set(vids.map((v) => v.id));
  for (let guard = 0; tokens.length && vids.length < max && key && guard < 10; guard++) {
    const res = await (await fetch(`https://www.youtube.com/youtubei/v1/browse?key=${key}`, {
      method: 'POST', headers: { ...HEAD, 'Content-Type': 'application/json' },
      body: JSON.stringify({ context: { client: { clientName: 'WEB', clientVersion: ver, hl: 'en', gl: 'IN' } }, continuation: tokens.shift() }),
    })).json();
    const h = harvest(res);
    for (const v of h.vids) if (!seen.has(v.id)) { seen.add(v.id); vids.push(v); }
    tokens = h.tokens;
  }
  return vids;
}
