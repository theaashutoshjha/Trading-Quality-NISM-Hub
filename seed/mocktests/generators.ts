// Parametric numerical question generators. Every correct answer is computed, so each generated
// question is unique to its seed and arithmetically exact.
export type Rng = () => number;

export interface GenQ {
  question: string;
  options: string[];
  correct: number;
  explanation: string;
}

export function mulberry32(seed: number): Rng {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

export const pick = <T,>(r: Rng, arr: T[]): T => arr[Math.floor(r() * arr.length)];
export const int = (r: Rng, lo: number, hi: number) => lo + Math.floor(r() * (hi - lo + 1));
export const shuffle = <T,>(r: Rng, arr: T[]): T[] => {
  const a = arr.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(r() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
};

const inr = (n: number, d = 2) =>
  '₹' + n.toLocaleString('en-IN', { minimumFractionDigits: d, maximumFractionDigits: d });
const pct = (n: number, d = 2) => `${n.toFixed(d)}%`;
const num = (n: number, d = 2) => n.toFixed(d);

// Builds 4 distinct options around the right answer, in random positions.
function build(
  r: Rng,
  question: string,
  right: number,
  wrongs: number[],
  fmt: (n: number) => string,
  explanation: string
): GenQ {
  const seen = new Set<string>([fmt(right)]);
  const opts: string[] = [fmt(right)];
  for (const w of wrongs) {
    const s = fmt(w);
    if (!seen.has(s)) {
      seen.add(s);
      opts.push(s);
    }
  }
  let bump = 1;
  while (opts.length < 4 && bump < 200) {
    const s = fmt(right * (1 + 0.07 * bump) + bump * (Math.abs(right) < 1 ? 0.5 : 1));
    bump++;
    if (!seen.has(s)) {
      seen.add(s);
      opts.push(s);
    }
  }
  const order = shuffle(r, opts.slice(0, 4));
  return { question, options: order, correct: order.indexOf(fmt(right)), explanation };
}

type Gen = (r: Rng) => GenQ;

// ---------------- NISM V-A ----------------
export const GEN_VA: Gen[] = [
  (r) => {
    const units = int(r, 5, 40) / 10; // crore units
    const assets = Math.round(units * int(r, 95, 140) * 100) / 100 * 1; // crore
    const liab = int(r, 5, 90) / 10;
    const nav = (assets - liab) / units;
    return build(r, `A scheme has total assets of ₹${num(assets)} crore, liabilities (other than to unitholders) of ₹${num(liab)} crore and ${num(units)} crore units outstanding. Its NAV per unit is:`, nav,
      [assets / units, (assets + liab) / units, (assets - liab) / (units + 1), nav * 1.1], (n) => inr(n), `NAV = (${num(assets)} − ${num(liab)}) ÷ ${num(units)} = ${inr(nav)}.`);
  },
  (r) => {
    const amt = int(r, 5, 200) * 1000;
    const nav = int(r, 120, 950) / 10;
    const units = amt / nav;
    return build(r, `An investor invests ₹${amt.toLocaleString('en-IN')} in an open-ended scheme at an NAV of ₹${num(nav)}. With no entry load, the number of units allotted is:`, units,
      [amt * nav, amt / (nav * 1.0225), amt / 10, units * 0.9], (n) => num(n, 3), `Units = ${amt} ÷ ${num(nav)} = ${num(units, 3)}.`);
  },
  (r) => {
    const nav = int(r, 100, 900) / 10;
    const load = pick(r, [0.5, 1, 1.5, 2, 3]);
    const price = nav * (1 - load / 100);
    return build(r, `A scheme has an NAV of ₹${num(nav)} and an exit load of ${load}%. The redemption (repurchase) price per unit is:`, price,
      [nav * (1 + load / 100), nav - load, nav, nav * (1 - load / 10)], (n) => inr(n), `Repurchase price = ${num(nav)} × (1 − ${load}%) = ${inr(price)}.`);
  },
  (r) => {
    const aum = int(r, 2, 80) * 100000;
    const rate = pick(r, [0.5, 0.75, 1, 1.25, 1.5]);
    const daily = (aum * rate) / 100 / 365;
    return build(r, `A distributor has ₹${aum.toLocaleString('en-IN')} of client AUM in regular plans with a trail rate of ${rate}% p.a. The approximate daily trail commission is:`, daily,
      [daily * 12, daily * 30, aum * rate / 100 / 12, daily / 2], (n) => inr(n), `Daily trail = AUM × rate ÷ 365 = ${inr(daily)}.`);
  },
  (r) => {
    const gain = int(r, 10, 60) * 10000 + 125000; // above exemption
    const tax = (gain - 125000) * 0.125;
    return build(r, `An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹${gain.toLocaleString('en-IN')} (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:`, tax,
      [gain * 0.125, gain * 0.2, (gain - 125000) * 0.2, 0], (n) => inr(n, 0), `Taxable = ${gain} − 1,25,000; tax at 12.5% = ${inr(tax, 0)}.`);
  },
  (r) => {
    const gain = int(r, 5, 90) * 1000;
    const tax = gain * 0.2;
    return build(r, `An investor redeems equity-oriented fund units after 8 months with a short-term capital gain of ₹${gain.toLocaleString('en-IN')}. The STCG tax (ignoring cess) is:`, tax,
      [gain * 0.125, gain * 0.15, gain * 0.1, 0], (n) => inr(n, 0), `STCG on equity-oriented funds is 20%: ${inr(tax, 0)}.`);
  },
  (r) => {
    const start = int(r, 10, 100) * 1000;
    const years = int(r, 2, 8);
    const rate = int(r, 6, 18);
    const end = start * Math.pow(1 + rate / 100, years);
    return build(r, `An investment of ₹${start.toLocaleString('en-IN')} grows to ₹${Math.round(end).toLocaleString('en-IN')} in ${years} years. The compounded annual growth rate (CAGR) is closest to:`, rate,
      [rate + 2, rate - 2, ((end / start - 1) * 100) / years, rate + 4], (n) => pct(n, 1), `CAGR = (end/start)^(1/${years}) − 1 ≈ ${rate}%.`);
  },
  (r) => {
    const inv = int(r, 5, 50) * 100;
    const units = int(r, 20, 90) * 5;
    const nav0 = inv / 10;
    void nav0;
    const idcw = pick(r, [1, 1.5, 2, 2.5]);
    const exNav = pick(r, [12, 15, 18, 20, 25]);
    const extra = (units * idcw) / exNav;
    return build(r, `An investor holds ${units} units under the IDCW Reinvestment option. IDCW is ₹${idcw} per unit and the ex-IDCW NAV is ₹${exNav}. The additional units allotted are:`, extra,
      [units * idcw, (units * idcw) / (exNav + idcw), extra * 2, units / exNav], (n) => num(n, 2), `Units = (${units} × ${idcw}) ÷ ${exNav} = ${num(extra)}.`);
  },
  (r) => {
    const cost = int(r, 20, 100) * 1000;
    const infl = pick(r, [5, 6, 7, 8]);
    const yrs = int(r, 5, 15);
    const fv = cost * Math.pow(1 + infl / 100, yrs);
    return build(r, `A goal costs ₹${cost.toLocaleString('en-IN')} today. With inflation of ${infl}% p.a., its cost after ${yrs} years will be approximately:`, fv,
      [cost * (1 + (infl * yrs) / 100), cost * Math.pow(1 + infl / 100, yrs - 1), cost * Math.pow(1 + infl / 100, yrs + 1), cost * 2], (n) => inr(Math.round(n), 0), `FV = ${cost} × (1 + ${infl}%)^${yrs}.`);
  },
  (r) => {
    const held = int(r, 3, 30) * 100;
    const k = pick(r, [2, 3, 4, 5]);
    const bonus = held / k;
    return build(r, `A scheme announces a bonus of 1:${k} (one free unit for every ${k} units held). An investor holding ${held} units will receive:`, bonus,
      [held * k, held / (k + 1), held, bonus * 2], (n) => `${num(n, 0)} units`, `Bonus units = ${held} ÷ ${k}.`);
  },
  (r) => {
    const exp = int(r, 5, 90) / 10;
    const avg = int(r, 3, 60) * 100;
    const ter = (exp / avg) * 100;
    return build(r, `A scheme with average net assets of ₹${avg} crore incurs total recurring expenses of ₹${num(exp)} crore in a year. Its expense ratio is:`, ter,
      [ter * 2, ter / 2, (exp / (avg + exp)) * 100, ter * 1.5], (n) => pct(n, 3), `TER = ${num(exp)} ÷ ${avg} × 100 = ${pct(ter, 3)}.`);
  },
  (r) => {
    const rp = int(r, 8, 22);
    const rf = pick(r, [5, 6, 7]);
    const sd = int(r, 6, 18);
    const sh = (rp - rf) / sd;
    return build(r, `A fund returned ${rp}% with a standard deviation of ${sd}%. The risk-free rate is ${rf}%. The Sharpe ratio is:`, sh,
      [rp / sd, (rp - rf) / (sd + 2), (rp + rf) / sd, sh * 1.5], (n) => num(n, 2), `Sharpe = (${rp} − ${rf}) ÷ ${sd}.`);
  },
  (r) => {
    const amt = int(r, 1, 50) * 100000;
    const duty = amt * 0.00005;
    return build(r, `Stamp duty at 0.005% on issue of units applies to an investment of ₹${amt.toLocaleString('en-IN')}. The stamp duty is:`, duty,
      [amt * 0.0005, amt * 0.00015, amt * 0.005, amt * 0.00001], (n) => inr(n), `₹${amt} × 0.005% = ${inr(duty)}.`);
  },
  (r) => {
    const total = int(r, 4, 40) * 100000;
    const eq = pick(r, [40, 50, 60, 70]);
    const growth = pick(r, [10, 15, 20]);
    const newEq = total * (eq / 100) * (1 + growth / 100);
    const rest = total * (1 - eq / 100);
    const newTotal = newEq + rest;
    const targetEq = newTotal * (eq / 100);
    const sell = newEq - targetEq;
    return build(r, `A portfolio of ₹${total.toLocaleString('en-IN')} is ${eq}:${100 - eq} equity:debt. Equity rises ${growth}% and debt is unchanged. To rebalance to the original ratio, the amount of equity to be sold is:`, sell,
      [newEq - total * (eq / 100), growth * total / 100, sell * 1.5, sell / 2], (n) => inr(Math.round(n), 0), `New equity = ${Math.round(newEq)}; target = ${Math.round(targetEq)}; sell the excess.`);
  },
  (r) => {
    const nav = int(r, 100, 900) / 10;
    const out = nav * (1 - 0.01);
    const units = int(r, 5, 80) * 10;
    return build(r, `An investor redeems ${units} units at an NAV of ₹${num(nav)} with an exit load of 1%. The amount received (before tax) is:`, units * out,
      [units * nav, units * nav * 1.01, units * (nav - 1), units * nav * 0.9], (n) => inr(n), `${units} × ${num(nav)} × 0.99.`);
  },
];

// ---------------- NISM XIII ----------------
export const GEN_XIII: Gen[] = [
  (r) => {
    const s = int(r, 5, 40) * 100;
    const rate = pick(r, [6, 7, 8, 9]);
    const d = int(r, 1, 6) * 30;
    const div = pick(r, [0, 5, 10, 15]);
    const f = s * (1 + (rate / 100) * (d / 365)) - div;
    return build(r, `Spot price is ₹${s}, financing rate ${rate}% p.a., expected dividend ₹${div} during the period, and futures expiry in ${d} days. The fair futures price is:`, f,
      [s * (1 + rate / 100) - div, s + div, s * (1 + (rate / 100) * (d / 365)), f + 5], (n) => inr(n), `F = S[1 + r·t/365] − D = ${inr(f)}.`);
  },
  (r) => {
    const entry = int(r, 200, 900) * 5;
    const exit = entry + int(r, -40, 60) * 5;
    const lot = pick(r, [25, 50, 75, 100, 125, 250]);
    const pl = (exit - entry) * lot;
    return build(r, `A trader buys 1 lot (${lot}) of stock futures at ₹${entry} and squares off at ₹${exit}. The profit/(loss), ignoring costs, is:`, pl,
      [-pl, (exit - entry), pl * 2, (exit - entry) * lot / 2 + 1], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), `(${exit} − ${entry}) × ${lot}.`);
  },
  (r) => {
    const k = int(r, 100, 400) * 10;
    const prem = int(r, 10, 90);
    const s = k + int(r, -100, 200);
    const lot = pick(r, [25, 50, 75]);
    const pl = (Math.max(s - k, 0) - prem) * lot;
    return build(r, `A trader buys one lot (${lot}) of a call option, strike ₹${k}, premium ₹${prem}. At expiry the underlying settles at ₹${s}. The net profit/(loss) is:`, pl,
      [(s - k) * lot, -prem * lot * 2, (s - k - prem) * lot * -1, prem * lot], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), `Payoff = max(S − K, 0) − premium, times lot.`);
  },
  (r) => {
    const k = int(r, 100, 400) * 10;
    const prem = int(r, 10, 90);
    const s = k + int(r, -200, 100);
    const lot = pick(r, [25, 50, 75]);
    const pl = (Math.max(k - s, 0) - prem) * lot;
    return build(r, `A trader buys one lot (${lot}) of a put option, strike ₹${k}, premium ₹${prem}. At expiry the underlying is at ₹${s}. The net profit/(loss) is:`, pl,
      [(k - s) * lot, -prem * lot * 2, (s - k - prem) * lot, prem * lot], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), `Payoff = max(K − S, 0) − premium, times lot.`);
  },
  (r) => {
    const k = int(r, 100, 400) * 10;
    const prem = int(r, 10, 90);
    return build(r, `The breakeven price at expiry of a long call with strike ₹${k} and premium ₹${prem} is:`, k + prem,
      [k - prem, k, k + 2 * prem, prem], (n) => inr(n, 0), 'Call breakeven = strike + premium.');
  },
  (r) => {
    const k = int(r, 100, 400) * 10;
    const prem = int(r, 10, 90);
    return build(r, `The breakeven price at expiry of a long put with strike ₹${k} and premium ₹${prem} is:`, k - prem,
      [k + prem, k, k - 2 * prem, prem], (n) => inr(n, 0), 'Put breakeven = strike − premium.');
  },
  (r) => {
    const s = int(r, 100, 400) * 10;
    const k = s + pick(r, [-200, -100, -50, 50, 100, 200]);
    const prem = int(r, 20, 150);
    const iv = Math.max(s - k, 0);
    return build(r, `A call option with strike ₹${k} trades at ₹${prem} while spot is ₹${s}. Its time value is:`, prem - iv,
      [prem + iv, iv, prem, prem - iv + 10], (n) => inr(n, 0), `Time value = premium − intrinsic value (${iv}).`);
  },
  (r) => {
    const pv = int(r, 20, 200) * 100000;
    const beta = pick(r, [0.8, 0.9, 1.1, 1.2, 1.5]);
    const idx = pick(r, [20000, 22000, 24000, 25000]);
    const lot = pick(r, [25, 50, 75]);
    const n = (beta * pv) / (idx * lot);
    return build(r, `A portfolio worth ₹${pv.toLocaleString('en-IN')} with beta ${beta} is to be hedged with index futures at ${idx} (lot size ${lot}). The number of contracts to short is approximately:`, n,
      [pv / (idx * lot), n * 2, n / 2, beta * lot], (x) => num(x, 1), `N = β × V ÷ (index × lot).`);
  },
  (r) => {
    const entry = int(r, 100, 400) * 10;
    const settle = entry + int(r, -50, 50);
    const lot = pick(r, [25, 50]);
    return build(r, `A long futures position (1 lot of ${lot}) was entered at ₹${entry}. The daily settlement price is ₹${settle}. The MTM profit/(loss) credited is:`, (settle - entry) * lot,
      [(entry - settle) * lot, settle - entry, 0, (settle - entry) * lot * 2], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), `(${settle} − ${entry}) × ${lot}.`);
  },
  (r) => {
    const spot = int(r, 60, 90) + int(r, 0, 99) / 100;
    const fut = spot + int(r, 5, 60) / 100;
    return build(r, `USDINR spot is ₹${num(spot)} and the near-month futures trade at ₹${num(fut)}. The basis (spot − futures) is:`, spot - fut,
      [fut - spot, spot, fut, (spot - fut) * 10], (n) => num(n, 2), 'Basis = spot − futures (negative in contango).');
  },
];

