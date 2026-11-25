// FundsIndia Academy: every public video of https://www.youtube.com/@FundsIndia grouped under headers that
// match what the videos are actually about. Headers follow the channel's own playlists first; videos that are
// not in any playlist are placed by what their title says. Data: seed/data/fi-playlists.json + fi-channel.json
// (refresh with seed/tools/fetch-fi.mjs and seed/tools/fetch-fi-playlists.mjs).

export const FI_HEADERS = [
  'Start here: investor mindset',
  'Getting started on FundsIndia',
  'SIPs & mutual funds',
  'Bonds, FDs & SIFs',
  'Stocks & IPOs',
  'NPS & retirement',
  'Market views & roundups',
  'Behind The Returns: fund manager talks',
  'FundsIndia 360° & media appearances',
  'Customer voices & SIP stories',
  'Brand films & campaigns',
];

const R = (s) => new RegExp(s, 'i');
const BRAND = R("bumper|commercial|mother'?s day|rakshabandhan|diwali|golden icon|dussehra|thank you mom|swadeshi|let the money work|a hero that|your child deserves|bano intelligent|invest in love|independence|festive|what'?s india'?s favorite|story$|the fundsindia story|robo advisor");
const TALKS = R('behind the returns|concall|facebook live|equity market - what|what should you do with your equity|debt funds become volatile|out-behave|timeless lessons');
const GETTING = R("how to invest|how to buy|how to open a demat|through fundsindia|via fundsindia|portal|fundsindia app|create your fundsindia account|dashboard|login|money mitr|super savings|paperless|start your investment journey|introducing fundsindia|new india portfolio|smartest way to invest|give your employees");
const NPS = R('\\bnps\\b|retire|pension');
const STOCKS = R('\\bipo|stock|alpha|watchlist|stocademy|share market|broking');
const DEBT = R('bond|\\bsif\\b|specialized investment|\\bfds?\\b|fixed deposit|laddering|debt fund|debt vs');
const MF = R('\\bsip\\b|\\bstp\\b|lumpsum|mutual fund|\\bnfo\\b|index fund|fund of fund|\\belss\\b|balanced advantage|tax saving|nifty|nasdaq|loan against|smart sip|choose the right|overwhelmed|best.? mutual|how long should you stay invested|8-4-3');
const MARKET = R('market (wrap|round)|roundup|round-up|elections|yearly|weekly market|market falls|market ke');
const MINDSET = R("advice|3 stages|before you invest|long-term investing|financial freedom|subject in school|financial lesson|tough times|invest early|start investing early|why you should start|what data reveals|finance was|who actually stays invested|three good calls|lucky one|diy vs");

/** Returns the header for a video given the titles of the channel playlists it appears in. */
export function headerFor(title, playlists = []) {
  const P = playlists.join(' | ');
  if (BRAND.test(title)) return 'Brand films & campaigns';
  if (TALKS.test(title)) return 'Behind The Returns: fund manager talks';
  if (/getting started/i.test(P) || GETTING.test(title)) return 'Getting started on FundsIndia';
  if (/\bNPS\b/i.test(P) || NPS.test(title)) return 'NPS & retirement';
  if (/weekly market roundup|market lounge/i.test(P) || MARKET.test(title)) return 'Market views & roundups';
  if (/stocademy|broking|alpha|ultrabagger/i.test(P) || STOCKS.test(title)) return 'Stocks & IPOs';
  if (DEBT.test(title)) return 'Bonds, FDs & SIFs';
  if (/voices|sip stories/i.test(P) || /customer voices|sahi hai/i.test(title)) return 'Customer voices & SIP stories';
  if (MF.test(title) || /fundsindia mutual funds/i.test(P)) return 'SIPs & mutual funds';
  if (/360|cnbc|meenakshi/i.test(P)) return 'FundsIndia 360° & media appearances';
  if (/balance test|investor awareness/i.test(P) || MINDSET.test(title)) return 'Start here: investor mindset';
  return 'Brand films & campaigns';
}

/**
 * @param channel  seed/data/fi-channel.json  (every video on the channel's Videos tab)
 * @param lists    seed/data/fi-playlists.json (each playlist and its videos)
 * @returns [{ title, videos: [{id,title,mins}] }] in FI_HEADERS order; every video appears exactly once
 */
export function buildAcademy(channel, lists, playable = () => true) {
  const info = new Map();           // id -> { title, dur, age, lists: [], order }
  let order = 0;
  for (const pl of lists) for (const v of pl.videos) {
    const e = info.get(v.id) || { id: v.id, title: v.title, dur: v.dur, age: v.age ?? 9e9, lists: [], order: order++ };
    e.lists.push(pl.title);
    info.set(v.id, e);
  }
  for (const v of channel) if (!info.has(v.id)) info.set(v.id, { id: v.id, title: v.title, dur: v.dur, age: v.age ?? 9e9, lists: [], order: 1e6 });
  const groups = new Map(FI_HEADERS.map((h) => [h, []]));
  for (const e of info.values()) if (e.title && playable(e.id)) groups.get(headerFor(e.title, e.lists)).push(e);
  return FI_HEADERS.map((title) => {
    const vs = groups.get(title);
    // Start-here / explainer headers: newest first; everything else keeps the channel playlist order, then newest first.
    // The first header leads with the explainer videos (not tied to a playlist); other headers follow playlist order.
    if (title === FI_HEADERS[0]) vs.sort((a, b) => (a.order >= 1e6) === (b.order >= 1e6) ? (a.order === b.order ? a.age - b.age : a.order - b.order) : a.order >= 1e6 ? -1 : 1);
    else vs.sort((a, b) => (a.order === b.order ? a.age - b.age : a.order - b.order));
    return { title, videos: vs.map((e) => ({ id: e.id, title: e.title, mins: Math.max(1, Math.round((e.dur || 0) / 60)) })) };
  }).filter((g) => g.videos.length);
}
