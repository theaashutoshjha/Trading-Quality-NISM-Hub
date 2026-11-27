// Live learning feed: pulls educational personal-finance, mutual-fund, and wealth-planning RSS feeds.
// Excludes regulatory enforcement/adjudication notices and short-term trading noise.

export interface FeedItem {
  title: string;
  link: string;
  source: string;
  category: string;
  published: string; // ISO
}

const FEEDS: { url: string; source: string; category: string }[] = [
  { url: 'https://economictimes.indiatimes.com/mf/rssfeeds/359241701.cms', source: 'ET Mutual Funds', category: 'Mutual Funds' },
  { url: 'https://economictimes.indiatimes.com/wealth/rssfeeds/837555174.cms', source: 'ET Wealth', category: 'Personal Finance' },
  { url: 'https://www.livemint.com/rss/money', source: 'Mint Money', category: 'Financial Planning' },
  { url: 'https://freefincal.com/feed/', source: 'Freefincal', category: 'Investing & Research' },
  { url: 'https://www.capitalmind.in/feed/', source: 'Capitalmind', category: 'Markets & Learning' },
];

const NOISE_RE = /\b(adjudication|recovery certificate|settlement order|show cause|penalty|impound|debar|insider trading|intraday|upper circuit|lower circuit|buy\/sell|target price|sensex jumps|nifty surges|stock tips|multibagger)\b/i;

const decode = (s: string) =>
  s
    .replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g, '$1')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;|&apos;/g, "'")
    .replace(/<[^>]+>/g, '')
    .trim();

const tag = (block: string, name: string) => {
  const m = block.match(new RegExp(`<${name}[^>]*>([\\s\\S]*?)</${name}>`, 'i'));
  return m ? decode(m[1]) : '';
};

function parse(xml: string, f: (typeof FEEDS)[number]): FeedItem[] {
  const items: FeedItem[] = [];
  const re = /<item[\s>]([\s\S]*?)<\/item>/gi;
  let m: RegExpExecArray | null;
  while ((m = re.exec(xml)) && items.length < 12) {
    const title = tag(m[1], 'title');
    if (!title || NOISE_RE.test(title)) continue;
    const link = tag(m[1], 'link') || (m[1].match(/<link[^>]*href="([^"]+)"/)?.[1] ?? '');
    let raw = tag(m[1], 'pubDate') || tag(m[1], 'dc:date');
    if (raw && !/(Z|GMT|UTC|[+-]\d{2}:?\d{2})\s*$/i.test(raw)) raw += ' +0530';
    const d = new Date(raw || Date.now());
    if (!/^https?:\/\//.test(link)) continue;
    items.push({ title, link, source: f.source, category: f.category, published: isNaN(+d) ? new Date().toISOString() : d.toISOString() });
  }
  return items;
}

export async function loadFeeds(ctx: ExecutionContext): Promise<FeedItem[]> {
  const cacheKey = new Request('https://cache.internal/feeds-v3');
  const cache = (caches as unknown as { default: Cache }).default;
  const hit = await cache.match(cacheKey);
  if (hit) return hit.json();

  const results = await Promise.allSettled(
    FEEDS.map(async (f) => {
      const r = await fetch(f.url, { headers: { 'User-Agent': 'Mozilla/5.0 (compatible; FundsIndiaLearningHub/1.0)' }, cf: { cacheTtl: 900 } as RequestInitCfProperties });
      if (!r.ok) throw new Error(String(r.status));
      return parse(await r.text(), f);
    }),
  );
  const all = results.flatMap((r) => (r.status === 'fulfilled' ? r.value : []));
  const seen = new Set<string>();
  const items = all
    .filter((i) => (seen.has(i.title) ? false : (seen.add(i.title), true)))
    .sort((a, b) => +new Date(b.published) - +new Date(a.published))
    .slice(0, 50);

  if (items.length) {
    ctx.waitUntil(cache.put(cacheKey, new Response(JSON.stringify(items), { headers: { 'Cache-Control': 'max-age=1200', 'Content-Type': 'application/json' } })));
  }
  return items;
}