// ---------------- NISM XV ----------------
export const GEN_XV: Gen[] = [
  (r) => {
    const pat = int(r, 50, 900);
    const sh = int(r, 5, 50);
    const eps = (pat * 10) / sh; // crore*10/crore shares
    void eps;
    const e = pat / sh;
    const p = int(r, 10, 50) * e;
    return build(r, `A company has profit after tax of ₹${pat} crore and ${sh} crore shares. Its share price is ₹${num(p)}. The P/E ratio is:`, p / e,
      [p / pat, e / p, (p / e) * 1.2, pat / sh], (n) => num(n, 2), `EPS = ${pat}/${sh} = ${num(e)}; P/E = price ÷ EPS.`);
  },
  (r) => {
    const pat = int(r, 20, 400);
    const eq = int(r, 100, 2000);
    const roe = (pat / eq) * 100;
    return build(r, `A company reports PAT of ₹${pat} crore and average shareholders' equity of ₹${eq} crore. ROE is:`, roe,
      [pat / (eq + pat) * 100, roe * 2, roe / 2, eq / pat], (n) => pct(n), 'ROE = PAT ÷ equity.');
  },
  (r) => {
    const d = pick(r, [4, 5, 8, 10, 12]);
    const price = int(r, 80, 800);
    return build(r, `A stock pays a dividend of ₹${d} per share and trades at ₹${price}. The dividend yield is:`, (d / price) * 100,
      [(price / d), (d / price) * 200, (d / price) * 50, d], (n) => pct(n), 'Yield = DPS ÷ price.');
  },
  (r) => {
    const rf = pick(r, [5, 6, 7]);
    const rm = rf + int(r, 5, 9);
    const beta = pick(r, [0.6, 0.8, 1, 1.2, 1.4]);
    const req = rf + beta * (rm - rf);
    return build(r, `The risk-free rate is ${rf}%, expected market return ${rm}% and the stock's beta ${beta}. By CAPM the required return is:`, req,
      [rm, rf + beta * rm, beta * (rm - rf), rf + (rm - rf)], (n) => pct(n, 2), 'CAPM: rf + β(rm − rf).');
  },
  (r) => {
    const d1 = pick(r, [5, 6, 8, 10]);
    const rr = int(r, 10, 14);
    const g = int(r, 4, 8);
    const v = d1 / ((rr - g) / 100);
    return build(r, `Next year's dividend is expected to be ₹${d1}, growing at ${g}% forever. With a required return of ${rr}%, the Gordon growth value is:`, v,
      [d1 / (rr / 100), d1 * (rr - g), v * 1.1, d1 / ((rr + g) / 100)], (n) => inr(n), 'V = D1 ÷ (r − g).');
  },
  (r) => {
    const mcap = int(r, 500, 5000);
    const debt = int(r, 50, 1500);
    const cash = int(r, 20, 400);
    return build(r, `A company has market capitalisation ₹${mcap} crore, debt ₹${debt} crore and cash ₹${cash} crore. Enterprise value is:`, mcap + debt - cash,
      [mcap + debt + cash, mcap - debt + cash, mcap, mcap + debt], (n) => inr(n, 0) + ' crore', 'EV = market cap + debt − cash.');
  },
  (r) => {
    const ca = int(r, 100, 900);
    const cl = int(r, 50, 600);
    return build(r, `Current assets are ₹${ca} crore and current liabilities ₹${cl} crore. The current ratio is:`, ca / cl,
      [cl / ca, (ca - cl) / cl, ca - cl, ca / (cl + 100)], (n) => num(n, 2), 'Current ratio = CA ÷ CL.');
  },
  (r) => {
    const ebit = int(r, 100, 900);
    const int2 = int(r, 10, 200);
    return build(r, `EBIT is ₹${ebit} crore and interest expense ₹${int2} crore. The interest coverage ratio is:`, ebit / int2,
      [int2 / ebit, (ebit - int2) / int2, ebit * int2, ebit / (int2 + ebit)], (n) => num(n, 2), 'ICR = EBIT ÷ interest.');
  },
  (r) => {
    const pe = int(r, 12, 40);
    const g = int(r, 8, 25);
    return build(r, `A stock has a P/E of ${pe} and expected earnings growth of ${g}% p.a. Its PEG ratio is:`, pe / g,
      [g / pe, pe * g, pe - g, pe / (g + 5)], (n) => num(n, 2), 'PEG = P/E ÷ growth (in %).');
  },
  (r) => {
    const m = int(r, 4, 20);
    const t = int(r, 6, 25) / 10;
    const l = int(r, 12, 30) / 10;
    const roe = (m / 100) * t * l * 100;
    return build(r, `A company has net margin ${m}%, asset turnover ${t.toFixed(1)}x and equity multiplier ${l.toFixed(1)}x. By DuPont, ROE is:`, roe,
      [m * t, m + t + l, roe * 2, m * l], (n) => pct(n, 2), 'ROE = margin × turnover × leverage.');
  },
];

