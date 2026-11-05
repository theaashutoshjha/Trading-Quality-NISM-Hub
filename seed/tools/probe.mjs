import { page, harvest, more } from './yt.mjs';
const { data, key, ver } = await page('https://www.youtube.com/@FundsIndia/videos');
const h = harvest(data);
console.log('first', h.vids.length, 'tokens', h.tokens.length, 'key', !!key, ver);
if (h.tokens[0]) {
  const r = await more(h.tokens[0], key, ver);
  console.log(JSON.stringify(r).slice(0, 400));
  const h2 = harvest(r);
  console.log('next', h2.vids.length, h2.tokens.length);
}
