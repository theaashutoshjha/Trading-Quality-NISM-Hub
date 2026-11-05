export interface ApprovedFrameworkSteps {
  step1Empathize: string;
  step2Clarify: string;
  step3MathematicalProof: string;
  step4CallToAction: string;
}

export interface ObjectionScenario {
  id: string;
  category: string;
  objectionTitle: string;
  clientDialogue: string;
  rootAnxiety: string;
  wrongResponses: string[];
  approvedFramework: ApprovedFrameworkSteps;
  modelResponseScript: string;
}

export const OBJECTION_SCENARIOS: ObjectionScenario[] = [
  {
    id: 'obj-1',
    category: 'Market Timing & Valuation',
    objectionTitle: 'Nifty is at All-Time Highs: "I will wait for a correction before investing"',
    clientDialogue: 'Nifty just crossed an all-time high record. Everyone in my office is saying the market is overvalued. I want to wait on cash until there is a 10% to 15% correction before starting my SIP.',
    rootAnxiety: 'Fear of immediate capital regret and buying at the absolute market peak before an imminent crash.',
    wrongResponses: [
      'Don\'t worry, the market will never crash under this government!',
      'You are completely wrong; you cannot time the market, just give us the money now.',
      'If you wait, you will miss out and regret it later.',
    ],
    approvedFramework: {
      step1Empathize: 'Acknowledge that investing at headline market peaks feels counterintuitive and psychologically daunting.',
      step2Clarify: 'Distinguish between an index at an "All-Time High" (which growing economies hit dozens of times a year) vs corporate earnings growth.',
      step3MathematicalProof: 'Present rolling SIP historical data: in 87% of historical instances where Nifty hit an all-time high, 5-year subsequent SIP returns were positive with median returns exceeding 12.8%. Waiting on cash for corrections typically misses the best upside days.',
      step4CallToAction: 'Propose a 6-month Systematic Transfer Plan (STP) from a Liquid/Arbitrage fund into diversified equity to capture any potential dip without staying in zero-return cash.',
    },
    modelResponseScript: 'Mr. Verma, that is an intuitive and very understandable hesitation. Seeing news headlines about "All-Time Highs" makes anyone pause. But let us consider this: India\'s GDP and corporate earnings have grown more than 6x over the last 20 years, which means the market has naturally touched new all-time highs hundreds of times on its way up. If an investor in 2014 waited for the market to drop when Nifty first crossed 6,000, they waited on the sidelines while it marched to 10,000, 15,000, and 25,000. Rather than trying to outsmart daily swings, let us place your capital in a secure FundsIndia Liquid Fund today earning 6.8%, and set up a weekly Systematic Transfer Plan (STP) into your chosen equity fund over 24 weeks. If the market dips, your STP automatically buys cheaper units; if it climbs, your money is already compounding. Shall we activate this STP today?',
  },
  {
    id: 'obj-2',
    category: 'Direct vs Regular Plans',
    objectionTitle: 'Expense Difference: "Why shouldn\'t I buy Direct plans on discount broker apps?"',
    clientDialogue: 'I can buy direct plans on Zerodha or Groww and save 0.5% to 0.75% expense ratio every year. Why should I invest through FundsIndia where funds charge the regular plan commission?',
    rootAnxiety: 'Suspicion of unnecessary intermediary costs and desire to optimize fee friction.',
    wrongResponses: [
      'Direct plans are only for institutional investors, retail investors cannot buy them.',
      'Discount apps have hidden charges that they do not tell you about.',
      '0.5% is too small an amount to care about.',
    ],
    approvedFramework: {
      step1Empathize: 'Validate that minimizing investment friction and fees is the hallmark of a smart, analytical investor.',
      step2Clarify: 'Clarify the distinction between Execution-Only discount platforms vs Active Wealth Advisory and human accountability.',
      step3MathematicalProof: 'Demonstrate the "Behavioural Gap" verified by Dalbar and RBI data: the average DIY investor underperforms the very funds they own by 3.5% per annum due to emotional panic selling, chasing hot sector funds, and failing to rebalance. Advisory alpha of 2% easily overtakes a 0.5% expense differential.',
      step4CallToAction: 'Highlight FundsIndia dedicated advisory reviews, automated rebalancing triggers, tax-harvesting engine, and operational concierge.',
    },
    modelResponseScript: 'Vivek, that question proves you are paying close attention to your costs, which I genuinely respect. Many sharp investors do that exact math: 0.5% saved every year sounds compelling. But here is the critical data point: Dalbar and global research show that DIY self-directed investors consistently underperform fund returns by 3% to 4% each year because when markets plunge 20%, an automated app does not call to stop them from panic-selling at the bottom. At FundsIndia, that 0.5% difference funds an entire team of dedicated advisors, quarterly portfolio rebalancing, tax-loss harvesting alerts, and emergency operational support for your family. If our advisory prevents just one emotional mistake over a decade, we have generated multiple times the fee difference in net wealth. Isn\'t having professional guidance and personalized oversight worth that protection?',
  },
  {
    id: 'obj-3',
    category: 'Bank FD vs Mutual Funds',
    objectionTitle: 'Capital Safety: "My bank is giving 7.5% guaranteed interest; mutual funds can lose money"',
    clientDialogue: 'My HDFC bank manager offered me a 7.5% 3-year Fixed Deposit with 100% safety. Why should I take risk in mutual funds when returns are not even guaranteed?',
    rootAnxiety: 'Need for absolute capital preservation and aversion to market fluctuation.',
    wrongResponses: [
      'Bank FDs are a terrible investment and only for uneducated people.',
      'Mutual funds always give 15% to 18% return guaranteed.',
      'Banks can go bankrupt anytime.',
    ],
    approvedFramework: {
      step1Empathize: 'Acknowledge the deep comfort and peace of mind that comes with fixed bank guarantees.',
      step2Clarify: 'Introduce the invisible risk: inflation erosion and post-tax real return destruction.',
      step3MathematicalProof: 'Calculate the math: 7.5% FD in 30% tax slab yields 5.25% in hand. If inflation is 6%, real purchasing power drops by 0.75% every year. ₹10 Lakhs in FD loses ₹75,000 of real purchasing value over 10 years.',
      step4CallToAction: 'Recommend a hybrid / multi-asset approach: keep short-term money in FD/Liquid funds, but allocate medium-to-long term wealth in hybrid equity for inflation-beating compounding.',
    },
    modelResponseScript: 'Mrs. Iyer, bank FDs have been the foundation of Indian household savings for generations, and for short-term needs within the next 12 months, a bank FD is perfectly suitable. But let us look at what happens to your purchasing power after taxes: at 7.5% interest, in your 30% tax bracket, the post-tax return is just 5.25%. Meanwhile, healthcare and education costs are rising at 8% to 10% per year. So while the bank guarantee ensures your nominal rupees won\'t drop, inflation quietly erodes what those rupees can actually buy. To protect your future lifestyle, we don\'t have to take reckless risks—we can allocate a portion into conservative hybrid or multi-asset funds that combine equity growth with debt stability. Shall we calculate the ideal split for your goals?',
  },
  {
    id: 'obj-4',
    category: 'Short-Term Underperformance',
    objectionTitle: 'Drawdown Frustration: "My portfolio is negative after 1 year; I want to stop my SIP"',
    clientDialogue: 'I have been putting in ₹25,000 every month for 12 months, and my current portfolio value is less than what I invested. I was told mutual funds give good returns, but this looks like a scam.',
    rootAnxiety: 'Disillusionment, betrayal, and feeling like the investment vehicle has failed them.',
    wrongResponses: [
      'One year is nothing, you should not look at your portfolio for 5 years.',
      'The fund manager made mistakes, but it will recover someday.',
      'Markets are like that, everyone is losing money right now.',
    ],
    approvedFramework: {
      step1Empathize: 'Directly acknowledge the frustration of dutifully saving each month only to see a lower balance.',
      step2Clarify: 'Explain the mechanics of equity compounding: equity returns are non-linear (lumpy), not fixed annual straight lines.',
      step3MathematicalProof: 'Show that during the first 1-2 years of an SIP, down markets are actually your greatest wealth generator because your fixed ₹25,000 accumulates more units at discounted prices. When the market turns, the accumulated units surge in value.',
      step4CallToAction: 'Review the underlying fund quality to confirm fundamentals are sound and reaffirm the 5-year target horizon.',
    },
    modelResponseScript: 'Mr. Ananth, I hear you, and you have every right to feel disappointed. When you diligently transfer ₹25,000 every single month from your salary, seeing a negative balance feels completely counter to what you hoped for. May I explain why this 1-year dip is actually the best thing that could happen to your 10-year goal? Think of mutual fund units like grocery items on sale. In months where NAV is down 10%, your ₹25,000 purchases 10% more units. When the market eventually rallies back to its long-term average, all those discounted units accelerate your returns. Investors who stopped their SIPs during previous dips in 2011, 2015, or 2020 missed the massive compounding wave that followed. Let us review your fund portfolio together today to ensure all funds maintain top-quartile fundamentals.',
  },
];