// ---------------- NISM XXI-A / XXI-B ----------------
export const GEN_XXI: Gen[] = [
  (r) => {
    const aum = int(r, 50, 500) * 100000;
    const fee = pick(r, [1, 1.5, 2, 2.5]);
    const f = (aum * fee) / 100;
    return build(r, `A PMS client has an average AUM of ₹${aum.toLocaleString('en-IN')} for the year and a fixed management fee of ${fee}% p.a. The annual fee (excluding GST) is:`, f,
      [f * 2, f / 2, f / 4, aum * fee / 10], (n) => inr(Math.round(n), 0), 'Fee = AUM × fee rate.');
  },
  (r) => {
    const open = int(r, 50, 500) * 100000;
    const ret = int(r, 12, 30);
    const hurdle = pick(r, [8, 10]);
    const share = pick(r, [10, 15, 20]);
    const close = open * (1 + ret / 100);
    const perf = ((close - open * (1 + hurdle / 100)) * share) / 100;
    return build(r, `A PMS portfolio starts the year at ₹${open.toLocaleString('en-IN')} and earns ${ret}% (gross). Performance fee: ${share}% of profits above a ${hurdle}% hurdle (hard hurdle, no catch-up). The performance fee is:`, perf,
      [(close - open) * share / 100, perf * 2, (open * hurdle / 100) * share / 100, perf / 2], (n) => inr(Math.round(n), 0), 'Fee = share × (closing value − opening × (1 + hurdle)).');
  },
  (r) => {
    const start = int(r, 50, 400) * 100000;
    const years = int(r, 2, 6);
    const rate = int(r, 8, 20);
    const end = start * Math.pow(1 + rate / 100, years);
    return build(r, `A PMS portfolio grows from ₹${start.toLocaleString('en-IN')} to ₹${Math.round(end).toLocaleString('en-IN')} over ${years} years with no flows. The annualised return is closest to:`, rate,
      [rate + 3, rate - 3, ((end / start - 1) * 100) / years, rate + 6], (n) => pct(n, 1), 'CAGR = (end ÷ start)^(1/n) − 1.');
  },
  (r) => {
    const r1 = int(r, -10, 30);
    const r2 = int(r, -10, 30);
    const twr = ((1 + r1 / 100) * (1 + r2 / 100) - 1) * 100;
    return build(r, `A PMS portfolio returns ${r1}% in the first period and ${r2}% in the second. The time-weighted return over the two periods is:`, twr,
      [r1 + r2, (r1 + r2) / 2, twr + 2, twr - 2], (n) => pct(n, 2), 'TWRR links sub-period returns geometrically.');
  },
  (r) => {
    const rp = int(r, 10, 28);
    const rb = int(r, 6, 20);
    const te = int(r, 2, 8);
    const ir = (rp - rb) / te;
    return build(r, `A portfolio returned ${rp}% against a benchmark return of ${rb}% with tracking error ${te}%. The information ratio is:`, ir,
      [(rp / te), (rp + rb) / te, ir * 2, ir / 2], (n) => num(n, 2), 'IR = (portfolio − benchmark) ÷ tracking error.');
  },
  (r) => {
    const rp = int(r, 10, 28);
    const rf = pick(r, [5, 6, 7]);
    const beta = pick(r, [0.8, 0.9, 1.1, 1.3]);
    const t = (rp - rf) / beta;
    return build(r, `A portfolio returned ${rp}% with beta ${beta}. The risk-free rate is ${rf}%. The Treynor ratio is:`, t,
      [(rp - rf) * beta, rp / beta, (rp + rf) / beta, t * 2], (n) => num(n, 2), 'Treynor = (Rp − Rf) ÷ β.');
  },
  (r) => {
    const w1 = pick(r, [20, 30, 40, 50, 60]);
    const r1 = int(r, 6, 20);
    const r2 = int(r, 4, 14);
    const er = (w1 * r1 + (100 - w1) * r2) / 100;
    return build(r, `A portfolio has ${w1}% in asset A (expected return ${r1}%) and the balance in asset B (expected return ${r2}%). The portfolio's expected return is:`, er,
      [r1 + r2, (r1 + r2) / 2, er + 1, er - 1], (n) => pct(n, 2), 'Weighted average of expected returns.');
  },
];

