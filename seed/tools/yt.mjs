// Minimal YouTube catalog scraper (public pages, no API key). Used only at seed-build time.
const H = {
  'Accept-Language': 'en-IN,en;q=0.9',
  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36',
  Cookie: 'SOCS=CAI; CONSENT=YES+1',
};

export async function page(url) {
  const html = await (await fetch(url, { headers: H })).text();
  const m = html.match(/var ytInitialData = (\{.*?\});<\/script>/s);
  const key = html.match(/"INNERTUBE_API_KEY":"([^"]+)"/)?.[1];
  const ver = html.match(/"INNERTUBE_CONTEXT_CLIENT_VERSION":"([^"]+)"/)?.[1] || '2.20260101.00.00';
  return { data: m ? JSON.parse(m[1]) : null, key, ver };
}

export async function more(token, key, ver) {
  const r = await fetch(`https://www.youtube.com/youtubei/v1/browse?key=${key}`, {
    method: 'POST',
    headers: { ...H, 'Content-Type': 'application/json' },
    body: JSON.stringify({ context: { client: { clientName: 'WEB', clientVersion: ver, hl: 'en', gl: 'IN' } }, continuation: token }),
  });
  return r.json();
}

/** Parse "3 weeks ago", "1 year ago", "Streamed 2 months ago" -> approximate age in days. */
export function ageDays(t = '') {
  const m = t.match(/(\d+)\s*(second|sec|minute|min|hour|hr|day|week|wk|month|mo|year|yr)s?\s+ago/i);
  if (!m) return null;
  const n = +m[1];
  const u = m[2].toLowerCase();
  const d = /^(sec|second|min|minute|hour|hr)/.test(u) ? 0 : /^day/.test(u) ? 1 : /^(wk|week)/.test(u) ? 7 : /^(mo|month)/.test(u) ? 30 : 365;
  return n * d;
}
export const secs = (t = '') => t.split(':').reverse().reduce((a, v, i) => a + (+v || 0) * 60 ** i, 0);

const text = (o) => o?.simpleText || o?.runs?.map((r) => r.text).join('') || '';

/** Walk any renderer tree and collect videos + continuation tokens. */
export function harvest(root) {
  const vids = [], tokens = [];
  const walk = (o) => {
    if (!o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    const v = o.videoRenderer || o.playlistVideoRenderer || o.gridVideoRenderer;
    if (v?.videoId) {
      vids.push({
        id: v.videoId,
        title: text(v.title),
        dur: secs(text(v.lengthText) || v.lengthSeconds ? text(v.lengthText) : ''),
        age: ageDays(text(v.publishedTimeText) || (v.videoInfo?.runs || []).map((r) => r.text).join('')),
        when: text(v.publishedTimeText) || (v.videoInfo?.runs || []).map((r) => r.text).join(''),
        views: text(v.viewCountText),
        channel: text(v.ownerText) || text(v.shortBylineText),
      });
    }
    // newer lockup model
    const l = o.lockupViewModel;
    if (l?.contentType === 'LOCKUP_CONTENT_TYPE_VIDEO' && l.contentId) {
      const md = l.metadata?.lockupMetadataViewModel;
      const parts = (md?.metadata?.contentMetadataViewModel?.metadataRows || []).flatMap((r) => (r.metadataParts || []).map((p) => p.text?.content));
      const dur = JSON.stringify(l.contentImage || {}).match(/"text":"((?:\d+:)?\d+:\d\d)"/)?.[1] || '';
      vids.push({ id: l.contentId, title: md?.title?.content || '', dur: secs(dur), age: ageDays(parts.join(' ')), when: parts.join(' '), views: parts[0] || '' });
    }
    if (o.continuationItemRenderer?.continuationEndpoint?.continuationCommand?.token) tokens.push(o.continuationItemRenderer.continuationEndpoint.continuationCommand.token);
    for (const k in o) walk(o[k]);
  };
  walk(root);
  return { vids, tokens };
}

/** Fetch every video of a channel tab / playlist (follows continuations, up to `max`). */
export async function collect(url, max = 400) {
  const { data, key, ver } = await page(url);
  if (!data) return [];
  let { vids, tokens } = harvest(data);
  const seen = new Set(vids.map((v) => v.id));
  let guard = 0;
  while (tokens.length && vids.length < max && guard++ < 30) {
    const next = tokens.shift();
    const res = await more(next, key, ver);
    const h = harvest(res);
    for (const v of h.vids) if (!seen.has(v.id)) { seen.add(v.id); vids.push(v); }
    tokens = h.tokens;
  }
  return vids;
}

export async function playlistsOf(url) {
  const { data } = await page(url);
  const out = [];
  const walk = (o) => {
    if (!o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    const l = o.lockupViewModel;
    if (l && /PLAYLIST|COURSE/.test(l.contentType || '')) out.push({ id: l.contentId, title: l.metadata?.lockupMetadataViewModel?.title?.content });
    for (const k in o) walk(o[k]);
  };
  walk(data);
  return out;
}
