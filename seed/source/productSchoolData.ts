export interface ProductLessonFaq {
  q: string;
  a: string;
}

export interface ProductLesson {
  id: string;
  title: string;
  durationMinutes: number;
  overview: string;
  features: string[];
  investorSuitability: string;
  fundsIndiaAdvantage: string;
  advisorPitchGuide: string;
  faqList: ProductLessonFaq[];
}

export interface ProductModule {
  id: string;
  code: string;
  name: string;
  shortDesc: string;
  category: string;
  badgeColor: string;
  lessons: ProductLesson[];
}

export const PRODUCT_SCHOOL_MODULES: ProductModule[] = [
  {
    id: 'prod-mod-1',
    code: 'SIP-ENGINE',
    name: 'Smart SIP Architectures & Step-Up Compounding',
    shortDesc: 'Automated annual top-ups, flexi-triggers, and dividend reinvestment optimization.',
    category: 'Systematic Investing',
    badgeColor: 'bg-emerald-100 text-emerald-800',
    lessons: [
      {
        id: 'sip-les-1',
        title: 'Step-Up SIP Mechanics & Wealth Multiplier',
        durationMinutes: 20,
        overview: 'Step-Up SIP allows investors to automatically increase their SIP installment by a predefined percentage (e.g., 10%) or fixed sum (e.g., ₹1,000) every year in tandem with salary increments. This counters lifestyle inflation and supercharges terminal corpus growth.',
        features: [
          'Automatic annual indexation aligned with employee salary increments',
          'Cap threshold option (e.g. stop increasing once SIP reaches ₹50,000/month)',
          'Multiplies 20-year terminal corpus by up to 2.2x compared to a flat SIP',
          'Seamless bank mandate management without needing a new NACH every year',
        ],
        investorSuitability: 'Salaried professionals aged 24-45 with regular annual increments seeking aggressive retirement or milestone corpus building.',
        fundsIndiaAdvantage: 'FundsIndia was the pioneer of automated Step-Up SIPs in India. Our engine allows date-based, anniversary-based, or manual bump triggers with zero platform transaction fees.',
        advisorPitchGuide: 'Mr. Sharma, if you invest ₹10,000/month for 20 years at 12%, you will accumulate ~₹1 Crore. But if you simply step it up by 10% each year—matching your normal salary raise—your corpus becomes ₹2.25 Crores! You invest 2x more over time, but accumulate more than double the wealth with no extra effort.',
        faqList: [
          {
            q: 'Can the client modify or pause the Step-Up percentage later?',
            a: 'Yes, FundsIndia allows one-click modification or capping of the step-up parameter without stopping the underlying SIP.',
          },
          {
            q: 'Does Step-Up require a higher initial bank mandate?',
            a: 'We recommend registering an e-NACH mandate with a maximum debit limit (e.g. ₹1 Lakh) to accommodate future automated annual step-ups.',
          },
        ],
      },
      {
        id: 'sip-les-2',
        title: 'Flexi-SIP & Volatility Buying Trigger',
        durationMinutes: 25,
        overview: 'Flexi-SIP dynamically adjusts monthly investment amounts based on market valuation metrics (P/E ratio, 200-day moving average). When markets are undervalued, the system invests up to 3x the base amount; when valuations are stretched, it invests the minimum base.',
        features: [
          'Algorithmic valuation triggers without requiring manual market timing',
          'Higher allocation during market corrections for maximum unit accumulation',
          'Disciplined capital preservation during speculative bull market peaks',
          'Backed by FundsIndia proprietary research signals',
        ],
        investorSuitability: 'High-conviction investors with variable monthly surplus who want algorithmic market-valuation advantages.',
        fundsIndiaAdvantage: 'Proprietary quantitative valuation models calibrated over 15 years of market cycles, automated seamlessly via our smart order router.',
        advisorPitchGuide: 'Instead of trying to time the market yourself, Flexi-SIP acts as an automated institutional buying engine—buying aggressively when quality funds are on discount and maintaining disciplined pace when markets are pricey.',
        faqList: [
          {
            q: 'What happens if the client bank account has insufficient funds for a high trigger?',
            a: 'The system defaults gracefully to the baseline scheduled SIP amount, avoiding mandate bounce charges.',
          },
        ],
      },
    ],
  },
  {
    id: 'prod-mod-2',
    code: 'SIF-WEALTH',
    name: 'FundsIndia Smart Investment Framework (SIF)',
    shortDesc: 'Proprietary goal-based portfolio construction, risk profiling, and annual rebalancing.',
    category: 'Advisory Engines',
    badgeColor: 'bg-blue-100 text-blue-800',
    lessons: [
      {
        id: 'sif-les-1',
        title: 'Three-Bucket Asset Allocation Architecture',
        durationMinutes: 30,
        overview: 'The Smart Investment Framework segregates capital into three distinct temporal buckets: Emergency/Liquidity (0-1 yr), Capital Preservation & Horizon Goals (1-5 yrs), and High-Alpha Compounding (5+ yrs).',
        features: [
          'De-risks investor psychology by securing short-term liquidity first',
          'Eliminates forced panic selling during bear markets',
          'Optimizes post-tax alpha using tax-efficient arbitrage and dynamic bond funds',
          'Dynamic Glide Path that shifts equity to debt as goals approach',
        ],
        investorSuitability: 'All retail and HNI clients planning for multi-stage goals: child education, home purchase, and retirement.',
        fundsIndiaAdvantage: 'Proprietary automated portfolio health check that monitors style drift, fund manager changes, and sector concentration across all folios.',
        advisorPitchGuide: 'We never treat your wealth as a single pool. By insulating your immediate needs in secure short-duration liquid buckets, your long-term equity engine can compound undisturbed through any market volatility.',
        faqList: [
          {
            q: 'How frequently does SIF trigger rebalancing notifications?',
            a: 'Quarterly review notices are generated, with automated rebalancing prompts whenever asset class weights deviate by more than 5%.',
          },
        ],
      },
    ],
  },
  {
    id: 'prod-mod-3',
    code: 'NPS-TIER',
    name: 'National Pension System (NPS) Wealth Architecture',
    shortDesc: 'PFRDA regulatory frameworks, Section 80CCD(1B) tax optimization, and active asset choice.',
    category: 'Retirement & Tax',
    badgeColor: 'bg-purple-100 text-purple-800',
    lessons: [
      {
        id: 'nps-les-1',
        title: 'NPS Tier-I vs Tier-II Strategic Comparison',
        durationMinutes: 25,
        overview: 'A deep dive into PFRDA regulations, corporate co-contribution benefits under Section 80CCD(2), and the extra ₹50,000 tax deduction under 80CCD(1B) beyond the ₹1.5L Section 80C limit.',
        features: [
          'Exclusive ₹50,000 tax deduction saving up to ₹15,600 annually in the 30% tax bracket',
          'Low expense ratio (~0.03% to 0.09%), the cheapest pension fund management in the world',
          'Active Choice: up to 75% equity allocation (Asset Class E) for aggressive long-term compounding',
          'Seamless digital onboarding via FundsIndia POP (Point of Presence) gateway',
        ],
        investorSuitability: 'All salaried and self-employed tax-paying Indian citizens aged 18 to 70.',
        fundsIndiaAdvantage: 'Instant digital PRAN generation, automated annual contribution reminders, and expert PFM (Pension Fund Manager) performance tracking.',
        advisorPitchGuide: 'NPS is the most tax-efficient retirement vehicle in India. You get an exclusive ₹50,000 tax deduction that no other product provides, managed at a near-zero fund management fee of less than 0.09%.',
        faqList: [
          {
            q: 'What is the exit taxation at age 60?',
            a: '60% of the accumulated corpus is 100% tax-free lump sum withdrawal. The remaining 40% is deployed in a life annuity.',
          },
        ],
      },
    ],
  },
];