// ---------------- NISM XVI (commodity derivatives) ----------------
export const GEN_XVI: Gen[] = [
  (r) => {
    const spot = int(r, 40, 900) * 100;
    const rate = pick(r, [6, 7, 8, 9]);
    const m = int(r, 1, 6);
    const storage = int(r, 1, 6) * 10;
    const f = spot * (1 + (rate / 100) * (m / 12)) + storage;
    return build(r, `A commodity spot price is ₹${spot} per unit, financing rate ${rate}% p.a., storage and insurance ₹${storage} per unit for ${m} months. The fair futures price is:`, f,
      [spot * (1 + rate / 100) + storage, spot + storage, spot * (1 + (rate / 100) * (m / 12)) - storage, f + 50], (n) => inr(n), 'F = S(1 + r·t) + storage cost.');
  },
  (r) => {
    const entry = int(r, 400, 900) * 100;
    const exit = entry + int(r, -40, 60) * 10;
    const lot = pick(r, [1, 10, 100, 1000]);
    const lots = int(r, 1, 5);
    const pl = (exit - entry) * lot * lots;
    return build(r, `A trader buys ${lots} lot(s) of a commodity future (lot size ${lot} units) at ₹${entry} and sells at ₹${exit}. The profit/(loss), ignoring costs, is:`, pl,
      [-pl, (exit - entry) * lot, pl * 2, (exit - entry) * lots], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), 'P/L = (exit − entry) × lot size × lots.');
  },
  (r) => {
    const spot = int(r, 400, 900) * 10;
    const fut = spot + int(r, -30, 40) * 5;
    const basis = spot - fut;
    return build(r, `The spot price of a commodity is ₹${spot} and the near-month futures price is ₹${fut}. The basis (spot − futures) is:`, basis,
      [-basis, spot, fut, basis * 2 + 5], (n) => (n < 0 ? '-' : '') + inr(Math.abs(n), 0), 'Basis = spot − futures; a negative value indicates contango.');
  },
  (r) => {
    const qty = int(r, 2, 40) * 100;
    const lot = pick(r, [10, 50, 100]);
    const n = qty / lot;
    return build(r, `A producer wants to hedge ${qty} units of a commodity using futures with a lot size of ${lot} units. The number of contracts to sell is:`, n,
      [n * 2, n / 2, qty * lot, n + 3], (x) => num(x, 0), 'Contracts = quantity ÷ lot size.');
  },
];

