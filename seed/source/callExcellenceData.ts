export interface CallRubricScore {
  criteria: string;
  benchmarkExpectation: string;
  maxMarks: number;
}

export interface CallTranscriptLine {
  speaker: 'Advisor' | 'Client';
  text: string;
  isKeyMoment?: boolean;
  note?: string;
}

export interface CallObservationExercise {
  id: string;
  callType: string;
  title: string;
  durationString: string;
  clientPersona: string;
  transcript: CallTranscriptLine[];
  rubricScores: CallRubricScore[];
}

export const CALL_EXCELLENCE_EXERCISES: CallObservationExercise[] = [
  {
    id: 'call-obs-1',
    callType: 'Market Volatility & Panic Reassurance',
    title: 'Managing Investor Panic During a 12% Midcap Correction',
    durationString: '08:45',
    clientPersona: 'Retail Investor (IT Professional, 36 yrs old, ₹35,000 monthly SIP running for 2.5 years, anxious about recent negative 1-year returns)',
    transcript: [
      {
        speaker: 'Advisor',
        text: 'Good afternoon, Mr. Rajesh! Thank you for scheduling this call with FundsIndia. I noticed you requested a review of your Wealth Builder portfolio today. How have things been with you?',
      },
      {
        speaker: 'Client',
        text: 'Hi Amit. Honestly, I am quite stressed. I opened my FundsIndia app yesterday and saw my portfolio in red over the last 12 months. My midcap fund is down 9%. My colleagues are saying markets will fall another 15%, and I am seriously thinking of stopping my SIPs and redeeming before I lose more of my hard-earned money.',
        isKeyMoment: true,
        note: 'Empathy checkpoint: Do NOT interrupt or counter with statistics immediately. Validate the emotional experience first.',
      },
      {
        speaker: 'Advisor',
        text: 'I completely understand why seeing your portfolio in red feels uncomfortable, Rajesh. When you work hard for your monthly savings, watching the dashboard dip naturally triggers anxiety. I would feel the exact same impulse if I looked at a single year in isolation. Can we step back together and look at your primary goal for this portfolio?',
      },
      {
        speaker: 'Client',
        text: 'Well, this is my daughter Ananya\'s higher education fund. She is currently 6 years old, so this money is needed when she turns 18 for her university admission.',
      },
      {
        speaker: 'Advisor',
        text: 'That gives us a clear 12-year runway. Rajesh, in the history of Indian equity markets over the last 25 years, every single rolling 7-to-10 year period has delivered positive compounding, even when investors lived through the 2008 Lehman crisis and the 2020 pandemic crash. When the market drops 10%, your ₹35,000 SIP is actually buying more mutual fund units at discounted NAVs—like a seasonal discount sale on quality assets.',
        isKeyMoment: true,
        note: 'Reframing technique: Connect current volatility to buying units at a discount for an undisrupted 12-year child goal.',
      },
      {
        speaker: 'Client',
        text: 'So stopping my SIP right now would actually lock in the loss and stop me from buying cheaper units?',
      },
      {
        speaker: 'Advisor',
        text: 'Precisely! Stopping your SIP pauses your rupee-cost averaging at the worst possible time. If anything, historical data shows that investors who maintained or stepped up their SIP during market pullbacks achieved 3% to 4% higher terminal returns by year 10. Let\'s keep your existing asset allocation steady. Would you like me to set a quarterly review so we monitor your goal milestones together?',
      },
      {
        speaker: 'Client',
        text: 'That gives me immense clarity and peace of mind, Amit. Let\'s continue the SIP without interruption. Please schedule the next check-in in 3 months.',
      },
    ],
    rubricScores: [
      {
        criteria: 'Empathy & Psychological De-escalation',
        benchmarkExpectation: 'Acknowledges anxiety without dismissing concerns; refrains from defensive rebuttals.',
        maxMarks: 25,
      },
      {
        criteria: 'Goal Anchoring & Horizon Alignment',
        benchmarkExpectation: 'Successfully pivots conversation from short-term noise to long-term milestone horizon.',
        maxMarks: 25,
      },
      {
        criteria: 'Rupee Cost Averaging Demonstration',
        benchmarkExpectation: 'Clear, jargon-free explanation of unit accumulation during NAV dips.',
        maxMarks: 25,
      },
      {
        criteria: 'Regulatory Compliance & Fair Dealing',
        benchmarkExpectation: 'No false return guarantees; SEBI compliance disclosures and disciplined review scheduling.',
        maxMarks: 25,
      },
    ],
  },
  {
    id: 'call-obs-2',
    callType: 'Goal Discovery & Asset Allocation',
    title: 'First-Time Investor Comprehensive Financial Planning Discovery',
    durationString: '12:20',
    clientPersona: 'First-time mutual fund investor (Doctor, 29 yrs old, currently holding ₹12 Lakhs in low-yield savings accounts and FDs)',
    transcript: [
      {
        speaker: 'Advisor',
        text: 'Hello Dr. Sneha, welcome to FundsIndia! As your dedicated Wealth Specialist, my goal today is not to sell you products, but to understand your life milestones and design an optimal allocation strategy. What prompted you to explore mutual funds today?',
      },
      {
        speaker: 'Client',
        text: 'Hello! I have saved around 12 lakhs from my residency and private clinic, but it is just sitting in a bank savings account earning 3%. My parents always told me to do Bank FDs, but with inflation, I feel like my purchasing power is actually shrinking.',
        isKeyMoment: true,
        note: 'Opportunity: Establish inflation concept and the risk of real-capital erosion in guaranteed fixed-income.',
      },
      {
        speaker: 'Advisor',
        text: 'You hit the nail on the head, Dr. Sneha. At 6% retail inflation and 30% tax bracket, a 6.5% bank FD yields an effective post-tax return of approximately 4.5%, meaning your wealth loses 1.5% purchasing power each year in real terms. Before we allocate a single rupee, do you have an emergency buffer of 6 months of living expenses?',
      },
      {
        speaker: 'Client',
        text: 'Yes, my monthly burn rate is about ₹60,000, and I have kept ₹4 Lakhs aside in a separate liquid account.',
      },
      {
        speaker: 'Advisor',
        text: 'That is outstanding discipline. With your emergency fund secure, we can segregate your remaining capital across short-term liquidity, medium-term debt/hybrid needs, and a long-term equity SIP engine. Let me run you through FundsIndia\'s proprietary Smart Investment Framework (SIF) to determine your exact risk score.',
      },
    ],
    rubricScores: [
      {
        criteria: 'Discovery Questioning & Active Listening',
        benchmarkExpectation: 'Uncovers emergency fund status, tax bracket, and goal horizon before recommending schemes.',
        maxMarks: 30,
      },
      {
        criteria: 'Inflation & Real Return Mathematics',
        benchmarkExpectation: 'Accurately explains post-tax real return vs fixed deposit illusion.',
        maxMarks: 30,
      },
      {
        criteria: 'Structured FundsIndia SIF Introduction',
        benchmarkExpectation: 'Frames recommendations inside FundsIndia asset allocation models rather than random hot tips.',
        maxMarks: 40,
      },
    ],
  },
  {
    id: 'call-obs-3',
    callType: 'Direct vs Regular Dissection',
    title: 'Articulating FundsIndia Value Proposition Against DIY Direct Platforms',
    durationString: '10:15',
    clientPersona: 'Tech-savvy DIY investor (Senior Product Manager, 41 yrs old, questioning distributor expense ratio differences)',
    transcript: [
      {
        speaker: 'Client',
        text: 'Amit, I like the FundsIndia platform, but I noticed that direct plans on discount brokers have a 0.5% lower expense ratio than regular plans. Why should I pay that difference?',
      },
      {
        speaker: 'Advisor',
        text: 'That is a very fair and financially prudent question, Vivek. Many savvy investors calculate that 0.5% difference on paper. However, let\'s examine where the actual returns are made or lost in mutual funds: is it in the 0.5% expense ratio, or is it in investor behaviour, asset rebalancing, and tax harvesting?',
        isKeyMoment: true,
        note: 'Framing: Don\'t hide the expense ratio difference. Contrast expense friction against costly DIY behavioral mistakes.',
      },
      {
        speaker: 'Advisor',
        text: 'Dalbar and RBI studies show that the average DIY investor underperforms the very funds they invest in by 3% to 4% annually due to emotional timing—buying at market peaks and selling at market bottoms. At FundsIndia, you receive automated annual portfolio rebalancing, tax-loss harvesting alerts, dedicated advisory reviews, and proactive risk de-risking as you approach goal maturity. An annual advisory alpha of 2% easily outperforms a 0.5% cost differential.',
      },
      {
        speaker: 'Client',
        text: 'I had not considered the cost of panic selling or failing to rebalance. When you put it in terms of behavioural alpha and tax-harvesting, the value is evident.',
      },
    ],
    rubricScores: [
      {
        criteria: 'Transparency & Respect for Client Inquiry',
        benchmarkExpectation: 'Addresses expense difference directly without defensiveness.',
        maxMarks: 25,
      },
      {
        criteria: 'Behavioural Alpha & Value Articulation',
        benchmarkExpectation: 'Cites Dalbar/SEBI investor return gap vs fund return gap accurately.',
        maxMarks: 35,
      },
      {
        criteria: 'FundsIndia Platform Capabilities',
        benchmarkExpectation: 'Highlights automated rebalancing, tax-harvesting, and dedicated human support.',
        maxMarks: 40,
      },
    ],
  },
];