// ---------------- NISM X-A / X-B (financial planning) ----------------
export const GEN_XA: Gen[] = [
  (r) => {
    const p = int(r, 1, 20) * 50000; const i = int(r, 6, 12); const n = int(r, 3, 15);
    const fv = p * Math.pow(1 + i / 100, n);
    return build(r, `₹${p.toLocaleString('en-IN')} is invested at ${i}% p.a. compounded annually for ${n} years. The future value is approximately:`, fv,
      [p * (1 + (i * n) / 100), p * Math.pow(1 + i / 100, n - 1), p * Math.pow(1 + i / 100, n + 1), p * 2], (x) => inr(Math.round(x), 0), 'FV = P × (1 + i)^n.');
  },
  (r) => {
    const fv = int(r, 5, 80) * 100000; const i = int(r, 6, 12); const n = int(r, 3, 15);
    const pv = fv / Math.pow(1 + i / 100, n);
    return build(r, `A goal of ₹${fv.toLocaleString('en-IN')} is needed in ${n} years. At ${i}% p.a. return, the lump sum to invest today is approximately:`, pv,
      [fv / (1 + (i * n) / 100), fv * Math.pow(1 + i / 100, n) / 10, fv / Math.pow(1 + i / 100, n - 1), fv / 2], (x) => inr(Math.round(x), 0), 'PV = FV ÷ (1 + i)^n.');
  },
  (r) => {
    const rate = pick(r, [6, 8, 9, 12, 18, 24]);
    return build(r, `By the Rule of 72, money earning ${rate}% p.a. doubles in about:`, 72 / rate,
      [rate / 72 * 10, 100 / rate, 72 / rate * 2, 72 * rate / 10], (x) => `${num(x, 1)} years`, 'Years to double ≈ 72 ÷ rate.');
  },
  (r) => {
    const exp = int(r, 2, 15) * 5000; const inf = pick(r, [4, 5, 6, 7]); const n = int(r, 5, 25);
    const f = exp * Math.pow(1 + inf / 100, n);
    return build(r, `Monthly expenses are ₹${exp.toLocaleString('en-IN')} today. With inflation of ${inf}% p.a., the monthly expense after ${n} years will be approximately:`, f,
      [exp * (1 + (inf * n) / 100), exp * Math.pow(1 + inf / 100, n - 2), exp * 2, exp * n], (x) => inr(Math.round(x), 0), 'Future expense = today\'s expense × (1 + inflation)^n.');
  },
  (r) => {
    const exp = int(r, 2, 12) * 10000; const m = pick(r, [3, 4, 6, 9]);
    return build(r, `A client's monthly essential expenses are ₹${exp.toLocaleString('en-IN')}. A ${m}-month emergency fund should be:`, exp * m,
      [exp * (m + 3), exp * 12, exp * m / 2, exp], (x) => inr(x, 0), 'Emergency fund = months × monthly expenses.');
  },
  (r) => {
    const inc = int(r, 4, 30) * 10000; const sav = Math.round(inc * (int(r, 5, 40) / 100) / 1000) * 1000;
    return build(r, `A client earns ₹${inc.toLocaleString('en-IN')} a month and saves ₹${sav.toLocaleString('en-IN')}. The savings ratio is:`, (sav / inc) * 100,
      [(inc / sav), ((inc - sav) / inc) * 100, (sav / inc) * 200, (sav / inc) * 50], (x) => pct(x, 1), 'Savings ratio = savings ÷ income.');
  },
  (r) => {
    const inc = int(r, 4, 30) * 10000; const emi = Math.round(inc * (int(r, 10, 60) / 100) / 500) * 500;
    return build(r, `A client's monthly income is ₹${inc.toLocaleString('en-IN')} and total loan EMIs are ₹${emi.toLocaleString('en-IN')}. The debt service ratio is:`, (emi / inc) * 100,
      [(inc / emi), ((inc - emi) / inc) * 100, (emi / inc) * 200, (emi / inc) * 50], (x) => pct(x, 1), 'Debt service ratio = EMIs ÷ income.');
  },
  (r) => {
    const sip = int(r, 1, 20) * 1000; const i = pick(r, [8, 10, 12]); const n = int(r, 3, 20);
    const mi = i / 1200; const m = n * 12;
    const fv = sip * ((Math.pow(1 + mi, m) - 1) / mi);
    return build(r, `A monthly SIP of ₹${sip.toLocaleString('en-IN')} earns ${i}% p.a. (monthly compounding, instalments at month-end) for ${n} years. The maturity value is approximately:`, fv,
      [sip * m, sip * m * (1 + i / 100), fv * 0.85, fv * 1.2], (x) => inr(Math.round(x), 0), 'FV = P × [((1 + r)^m − 1) ÷ r], r = i ÷ 12.');
  },
  (r) => {
    const loan = int(r, 5, 80) * 100000; const i = pick(r, [8, 9, 10, 12]); const yrs = pick(r, [5, 10, 15, 20]);
    const mi = i / 1200; const m = yrs * 12;
    const emi = (loan * mi * Math.pow(1 + mi, m)) / (Math.pow(1 + mi, m) - 1);
    return build(r, `A loan of ₹${loan.toLocaleString('en-IN')} at ${i}% p.a. for ${yrs} years is repaid in monthly instalments. The EMI is approximately:`, emi,
      [loan / m, (loan * (1 + (i * yrs) / 100)) / m, emi * 1.15, emi * 0.85], (x) => inr(Math.round(x), 0), 'EMI = P·r·(1 + r)^n ÷ [(1 + r)^n − 1].');
  },
];

// ---------------- NISM VII (securities operations & risk) ----------------
export const GEN_VII: Gen[] = [
  (r) => {
    const buy = int(r, 5, 50) * 10000; const sell = int(r, 5, 50) * 10000;
    return build(r, `On a day, a member buys shares worth ₹${buy.toLocaleString('en-IN')} and sells shares worth ₹${sell.toLocaleString('en-IN')} (same client, same settlement). The net obligation is:`, Math.abs(buy - sell),
      [buy + sell, buy, sell, Math.abs(buy - sell) / 2 + 1], (x) => inr(x, 0), 'Net obligation = |buys − sells|.');
  },
  (r) => {
    const t = int(r, 5, 80) * 100000; const v = pick(r, [5, 8, 10, 12, 15]);
    return build(r, `A client trades ₹${t.toLocaleString('en-IN')} of a stock with a VaR margin of ${v}%. The VaR margin is:`, (t * v) / 100,
      [t * v / 10, t * (v + 5) / 100, t / v, (t * v) / 200], (x) => inr(x, 0), 'VaR margin = turnover × VaR %.');
  },
  (r) => {
    const t = int(r, 5, 100) * 100000;
    return build(r, `Securities Transaction Tax on equity delivery sale is applied at 0.1% on a sale of ₹${t.toLocaleString('en-IN')}. The STT is:`, t * 0.001,
      [t * 0.01, t * 0.0001, t * 0.00025, t * 0.0005], (x) => inr(x, 0), 'STT = 0.1% of the sale value (delivery).');
  },
  (r) => {
    const q = int(r, 1, 50) * 10; const p = int(r, 5, 200) * 5; const b = pick(r, [0.1, 0.2, 0.3, 0.5]);
    return build(r, `A client buys ${q} shares at ₹${p} with brokerage of ${b}% of the trade value. The brokerage is:`, (q * p * b) / 100,
      [q * b, (q * p * b) / 10, q * p / b, (q * p * b) / 200], (x) => inr(x, 2), 'Brokerage = value × rate.');
  },
];

// ---------------- NISM XII (securities markets foundation) ----------------
export const GEN_XII: Gen[] = [
  (r) => {
    const pr = int(r, 20, 500) * 5; const sh = int(r, 2, 100) * 10;
    return build(r, `A company has ${sh} crore shares outstanding at a price of ₹${pr}. Its market capitalisation is:`, pr * sh,
      [pr + sh, pr * sh * 10, pr * sh / 10, pr * sh * 2], (x) => inr(x, 0) + ' crore', 'Market cap = price × shares outstanding.');
  },
  (r) => {
    const eps = int(r, 2, 80); const pe = int(r, 8, 40);
    return build(r, `A stock has EPS of ₹${eps} and trades at ${pe} times earnings. Its price is:`, eps * pe,
      [eps + pe, eps / pe, eps * pe * 2, eps * pe / 2], (x) => inr(x, 0), 'Price = EPS × P/E.');
  },
  (r) => {
    const k = pick(r, [2, 3, 4, 5]); const p = int(r, 10, 200) * 10;
    return build(r, `A stock priced at ₹${p} announces a stock split of 1 share into ${k}. The theoretical price after the split is:`, p / k,
      [p * k, p, p / (k + 1), p / (k * 2)], (x) => inr(x, 2), 'New price = old price ÷ split ratio.');
  },
  (r) => {
    const n = pick(r, [2, 3, 4, 5]); const r1 = pick(r, [1, 2, 3]); const p = int(r, 20, 200) * 5; const rp = Math.round(p * 0.7);
    const terp = (n * p + r1 * rp) / (n + r1);
    return build(r, `A company offers a rights issue of ${r1} share(s) for every ${n} held at ₹${rp}; the market price is ₹${p}. The theoretical ex-rights price is:`, terp,
      [(p + rp) / 2, p - rp, (n * p) / (n + r1), p], (x) => inr(x, 2), 'TERP = (N × market price + R × rights price) ÷ (N + R).');
  },
  (r) => {
    const d = pick(r, [2, 4, 5, 8, 10]); const p = int(r, 40, 800);
    return build(r, `A stock pays a dividend of ₹${d} per share and trades at ₹${p}. The dividend yield is:`, (d / p) * 100,
      [(p / d), (d / p) * 200, d, (d / p) * 50], (x) => pct(x, 2), 'Yield = dividend ÷ price.');
  },
  (r) => {
    const a = int(r, 15000, 26000); const b = a + int(r, -800, 900);
    return build(r, `An index moves from ${a} to ${b}. The percentage change is:`, ((b - a) / a) * 100,
      [(b - a), ((a - b) / a) * 100, ((b - a) / b) * 100 * 2, (b / a) * 100], (x) => pct(x, 2), '% change = (new − old) ÷ old.');
  },
];
