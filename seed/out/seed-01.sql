INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q29','nism-5a-z1','Sectoral/thematic funds can have portfolio overlap with other equity schemes (other than large cap) of at most:','["75%","50%","25%","10%"]',1,'Overlap limit is 50%.',29) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q30','nism-5a-z1','Mutual fund industry AUM reached ₹79.46 lakh crore in March 2026, having been ₹12.33 lakh crore in March 2016. The CAGR is about:','["30%","8%","20.48%","12%"]',2,'As per the workbook growth data.',30) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q31','nism-5a-z1','Balanced Hybrid funds hold equity of:','["40–60%, debt 40–60%, with no arbitrage","10–25%","≥65%","65–80%"]',0,'Balanced hybrid: equity 40–60%, debt 40–60%.',31) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q32','nism-5a-z1','An ELSS must invest at least ___ in equity.','["90%","75%","65%","80%"]',3,'ELSS: ≥80% equity with 3-year lock-in.',32) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q33','nism-5a-z1','An Equity Savings fund holds at least ___ equity and ___ debt, with net equity of 15–40%.','["50%; 20%","65%; 10%","75%; 15%","80%; 5%"]',1,'Equity savings: ≥65% equity, ≥10% debt, net equity 15–40%.',33) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q34','nism-5a-z1','For an interval fund, the minimum transaction period and interval period are respectively:','["3 days and 60 days","2 days and 15 calendar days","1 day and 7 days","5 days and 30 days"]',1,'Transaction period at least 2 days; interval period at least 15 calendar days.',34) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q35','nism-5a-z1','A Credit Risk fund must invest at least ___ in corporate bonds rated AA and below (excluding AA+).','["80%","75%","65%","50%"]',2,'Credit risk ≥65% in AA and below.',35) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q36','nism-5a-z1','"Mark to Market" in a mutual fund means:','["Valuation at cost price","Valuation once a year","Daily valuation of each security at current market value","Valuation at face value"]',2,'MTM ensures NAV reflects true worth.',36) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q37','nism-5a-z1','The maximum unhedged short exposure in a SIF strategy is:','["50% of NAV","25% of NAV","10% of NAV","100% of NAV"]',1,'Only one strategy per category may be offered.',37) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q38','nism-5a-z1','Index funds and ETFs must invest at least ___ in the index securities.','["75%","65%","80%","95%"]',3,'Index funds/ETFs ≥95%; Fund of Funds ≥95% in the underlying fund.',38) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q39','nism-5a-z1','REITs and InvITs are:','["Mutual fund schemes","Registered with SEBI but not mutual fund schemes","Regulated by RBI","Bank deposits"]',1,'They are listed trust structures, not mutual funds.',39) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q40','nism-5a-z1','Assets Under Management (AUM) of a scheme equals:','["Face value × investors","Number of folios × NAV","NAV × units outstanding","Unit capital − expenses"]',2,'AUM = NAV × units outstanding.',40) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q41','nism-5a-z1','The minimum investment per investor in Specialized Investment Funds (SIF) across an AMC''s SIF strategies is:','["₹50 lakh","₹1 lakh","₹5 lakh","₹10 lakh"]',3,'SIF bridges the gap between MFs and PMS.',41) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q42','nism-5a-z1','Which statement about ETFs is correct?','["They can only be bought in the NFO","They have a single end-of-day price only","They trade on a stock exchange throughout the day and need a demat account","They are always actively managed"]',2,'ETFs have multiple intra-day prices vs a single NAV for open-ended funds.',42) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q43','nism-5a-z1','The Macaulay duration of an Ultra-Short Term fund portfolio is:','["3 to 6 months","6 to 12 months","1 to 3 years","Above 7 years"]',0,'Ultra short: 3–6 months; Low duration: 6–12 months.',43) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q44','nism-5a-z1','An Overnight fund invests in securities with a maturity of:','["1 year","1 day","7 days","91 days"]',1,'Overnight = 1-day maturity securities.',44) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q45','nism-5a-z1','The statutory lock-in of an ELSS is:','["5 years","1 year","10 years","3 years from each investment"]',3,'Each SIP instalment is locked for 3 years separately.',45) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q46','nism-5a-z1','In a Life Cycle Fund, as maturity approaches:','["Equity increases and debt reduces","Equity reduces and debt increases","Gold is increased to 100%","Both stay constant"]',1,'This is the glide path.',46) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q47','nism-5a-z1','Overnight funds may keep at most ___ in G-secs/T-bills of up to 30 days as margin.','["5%","20%","10%","15%"]',0,'Overnight funds may place ≤5% as margin.',47) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q48','nism-5a-z1','A Large & Mid Cap fund must invest at least:','["80% in large caps","35% in large caps and 35% in mid caps","65% in mid caps","25% each in large and mid caps"]',1,'Large & Mid Cap: ≥35% large + ≥35% mid.',48) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q49','nism-5a-z1','ELSS investors can claim deduction under Section 80C up to:','["₹50,000 under any regime","₹2,50,000 under the New Tax Regime","₹5,00,000 under the Old Tax Regime","₹1,50,000 under the Old Tax Regime"]',3,'Deduction up to ₹1.5 lakh, Old Tax Regime only.',49) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q50','nism-5a-z1','A Focused fund can hold a maximum of:','["100 stocks","20 stocks","50 stocks","30 stocks"]',3,'Focused: max 30 stocks, ≥80% in equity.',50) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q51','nism-5a-z1','Which of the following is NOT an advantage of mutual funds?','["Transparency","Professional management","Affordable diversification","Guaranteed returns"]',3,'Mutual funds are pass-through vehicles; returns are never guaranteed.',51) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z1-q52','nism-5a-z1','A close-ended scheme can be bought by investors:','["Only during the NFO","Only during transaction periods","At any time at NAV","Only on Sundays"]',0,'Close-ended units are bought in the NFO and then traded on exchange.',52) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m3','nism-5a','Ch 3: Legal Structure of Mutual Funds in India',4,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-AA8Y_k69Wh0','nism-5a','nism-5a-m3','Video lesson: Chapter 3: Legal Structure of Mutual Funds','video','AA8Y_k69Wh0','',32,'N V Finance',1,14) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l15','nism-5a','nism-5a-m3','Summary notes 1/3: Definition, Structure and Who Does What to Asset Management Company','note','## Definition, Structure and Who Does What

- **Mutual Fund:** Definition & Structure

- SEBI (MF) Regulations 2026: a fund set up as a trust, registered under Reg. 3, raising money by sale of units under one or more schemes
- Invests in securities, money market, gold/silver & related instruments, real estate & other SEBI-specified assets
- Must set up a separate AMC to run the business
- **Three-tier structure:** Sponsor → Trust (Trustees) → AMC
- Governed by Indian Trusts Act, 1882; beneficiaries = unitholders
- Trust Deed executed between sponsor and trustees (SEBI-specified clauses); registered under Indian Registration Act, 1908

- **Who Does What**

| Constituent | Role / appointed by |
| --- | --- |
| Sponsor | Creates the trust; applies to SEBI; invests in AMC capital |
| Trustees | Protect unitholders; individuals (Board of Trustees) or trustee company |
| AMC | Day-to-day management; appointed by sponsor/trustees via investment management agreement |
| Custodian | Holds scheme assets; appointed by trustees |
| RTA | Maintains investor records; appointed by AMC (optional) |

## Sponsor Eligibility

- Sound track record, reputation of fairness & integrity; fit and proper
- In financial services business for ≥ 5 years
- Positive net worth in each of the preceding 5 years
- Positive liquid net worth > proposed capital contribution to AMC
  - **On change in control:** liquid net worth ≥ higher of par/market value of shares acquired
- Net profit (after depreciation, interest & tax) in each of preceding 5 years
- Average annual net profit ≥ ₹10 crore over preceding 5 years
- **AMFI lists AMCs by sponsor category:** banks, institutions, private (Indian, foreign, JVs)

## Trustees

- **Eligibility (Reg. 11):** fit & proper; not a director/officer/employee of an AMC; not trustee of another MF; provide SEBI info
- Prior SEBI approval needed
- At least 2/3 of trustee board must be independent (not associates of sponsor/AMC/trustee co.)
- Rights & responsibilities:
  - Appoint and terminate AMC
  - Address conflicts of interest & broker empanelment
  - Regulatory compliance; oversight for investor interests
  - Due diligence on matters specified by SEBI

## Asset Management Company

- Appointed by sponsor/trustees with SEBI approval
- **Directors:** experienced in finance; fit & proper; ≥50% not associates of sponsor or trustees
- AMC directors cannot sit on any trustee board; cannot be director of more than one AMC
- Net worth ≥ ₹50 crore (from 1 Jan 2024), maintained continuously – sponsor''s duty
- **Change in control:** trustees + SEBI approval; notify unitholders + ads; exit at NAV without load ≥ 30 calendar days
- Runs offices, staff, software, marketing; due diligence in investments
- Can be terminated by majority of trustees or 75% of unitholders (SEBI + unitholder approval)',12,1,15) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l16','nism-5a','nism-5a-m3','Summary notes 2/3: Custodian to Service Providers (2/2)','note','## Custodian

- Holds the fund''s assets; settles purchase & sale transactions
- Registered with SEBI (Custodian Regulations 1996); appointed by trustees under custodial agreement
- **Independence:** if sponsor/associates hold ≥50% voting rights or ≥50% directors – cannot act (unless conditions met)
- **Tracks corporate actions:** dividends, bonus, rights

## Organisation Structure of an AMC

- **Compliance:** signs due-diligence certificate for scheme documents; reports to AMC head; reports non-compliance to trustees
- Fund management (core function):
  - Analysts – identify opportunities (equity, credit, interest rates)
  - Fund managers – decide investments; responsible for performance
  - Dealers – place orders with brokers
- **Operations & customer service:** front office, back office, call centres, chatbots; RTA; custody team; fund accounting (daily NAV)
- **Risk Management Framework:** independent risk function – officers for investment, compliance, operational & cyber risk
- **Sales & marketing:** branding, ads, events, distributor relationships & training
- **Support:** Accounts (AMC finances), Administration, HRD, IT

## Service Providers (1/2)

- **Fund accountant:** calculates NAV; in-house or outsourced; no SEBI registration needed
- **RTA:** investor records (folios), purchase/redemption processing, unit capital updates; ISCs; appointed by AMC; SEBI-registered; optional
- **Auditors:** scheme auditor (appointed by trustees) must differ from AMC auditor (appointed by AMC)
- **Distributors:** individuals or institutions; pass NISM V-A + AMFI registration (ARN); can work with many AMCs
  - **New cadre:** NISM V-B Foundation – sell limited set of schemes
- Collecting bankers (appointed by AMC) & payment aggregators (gateways, wallets, payment banks)

## Service Providers (2/2)

- **KYC Registration Agencies (KRAs):** common KYC under PMLA; SEBI-registered (2011 regulations); share data; maintain confidentiality
- **Valuation agencies:** CRISIL & ICRA appointed by AMFI for non-traded/thinly traded debt
- **Credit rating agencies:** initial input for debt investing; define corporate bond & credit risk funds; FMPs disclose proposed rating profile
- **Depositories:** NSDL & CDSL, via Depository Participants; ETF units compulsorily demat
- **Stock exchange platforms:** BSE StAR MF, NSE NMF-II; MF Utilities (AMFI initiative)
- **MF Central:** investor hub by KFintech & CAMS',12,1,16) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l17','nism-5a','nism-5a-m3','Summary notes 3/3: Execution Only Platforms (EOP) to Role of AMFI','note','## Execution Only Platforms (EOP)

- Digital platforms for subscription, redemption & switch in direct plans
- **Not covered:** platforms of SEBI RIAs and stock brokers for their own clients

| Category 1 EOP | Category 2 EOP |
| --- | --- |
| Registered with AMFI | Registered as stock broker (EOP segment of exchanges) |
| Body corporate; agent of AMCs | Body corporate; agent of investor |
| Integrates with AMCs/RTAs; may aggregate | Operates only via exchange platforms |

## Role of AMFI

- Association of all SEBI-registered AMCs
- Maintain professional & ethical standards; promote best practices & code of conduct
- Represent industry to SEBI, Government, RBI
- Nationwide investor awareness; data, studies & research
- Register distributors – allot ARN (mandatory); regulate conduct incl. ARN cancellation
- Protect investor interests; issue best-practice circulars
- AMFI is neither a regulator nor an SRO',6,1,17) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z2','nism-5a','nism-5a-m3','Chapter 3 practice',24,50,0,0,0,1,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q0','nism-5a-z2','The minimum net worth of an AMC (from 1 January 2024) is:','["₹25 crore","₹10 crore","₹50 crore","₹100 crore"]',2,'Maintained continuously; the sponsor''s duty.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q1','nism-5a-z2','A custodian cannot act for the fund if the sponsor or its associates hold ___ or more of the voting rights.','["10%","25%","50%","75%"]',2,'Unless specified conditions are met.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q2','nism-5a-z2','The fund accountant calculates:','["Distributor commission","Tax on IDCW","NAV","KYC status"]',2,'No SEBI registration is required for the fund accountant.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q3','nism-5a-z2','At least what proportion of the board of trustees must be independent?','["One-half","Three-fourths","Two-thirds","One-third"]',2,'Independent = not associates of sponsor/AMC/trustee company.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q4','nism-5a-z2','The custodian is appointed by:','["AMFI","The AMC","The sponsor","The trustees"]',3,'Custodians are registered with SEBI under the Custodian Regulations, 1996.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q5','nism-5a-z2','A sponsor must have been in the financial services business for at least:','["5 years","1 year","3 years","10 years"]',0,'Also positive net worth and net profit in each of the preceding 5 years.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q6','nism-5a-z2','The average annual net profit of a sponsor over the preceding 5 years must be at least:','["₹50 crore","₹5 crore","₹1 crore","₹10 crore"]',3,'This is part of sponsor eligibility.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q7','nism-5a-z2','On a change in control of an AMC, unitholders must be given an exit option at NAV without load for at least:','["15 days","7 days","30 calendar days","90 days"]',2,'Also notice to unitholders and advertisement.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q8','nism-5a-z2','Execution Only Platforms (EOP) facilitate transactions in:','["Insurance products","Close-ended schemes only","Regular plans only","Direct plans"]',3,'Platforms of RIAs and stockbrokers for their own clients are not covered.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q9','nism-5a-z2','The scheme auditor is appointed by:','["AMFI","The trustees","The AMC","SEBI"]',1,'The scheme auditor must differ from the AMC auditor (appointed by the AMC).',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q10','nism-5a-z2','Which of the following is a stock exchange platform for mutual fund transactions?','["CAN","BSE StAR MF","SCORES","MF Central"]',1,'Also NSE NMF-II.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q11','nism-5a-z2','MF Central is an investor hub created by:','["CRISIL and ICRA","NSDL and CDSL","CAMS and KFintech","BSE and NSE"]',2,'It went live on 31 December 2021.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q12','nism-5a-z2','AMFI is:','["Neither a regulator nor a self-regulatory organisation","A stock exchange","A regulator","A government ministry"]',0,'AMFI is an association of AMCs and issues ARN.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q13','nism-5a-z2','Beneficiaries of the mutual fund trust are:','["The AMC","The trustees","The sponsor","Unitholders"]',3,'Trustees hold the assets for unitholders.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q14','nism-5a-z2','The AMC can be terminated by:','["AMFI alone","The distributor","A majority of trustees or 75% of unitholders","The custodian"]',2,'SEBI and unitholder approval are needed.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q15','nism-5a-z2','The Registrar and Transfer Agent (RTA) is appointed by:','["The AMC","The trustees","The custodian","SEBI"]',0,'The RTA is optional; the AMC can do it in-house.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q16','nism-5a-z2','Valuation agencies appointed by AMFI for non-traded/thinly traded debt are:','["CIBIL and Equifax","CAMS and KFintech","NSDL and CDSL","CRISIL and ICRA"]',3,'They provide valuation inputs.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q17','nism-5a-z2','At least ___ of the AMC directors must not be associates of the sponsor or trustees.','["50%","75%","25%","100%"]',0,'AMC directors cannot sit on any trustee board.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q18','nism-5a-z2','The three-tier structure of a mutual fund is:','["SEBI → Sponsor → Distributor","RTA → AMC → Trustees","Sponsor → Trust (Trustees) → AMC","Sponsor → AMC → Custodian"]',2,'Sponsor creates the trust; trustees oversee; AMC manages.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z2-q19','nism-5a-z2','The ARN (AMFI Registration Number) is allotted by:','["RBI","SEBI","NISM","AMFI"]',3,'ARN is mandatory for distributors.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m4','nism-5a','Ch 4: Legal and Regulatory Framework',10,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-QBiKF20D4h4','nism-5a','nism-5a-m4','Video lesson: Chapter 4: Legal & Regulatory Framework','video','QBiKF20D4h4','',40,'N V Finance',1,18) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l19','nism-5a','nism-5a-m4','Summary notes 1/4: Regulators in India and the Role of SEBI to Investment Universe – Regulation 39','note','## Regulators in India and the Role of SEBI

- **Regulators in India**

- **Purpose:** protect consumers of financial products + orderly market development

| Regulator | Regulates |
| --- | --- |
| RBI | Banking system and money markets (also forex) |
| SEBI | Securities markets – MFs, depositories, custodians, RTAs, CRAs |
| IRDAI | Insurance |
| PFRDA | Pension |

- All come under the Ministry of Finance
- ''Securities'' defined in Sec 2(h) of Securities Contracts (Regulation) Act, 1956

- **Role of SEBI**

- **Preamble:** protect investors'' interests, promote development of, and regulate the securities market
- **Three focus areas:** issuer disclosures, efficient transactions, low transaction costs
- **Also curbs:** speculation, insider trading, excessive MF risk, inadequate collateral
- MF Regulations first issued 1996 → replaced by SEBI (MF) Regulations 2026
- Master Circulars on www.sebi.gov.in consolidate circulars
- MFs also follow RBI rules (money market, overseas investment, forex) and stock exchange rules

## SEBI Regulation Categories (1/2)

- **Scheme related documents:** content, frequency; benchmark against Total Return Index (TRI) not Price Return Index
- Registration of AMC, sponsor, trustees; AMC mergers & management change
- **Conversion & consolidation:** one scheme per category; merger procedure
  - Potential Risk Class (PRC) matrix for debt schemes – max interest rate risk (Macaulay duration) × max credit risk (CRV)
- New products (e.g. IDFs, ESG)
- **Risk management:** operational risk, exposure limits, segregated portfolios (after 2018 credit crisis)
  - **2008 reforms:** no premature FMP redemption; "liquid plus" names banned
- Disclosures & reporting norms; governance norms (audit & valuation committees, minimum investors, systems audit)

## SEBI Regulation Categories (2/2)

- Secondary market activities; NAV (rounding, cut-off, time stamping); Valuation
- Loads, fees & expenses incl. commission disclosure
- IDCW distribution procedure (distributable surplus)
- Investment by schemes – restrictions & limits
- Advertisements – content, disclaimers, frequency
- Investor rights & obligations – statements, payout delays & penalty, instant access in liquid funds
- Certification & registration of intermediaries incl. CPE
- Transactions in MF units – exchanges, records, KYC
- Corporate Debt Market Development Fund (CDMDF); Execution Only Platforms; MF Lite; SIF; Miscellaneous

## Investment Universe – Regulation 39

- AMC may invest scheme funds only in:
  - Securities
  - Money market instruments
  - Privately placed debentures
  - Securitised debt (asset-backed / mortgage-backed)
  - Gold or gold-related instruments
  - Silver or silver-related instruments
  - Any other asset specified by SEBI
- MF is a pass-through vehicle – restrictions control fund manager risks; apply at time of investment',12,1,19) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l20','nism-5a','nism-5a-m4','Summary notes 2/4: Investment Restrictions – Regulation 41 to Performance Advertising Rules','note','## Investment Restrictions – Regulation 41

- All investments (except gold/silver ETFs) subject to Sixth Schedule limits
- **Gold/silver ETFs:** invest only in gold/silver instruments (plus liquidity); may use exchange-traded commodity derivatives; pending deployment → short-term bank deposits
- Settle transactions only in demat securities (except specified)
- No carry-forward transactions (except as specified)
- Derivatives only on recognised exchanges
- Short selling only on exchange under SLB framework
- Inter-scheme transfers as per SEBI conditions

## Investment Restrictions – Sixth Schedule

- Equity & debt only in listed/to-be-listed securities – except unlisted G-secs, money market (not CPs), unlisted NCDs as specified
- Unrated debt – subject to SEBI conditions
- Inter-scheme investment allowed without fees, within limits (not for FoFs)
- No scheme may invest in a Fund of Funds; FoF cannot invest in another FoF
- FoF invests only in MF schemes (except liquidity needs)
- All purchases/sales on delivery basis (exceptions: short selling, derivatives, G-sec as per RBI)
- Securities held in the name of the mutual fund for the scheme
- Pending deployment → short-term deposits of scheduled commercial banks

## SEBI Advertisement Code (Fifth Schedule)

- Accurate, true, fair, clear, complete, unambiguous, concise – not misleading
- No projections, testimonials or rankings; no exaggerated slogans
- No celebrities in scheme/AMC ads
- Avoid jargon and excessive detail; consistent with SID, SAI, KIM
- No discrediting others or unfair comparisons
- **Standard warning:** "Mutual Fund investments are subject to market risks, read all scheme related documents carefully." – no changes
  - Vernacular ads → warning in same language
  - **Audio-visual:** visual + voice-over, 14 words for ≥ 5 seconds
- **IDCW ads:** show ₹ per unit, face value, prevailing NAV; NAV falls to extent of payout + levy
- **Close-ended/interval maturity:** "entire distributable surplus … shall be distributed"

## Performance Advertising Rules

- **Scheme > 3 years:** CAGR for 1, 3, 5 years & since inception (date of allotment) + point-to-point value of ₹10,000
- Data up to last day of preceding month; state regular or direct plan; note fund manager changes
- **Scheme < 6 months:** no performance; 6–12 months: simple annualised 6-month return
- **Overnight, liquid, money market:** simple annualised yields for 7, 15, 30 days
- Also show performance of all other schemes of the same fund manager (1, 3, 5 yr CAGR)
  - > 6 schemes → total count + top 3 and bottom 3
  - Internet ads may link to the summary',12,1,20) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l21','nism-5a','nism-5a-m4','Summary notes 3/4: Standard Additional Benchmarks to Investors'' Rights (2/2)','note','## Standard Additional Benchmarks

| Scheme type | Additional benchmark |
| --- | --- |
| Equity | Sensex / Nifty |
| Debt ≤ 1 yr duration & Arbitrage | 1-year T-Bill |
| Other debt schemes | 10-year GoI security |
| Conservative Hybrid | 10-year GoI security |
| Balanced/Aggressive Hybrid, BAF, Multi Asset | Sensex or Nifty |
| Equity Savings | 10-year GoI security |
| Index Funds/ETFs & FoFs | Based on underlying allocation |
| Retirement / Children''s Fund | Sensex / Nifty |

- Part of SAI and all advertisements

## Celebrity Endorsement & Unauthenticated News

- Celebrities allowed only at industry level – for MF awareness
  - Not for any scheme or AMC branding
  - Paid from industry-pooled investor education funds
  - Prior SEBI approval required
- Unauthenticated news – intermediaries must:
  - Have internal code; staff must not circulate rumours
  - Restrict/supervise access to blogs, chat, messenger
  - Keep logs as records
  - Forward market news only after Compliance Officer approval – else both liable

## Investors'' Rights (1/2)

- **Beneficial ownership:** proportionate right in scheme assets; unit certificate or demat; demat units freely transferable (ELSS restricted during lock-in)
- **Change distributor or go direct:** written request; no NOC needed
- **Inspect documents:** Trust Deed, IMA, custodial & RTA agreements, AMC MoA/AoA
- **Nominees:** up to 3; specify % split (else equal)
- Pledge units as security to a financier
- **Grievance redressal:** complaint status in annual report, AMC & AMFI website; pending complaints may block new schemes

## Investors'' Rights (2/2)

- **Change in fundamental attributes:** written/digital notice + website disclosure + exit at NAV without load for ≥ 30 days
- 75% unitholders can terminate AMC or wind up a scheme
- Trustees must obtain unitholder consent when SEBI or 75% unitholders require, or on winding up/premature redemption
- Can sue trustees (not the trust) for breach of trust
- **Unclaimed amounts:** claimed within 3 yrs → prevailing NAV; after 3 yrs → NAV at end of 3 yrs
  - Deployed in separate liquid fund plan; max fee 0.50% p.a.; no exit load
- Daily disclosure of debt/money market trades with 15-day lag
- **Illiquid security recovered:** substantial & within 2 yrs → old investors; else Investor Education Fund',12,1,21) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l22','nism-5a','nism-5a-m4','Summary notes 4/4: Grievance Redress and Cyber Security to AMFI Codes','note','## Grievance Redress and Cyber Security

- **Grievance Redress & Due Diligence**

- AMCs conduct due diligence on distributors (AMFI may coordinate unified process) – see Ch 6
- **Investor path:** Investor Service Centre → senior AMC levels → SEBI
- AMC must redress within 21 calendar days
- **SCORES:** SEBI''s online system to lodge & track complaints (physical complaints scanned in)
  - Covers listed cos/RTAs, brokers/exchanges, DPs/depositories, MFs, PMS, KRAs, CRAs etc.
- **SMART ODR:** online conciliation & arbitration if unsatisfied with AMC/SCORES
- Caveat emptor applies; prospective investors don''t have unitholder rights

- **Cyber Security & Cyber Resilience**

- SEBI CSCRF for all Regulated Entities – standards based, standard reporting formats
- **Five goals (from CERT-In CCMP):** Anticipate, Withstand, Contain, Recover, Evolve
- Address AI-enabled threats; task force cybersuraksha.ai
- **Report cyber incidents:** mkt_incidents@sebi.gov.in within 6 hours; SEBI Incident Reporting Portal within 24 hours
- Portal aligned with FSB''s FIRE (Format for Incident Reporting Exchange)

## AMFI Codes

- **SEBI Fourth Schedule:** Code of Conduct for AMCs & Trustees (broad principles)
- **AMFI Code of Ethics (ACE):** more explicit, higher standards for AMCs & Trustees
- AGNI – AMFI Guidelines & Norms for Intermediaries: agents, brokers, distribution houses, banks
- Breach procedure:
  - AMFI seeks explanation within 3 weeks
  - No/unsatisfactory reply → warning letter
  - Proven second violation → ARN cancelled; all AMCs informed
  - Intermediary may appeal to AMFI',6,1,22) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z3','nism-5a','nism-5a-m4','Chapter 4 practice',30,50,0,0,0,1,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q0','nism-5a-z3','No scheme of a mutual fund may invest in a:','["Government security","Fund of Funds","Index fund","Liquid scheme"]',1,'A FoF cannot invest in another FoF either.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q1','nism-5a-z3','The additional benchmark for a Conservative Hybrid scheme is:','["10-year GoI security","Sensex/Nifty","Gold","1-year T-bill"]',0,'Balanced/aggressive hybrid use Sensex or Nifty.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q2','nism-5a-z3','Which regulator regulates the securities markets, including mutual funds?','["SEBI","RBI","PFRDA","IRDAI"]',0,'RBI – banking; IRDAI – insurance; PFRDA – pension.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q3','nism-5a-z3','Pending deployment, funds may be kept in short-term deposits of:','["Scheduled commercial banks","NBFCs","Any bank","Co-operative banks"]',0,'Per the Sixth Schedule.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q4','nism-5a-z3','The AMFI guidelines applicable to intermediaries are called:','["CAMS","ACE","SCORES","AGNI"]',3,'ACE = AMFI Code of Ethics for AMCs and trustees.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q5','nism-5a-z3','A mutual fund scheme can undertake short selling:','["Without restriction","Only on exchange under the SLB framework","Only in OTC markets","Only through the AMC"]',1,'Derivatives only on recognised exchanges.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q6','nism-5a-z3','The AMC must redress an investor complaint within:','["6 months","21 calendar days","60 days","7 days"]',1,'Then the investor may approach SEBI SCORES.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q7','nism-5a-z3','Cyber incidents must be reported by email to SEBI within ___ and on the Incident Reporting Portal within ___.','["1 hour; 6 hours","6 hours; 24 hours","24 hours; 48 hours","48 hours; 7 days"]',1,'As per the SEBI CSCRF.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q8','nism-5a-z3','Celebrities in mutual fund advertising are allowed:','["For AMC branding","Without any approval","For any scheme branding","Only at the industry level for MF awareness, with prior SEBI approval"]',3,'Paid from industry-pooled investor education funds.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q9','nism-5a-z3','For a scheme with performance history of more than 3 years, advertisements must show CAGR for:','["Only the last month","1, 3, 5 years and since inception","10 years only","1 and 2 years only"]',1,'Plus the point-to-point value of ₹10,000.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q10','nism-5a-z3','SEBI mutual fund regulations were first issued in 1996 and replaced by:','["SEBI (MF) Regulations, 2020","SEBI (MF) Regulations, 2018","SEBI (Mutual Funds) Regulations, 2026","Companies Act, 2013"]',2,'Per the Sept 2026 workbook.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q11','nism-5a-z3','The Potential Risk Class (PRC) matrix applies to:','["Hybrid schemes only","Equity schemes","ETFs only","Debt schemes"]',3,'Maximum interest rate risk × maximum credit risk.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q12','nism-5a-z3','SEBI''s online system for lodging and tracking investor complaints is:','["ARN","MFU","CAN","SCORES"]',3,'SMART ODR provides online conciliation and arbitration.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q13','nism-5a-z3','For a breach of the AMFI code, AMFI first seeks an explanation from the intermediary within:','["3 weeks","3 months","1 year","3 days"]',0,'A proven second violation leads to ARN cancellation.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q14','nism-5a-z3','On a change in fundamental attributes, unitholders must be given an exit option at NAV without load for at least:','["60 days","30 days","15 days","7 days"]',1,'Plus notice and website disclosure.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q15','nism-5a-z3','Unitholders holding what percentage can terminate the AMC or wind up a scheme?','["66%","90%","75%","51%"]',2,'By resolution of unitholders.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q16','nism-5a-z3','For a scheme older than 6 months but under 12 months, the ad may show:','["CAGR for 5 years","Simple annualised 6-month return","No return at all","Projected returns"]',1,'Schemes <6 months: no performance.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q17','nism-5a-z3','Unclaimed redemption/IDCW amounts, if claimed within 3 years, are paid at:','["NAV at the end of 3 years","Cost price","Face value","Prevailing NAV"]',3,'After 3 years: NAV at the end of 3 years.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q18','nism-5a-z3','An investor can nominate up to ___ nominees in a folio.','["3","1","2","5"]',0,'The percentage split must be specified; otherwise equal.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q19','nism-5a-z3','Unclaimed amounts are deployed in a separate liquid fund plan with a maximum fee of:','["0.10% p.a.","1.00% p.a.","0.50% p.a.","2.00% p.a."]',2,'No exit load.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q20','nism-5a-z3','The standard additional benchmark for equity schemes is:','["Gold price","Sensex or Nifty","10-year GoI security","1-year T-bill"]',1,'Debt ≤1 year and Arbitrage: 1-year T-bill; others: 10-year GoI.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q21','nism-5a-z3','Mutual fund scheme funds may be invested in all EXCEPT:','["Securities","Real estate bought directly by the scheme","Gold","Money market instruments"]',1,'Regulation 39 lists permitted universe including gold and silver instruments.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q22','nism-5a-z3','Scheme performance must be benchmarked against a:','["Gold price","Price Return Index","Bank FD rate","Total Return Index (TRI)"]',3,'TRI includes dividends.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q23','nism-5a-z3','The standard warning in a mutual fund advertisement is:','["\"Returns are guaranteed.\"","\"SEBI recommends this scheme.\"","\"Past performance is always repeated.\"","\"Mutual Fund investments are subject to market risks, read all scheme related documents carefully.\""]',3,'It must be used without changes; in vernacular ads, in the same language.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z3-q24','nism-5a-z3','An investor can change distributor or go direct by:','["Obtaining an NOC from the old distributor","Paying a fee to AMFI","Waiting 3 years","A written request, without NOC from the existing distributor"]',3,'No NOC is required.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m5','nism-5a','Ch 5: Scheme Related Information',10,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-Y5qUlpr4HZo','nism-5a','nism-5a-m5','Video lesson: Chapter 5: Scheme Related Information','video','Y5qUlpr4HZo','',44,'N V Finance',1,23) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l24','nism-5a','nism-5a-m5','Summary notes 1/3: Scheme Related Documents to Fundamental Attributes','note','## Scheme Related Documents

- **Mandatory:** Scheme Information Document (SID), Statement of Additional Information (SAI), Key Information Memorandum (KIM)
- Caveat emptor – investor presumed to have read them; signing the form = accepting the offer (contract)
- **SID:** scheme-specific details · SAI: statutory info on the MF/AMC – one SAI for all schemes (legally part of SID)
- SEBI-prescribed format & sequence; simple language; MF may add material disclosures
- SEBI does not approve – it "vets" (gives observations)
- Drafts on SEBI website; final documents on AMFI website and AMC website

## SID – Cover Page & Structure

- **Cover page:** scheme name, type (open/close/interval; equity/debt…), face value, NFO dates, SID date, MF, AMC & trustee details
- **Standard clause:** filed with SEBI with AMC''s Due Diligence Certificate; not approved/recommended by SEBI
- Risk-o-meter and suitability statement on front page
- **Sections:** Highlights · Introduction · Risk factors (standard & scheme-specific) · Minimum investors · Definitions · Due Diligence Certificate
- **Information about the scheme:** objective, asset allocation, where it invests, strategy, fundamental attributes, benchmark, fund managers, restrictions, performance
- Units & Offer · Fees & Expenses · Rights of Unitholders · Penalties & Litigation
- Valid until a material change → filed with SEBI and communicated

## Using the SID to Decide

- Eligible / ineligible investors – NFO & ongoing offer section
- **Suitability:** risk factors, type, objective, asset allocation, instruments, strategy
  - **Standard risks:** volatility, no guarantee, sponsor liability limited, past performance not indicative
  - **Specific risks:** credit, interest rate, liquidity, prepayment, reinvestment, equity volatility, derivatives, foreign
- **When to buy:** open-ended (NFO + ongoing), close-ended (NFO only), interval (NFO + transaction periods)
- **How to apply:** read SID with SAI – PAN, KYC, bank details, cut-off, minors, NRIs, demat
- Prices, loads, min/max investment, plans (Regular/Direct) & options (IDCW payout, reinvestment, sweep, growth)
- Modes of transaction, liquidity & redemption, fees & expenses, special facilities (SIP, STP, switch), NAV computation, tax

## Fundamental Attributes

- **Type of scheme:** open/close-ended/interval; sectoral, equity, balanced, income, index etc.
- **Investment objective:** growth / income / both; min–max asset allocation (defensive deviation allowed short term)
- **Terms of issue:** liquidity (listing, repurchase, redemption); aggregate fees & expenses; any safety net/guarantee
- Change allowed only if (Reg 22(9)(c)):
  - Written/digital communication to each unitholder
  - Details on AMC website
  - Exit option at prevailing NAV without exit load',12,1,24) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l25','nism-5a','nism-5a-m5','Summary notes 2/3: Statement of Additional Information (SAI) to Ongoing Disclosures: NAV','note','## Statement of Additional Information (SAI)

| Section | Covers |
| --- | --- |
| Constituents | Sponsor, AMC, Trustee, Custodian, RTA, Auditor, Fund accountant, Bankers – experience, financials, key people |
| How to apply | Application guidance |
| Rights of unitholders | Ownership, service timelines, information, exit on changes |
| Valuation norms | SEBI-standardised valuation rules |
| Tax, legal & general | Nomination, transfer, transmission, minors, pledge/lien, taxation |
| Investor grievance | How to register a grievance |

- On AMC & AMFI websites; investor may ask for printed copy

## Key Information Memorandum (KIM)

- Summary of SID & SAI – must accompany every application form
- Contents:
  - Names of AMC, MF, trustee, fund manager, scheme
  - NFO opening, closing & re-opening dates
  - Investment objective & asset allocation
  - Risk profile – risk to principal, horizon, securities
  - Plans & options, benchmark, dividend policy
  - **Performance vs benchmark:** 1, 3, 5 yrs & since inception
  - Expenses; grievance registration
- **Addendum:** interim changes; part of scheme documents; must accompany KIM

## Updating Scheme Documents

| Document | Update rule |
| --- | --- |
| SID (open-ended/interval) | First within 6 months of half-year end after launch; then within 1 month of each half-year (Sept/Mar data) |
| SAI | Within 3 months of every financial year end; material changes ongoing |
| KIM | At least once every half-year, within 1 month (Sept/Mar data); filed electronically with SEBI |

- **Change in fundamental attributes:** addendum on website immediately; SID revised after exit window (≥30 days); public notice in English national daily + regional-language paper
- **Other changes:** addendum on website; circulate to distributors/ISCs; attach to KIM & SID in stock; account statements show load structure

## Ongoing Disclosures: NAV

- Current value = Unit balance × current NAV
- NAV disclosed every business day on AMC website and AMFI website
- **Liquid & overnight funds:** NAV declared on Sundays/holidays too (daily accrual)
- **Close-ended schemes:** NAV at least once a week
- Separate time limit for schemes investing overseas
- Historical NAVs let investors compute performance for any period',12,1,25) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l26','nism-5a','nism-5a-m5','Summary notes 3/3: Total Expense Ratio Disclosures to Non-Mandatory: Fund Factsheet','note','## Total Expense Ratio Disclosures

- Daily scheme-wise TER on AMC & AMFI websites (except IDFs) – downloadable, machine-readable
- TER = Base Expense Ratio (BER) + Brokerage + Transaction cost + Statutory levies (incl. GST)
- **BER change:** email/SMS + website notice ≥ 3 working days before
  - **Exempt:** change due only to AUM movement or regulatory decrease
  - Report to AMC Board (with rationale) and Trustees quarterly
- **SID/KIM:** weblink to last 6 months'' TER, daily TER & factsheet; illustration of TER impact for Direct & Regular
- **Half-yearly CAS:** average TER with split – advisory fees, distributor commission, other expenses
- **Annual accounts:** any item > 10% of total expenses shown separately; abridged report shows TER as % of AAUM plan-wise

## Dashboard & Risk-o-meter

- Scheme performance dashboard on AMC website (also AMFI): name, category, type, objective, fund manager, benchmark, exit load/lock-in, plans/options, min investment, AUM, TER, inception, portfolio, performance

| Risk level | Colour |
| --- | --- |
| Low | Irish Green |
| Low to Moderate | Chartreuse |
| Moderate | Neon Yellow |
| Moderately High | Caramel |
| High | Dark Orange |
| Very High | Red |

- Evaluated monthly; change → notice-cum-addendum + email/SMS; show scheme & benchmark risk-o-meter with performance
- Commodity risk by annualised volatility (15-yr prices, quarterly): <10% → 3, 10–15% → 4, 15–20% → 5, >20% → 6
- First step only – not the sole basis for decision

## Portfolio, Results & Annual Reports

- Portfolio (with ISIN) as of month-end / half-year: on AMC & AMFI websites within 10 days; spreadsheet format; yield shown
- **Debt schemes:** fortnightly portfolio within 5 days
- Emailed to registered unitholders within 10 days
- Unaudited half-yearly results (31 Mar & 30 Sep) on website within 1 month; unitholders informed
- **Annual report/abridged summary:** on AMC & AMFI sites; emailed within 4 months of 31 March; physical copy on request
  - Ads in two all-India dailies (English & Hindi); functional link on website
- **Change in control:** draft letter/email and draft ad filed with SEBI

## Non-Mandatory: Fund Factsheet

- Monthly, voluntary – AMFI best practice; SEBI disclosure rules still apply
- **Contents:** inception date, AUM, NAV, benchmark, style box, performance vs benchmark, SIP returns
- **Equity:** sector & security allocation (some show top 10), derivative exposure (hedging only)
- **Debt:** rating profile, average maturity, duration
- **Ratios:** P/E, standard deviation, beta, Sharpe, information ratio (mandatory from Jan 2025)
- **Investment details:** minimum amount, plans/options, loads, expenses, systematic facilities',12,1,26) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z4','nism-5a','nism-5a-m5','Chapter 5 practice',20,50,0,0,0,1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q0','nism-5a-z4','In the Risk-o-meter, the colour for "Very High" risk is:','["Dark Orange","Red","Neon Yellow","Caramel"]',1,'Low – Irish Green; Low to Moderate – Chartreuse; Moderate – Neon Yellow; Moderately High – Caramel; High – Dark Orange; Very High – Red.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q1','nism-5a-z4','The annual report must be emailed to unitholders within ___ of 31 March.','["1 month","10 days","4 months","6 months"]',2,'Physical copy on request.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q2','nism-5a-z4','The fund factsheet is:','["Issued daily","Monthly and non-mandatory (AMFI best practice)","Mandatory by law","Prepared by SEBI"]',1,'SEBI disclosure rules still apply.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q3','nism-5a-z4','The NAV of open-ended schemes is disclosed:','["Monthly","Annually","Every business day on AMC and AMFI websites","Weekly"]',2,'Liquid and overnight funds also declare NAV on Sundays/holidays.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q4','nism-5a-z4','The Statement of Additional Information (SAI) is:','["One document covering all schemes of a mutual fund","Prepared by the distributor","Scheme-specific","Prepared by AMFI"]',0,'The SAI is legally part of the SID.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q5','nism-5a-z4','TER equals:','["Advisory fee only","Distributor commission only","Entry load + exit load","Base expense ratio + brokerage + transaction cost + statutory levies"]',3,'From 1 Apr 2026: BER + execution brokerage + statutory levies such as GST.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q6','nism-5a-z4','The Key Information Memorandum (KIM) must:','["Be issued only for NFOs","Be sent only on request","Accompany every application form","Be filed with RBI"]',2,'KIM is a summary of SID and SAI.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q7','nism-5a-z4','Mutual fund portfolios must be disclosed on websites within:','["1 year","30 days","3 months","10 days of month-end/half-year"]',3,'Debt schemes also disclose a fortnightly portfolio within 5 days.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q8','nism-5a-z4','A change in Base Expense Ratio must be communicated to investors at least ___ in advance.','["1 day","30 days","3 working days","1 week"]',2,'By email/SMS and a website notice.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q9','nism-5a-z4','A change in fundamental attributes requires all EXCEPT:','["Prior approval of AMFI","Details on the AMC website","Written communication to each unitholder","Exit option at prevailing NAV without exit load"]',0,'Per Regulation 22(9)(c).',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q10','nism-5a-z4','After the launch of an open-ended scheme, the SID must first be updated within ___ of the half-year end.','["3 months","1 month","6 months","1 year"]',2,'Then within 1 month of each half-year (Sept/Mar).',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q11','nism-5a-z4','NAV of close-ended schemes must be disclosed at least:','["Daily","Monthly","Quarterly","Once a week"]',3,'Per disclosure norms.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q12','nism-5a-z4','SEBI does the following with the Scheme Information Document:','["Guarantees it","Vets it (gives observations); it does not approve it","Prepares it","Approves it"]',1,'The SID carries a standard clause that SEBI neither approves nor recommends the scheme.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q13','nism-5a-z4','The SAI must be updated within ___ of every financial year end.','["6 months","1 month","3 months","1 year"]',2,'Material changes are updated on an ongoing basis.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q14','nism-5a-z4','The three mandatory scheme-related documents are:','["SID, TER and CAS","KYC, KIM and CAS","SID, SAI and KIM","SAI, SEBI circular and factsheet"]',2,'The fund factsheet is non-mandatory.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q15','nism-5a-z4','Which of the following is a fundamental attribute of a scheme?','["Daily NAV","Name of the distributor","Type of scheme and investment objective","The fund manager''s salary"]',2,'Also the terms of issue.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z4-q16','nism-5a-z4','The Risk-o-meter is evaluated:','["Daily","Annually","Quarterly","Monthly"]',3,'Changes require a notice-cum-addendum and an email/SMS.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m6','nism-5a','Ch 6: Fund Distribution and Channel Management Practices',6,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-nAwcRqSLALo','nism-5a','nism-5a-m6','Video lesson: Chapter 6: Fund Distribution','video','nAwcRqSLALo','',40,'N V Finance',1,27) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l28','nism-5a','nism-5a-m6','Summary notes 1/4: Role and Kinds of Distributors to MF Utilities & MF Central','note','## Role and Kinds of Distributors

- **Role of Mutual Fund Distributors**

- Two professionals between investor and portfolio: Distributor and Fund manager
- Fund manager analyses markets (company, industry, economy, liquidity, sentiment) → builds scheme portfolio
- Distributor analyses the investor (needs, limits, resources, goals) → asset allocation → suitable schemes
- Both help the investor achieve financial goals

- **Kinds of Distributors**

- **Individual channel:** long history via LIC & UTI agents; often single-handed
- **Non-individual:** partnerships, regional & national distributors, NBFCs, banks, stock brokers
  - Institutional distributors = distribution companies & banks
  - **Model:** own branches & employees (fixed costs, salary) or sub-agents (variable cost, commission)
- **Banks:** MNC banks first, then private, PSU & co-operative banks; segments – retail, wealth/priority/private banking
- **NBFCs & brokers:** employees or sub-agents (agency channel)
- E-commerce & online distributors – no physical office; Execution Only Platform guidelines apply

## Modes of Distribution

- **Physical:** paper forms deposited at Official Points of Acceptance (OPOAs)
- **Digital:** internet & mobile; hybrid mode also common
- Online channel partners – distributor websites, no geographic limits
- Distributor apps (computer & mobile); AMC web/mobile apps, SMS, WhatsApp (direct with MF)
- New-age platforms (e.g. Groww, Kuvera, Paytm Money, Coin) – low cost, often direct plans

## Stock Exchange Platforms

- **NSE:** NMF II (versions for trading members & distributors); BSE: StAR MF
- Trading members registered with AMFI & empanelled with MF can transact; clearing members too; DPs – redemptions only
- AMFI-registered distributors may take limited-purpose membership
- Eligible schemes notified by MFs – not listed on exchange
- Exchange is an order-routing system – not a substitute for RTAs; no settlement guarantee (AMC responsible); exchange grievance mechanism available
- Since Feb 2020 investors can access exchange infrastructure directly
- Units credited to demat; supports SIP, STP, SWP, switch

## MF Utilities & MF Central

- **MF Utilities (MFU):** aggregator connecting investors, RTAs, distributors, banks, AMCs
  - Common Account Number (CAN) – needs KYC (MFU facilitates)
  - Common Transaction Form; single payment for multiple schemes; neutral Points of Service
  - Holdings mapped by PAN & holding pattern; multiple CANs possible
  - Bank & nomination details in CAN override folio details
- MF Central (CAMS + KFintech, under SEBI mandate; live since 31 Dec 2021)
  - Consolidated view (demat & non-demat), service requests (bank, contact, KYC, nominee)
  - Transactions (lump sum, SIP, redemption, switch), folio consolidation, minor-to-major, FATCA
  - CAS, unclaimed amounts, family portfolio tracking',12,1,28) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l29','nism-5a','nism-5a-m6','Summary notes 2/4: Becoming a Distributor to Additional Commission & Transaction Charges','note','## Becoming a Distributor

- **Who:** individuals, banks, NBFCs, distribution companies (AMC appoints)
- NISM Series V-A certification mandatory for anyone selling MFs
  - **Exemption route:** age ≥ 50 or ≥ 10 yrs experience as on 31 May 2010 → CPE credits instead
- Eligible distributors may also offer SIF products if additional criteria met
- **Know Your Distributor (KYD):** PAN + address proof at CAMS PoS + biometric (right index finger); acknowledgement sent to AMCs
  - New cadre (V-B) exempt from biometrics – only ID & address proof
- Obtain ARN from AMFI; minimum age 18
- Empanel with any number of AMCs or work as agent of an empanelled distributor
- **Employees of institutions:** pass V-A and get EUIN (quote in forms); work under firm''s ARN
- From 1 Oct 2024: ARN & EUIN applications only online via AMFI website

## Empanelment with AMCs

- **Request for Empanelment Form:** personal info, ARN, PAN, tax status; key people; business details; bank details for direct credit; nominee
- Declaration:
  - Information correct; keep transactions confidential
  - Follow AMC instructions and statutory codes
  - Use only AMC-provided/approved advertising
  - Show risk factors with performance
  - All selling staff have EUIN
  - No rebating of commission or gifts
  - AMC may terminate empanelment any time
- No standard format – each AMC has its own; some empanel only high-volume distributors

## Distributor Revenue: Trail Commission

- Paid only on Regular plans; no commission on direct plans or own investments
- **SEBI Master Circular (20 Mar 2026):** full trail model – no upfront commission or upfronting of trail, in cash or kind (Reg 66(6))
- Trail = % of net assets attributable to units sold; calculated on daily balances; paid monthly/quarterly
- Rises with NAV; paid as long as investor stays invested
- Daily trail = AUM × trail rate p.a. ÷ 365
- **Example:** ₹10 lakh at 1% p.a. → ~₹27.40/day; August total ≈ ₹853
- Must disclose commissions from competing schemes recommended
- Change of distributor → no trail to either for 12 months

## Additional Commission & Transaction Charges

- Additional commission for new investors (new PAN, industry level):
  - New individual investors from B-30 cities
  - New women investors from Top-30 and B-30 cities

| Mode | Additional commission |
| --- | --- |
| Lump sum | 1% of first application, max ₹2,000 – if invested ≥ 1 year |
| SIP | 1% of first-year investment, max ₹2,000 |

- Paid from the 2 bps of daily net assets set aside for investor education; claw-back applies; over & above trail
- No dual incentive for the same investor/investment
- Transaction charges (earlier for > ₹10,000) withdrawn Aug 2025 – no deduction from investor; AMC pays distributor
  - Upfronting of trail allowed only for SIP inflows',12,1,29) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l30','nism-5a','nism-5a-m6','Summary notes 3/4: GST on Commission & Commission Disclosure to Nomination for Distributors','note','## GST on Commission & Commission Disclosure

- GST (from July 2017) payable if annual turnover > ₹20 lakh
- Registered distributor raises invoice and pays GST
- Unregistered supplier → registered recipient (AMC) pays under reverse charge (Sec 9(4) CGST, 5(4) IGST)
- AMCs disclose commission paid to distributors meeting any of:
  - > 20 locations
  - AUM > ₹100 crore (non-institutional incl. HNI) across industry
  - Commission > ₹1 crore p.a. across industry
  - Commission > ₹50 lakh from a single MF
- **Also yearly:** distributor-wise gross & net inflows, AAUM, AUM/gross inflow ratio; associate status flagged
- Portfolio turnover > 2× industry average → extra due diligence; data to AMFI

## Due Diligence by AMCs on Distributors

- Applies to distributors meeting the same four thresholds (20 locations / ₹100 cr AUM / ₹1 cr / ₹50 lakh)
- Done at empanelment and periodically – ''fit and proper'' check:
  - Business model, experience, proficiency
  - Record of levies, fines, penalties, suits, compensations & corrective action
  - Review of associates and subsidiaries
  - Controls delinking customer risk evaluation & scheme appropriateness from sales staff
- **Also reviewed:** product review criteria, customer risk factors, internal audit of exceptions, staff training & certification, onboarding & grievance handling, audit observations, investor sample surveys

## Distributor vs Investment Adviser

- **Investment adviser:** paid for advice; excludes AMFI-registered MFD giving advice incidental to distribution
- MFD cannot call itself an investment adviser or financial planner; RIA cannot earn both fees and commission
- Only two transaction types – no third category:
  - **Advisory:** sell only ''appropriate'' products within customer''s risk ceiling – no exceptions
  - **Execution only:** if unsuitable, written communication acknowledged by investor + confirmation; no extra charge
- Disclose conflict of interest when selling group/associate products
- **Mis-selling (PFUTP Regulations 2003):** false/misleading statement; concealing material facts; concealing risk factors; not ensuring suitability

## Nomination for Distributors

- AMCs offer nomination at empanelment (AMFI uniform practice)
- **On death of MFD:** commission to nominee, else legal heirs (with heirship documents)
  - Nominee need not hold ARN; receives as trustee for legal heirs
  - Only on assets procured while ARN was valid & not suspended
  - Paid until investor changes ARN or AUM under that ARN becomes nil
  - No new business or new/changed systematic transactions under deceased''s ARN
- Intimate AMFI with attested death certificate → AMFI informs AMCs (not for overseas distributors)
- **Transfer of AUM to nominee/heir:** needs investor request or valid ARN + KYD; clients informed, 15 days to object',12,1,30) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l31','nism-5a','nism-5a-m6','Summary notes 4/4: Change of Distributor','note','## Change of Distributor

- Investor can change distributor or go direct – written request, no NOC
- Investor-initiated change → no trail to old or new distributor; new one may be paid after 12-month cooling-off
- **Exception:** change due to voluntary cessation of business by distributor – new distributor gets trail
- Distributor-initiated change allowed only for:
  - Change in name/legal status (individual → firm → LLP etc.)
  - Merger/acquisition/consolidation within same group
  - AUM consolidation within family/close relatives
  - Transfer of business by individual distributors
- Entire AUM must move to a valid, KYD-compliant ARN holder; old ARN surrendered',3,1,31) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z5','nism-5a','nism-5a-m6','Chapter 6 practice',30,50,0,0,0,1,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q0','nism-5a-z5','Know Your Distributor (KYD) involves:','["A bank guarantee","PAN and address proof plus biometric (right index finger)","A demat account","An exam only"]',1,'New cadre (V-B) is exempt from biometrics.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q1','nism-5a-z5','A distributor cannot call itself:','["An investment adviser or financial planner","An empanelled partner","A mutual fund distributor","An ARN holder"]',0,'MFD advice must be incidental to distribution.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q2','nism-5a-z5','A distributor has ₹22,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹723.29","₹60.27","₹1,808.22","₹1,833.33"]',1,'Daily trail = AUM × rate ÷ 365 = ₹60.27.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q3','nism-5a-z5','Daily trail commission is calculated as:','["AUM × trail rate ÷ 12 ÷ 100","Units × face value","AUM × trail rate p.a. ÷ 365","NAV × units"]',2,'Paid monthly or quarterly.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q4','nism-5a-z5','As per the SEBI Master Circular (March 2026), distributor commission follows:','["A full trail model with no upfront commission","A fixed salary model","An entry load model","An upfront commission model"]',0,'Upfronting of trail is allowed only for SIP inflows.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q5','nism-5a-z5','The minimum age for obtaining an ARN is:','["18 years","21 years","25 years","16 years"]',0,'ARN application is online via AMFI from 1 Oct 2024.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q6','nism-5a-z5','A distributor has ₹21,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹1,312.50","₹43.15","₹517.81","₹1,294.52"]',1,'Daily trail = AUM × rate ÷ 365 = ₹43.15.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q7','nism-5a-z5','A Registered Investment Adviser (RIA) cannot:','["Earn both advisory fees and commission","Charge advisory fees","Use a risk profile","Advise on mutual funds"]',0,'Only two transaction types exist: advisory and execution-only.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q8','nism-5a-z5','A distributor has ₹24,00,000 of client AUM in regular plans with a trail rate of 1.25% p.a. The approximate daily trail commission is:','["₹2,465.75","₹2,500.00","₹986.30","₹82.19"]',3,'Daily trail = AUM × rate ÷ 365 = ₹82.19.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q9','nism-5a-z5','A distributor has ₹10,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹833.33","₹821.92","₹328.77","₹27.40"]',3,'Daily trail = AUM × rate ÷ 365 = ₹27.40.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q10','nism-5a-z5','A distributor has ₹63,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹7,875.00","₹258.90","₹3,106.85","₹7,767.12"]',1,'Daily trail = AUM × rate ÷ 365 = ₹258.90.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q11','nism-5a-z5','A distributor has ₹11,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹678.08","₹687.50","₹22.60","₹271.23"]',2,'Daily trail = AUM × rate ÷ 365 = ₹22.60.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q12','nism-5a-z5','On the death of an MFD, commission on the assets procured is paid to:','["The AMC","The investor","The nominee, else legal heirs","AMFI"]',2,'Nominee receives as trustee for legal heirs.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q13','nism-5a-z5','If an investor changes the distributor, the trail commission:','["Is not paid to either distributor for 12 months","Goes to the old distributor forever","Goes to the AMC","Is doubled"]',0,'New distributor may be paid after the 12-month cooling-off.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q14','nism-5a-z5','Additional commission for new investors (B-30 individuals, women) on lump sum is:','["0.5% maximum ₹500","3% maximum ₹10,000","1% of the first application, maximum ₹2,000","2% maximum ₹5,000"]',2,'SIP: 1% of the first-year investment, maximum ₹2,000.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q15','nism-5a-z5','Employees of institutional distributors must obtain:','["CAN","SCORES ID","EUIN","OTM"]',2,'EUIN must be quoted in forms.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q16','nism-5a-z5','A distributor has ₹41,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹2,021.92","₹5,125.00","₹5,054.79","₹168.49"]',3,'Daily trail = AUM × rate ÷ 365 = ₹168.49.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q17','nism-5a-z5','The mandatory certification for those selling mutual funds is:','["NISM Series XV","NISM Series VIII","NISM Series V-A","NISM Series IV"]',2,'NISM Series V-B is the foundation (new cadre) certification.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q18','nism-5a-z5','A distributor has ₹77,00,000 of client AUM in regular plans with a trail rate of 0.75% p.a. The approximate daily trail commission is:','["₹1,898.63","₹158.22","₹4,812.50","₹4,746.58"]',1,'Daily trail = AUM × rate ÷ 365 = ₹158.22.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q19','nism-5a-z5','A distributor has ₹25,00,000 of client AUM in regular plans with a trail rate of 1% p.a. The approximate daily trail commission is:','["₹821.92","₹2,054.79","₹68.49","₹2,083.33"]',2,'Daily trail = AUM × rate ÷ 365 = ₹68.49.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q20','nism-5a-z5','A distributor has ₹74,00,000 of client AUM in regular plans with a trail rate of 1.5% p.a. The approximate daily trail commission is:','["₹9,123.29","₹9,250.00","₹3,649.32","₹304.11"]',3,'Daily trail = AUM × rate ÷ 365 = ₹304.11.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q21','nism-5a-z5','GST on distributor commission is payable when annual turnover exceeds:','["₹20 lakh","₹1 crore","₹40 lakh","₹10 lakh"]',0,'Reverse charge applies to unregistered suppliers.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q22','nism-5a-z5','Commission is paid only on:','["Direct plans","Overnight funds only","Own investments by the distributor","Regular plans"]',3,'No commission on direct plans.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q23','nism-5a-z5','The law under which mis-selling is addressed is the:','["Negotiable Instruments Act","Companies Act","SEBI (PFUTP) Regulations, 2003","Contract Act"]',2,'Prohibition of Fraudulent and Unfair Trade Practices.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z5-q24','nism-5a-z5','A distributor has ₹48,00,000 of client AUM in regular plans with a trail rate of 1.25% p.a. The approximate daily trail commission is:','["₹4,931.51","₹5,000.00","₹1,972.60","₹164.38"]',3,'Daily trail = AUM × rate ÷ 365 = ₹164.38.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m7','nism-5a','Ch 7: NAV, Total Expense Ratio and Pricing of Units',8,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-KSGriBaTAD0','nism-5a','nism-5a-m7','Video lesson: Chapter 7: Net Asset Value, Total Expense Ratio & Pricing Units','video','KSGriBaTAD0','',47,'N V Finance',1,32) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l33','nism-5a','nism-5a-m7','Summary notes 1/3: Fair Valuation Principles (1/2) to Net Asset Value: Formula and Worked Examples','note','## Fair Valuation Principles (1/2)

- **Goal:** fair treatment of existing, incoming and exiting investors; reduce mispricing & redemption pressure
- Valuation per Seventh Schedule of SEBI (MF) Regulations 2026
- P1: Value at realisable (fair) value, in good faith, true & fair
- P2: AMC Board-approved methodology for each security type; new security types only after method approved
- P3: Consistent valuation; process for exceptional events when quotes unreliable
- P4: Periodic review; independent auditor reviews policy at least once a financial year; boards updated
- P5: Policies must address conflict of interest

## Fair Valuation Principles (2/2)

- P6: Disclose valuation policy in SAI, AMC website and as specified
- P7: AMC responsible for true & fair valuation – may deviate from policy to reach fair value, with reporting to boards & disclosure to investors
- P8: Policies to detect and prevent incorrect valuation
- P9: Document rationale incl. inter-scheme transfers – audit trail
- P10: Debt & money market – consider trades of same/similar security on all public platforms
- Fair Valuation Principles prevail over Valuation Guidelines in any conflict
- Guidelines cover traded, non-traded & thinly traded securities, gold/silver, illiquidity adjustments

## Net Assets of a Scheme – Example

- 20 crore units × ₹10 = ₹200 cr; ₹140 cr in equity (+10%); ₹60 cr in deposits/money market
- Income ₹8 cr; expenses paid ₹4 cr; expenses payable ₹1 cr

| Liabilities | ₹ cr | Assets | ₹ cr |
| --- | --- | --- | --- |
| Unit capital | 200 | Equity at market value | 154 |
| Profits (8 − 4 − 1) | 3 | Deposits & money market (60 + 8 − 4) | 64 |
| Capital appreciation | 14 |  |  |
| Unitholders'' funds (Net assets) | 217 |  |  |
| Expenses payable | 1 |  |  |
| Total | 218 | Total | 218 |

- Net assets = amount invested + profits booked + portfolio appreciation (even unrealised)
- **Accrual principle:** income/expenses for the period counted whether received/paid or not

## Net Asset Value: Formula and Worked Examples

- **Net Asset Value (NAV)**

- NAV = Net assets ÷ Units outstanding = 217 ÷ 20 = ₹10.85
- Or (Total assets − Liabilities other than to unitholders) ÷ Units = (218 − 1) ÷ 20 = ₹10.85
- NAV rises with income & gains; falls with expenses & losses
- Profit = Interest + Dividend + Realised gains + Valuation gains − Realised losses − Valuation losses − Expenses
- Current liabilities may include payables for securities bought and borrowings ≤ 6 months (also intra-day borrowing repaid same day)

- **NAV – Worked Examples**

- Example 1: Stocks 150 + Bonds 67 + Money market 2.36 + Dividend accrued 1.09 + Interest accrued 2.68 − Fees payable 0.36 = 222.77
  - ÷ 1.90 crore units → NAV = ₹117.25
- Example 2: Stocks 230 + Money market 5 + Dividend accrued 2.39 + Receivable on sale 2.34 − Payable on purchase 7.5 − Fees 0.41 = 231.82
  - ÷ 2.65 crore units → NAV = ₹87.48
- **General formula:** (Investments at market value + Accrued income + Current assets − Current liabilities − Accrued expenses) ÷ Units',12,1,33) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l34','nism-5a','nism-5a-m7','Summary notes 2/3: Why Mark to Market? to TER for Fund of Funds & Extra Charges','note','## Why Mark to Market?

- NAV must reflect true worth – valuing a ₹50 share at cost ₹15 is meaningless
- **Example:** Net assets ₹1,50,000; 10,000 units; NAV ₹15

| Case | Effect |
| --- | --- |
| Issue 100 units at face value ₹10 (below NAV) | NAV falls to ₹14.95 – hurts existing investors |
| Redeem 100 units at ₹10 (below NAV) | NAV rises to ₹15.05 – exiting investor loses |

- MTM ensures fair buy/sell prices and helps assess fund manager performance

## Scheme Expenses

- All expenses must be identified and paid from the scheme within base expense limits, brokerage limits, transaction cost & statutory levy
- Excess over limits borne by AMC, trustees or sponsor
- Investment & advisory fee charged by AMC – disclosed in SID
- **Recurring expenses:** marketing & distribution, brokerage, RTA, trustee fees, audit, custodian, investor communication, fund transfer, statements & payouts, insurance, winding-up, statutory ads, gold/silver/commodity storage, listing fees, others approved by SEBI
- Equity-oriented for TER = ≥ 65% in equity (other than index fund/ETF)

## Total Expense Ratio Limits

| Daily net assets slab | Equity-oriented | Other schemes |
| --- | --- | --- |
| First ₹500 cr | 2.10% | 1.85% |
| Next ₹250 cr | 1.90% | 1.65% |
| Next ₹1,250 cr | 1.60% | 1.40% |
| Next ₹3,000 cr | 1.50% | 1.25% |
| Next ₹5,000 cr | 1.40% | 1.15% |
| Next ₹40,000 cr | −0.05% per ₹5,000 cr | −0.05% per ₹5,000 cr |
| Balance | 0.95% | 0.70% |

- **Index funds / ETFs:** max 0.90%
- **Close-ended & interval:** equity 1.00%; others 0.80%

## TER for Fund of Funds & Extra Charges

| FoF type | Max TER (incl. underlying) |
| --- | --- |
| Investing in liquid, index funds, ETFs | 0.90% |
| ≥ 65% in equity-oriented schemes | 2.10% |
| Others | 1.85% |

- FoF''s own TER ≤ 2× weighted average TER of underlying schemes (within ceilings)
- Brokerage & transaction cost over limits: 0.06% (cash market), 0.02% (derivatives) of trade value
- TER = base expense + brokerage + transaction cost + statutory levies
- Nothing else may be charged except exit load & specified levies
- Daily TER disclosed on AMC & AMFI websites',12,1,34) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l35','nism-5a','nism-5a-m7','Summary notes 3/3: IDCW & Distributable Reserves to Accounting, Segregated Portfolio & Perpetual Bonds','note','## IDCW & Distributable Reserves

- Valuation gains are only on paper – not certain until sold
- IDCW paid only out of distributable reserves:
  - All accrued profits are distributable
  - Valuation gains ignored; valuation losses deducted
  - Portion of sale price of new units attributable to valuation gains not distributable
- **Equalisation reserve:** realised-gain portion of sale price can fund IDCW → part of IDCW is investor''s own capital; MF must show income vs capital split
- No guarantee of rate or regularity of IDCW

## IDCW Declaration Process

- Trustees decide quantum and record date (may delegate to AMC for up to monthly frequency; ratified at next board meeting)
- Record date = cut-off for eligibility from register of unitholders; NAV adjusted at end of record date
- Public notice within 1 day of trustee decision; record date 5 calendar days from notice
- Notice must state NAV will fall by payout + statutory levy
- Delay in payment → interest from record date
- No notice needed for liquid/debt schemes with daily-to-monthly IDCW (disclosed in SID)
- Listed schemes follow listing agreement

## Entry & Exit Loads

- Entry load (sale price above NAV) – banned; sale price = NAV (less stamp duty)
  - e.g. ₹25,000 at NAV ₹43.21 → 578.570 units
- **Exit load:** repurchase price below NAV
  - NAV ₹11, exit load 1% → repurchase price ₹10.89
  - May reduce with holding period (3% yr 1, 2% yr 2 …)
- No distinction between investors by amount; changes apply only to prospective investments
- No exit load on bonus units or IDCW reinvestment units
- Exit load credited back to the scheme (not for AMC selling expenses)

## Accounting, Segregated Portfolio & Perpetual Bonds

- **Accounting, Reporting & Segregated Portfolio**

- Scheme accounts separate from AMC accounts; different auditors
- Norms on when interest, dividends, bonus, rights are recognised
- **NAV decimals:** 4 places for index, liquid & debt funds; at least 2 for equity & balanced
- Fractional units allowed; exchanges may restrict to whole units
- Segregated portfolio (credit event / actual default on unrated issuer debt):
  - No investment & advisory fee on segregated portfolio
  - Other TER charged pro-rata only on recovery
  - NAV declared daily; disclosed in scheme documents, portfolio disclosures & annual report

- **Perpetual Bonds (AT-1 / Tier 2)**

- Bank-issued perpetual bonds; absorb losses before equity / may convert to equity on trigger
- SEBI caps fund exposure to these bonds
- AT-1 bonds valued on Yield to Call basis',12,1,35) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z6','nism-5a','nism-5a-m7','Chapter 7 practice',30,50,0,0,0,1,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q0','nism-5a-z6','AT-1 bonds are valued on:','["Cost basis","Yield to Call basis","Yield to maturity only","Face value"]',1,'SEBI caps fund exposure to perpetual bonds.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q1','nism-5a-z6','A Fund of Funds investing in liquid funds, index funds or ETFs can have a maximum TER (including underlying) of:','["1.00%","1.85%","0.90%","2.10%"]',2,'FoFs investing ≥65% in equity-oriented schemes: 2.10%; others 1.85%.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q2','nism-5a-z6','The notice of IDCW must state that:','["Units will be cancelled","Returns are guaranteed","NAV will fall by the payout plus statutory levy","NAV will rise"]',2,'This applies to non-liquid schemes.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q3','nism-5a-z6','Net assets of a scheme equal:','["Realised profits only","AUM minus loads","Amount invested + profits booked + portfolio appreciation (even unrealised)","Amount invested only"]',2,'This uses the accrual principle.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q4','nism-5a-z6','A scheme with average net assets of ₹3800 crore incurs total recurring expenses of ₹4.10 crore in a year. Its expense ratio is:','["0.216%","0.108%","0.054%","0.162%"]',1,'TER = 4.10 ÷ 3800 × 100 = 0.108%.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q5','nism-5a-z6','Entry load in mutual funds:','["Is charged by AMFI","Is banned; sale price equals NAV","Is allowed for distributors","Is allowed up to 2.25%"]',1,'Entry load was banned in 2009.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q6','nism-5a-z6','A scheme has total assets of ₹134.40 crore, liabilities (other than to unitholders) of ₹3.40 crore and 1.40 crore units outstanding. Its NAV per unit is:','["₹98.43","₹54.58","₹93.57","₹96.00"]',2,'NAV = (134.40 − 3.40) ÷ 1.40 = ₹93.57.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q7','nism-5a-z6','The maximum TER for equity-oriented schemes on the first ₹500 crore of daily net assets is:','["1.85%","2.10%","2.25%","2.50%"]',1,'Other schemes: 1.85%.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q8','nism-5a-z6','Extra brokerage and transaction cost over the limits is allowed at:','["0.06% (cash market) and 0.02% (derivatives) of trade value","0.50% and 0.25%","1% and 0.5%","0.01% and 0.10%"]',0,'Within the TER ceilings.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q9','nism-5a-z6','A scheme with average net assets of ₹2100 crore incurs total recurring expenses of ₹7.00 crore in a year. Its expense ratio is:','["0.667%","0.332%","0.333%","0.167%"]',2,'TER = 7.00 ÷ 2100 × 100 = 0.333%.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q10','nism-5a-z6','A scheme has an NAV of ₹20.90 and an exit load of 0.5%. The redemption (repurchase) price per unit is:','["₹21.00","₹20.40","₹20.90","₹20.80"]',3,'Repurchase price = 20.90 × (1 − 0.5%) = ₹20.80.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q11','nism-5a-z6','A scheme has total assets of ₹182.40 crore, liabilities (other than to unitholders) of ₹5.10 crore and 1.60 crore units outstanding. Its NAV per unit is:','["₹110.81","₹114.00","₹117.19","₹68.19"]',0,'NAV = (182.40 − 5.10) ÷ 1.60 = ₹110.81.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q12','nism-5a-z6','The maximum TER for index funds/ETFs is:','["0.90%","0.50%","2.10%","1.00%"]',0,'Close-ended and interval: equity 1.00%, others 0.80%.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q13','nism-5a-z6','Mark-to-market ensures that when units are issued below NAV:','["The distributor is rewarded","Existing investors would otherwise be hurt","The NAV rises","The AMC earns more"]',1,'In the example, NAV falls to ₹14.95.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q14','nism-5a-z6','IDCW can be paid only out of:','["Capital only","Distributable reserves","Unrealised gains","Entry loads"]',1,'Valuation gains are ignored; valuation losses are deducted.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q15','nism-5a-z6','NAV of index, liquid and debt funds must be declared to at least ___ decimal places.','["4","3","2","6"]',0,'At least 2 for equity and balanced funds.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q16','nism-5a-z6','Exit load is NOT charged on:','["Bonus units and IDCW reinvestment units","Lump sum purchases","Units redeemed in 1 week","SIP units"]',0,'Per exit-load norms.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q17','nism-5a-z6','A scheme with average net assets of ₹600 crore incurs total recurring expenses of ₹5.30 crore in a year. Its expense ratio is:','["0.883%","0.442%","0.876%","1.767%"]',0,'TER = 5.30 ÷ 600 × 100 = 0.883%.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q18','nism-5a-z6','A segregated portfolio is created on:','["A credit event or actual default on unrated or rated debt as specified","IDCW declaration","A distributor change","Every NFO"]',0,'No investment and advisory fee is charged on it.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q19','nism-5a-z6','The record date for IDCW is how many days from the notice?','["10 working days","5 calendar days","30 days","1 day"]',1,'Public notice within 1 day of the trustee decision.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q20','nism-5a-z6','Exit load is:','["Retained by the AMC","Credited back to the scheme","Paid to SEBI","Paid to the distributor"]',1,'It cannot be used for AMC selling expenses.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q21','nism-5a-z6','NAV per unit is:','["Total assets ÷ number of investors","Face value × units","Net assets × units","Net assets ÷ units outstanding"]',3,'NAV = (Assets − Liabilities other than to unitholders) ÷ units.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q22','nism-5a-z6','With NAV of ₹11 and exit load of 1%, the repurchase price is:','["₹10.89","₹11.11","₹11.00","₹10.00"]',0,'11 × (1 − 0.01) = ₹10.89.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q23','nism-5a-z6','The maximum TER for an equity-oriented scheme on the next ₹250 crore is:','["1.60%","1.90%","2.10%","2.25%"]',1,'Other schemes: 1.65%.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z6-q24','nism-5a-z6','The accrual principle means income and expenses are counted:','["Only when paid","Only on redemption","Only when received","For the period whether received/paid or not"]',3,'Core accounting principle.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m8','nism-5a','Ch 8: Taxation',4,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-GLq8szwqf3s','nism-5a','nism-5a-m8','Video lesson: Chapter 8: Taxation','video','GLq8szwqf3s','',32,'N V Finance',1,36) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l37','nism-5a','nism-5a-m8','Summary notes 1/2: Taxation: Two Levels to Taxation of IDCW','note','## Taxation: Two Levels

- "Not how much you earn, but how much you keep after taxes"
- Mutual fund = pass-through vehicle → consider income of the fund and of the investor
- Fund income (interest, dividend, capital gains) exempt under Sec 10(23D) – MF is a trust for unitholders
- Investor income:
  - Growth option → capital gains on sale only
  - IDCW option → IDCW when declared + capital gains on sale
- **Tax depends on:** type of income, holding period, type of scheme, type of investor
- **Equity-oriented scheme for tax:** > 65% in domestic listed equity shares (FoF of equity funds = non-equity)
- **Joint holding:** income taxed in hands of first holder

## Capital Gains on Equity-oriented Funds

- **Grandfathering:** gains up to 31 Jan 2018 exempt – cost = higher of purchase price or NAV on 31 Jan 2018
  - ₹1 lakh invested, ₹2 lakh on 31 Jan 2018, sold at ₹1.8 lakh → LTCG = 0
  - Sold at ₹2.2 lakh → LTCG = ₹20,000
- **LTCG exemption:** first ₹1.25 lakh per financial year tax-free
  - LTCG ₹90,000 → nil tax; ₹1,35,000 → tax on ₹10,000

## Tax Rates for Unitholders

| Scheme type | STCG | LTCG | LTCG holding period |
| --- | --- | --- | --- |
| Equity-oriented (incl. hybrid > 65% equity) | 20% | 12.5% (₹1.25 lakh exempt) | > 12 months |
| Debt-oriented (incl. hybrid > 65% debt) | Slab rate | Slab rate | – |
| Hybrid with 35–65% domestic equity | Slab rate | 12.5% | > 24 months |
| Other MFs (FoFs, international) | Slab rate | 12.5% | > 24 months |
| Equity ETFs | Slab rate | 12.5% | > 12 months |
| Gold ETFs | Slab rate | 12.5% | > 12 months |
| Debt ETFs | Slab rate | Slab rate | – |

- Rates as stated in the workbook (Sept 2026)

## Taxation of IDCW

- Till FY 2019-20: IDCW tax-free for investor; Dividend Distribution Tax (DDT) deducted by the scheme
- From April 2020: DDT abolished; IDCW added to income and taxed at investor''s slab rate
  - Higher-income investors pay more; tax-exempt investors (charitable trusts, low-slab individuals) benefit
  - New regime allows exemptions/adjustments; DDT could not be set off
- NAV still falls by the full payout – post-tax receipt is lower than NAV drop
- Growth option is more tax-efficient – tax deferral, compounding pre-tax
- From 1 April 2021: IDCW must be split into income distribution (NAV appreciation) and capital distribution',12,1,37) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l38','nism-5a','nism-5a-m8','Summary notes 2/2: Stamp Duty and Securities Transaction Tax to TDS and GST','note','## Stamp Duty and Securities Transaction Tax

- **Stamp Duty**

- Effective 1 July 2020 (Indian Stamp Act amended Feb 2019)
- 0.005% on issue of units – physical and demat
  - Purchase, additional purchase, IDCW reinvestment, SIP, STP, IDCW transfer plan (incl. old SIP/STP triggers)
  - Units allotted on amount net of stamp duty
- 0.015% on transfer of units (e.g. between demat accounts)

- **Securities Transaction Tax (STT)**

- Only on equity-oriented funds – on redemption/switch/sale; not on purchase; not on debt funds

| Transaction | STT | Payable by |
| --- | --- | --- |
| Purchase of equity MF units | Nil | – |
| Sale of equity MF units on exchange (delivery) | 0.001% | Seller |
| Sale of equity shares/units (non-delivery) | 0.025% | Seller |
| Redemption of equity MF units to the fund | 0.001% | Seller |

## Set-off of Losses & Bonus Stripping

- Capital loss cannot be set off against other heads (e.g. salary)
- Short-term capital loss → against STCG or LTCG
- Long-term capital loss → only against LTCG
- Unabsorbed capital loss carried forward up to 8 years
- **Bonus stripping:** buy at ₹30, 1:1 bonus, sell original at ₹15 → loss ₹15
  - Loss disallowed if bought within 3 months before record date and sold within 9 months after
  - Disallowed loss becomes cost of the bonus units
  - Invest for fundamentals, not tax tricks

## Section 80C – ELSS

- **ELSS (Tax Saver):** deduction up to ₹1.5 lakh per year for individuals & HUFs – Old Tax Regime only
- 3-year lock-in from date of each investment
  - Limit shared with other 80C avenues – lock-in applies even without extra benefit
  - Each SIP instalment locked for 3 years separately
  - IDCW reinvestment also locked in → most AMCs offer only growth/IDCW payout
- Benefit to first holder in joint holding
- **New Tax Regime (Budget 2020):** lower rates, no 80C → ELSS is just a locked-in equity fund
- Some retirement funds also qualify for 80C – 5-year lock-in; check individually
- MF = tax-sheltered vehicle → tax deferral and pre-tax compounding in growth option

## TDS and GST

- No TDS on redemption for residents; TDS applies for certain non-residents (rate by investor, asset & income type)
- **IDCW:** TDS 10% for residents if IDCW exceeds ₹10,000
- **NRIs:** lower of Income Tax rate or DTAA rate – with supporting documents
- GST in schemes:
  - On investment & advisory fees – over and above TER limits
  - On other fees – within TER
  - On exit load – deducted from load, net credited to scheme
  - On brokerage & transaction cost – within TER
- GST on distributor commission – cannot be charged to the scheme
- From 1 Apr 2026: TER = Base Expense Ratio + execution brokerage + statutory levies (e.g. GST)',12,1,38) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z7','nism-5a','nism-5a-m8','Chapter 8 practice',30,50,0,0,0,1,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q0','nism-5a-z7','Gains on units up to which date are grandfathered for equity funds?','["31 March 2018","31 March 2000","31 January 2018","1 April 2020"]',2,'Cost = higher of purchase price or NAV on 31 Jan 2018.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q1','nism-5a-z7','LTCG on equity-oriented mutual funds is taxed at ___ on gains exceeding ₹1.25 lakh in a financial year.','["10%","15%","20%","12.5%"]',3,'Holding period more than 12 months.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q2','nism-5a-z7','STCG on equity-oriented mutual funds is taxed at:','["30%","20%","15%","10%"]',1,'Holding period of up to 12 months.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q3','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹16,00,000. The stamp duty is:','["₹8,000.00","₹80.00","₹800.00","₹240.00"]',1,'₹1600000 × 0.005% = ₹80.00.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q4','nism-5a-z7','An investor redeems equity-oriented fund units after 8 months with a short-term capital gain of ₹49,000. The STCG tax (ignoring cess) is:','["₹4,900","₹7,350","₹6,125","₹9,800"]',3,'STCG on equity-oriented funds is 20%: ₹9,800.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q5','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹40,00,000. The stamp duty is:','["₹2,000.00","₹600.00","₹20,000.00","₹200.00"]',3,'₹4000000 × 0.005% = ₹200.00.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q6','nism-5a-z7','GST on a scheme''s investment and advisory fees is:','["Over and above the TER limits","Within the TER","Not applicable","Paid by the distributor"]',0,'GST on distributor commission cannot be charged to the scheme.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q7','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹7,05,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,16,000","₹88,125","₹72,500","₹1,41,000"]',2,'Taxable = 705000 − 1,25,000; tax at 12.5% = ₹72,500.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q8','nism-5a-z7','A short-term capital loss can be set off against:','["LTCG only","Salary income","No income","STCG or LTCG"]',3,'Long-term loss only against LTCG.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q9','nism-5a-z7','LTCG of ₹1,35,000 on equity funds leads to tax on:','["₹1,25,000","₹25,000","₹1,35,000","₹10,000"]',3,'Tax at 12.5% on ₹10,000 = ₹1,250.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q10','nism-5a-z7','Stamp duty at 0.005% on issue of units applies to an investment of ₹14,00,000. The stamp duty is:','["₹7,000.00","₹70.00","₹210.00","₹700.00"]',1,'₹1400000 × 0.005% = ₹70.00.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q11','nism-5a-z7','Hybrid funds with 35–65% domestic equity attract LTCG at 12.5% after a holding period of:','["More than 24 months","More than 12 months","More than 6 months","More than 36 months"]',0,'STCG at slab rate.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q12','nism-5a-z7','An investor redeems equity-oriented fund units after 8 months with a short-term capital gain of ₹66,000. The STCG tax (ignoring cess) is:','["₹6,600","₹8,250","₹9,900","₹13,200"]',3,'STCG on equity-oriented funds is 20%: ₹13,200.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q13','nism-5a-z7','TDS on IDCW for residents applies if IDCW exceeds ₹10,000 at the rate of:','["10%","5%","30%","20%"]',0,'No TDS on redemption for residents.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q14','nism-5a-z7','Stamp duty on issue of units is:','["0.015%","0.1%","0.001%","0.005%"]',3,'From 1 July 2020; 0.015% on transfer of units.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q15','nism-5a-z7','A person has LTCG of ₹90,000 on equity funds in a year. The tax payable is:','["Nil","₹11,250","₹9,000","₹18,000"]',0,'First ₹1.25 lakh is exempt.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q16','nism-5a-z7','Debt-oriented mutual fund gains are taxed at:','["12.5% LTCG","Slab rates for both short-term and long-term","20% STCG only","Nil"]',1,'Per the Sept 2026 workbook.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q17','nism-5a-z7','STT on redemption of equity MF units is:','["0.025% payable by the buyer","0.1% payable by the buyer","Nil","0.001% payable by the seller"]',3,'STT is not charged on purchase or on debt funds.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q18','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹5,95,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,19,000","₹58,750","₹74,375","₹94,000"]',1,'Taxable = 595000 − 1,25,000; tax at 12.5% = ₹58,750.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q19','nism-5a-z7','Since April 2020, IDCW is:','["Added to the investor''s income and taxed at slab rate","Tax-free","Taxed at 10% flat","Taxed through DDT in the scheme"]',0,'DDT was abolished.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q20','nism-5a-z7','Unabsorbed capital losses can be carried forward for:','["4 years","8 years","Indefinitely","2 years"]',1,'As per tax rules.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q21','nism-5a-z7','An investor sells equity-oriented fund units after 18 months with a long-term capital gain of ₹6,75,000 (no other LTCG in the year). As per the rates in the current workbook, the LTCG tax (ignoring cess) is:','["₹1,10,000","₹84,375","₹68,750","₹1,35,000"]',2,'Taxable = 675000 − 1,25,000; tax at 12.5% = ₹68,750.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q22','nism-5a-z7','Income of a mutual fund scheme is exempt from tax under:','["Section 80C","Section 112A","Section 10(23D)","Section 194"]',2,'The investor, not the fund, pays tax.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q23','nism-5a-z7','Bonus stripping loss is disallowed if units are bought within ___ before the record date and sold within ___ after.','["3 months; 9 months","9 months; 3 months","1 month; 6 months","6 months; 12 months"]',0,'The disallowed loss becomes the cost of the bonus units.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z7-q24','nism-5a-z7','For tax purposes, an equity-oriented fund is one investing more than ___ in domestic listed equity shares.','["75%","80%","65%","50%"]',2,'A FoF of equity funds is treated as non-equity.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m9','nism-5a','Ch 9: Investor Services',15,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-Pxg32Lmp3vU','nism-5a','nism-5a-m9','Video lesson: Chapter 9: Investor Services','video','Pxg32Lmp3vU','',44,'N V Finance',1,39) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l40','nism-5a','nism-5a-m9','Summary notes 1/9: The NFO Process to Options – Illustration','note','## The NFO Process

- AMC picks scheme based on CIO (investment) and CMO (market interest) inputs
- One scheme per category – except sector/thematic, index funds, FoFs
- SID approved by Trustees & AMC Board → filed with SEBI → observations incorporated → issued
- Timetable, advertising (SEBI code), intermediary & press events; documents and forms circulated
- **Open-ended:** NFO open date, NFO close date, scheme re-opening date
- **Close-ended:** no re-opening – trade on exchange
- NFO open minimum 3 working days; maximum 15 days (except ELSS)
- Allotment/refund within 5 business days of NFO close; re-open within 5 business days of allotment
- **Reg 35(5):** realistic deployment timelines in SID

## NFO & Ongoing Prices; Direct vs Regular

- **NFO price:** price per unit during NFO (face value, usually ₹10)
- Ongoing purchase price = NAV (no entry load); redemption = NAV less exit load
- Every scheme must offer Regular and Direct plans
  - **Direct:** lower TER (no distribution cost/commission); separate NAV
  - Any investment routed through a distributor = Regular plan
- No other expense-based plans allowed

## Options: IDCW Payout, Reinvestment, Growth

- Same portfolio → same portfolio return; differ in cash flows, units, taxability (renamed IDCW from 1 Apr 2021)

| Parameter | IDCW Payout | IDCW Reinvestment | Growth |
| --- | --- | --- | --- |
| IDCW in bank account | Yes | No | No |
| Tax on IDCW | Yes | Yes | N.A. |
| Increase in units | No | Yes | No |
| NAV change | Falls by IDCW | Falls by IDCW | Reflects full gains |

- Cum-IDCW NAV (before payout) vs Ex-IDCW NAV (after)
- **Reinvestment at ex-IDCW NAV:** ₹2 × 100 units = ₹200 ÷ ₹20 = 10 units

## Options – Illustration

- A (Growth), B (Payout), C (Reinvestment): 100 units at ₹10; NAV → ₹12; IDCW 10% of face value = ₹1/unit

| Investor | Outcome | Value |
| --- | --- | --- |
| A – Growth | No IDCW; capital gain ₹200 | 100 × ₹12 = ₹1,200 |
| B – Payout | ₹100 IDCW + ₹100 capital gain | 100 × ₹11 = ₹1,100 + ₹100 cash |
| C – Reinvest | ₹100 ÷ ₹11 = 9.09 extra units | 109.09 × ₹11 = ₹1,200 |

- Pre-tax return same (₹200); post-tax differs because IDCW and capital gains are taxed differently',12,1,40) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l41','nism-5a','nism-5a-m9','Summary notes 2/9: Allotment of Units to Application Form (1/2)','note','## Allotment of Units

- **NFO:** amount ÷ ₹10 face value; full allotment if minimum subscription met; trustees may reject
- Allotment within 5 business days; demat credit within 2 working days; account statement within 5 business days
- FPIs subject to RBI approval if required; ASBA account debited on allotment
- **Ongoing:** ₹12,000 ÷ NAV ₹12 = 1,000 units
- **Rights issue:** amount ÷ rights price (rare for MFs)
- Bonus 1:3: 1 free unit per 3 held; NAV falls proportionately – value unchanged
- Demat units freely transferable (subject to lock-in/lien)
- Refund later than 5 business days → 15% p.a. interest, borne by AMC

## Account Statements

- Monthly statement if any transaction – value, NAV, units, closing balance & value
- Annual statement for folios with no transaction in last 6 months (email if registered)
- Consolidated Account Statement (CAS):
  - Monthly to investors with a transaction that month – all schemes of all MFs
  - Half-yearly (Sept/Mar) if no transaction in preceding 6 months
  - Common investors identified by PAN
- ''Transaction'' = purchase, redemption, switch, IDCW payout/reinvestment, SIP, SWP, STP, bonus

## Who Can Invest in Mutual Funds

- **Who Can Invest – Individuals**

- **Resident adults (18+):** singly or jointly – max 3 holders
- **Minors:** through guardian; payment from minor''s account, parent/guardian''s account or joint account with parent/guardian; change of payout bank mandate before redemption in old folios
- **HUF:** Karta invests on behalf of family ("HUF" after name)
- **NRIs/PIOs:** repatriable or non-repatriable basis; PIO/OCI card
- Foreign nationals as Qualified Foreign Investors (QFIs – sub-category of FPI)
  - From FATF-member country and IOSCO MMOU signatory
  - Via demat (direct) or Unit Confirmation Receipt (indirect)

- **Who Can Invest – Non-individuals**

- Indian companies & corporate bodies; registered & co-operative societies
- Trustees of religious/charitable and private trusts; partnership firms
- AOPs/BOIs; banks (incl. co-op & RRBs), FIs, investment institutions
- Other SEBI-registered MFs; SEBI-registered FPIs (demat or UCR route)
- Multilateral agencies approved by GoI; armed forces & para-military units
- Scientific & industrial research organisations; universities & educational institutions
- Some plans restricted (e.g. Gilt plans for PF, gratuity, pension funds, trusts) – check ''Who can invest'' in SID

## Application Form (1/2)

- **Direct plan:** write "Direct" in ARN box; Regular: ARN/RIA number & details
- Up to 3 holders; folio in first holder''s name – all benefits (IDCW, redemption, tax) to first holder
- **Details:** names, nationality, ID/KYC, signatures, first holder''s address (overseas address for NRI/FPI)
- **Minor:** guardian with KYC & PAN; proof of relationship & minor''s age; no joint holders; on majority folio frozen until status updated
- **Power of Attorney:** KYC & PAN of both; certified PoA copy; PoA holder can do everything except make/change nominations
- **Mode of holding:** single / joint / either or survivor (default if blank); joint holders cannot be changed except deletion on death
- KYC address overrides application address',12,1,41) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l42','nism-5a','nism-5a-m9','Summary notes 3/9: Application Form (2/2) to One-Time Mandate (OTM)','note','## Application Form (2/2)

- KYC acknowledgement + occupation, income/net worth, PEP status (all applicants)
- **FATCA/CRS:** birth place, citizenship, tax residencies & TINs if not only India
- Bank details of first holder mandatory (bank, branch, account no., type, MICR, IFSC)
  - **Demat:** must match demat-linked bank account
  - Different payout account → cancelled cheque / passbook / statement ≤ 3 months / bank letter
- **Investment details:** scheme mandatory; plan, option, frequency – defaults apply
- Payment details; folio/application no. on reverse of cheque
- **Demat option:** DP ID, beneficiary account; DP''s KYC accepted
- **Nomination:** up to 3 nominees (as per prevailing regulation); single-holder folio should nominate or declare opt-out
- Meet minimum investment; signed by all holders

## Purchases, Redemption & Switch

- **Initial purchase:** application form + KIM + documents → folio created
- **Additional purchase:** transaction slip with folio number; folio details override form; name mismatch may be rejected
- **Redemption:** transaction slip – amount or units; price = NAV − exit load; FIFO basis
  - Balance below minimum → entire holding may be redeemed & folio closed
  - Demat units redeemed through DP; proceeds to demat-linked bank
- Pool accounts of brokers/clearing members discontinued – units credited/debited directly
- Switch = redemption + purchase in one transaction
- Subscription & redemption frequency must be the same – except SIF (e.g. daily buy, weekly redeem)

## Payment Modes – Digital

- Two-Factor Authentication mandatory for subscription & redemption
- **Internet banking:** NEFT (batched), RTGS (real-time), IMPS (instant), SWIFT (abroad, slower) – attach bank acknowledgement; first holder must be an account holder
- NACH (by NPCI) – replaced ECS; repetitive payments like SIPs; Credit & Debit variants
- UPI – Virtual Payment Address; BHIM etc.
- ASBA – amount blocked until allotment; no refund wait
- AEPS – Aadhaar + fingerprint; NUUP *99# – USSD, no internet, 11 languages
- Debit cards & net banking accepted; credit cards not allowed for MF purchases
- **E-wallets:** ₹50,000 per investor per MF per FY (combined with cash); loaded only via cash/debit card/net banking; no third-party; RBI KYC

## One-Time Mandate (OTM)

- Authorises bank to process NACH debits raised by a specified MF
- Register once per folio – used for lump sum, additional purchase, SIP
- Needs bank name, account no., type, IFSC, MICR + cancelled cheque
- **Frequency:** monthly, quarterly, half-yearly or ''as and when presented''
- Set fixed or maximum daily debit amount (e.g. ₹5,000) – unlimited transactions within limit
- Validity period and all account holders'' signatures required
- Registration takes 3–4 weeks; usable via physical, online, SMS; cancel by OTM form',12,1,42) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l43','nism-5a','nism-5a-m9','Summary notes 4/9: Cheques, DDs & Third-Party Payments to Cut-off Times: Redemptions','note','## Cheques, DDs & Third-Party Payments

- Cheque/DD in favour of scheme; name/PAN on instrument; separate instrument per scheme/plan
- DD only where no collection centre; AMC bears outstation DD charges within limits
- **NRIs:** NRE/FCNR (repatriable) or NRO (non-repatriable); debit certificate/FIRC for foreign drafts
- Local or ''at par'' cheques; not post-dated (except SIP); not stale (> 3 months)
- Third-party payment (not from first holder''s account) – not accepted except:
  - Parents/related persons for a minor – up to ₹50,000 per purchase/SIP instalment
  - Employer via payroll; custodian on behalf of FPI
  - Needs Third Party Declaration, KYC & PAN of payer, proof of source
- DDs against cash ≥ ₹50,000 not accepted

## Cash Payments & Redemption Payouts

- Cash up to ₹50,000 per investor per MF per FY – small investors without PAN/bank (farmers, small traders)
  - Resident individuals, sole proprietors, minors via guardian; KYC & PMLA compliance; physical application
  - Payouts only via banking channel
- **Not accepted:** stock-invests, postal/money orders, outstation & post-dated cheques
- **Redemption payout:** cheque (slow) or electronic – direct credit, RTGS, NEFT, NACH
  - Paid to sole/first holder; demat → DP-linked bank
  - NRIs paid in rupees; conversion cost borne by investor; TDS as applicable
- **Multiple bank accounts:** up to 5 (individual), 10 (non-individual); one default; unregistered account request → paid to default
- Instant Access Facility (liquid & overnight): same day credit – lower of ₹50,000 or 90% of value, per day per scheme

## Cut-off Times: Purchases

| Scheme | Cut-off | Applicable NAV |
| --- | --- | --- |
| Equity & debt (excl. liquid & overnight) – purchases, switch-ins | 3:00 pm | NAV of the day funds are available for utilisation before cut-off (any amount) |
| Liquid & overnight – purchases, switch-ins | 1:30 pm | Funds by cut-off → NAV of day before receipt; after cut-off → NAV of day before next business day |

- **Liquid funds:** NAV calculated for every calendar day
- Not applicable to NFOs and international schemes

## Cut-off Times: Redemptions

| Scheme | Cut-off | Applicable NAV |
| --- | --- | --- |
| Equity & debt (excl. liquid) | 3:00 pm | Same day before cut-off; next business day after |
| Liquid | 3:00 pm | NAV of day before next business day; after cut-off → next business day NAV |
| Liquid via IAF | 3:00 pm | Lower of previous & current calendar day NAV (after cut-off: lower of current & next) |
| Overnight | 3:00 pm (online 7:00 pm) | Before → NAV of day before next business day; after → next business day NAV |

- **Example week:** Mon, Wed, Thu, Fri business days
  - Equity purchase, funds realised Wed 2 pm → Wed NAV; Wed 5 pm → Thu NAV
  - Liquid purchase, funds Mon by 1 pm → Sunday NAV; Mon by 3 pm → Tuesday NAV
  - Equity redemption Mon after cut-off → Wed NAV; Liquid redemption Mon before cut-off → Tue NAV',12,1,43) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l44','nism-5a','nism-5a-m9','Summary notes 5/9: Time Stamping to KYC Registration Agencies & Central KYC','note','## Time Stamping

- Transactions accepted only at Official Points of Acceptance (OPoAs) – listed in SID & website
- Time at OPoA counts, not when handed to distributor
- Tamper-proof time-stamping machines; openings documented and reported to trustees
- Continuous serial numbering (does not restart daily)
- **Stamp:** location code, machine ID, serial no., date, time – on form, cheque reverse & acknowledgement
- **Non-financial transactions:** date stamp relevant
- **Online:** web-server time determines NAV

## KYC Requirements & Documents

- Mandatory for all – individuals, non-individuals, joint holders, NRIs, PoA holders & issuers, guardians – any amount
- Covers purchases, switches, new SIPs/micro-SIPs, STPs, DTPs
- **Under Anti-Money Laundering laws:** establish identity and address; KRA acknowledgement with application
- **Proof of identity:** PAN with photo (online verification allowed)
  - **PAN exempt:** Govt/court officials, Sikkim residents, UN/multilateral agencies, investments up to ₹50,000 per investor per MF per year
- **Proof of address:** passport, voter ID, ration card, DL, bank statement, utility bill; spouse''s address proof accepted
- Self-attested copies + originals for verification (or attested by authorised persons)

## PAN-Exempt Investments (Micro-SIP)

- **Micro-SIP:** annual SIP ≤ ₹50,000 (rolling 12 months or FY); small lump sum within same composite ₹50,000 limit
- For individuals, minors, sole proprietors – KYC with KRA still needed; quote PEKRN (PAN Exempt KYC Reference No.)
- **Alternative photo IDs:** Voter ID, DL, Govt/Defence ID, passport, photo ration card, photo debit card (not credit card)
  - Employee ID (ROC-registered co.), bank manager/gazetted officer/MLA/MP attested ID, bank employee ID
  - Senior citizen/freedom fighter ID, university/ICAI/ICMAI/ICSI cards, NPS PRAN card, other Govt IDs (ESIC/EPFO)
- Copy self-attested or attested by ARN holder (with ARN)

## KYC Registration Agencies & Central KYC

- One KYC with any intermediary → valid across capital market via KRAs
- In-Person Verification (IPV) mandatory – by intermediary or scheduled commercial bank
- **Uniform Account Opening Form:** Part I (basic KYC), Part II (exchange-specific)
- CERSAI = Central KYC Records Registry (Notification Nov 2015)
  - Individual accounts from 1 Aug 2016 uploaded to CKYCR
  - Stores records, de-duplicates, issues unique KYC Identifier; shares updates; fee-based
  - With KYC Identifier, documents not needed again unless info changed, address verification or enhanced due diligence needed
- UIDAI e-KYC accepted (client authorisation); KUAs & sub-KUAs under Sec 11A PMLA
- **Demat/exchange route:** DP''s KYC accepted',12,1,44) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l45','nism-5a','nism-5a-m9','Summary notes 6/9: KYC Process & Special Cases to SWP, STP, Switch & Transfer of IDCW','note','## KYC Process & Special Cases

- Fill form + documents verified with originals (or notary/gazetted officer/bank manager attested copy)
- Upload to KRA → KYC complete for entire securities market; changes updated once for all
- **Online KYC:** app/website; eSign, DigiLocker; OTP for mobile/email; Aadhaar via UIDAI; PAN via tax database; bank via penny drop
- **SC judgement (30 Apr 2025):** digital KYC must be accessible to persons with disabilities
- **Minors:** guardian''s KYC + minor''s age proof
- **PoA:** KYC of both investor and PoA holder (PoA holder can''t do issuer''s KYC)
- **NRIs:** PAN sole identifier; passport/PIO/OCI + overseas address proof

## Institutional Investors, UBO & FATCA

- Additional documents:
  - Eligibility to invest – MoA/AoA or Trust Deed must permit; Charity Commissioner approval in some states
  - Board resolution authorising investment and signatories; list of authorised signatories
- Ultimate Beneficial Owner (UBO):
  - **Company:** > 25% shares/profits; Partnership/BOI: > 15%; Trust: settlor, trustees, beneficiaries ≥ 15%
  - Not for listed companies & their majority-owned subsidiaries; changes to be informed
- **FATCA & CRS:** identify foreign reportable accounts; report to US IRS/others via Indian tax authorities
  - All folios'' value reported; change in status to be informed within 30 days

## Systematic Investment Plan (SIP)

- Fixed amount at regular intervals – disciplined; protects against inertia

| Month | NAV (₹) | Units |
| --- | --- | --- |
| 1 | 10 | 100.000 |
| 2 | 12 | 83.333 |
| 3 | 9 | 111.111 |
| 4 | 11 | 90.909 |
| 5 | 10 | 100.000 |
| 6 | 12 | 83.333 |
| Total ₹6,000 |  | 568.686 |

- Average cost ₹10.55 < average NAV ₹10.67 → Rupee Cost Averaging
- Pay via PDCs, NACH, standing instructions; lower initial minimum; can start in NFO

## SWP, STP, Switch & Transfer of IDCW

- **SWP:** fixed withdrawal at intervals – avoids exiting at a trough; regular income (retirement); exit load & tax apply
  - 1% exit load at NAV ₹10 → effective ₹9.90 → 101.0101 units for ₹1,000
  - **Variants:** withdraw only appreciation/IDCW – capital stays invested
- **STP:** SWP from source scheme + SIP into target scheme of same MF
  - Avoids idle money & double paperwork; min limits don''t apply; exit load & tax apply
  - **Example:** ₹10 lakh debt fund → ₹1 lakh/month to equity; 0.25% load first 3 months → ₹99,750 transferred
- SIP, SWP, STP may be offered in SIF strategies (respecting minimum threshold)
- **Switch:** one-time move (e.g. equity → short-term debt to book profits)
- **Transfer of IDCW Plan (DTP):** IDCW of one scheme invested in another of same MF
  - Overrides payout/reinvestment; all units in that option covered; target min limit not applicable
  - Invested next business day after record date; ends when source holding nil or on request',12,1,45) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l46','nism-5a','nism-5a-m9','Summary notes 7/9: Systematic Transactions – Operations to Pledge of Units and Demat Holding','note','## Systematic Transactions – Operations

- MF specifies eligible schemes, minimum per instalment, dates, minimum tenure; investor picks amount, frequency, period, dates
- Minor''s SIP registered only till date of majority; defaults apply if not selected
- **New investor:** application + SIP enrolment form; existing: enrolment form only (folio no.); signed per mode of holding
- Submit 15–30 days before first instalment (e.g. submitted 5 Sep, date 15th, 30-day lead → starts 15 Oct); faster with OTM
- **Payment:** PDCs, NACH, direct debit, standing instructions; first instalment by cheque (or bank-attested form)
- Renewal by form; cancellation with notice (and cancel bank mandate); insufficient funds may cancel SIP
- **SWP:** register scheme, amount, frequency, period; ends when units exhausted; minimum lower than normal redemption
- **STP/Switch:** MF defines source & target schemes, minimum amount; target units in same folio; each leg at applicable NAV

## SIP Top-up, SIP Pause & Triggers

- **SIP Top-up:** raise instalment by fixed amount or % at chosen intervals
  - ₹2,500 + ₹500/yr → ₹3,000 (yr 2), ₹3,500 (yr 3); or +10% → ₹2,750, ₹3,025
  - Cap by amount or date; then constant till end; Micro-SIP top-up may be capped at ₹50,000
- **SIP Pause:** halt for 1–6 months without cancelling mandate; auto-resumes; no bounce charges
- Triggers (one-time; end once executed):
  - Profit-booking at a market/NAV level; date trigger; stop-loss on NAV or % fall
  - Buy trigger – e.g. move money into equity when market falls 20%
  - Redeem appreciation, full value or % – or switch to another scheme
  - Separate request per investment; notice period may apply

## Nomination

- Applies to all investments in the folio; up to 3 nominees as prescribed (SEBI revamped norms allow up to 10 persons)
- Specify % share totalling 100% – else equal
- **Single-holder folio:** nominate or explicitly opt out (for subscriptions from 1 Aug 2022)
- **Joint holding:** all holders sign; only individuals can nominate; not for minor''s folio; PoA holder cannot nominate
- **Nominee can be:** individuals (incl. minors with guardian, NRIs), Central/State Govt, local authorities
- **Cannot be:** trust (except religious/charitable), society, body corporate, partnership, Karta of HUF, PoA holder
- Change/cancel any number of times by all original holders; new one supersedes old
- Death of sole nominee cancels nomination; with multiple, remaining nominees get units
- **Demat units:** demat account nomination applies (depository bye-laws)
- Incapacitated investor (still able to contract) may empower one non-minor nominee to operate folio up to set % / amount
- **On death of a joint holder:** survivors get units as owners (not trustees)

## Pledge of Units and Demat Holding

- **Pledge / Lien of Units**

- Banks, NBFCs lend against units – Pledge Form by unitholder (pledger) naming pledgee
- Units must be out of lock-in; all holders sign; non-individuals attach board resolution
- Pledged units cannot be sold or switched until pledgee gives written NOC
- Lender can enforce pledge and redeem (minimum redemption rule doesn''t apply)
- IDCW on pledged units to holder or lender as per agreement

- **Demat Holding of Units**

- MF must offer demat option; ISIN for each scheme option shown in statements
- Provide DP name, DP ID, beneficiary account; names, mode of holding & PAN must match depository data – else units issued in physical mode
- DP''s KYC (with IPV) sufficient – no separate KYC
- Address, bank, nomination as per depository records; redeem via DP or exchange platform
- Existing SoA units can be dematerialised; re-materialisation also possible
- **Benefits:** less paperwork, direct credit of bonus/rights, single change of address, consolidated view of all securities',12,1,46) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l47','nism-5a','nism-5a-m9','Summary notes 8/9: Change in Folio Details to NRI to Resident & Change in Karta','note','## Change in Folio Details

- KYC data (name, status/nationality, PAN, address, contact, spouse/father''s name) → change form to KRA → KRA updates all MFs
  - Give name, DOB, PAN/PERN, Aadhaar; self-attested proofs + originals
- **Demat units:** address change via DP
- **Change of guardian:** new guardian''s KYC, PAN, bank details + NOC from existing guardian
- **Bank accounts:** register with each MF – up to 5 (individuals) / 10 (non-individuals); one default
  - Before deleting default, designate another; cancelled cheque with first holder''s name (or statement/passbook/bank certificate)
- Transfer & gifting of units (SoA or demat) to spouse, children, parents, siblings, parents-in-law
  - Both must be KYC compliant; not for ETFs, retirement/children''s funds, locked-in or liened units

## Transmission of Units

- Transfer on death of unitholder:
  - First holder dies → second holder becomes first holder
  - Single holder with nominee → nominee
  - Joint holding + nominee → joint holder''s right prevails
  - No nomination → legal heirs
- Nominee holds units in trust for legal heirs – no title/beneficial interest; inheritance laws apply
- **Documents:** nominee''s KYC, death certificate, indemnity
- Standard Transmission Request Form & NOC; common documents prescribed by AMFI (on AMC, RTA, AMFI websites)

## Minor Turned Major

- On majority, folio frozen for guardian – no investor-initiated transactions until status changed
  - IDCW payout/reinvestment continues (net of TDS)
  - SIP/SWP/STP registered only till majority date – stop then
- **Before MAM form:** obtain PAN, complete KYC, convert bank account to major or open new one
- **Documents:** MAM form, PAN copy, KYC acknowledgement, cancelled cheque/bank statement, banker''s signature attestation, nomination form, fresh SIP/STP/SWP mandate
- Signature attested by registered guardian, notary/JMFC, or banker
- Minor''s PAN re-issued with new signature; minor demat (single name) → open new demat & transfer

## NRI to Resident & Change in Karta

- NRI returning to India:
  - **Bank:** cannot operate NRO/NRE/FCNR – open resident rupee account; RFC account for foreign currency balances
  - **Demat:** inform authorised dealer (PIS) & DP; open ''Resident'' demat; transfer and close NRI demat
  - **MFs:** inform AMCs of status, address, bank; KYC change form to KRA
- Change in Karta of HUF:
  - Letter from new Karta with reason, folio & scheme details (or AMC form)
  - KYC of new Karta (and HUF if not already compliant)
  - Attested death certificate, bank certificate of new Karta''s signature, indemnity signed by all co-parceners & new Karta',12,1,47) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l48','nism-5a','nism-5a-m9','Summary notes 9/9: Service Turnaround Times to Unclaimed Assets & Voluntary Debit Freeze','note','## Service Turnaround Times

| Service | Timeline |
| --- | --- |
| NAV calculation & disclosure | Daily |
| NFO open period (other than ELSS) | Max 15 days |
| Allotment of units / refund | Within 5 business days of NFO close |
| Re-opening of open-ended scheme | Within 5 business days of allotment |
| IDCW & redemption proceeds | As specified by SEBI – delay → interest borne by AMC |
| Annual report / abridged summary | Within 4 months of year end |
| Half-yearly portfolio statement | Within 10 days of 31 Mar / 30 Sep |
| Half-yearly unaudited results | Within 1 month of half-year end |
| Debt/money market trades disclosure | Daily, with 15-day lag |
| CAS – monthly & half-yearly | As per SEBI timelines |
| Unit certificate | Within 5 working days of request |
| Demat units (close-ended) on request | Within 2 working days |

- Statement of account / demat credit within 5 working days of NFO close or application
- NFO refund delay → 15% p.a. interest, not chargeable to scheme

## Unclaimed Assets & Voluntary Debit Freeze

- **SEBI measures:** norms for dormant folios; mandatory contact & bank details; nominate or opt out; simpler transmission; central reporting of investor''s death
- MITRA (Mutual Fund Investment Tracing and Retrieval Assistant) – by QRTAs CAMS & KFintech
  - Find forgotten folios or those one may legally claim; encourages KYC; reduces unclaimed folios; fraud safeguards
  - Linked from AMC, QRTA, AMFI & SEBI websites
- **DigiLocker:** MF & demat statements to sit alongside bank, insurance, NPS records; nominee access on demise (nominee''s mobile & email needed)
- **Voluntary lock-in / debit freeze:** investor can freeze folio (demat & SoA) against unauthorised redemption – first via MF Central
- **Additional services:** online consolidated family view; valuation, income, returns & capital gains reports',6,1,48) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z8','nism-5a','nism-5a-m9','Chapter 9 practice',60,50,0,0,0,1,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q0','nism-5a-z8','In a joint folio, all benefits (IDCW, redemption proceeds, tax) go to the:','["First holder","All holders equally","Youngest holder","Second holder"]',0,'The folio is in the first holder''s name.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q1','nism-5a-z8','Third-party payments for a minor''s investment by parents or related persons are allowed up to:','["Any amount","₹5,000","₹1,00,000","₹50,000 per purchase or SIP instalment"]',3,'A Third Party Declaration and KYC of the payer are required.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q2','nism-5a-z8','MITRA helps investors:','["Pay taxes","File complaints","Compute NAV","Trace forgotten or unclaimed mutual fund folios"]',3,'It is run by the QRTAs CAMS and KFintech.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q3','nism-5a-z8','For liquid and overnight schemes, the cut-off time for purchases is:','["3:00 pm","2:30 pm","12:00 noon","1:30 pm"]',3,'Funds must be available before the cut-off to get the NAV of the day before receipt.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q4','nism-5a-z8','An Ultimate Beneficial Owner (UBO) of a company is someone holding more than:','["25% of shares or profits","10%","50%","15%"]',0,'For partnership/BOI: more than 15%.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q5','nism-5a-z8','A SIP Top-up of +10% a year on ₹2,500 gives an instalment in year 2 of:','["₹2,510","₹2,600","₹2,750","₹3,000"]',2,'2,500 × 1.10 = 2,750.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q6','nism-5a-z8','CAS identifies common investors by:','["Folio number","PAN","Name","Phone number"]',1,'It covers all schemes of all mutual funds.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q7','nism-5a-z8','ASBA means that the amount is:','["Paid by cheque only","Blocked in the investor''s account until allotment","Refunded after 30 days","Paid in advance to the AMC"]',1,'There is no refund wait.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q8','nism-5a-z8','An SWP stands for:','["Scheme Withdrawal Policy","Standard Withdrawal Payment","Systematic Wealth Plan","Systematic Withdrawal Plan"]',3,'It gives regular income and exit load and tax apply.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q9','nism-5a-z8','₹12,000 invested at an NAV of ₹12 gives:','["1,200 units","1,000 units","144 units","100 units"]',1,'Units = amount ÷ NAV.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q10','nism-5a-z8','SIP Pause allows an investor to halt SIP instalments for:','["1 to 6 months","1 year","2 years","1 to 2 weeks"]',0,'The mandate is not cancelled and the SIP resumes automatically.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q11','nism-5a-z8','A refund after an NFO delayed beyond 5 business days attracts interest at:','["5% p.a. charged to the scheme","10% p.a. borne by the investor","15% p.a. borne by the AMC","12% p.a. charged to the scheme"]',2,'It is not chargeable to the scheme.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q12','nism-5a-z8','A One-Time Mandate (OTM) takes about ___ to register.','["1 week","3 to 4 weeks","6 months","1 day"]',1,'It can then be used for lump sum, additional purchase and SIP.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q13','nism-5a-z8','If refund after NFO is delayed beyond 5 business days, the AMC pays interest at:','["15% p.a.","12% p.a.","10% p.a.","5% p.a."]',0,'The interest is borne by the AMC.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q14','nism-5a-z8','A Transfer of IDCW Plan (DTP) invests the IDCW of one scheme into:','["The same scheme at face value","A scheme of any AMC","A bank deposit","Another scheme of the same MF"]',3,'It overrides payout or reinvestment.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q15','nism-5a-z8','For equity and debt schemes (excluding liquid and overnight), the cut-off time for purchases is:','["4:00 pm","3:00 pm","2:00 pm","1:30 pm"]',1,'Funds must be available for utilisation before the cut-off.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q16','nism-5a-z8','An STP involves:','["Switching to another AMC","An SWP from a source scheme and an SIP into a target scheme of the same MF","A lump sum into two schemes","A transfer of folio"]',1,'It avoids idle money and double paperwork.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q17','nism-5a-z8','Cash investments in mutual funds are allowed up to ___ per investor per MF per financial year.','["₹10,000","₹2,00,000","₹20,000","₹50,000"]',3,'It is meant for small investors without PAN or bank accounts, with KYC and PMLA compliance.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q18','nism-5a-z8','NACH, set up by NPCI, replaced:','["ECS","RTGS","IMPS","SWIFT"]',0,'It is used for repetitive payments like SIPs.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q19','nism-5a-z8','For a Direct plan the ARN box on the application form should carry:','["The AMC''s code","The word \"Direct\"","It is left blank","The RTA code"]',1,'For Regular plans the ARN/RIA number is written.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q20','nism-5a-z8','A 1:3 bonus means:','["1 free unit for every 3 held, with NAV falling proportionately","A 1% exit load","3 free units for every 1 held","IDCW of ₹1 per unit"]',0,'Value of holding remains unchanged.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q21','nism-5a-z8','Which payment mode is NOT accepted for mutual fund purchases?','["NEFT","UPI","Debit cards","Credit cards"]',3,'Debit cards and net banking are accepted; credit cards are not.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q22','nism-5a-z8','An IDCW of ₹2 per unit on 100 units reinvested at an ex-IDCW NAV of ₹20 results in:','["10 additional units","2 additional units","20 additional units","100 additional units"]',0,'₹200 ÷ ₹20 = 10 units.',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q23','nism-5a-z8','The cut-off time for redemptions in equity and debt schemes (excluding liquid) is:','["3:00 pm","2:00 pm","1:30 pm","5:00 pm"]',0,'Same-day NAV if before the cut-off, otherwise next business day.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q24','nism-5a-z8','Units transmitted on the death of the first holder in a joint folio go to:','["The AMC","The nominee","The legal heirs","The second holder, who becomes the first holder"]',3,'Where there is a nominee and a joint holder, the joint holder''s right prevails.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q25','nism-5a-z8','FATCA and CRS identify:','["Credit defaults","PAN duplicates","Fund NAV errors","Foreign reportable accounts"]',3,'A change in status must be informed within 30 days.',25) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q26','nism-5a-z8','Every scheme must offer:','["Only Direct plans","Only Regular plans","Three plans","Regular and Direct plans"]',3,'No other expense-based plans are allowed.',26) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q27','nism-5a-z8','An investor can invest without a PAN through a Micro-SIP if the annual investment is up to:','["₹50,000","₹10,000","₹1,00,000","₹5,00,000"]',0,'The investor must still be KYC-compliant and quote a PEKRN.',27) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q28','nism-5a-z8','KYC is mandatory for mutual fund investments of:','["Above ₹50,000 only","Any amount","Above ₹10 lakh only","Above ₹1 lakh only"]',1,'It applies to individuals, non-individuals, joint holders, NRIs, PoA holders and guardians.',28) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q29','nism-5a-z8','A nominee CANNOT be:','["A body corporate or a Karta of an HUF","An NRI","A minor with a guardian","A Central Government"]',0,'Trusts (other than religious or charitable), societies and partnerships are also barred.',29) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q30','nism-5a-z8','The Direct plan has a lower expense ratio because it has:','["No exit load","No distribution cost or commission","A different portfolio","A different benchmark"]',1,'It has a separate NAV.',30) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q31','nism-5a-z8','The Instant Access Facility for liquid and overnight funds credits the lower of:','["₹10,000 or 100% of value","₹5 lakh or 80% of value","₹50,000 or 90% of the value, per day per scheme","₹1 lakh or 50% of the value"]',2,'It gives same-day credit.',31) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q32','nism-5a-z8','If the mode of holding is left blank on the application form, the default is:','["Single","Joint","Either or survivor","Anyone or survivor with consent"]',2,'Joint holders cannot be changed except by deletion on death.',32) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q33','nism-5a-z8','The limit for e-wallet payments per investor per mutual fund per financial year is:','["₹50,000","₹10,000","₹2,00,000","₹1,00,000"]',0,'The limit is combined with cash payments.',33) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q34','nism-5a-z8','A cheque is considered stale if it is older than:','["3 months","1 year","1 month","6 months"]',0,'Post-dated cheques are not accepted except for SIP.',34) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q35','nism-5a-z8','A Consolidated Account Statement (CAS) is sent monthly to investors:','["Only to NRIs","Who had a transaction that month","Only on request","Only if the portfolio loss exceeds 10%"]',1,'Half-yearly if no transaction in the preceding 6 months.',35) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q36','nism-5a-z8','When a minor turns major, the folio is:','["Frozen for investor-initiated transactions until status is changed","Closed automatically","Transferred to the guardian","Switched to Direct plan"]',0,'IDCW payout continues net of TDS.',36) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q37','nism-5a-z8','Pledged units cannot be sold or switched until:','["The unitholder dies","The pledgee gives a written NOC","SEBI approves","The AMC approves"]',1,'Units must be out of lock-in to be pledged.',37) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q38','nism-5a-z8','In-Person Verification (IPV) for KYC can be done by:','["Only AMFI","Only SEBI","Only the AMC","The intermediary or a scheduled commercial bank"]',3,'IPV is mandatory.',38) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q39','nism-5a-z8','An investor can register up to ___ bank accounts (individual) and ___ (non-individual) with an MF.','["5; 10","2; 5","3; 3","10; 20"]',0,'One account must be the default.',39) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q40','nism-5a-z8','Unit certificates must be issued within ___ of a request.','["10 working days","30 days","1 day","5 working days"]',3,'Demat units for close-ended schemes within 2 working days.',40) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q41','nism-5a-z8','In an SIP, rupee cost averaging means that over time:','["The average cost per unit tends to be lower than the average NAV","NAV never falls","No tax is payable","Returns are guaranteed"]',0,'In the deck example, average cost ₹10.55 against average NAV ₹10.67.',41) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q42','nism-5a-z8','The minimum period an NFO must remain open and the maximum (other than ELSS) are:','["7 days and 60 days","3 working days and 15 days","1 day and 7 days","5 days and 30 days"]',1,'Allotment/refund within 5 business days of closing.',42) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q43','nism-5a-z8','For a single-holder folio, nomination is:','["Not allowed","Optional with no declaration","Required only for NRIs","To be made or an opt-out explicitly declared"]',3,'This applies for subscriptions from 1 August 2022.',43) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q44','nism-5a-z8','Up to how many holders can a mutual fund folio have?','["3","2","5","10"]',0,'Resident adults may invest singly or jointly, maximum 3 holders.',44) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q45','nism-5a-z8','In the IDCW Payout option, NAV after the payout:','["Falls by the IDCW","Stays unchanged","Equals face value","Rises"]',0,'In Growth, NAV reflects the full gains.',45) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q46','nism-5a-z8','A NRI returning to India must open:','["A resident rupee account and a Resident demat account","No new account","An FCNR account only","An NRE account only"]',0,'An RFC account holds foreign currency balances.',46) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q47','nism-5a-z8','A Power of Attorney holder can do everything for the investor EXCEPT:','["Redeem units","Make or change nominations","Make additional purchases","Switch schemes"]',1,'Nominations cannot be made through a PoA.',47) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q48','nism-5a-z8','CERSAI is the:','["Stock exchange platform","Central KYC Records Registry","Credit rating agency","Mutual fund registrar"]',1,'It issues a unique KYC Identifier.',48) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z8-q49','nism-5a-z8','The time used to decide the applicable NAV for a physical application is the time at:','["The fund manager''s desk","Cheque clearing","The Official Point of Acceptance","Handing the form to the distributor"]',2,'Time-stamping machines are tamper-proof.',49) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m10','nism-5a','Ch 10: Risk, Return and Performance of Funds',7,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-O22YjSIKbOY','nism-5a','nism-5a-m10','Video lesson: Chapter 10: Part 1 (Risk, Return & Performance of Mutual Fund)','video','O22YjSIKbOY','',40,'N V Finance',1,49) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-UHdBKjBUD5I','nism-5a','nism-5a-m10','Video lesson: Chapter 10: Part 2 ( Risk, Return & Performance of Fund)','video','UHdBKjBUD5I','',48,'N V Finance',1,50) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l51','nism-5a','nism-5a-m10','Summary notes 1/5: Risk in Fund Investing: Standard & General Factors to Securitised Debt Risks','note','## Risk in Fund Investing: Standard & General Factors

- **Risk in Mutual Fund Investing**

- Some risks managed by fund manager, some by MF structure, some remain with investor
- **SID lists two types:** standard (general) risk factors and specific risk factors + mitigation strategies
- Standard risk statements:
  - Trading volume, settlement, liquidity, default risk incl. loss of principal
  - NAV fluctuates with markets, rates, currency, policy, tax, politics
  - Past performance doesn''t guarantee future; scheme name doesn''t indicate quality
  - Sponsor not liable beyond initial contribution

- **General Risk Factors**

- **Liquidity risk:** trading volumes, settlement delays, thin secondary debt/money market; liquidity premium changes
- **Interest rate risk:** rates ↑ → bond prices ↓; depends on coupon, maturity, yield level
- **Re-investment risk:** interim cash flows reinvested at lower rates (''interest on interest'')
- **Political risk:** central/state/local politics, unrest, policy delays
- **Economic risk:** slowdown, fiscal deficits
- **Foreign currency risk:** for FPIs converting INR to home currency – FPI''s own responsibility
- **Settlement/counterparty risk:** e.g. swap counterparty default
- **Stock exchange transaction risk:** depends on exchange & clearing corporation processing

## Specific Risks – Equity & Derivatives

- **Equity:** daily price volatility, liquidity & settlement constraints, policy/tax/political impacts
- **Securities lending:** borrower failure – loss of collateral rights/corporate benefits
- **Short selling:** counterparty & liquidity risk – covering at higher price
- **Mid & small caps:** faster growth potential but higher volatility & lower liquidity
- **Dividend risk:** dividends not assured even with past record
- Derivatives – leveraged; small moves → big NAV impact:
  - Counterparty risk (exchange-traded mitigated by guaranteed settlement)
  - Market liquidity risk, model risk (mis-pricing), basis risk (hedge mismatch)
  - Execution difficulty (circuit breakers), index futures carry index risk, fixed-income derivative risks

## Specific Risks – Debt

- Reinvestment risk; rating migration risk (e.g. AAA → AA+ lowers price)
- Term structure of interest rate risk – rates ↓ portfolio value ↑ and vice versa
- Credit risk – issuer unable to pay; corporate > G-sec; AA riskier than AAA; SEBI single-issuer limits
- **Floating rate:** spread risk (spread widens) and basis risk (benchmark inactive/ceases)
- **Corporate bond repo:** counterparty risk – mitigated by over-collateralisation
- **Segregated portfolio:** no liquidity until recovery; may realise nothing; listed units may trade well below NAV
- **REITs/InvITs:** price, interest rate, credit, liquidity, reinvestment risk; lower-than-expected distributions

## Securitised Debt Risks

- Originator (bank, NBFC, HFC, company) sells receivables to SPV (trust) → investors get rated Pass-Through Certificates (PTCs)
- **Asset class risk:** CV, auto, credit card, home loans – macro & collateral factors
- Pool characteristics:
  - Loan size – very small tickets raise recovery cost
  - Loan-to-Value – lower LTV = lower default risk (₹10 lakh own on ₹20 lakh truck vs ₹2 lakh)
  - Original maturity & seasoning – 80% instalments repaid > 10%
  - Default distribution – 0–30, 30–60, 60–90 days past due
- Credit enhancement can lift rating above originator''s; funds mostly buy AA & above
- **Other risks:** limited liquidity & price risk, limited recourse/delinquency, prepayment, bankruptcy of originator (''true sale'') or investor''s agent, co-mingling of collections',12,1,51) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l52','nism-5a','nism-5a-m10','Summary notes 2/5: Risk Management Strategies (from SID) to Investment Styles & Portfolio Approach','note','## Risk Management Strategies (from SID)

- **Market liquidity:** hold liquid securities (G-secs, PSU bonds); portfolio liquidity limits; cash first line
- **Credit:** in-house analysis & due diligence; issuer limits on amount and tenor; periodic reviews
- **Term structure:** active duration management (short duration → small risk)
- **Rating migration:** invest in high-grade paper; periodic credit review
- **Reinvestment:** short-duration holdings limit impact
- **Equity market risk:** own research – management meetings, financials, governance, competitive edge
- **Floating rate:** limited new investment due to low liquidity
- **Equity tax status:** regular monitoring of equity exposure

## Systematic vs Unsystematic Risk

| Systematic (market) | Unsystematic (company-specific) |
| --- | --- |
| Affects whole economy – e.g. inflation | Affects one company – e.g. labour strike |
| Non-diversifiable | Diversifiable |
| Rewarded (per finance theory) | Not rewarded |

- Fund managers can cut systematic risk only by holding cash – within SEBI limits; many stay fully invested
- Active managers take unsystematic risk (security views) to beat benchmark
- **"Subject to market risks":** MF is pass-through – risk lies in underlying investments; diversification reduces credit & specific risk but not market-wide fluctuation

## Equity Return Drivers and Fundamental Ratios

- **Drivers of Equity Scheme Returns**

- Returns linked to business earnings; need ongoing business analysis
- To beat benchmark, portfolio must differ from it: security selection and market timing
- Fundamental analysis – business & financials; long-term stock selection
- Technical analysis – price-volume charts, support/resistance, breakouts; short term & timing (''chartists'')

- **Fundamental Ratios**

| Ratio | Formula / meaning |
| --- | --- |
| EPS | Net profit after tax ÷ No. of shares |
| P/E | Market price ÷ EPS; forward P/E uses projected EPS |
| PEG | P/E ÷ earnings growth: 1 = fair, <1 undervalued, >1 overvalued |
| Book value per share | Net worth ÷ No. of shares |
| Price to Book | Market price ÷ Book value per share |
| Dividend yield | Dividend per share ÷ Market price |

- Low P/E isn''t automatically cheap – depends on prospects; compare within sector
- Dividend yields fall in bull markets, rise in bear markets; high yield may signal fewer investment prospects

## Investment Styles & Portfolio Approach

- **Growth style:** fast-growing companies; high P/E & PEG, low dividend yield; fall more in corrections
- **Value style:** priced below intrinsic value; needs longer horizon; winners offset failures
- High valuation ≠ high share price (₹100 can be fair; ₹5 can be overvalued)
- Growth does well early in bull run; value safer when market heats up
- EIC framework – Economy, Industry, Company
- **Top-down:** economy → sectors → stocks (avoids big exposure to poor sectors)
- **Bottom-up:** stocks first; sector allocation is a result (finds good stocks in unfashionable sectors)',12,1,52) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l53','nism-5a','nism-5a-m10','Summary notes 3/5: Drivers of Debt Scheme Returns to Measures of Return','note','## Drivers of Debt Scheme Returns

- **Key risks:** interest rate & credit; yields rise with maturity and credit risk
- Tenor, maturity, redemption; money market = maturity within 1 year
- Yield to Maturity (held to maturity) vs Holding Period Return (interest + capital gain/loss)
- Issuers & instruments:
  - G-Sec/Gilt (no credit risk, lowest yield); T-Bills (RBI for GoI)
  - **Certificates of Deposit:** banks 7 days–1 yr, FIs 1–3 yrs; Commercial Paper: companies up to 1 yr
  - Bonds (Govt/PSU) & Debentures (private) – beyond 1 year
- Credit spread = corporate yield − Gilt yield; rated by CRISIL, ICRA, CARE, India Ratings (AAA = highest safety)
- **Floaters:** Base + Spread (e.g. 5-yr G-sec + 2%) – hold value as rates change

## Interest Rates & Credit Spreads

- Yields ↑ → fixed-rate bond values ↓ (8% bond loses value when market yield is 9%)
- **Example:** 9.5% AAA 5-yr debenture; 2 years later 3-yr AAA rate 8.5% → trades at premium
- Higher modified duration → greater price volatility
- Expect rates ↑ → move to floaters / short tenor; expect rates ↓ → long fixed-rate bonds
- Rating upgrade → lower spread → price ↑
- Accrual funds (liquid, money market, ultra-short, floater) focus on interest income – low duration
- Duration management & credit calls add return but add risk if views go wrong
- Tight SEBI mandates (e.g. overnight) leave little room; dynamic bond funds actively change maturity

## Drivers of Gold & Real Estate Funds

- **Gold:** no current income – returns only from price rise
  - Global gold price – safe haven in turmoil; central bank/IMF buying & selling
  - Rupee strength – stronger rupee lowers gold returns; weaker rupee raises them
  - Import duties; gold funds are passive – no fund manager call risk
- Real estate – local asset:
  - Economic scenario, infrastructure development, interest rates (cheap money lifts prices)
  - **Type:** residential, commercial, industrial, warehouse, hotel, retail
  - **Returns:** rental income + capital appreciation; neutral valuation agencies mandated
  - No MF real estate schemes currently; REITs gaining ground

## Measures of Return

- Simple return = (Later value − Initial value) ÷ Initial value: NAV ₹12 → ₹15 = 25%
- Annualised = Simple return × 12 ÷ months: 5% in 6 months = 10%; 3% in 4 months = 9%
- **Compounding:** ₹10,000 @10% for 3 yrs = ₹13,310 (vs ₹13,000 simple)
- Compounded return = (LV ÷ IV)^(1/n) − 1: ₹1,000 → ₹4,000 in 2 yrs = 100%
  - n = days ÷ 365; uses NAV – valid only if no IDCW paid in period',12,1,53) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l54','nism-5a','nism-5a-m10','Summary notes 4/5: CAGR with IDCW Reinvestment (SEBI method) to Measures of Risk','note','## CAGR with IDCW Reinvestment (SEBI method)

- ₹10,000 at ₹10 (30 Jun 2019) → 1,000 units
- 1 Jan 2020: IDCW ₹1 → ₹1,000 ÷ ex-NAV ₹12.50 = 80 units → 1,080 units
- 1 Jan 2021: IDCW ₹1 → ₹1,080 ÷ ex-NAV ₹15 = 72 units → 1,152 units × ₹15 = ₹17,280
- n = 551 days ÷ 365 = 1.51 years
- CAGR = (17,280 ÷ 10,000)^(1/1.51) − 1 = 43.65% (pre-tax)

## Scheme Returns vs Investor Returns

- Loads & taxes pull investor return below scheme return (1% exit load: ₹15 → ₹14.85)
- For investor return use amount actually paid (NAV + entry load) and received (NAV − exit load)
- Additional purchases/partial redemptions also change investor return
- Advertised returns exclude loads
- **Holding period returns:** CAGR if > 1 year, absolute if < 1 year – sensitive to start/end points
- **Rolling returns:** average of consecutive period returns (e.g. all 1-yr returns over 3 yrs) – removes start/end bias
- Don''t judge on returns alone – check consistency, benchmark & peers, downside protection and volatility
- MFs cannot promise returns except assured return schemes (needs named guarantor) – none so far; capital protection-oriented funds exist

## Risks from the Investor''s View

- **Equity funds:** price risk rises large → mid → small cap; business & liquidity risk; focused funds concentrate risk – keep liquid funds for emergencies
- **Debt funds:** NAV moves with rates & credit migration; IDCW not guaranteed
  - Liquid/ultra-short may give partial liquidity if gating or segregation applied
  - Without segregation, exits raise defaulted paper share: 5% → 10% after 50% redemptions
  - 2018–19 credit events hit even liquid funds – "low risk ≠ zero risk"
  - Close-ended (except ELSS), segregated portfolio and winding-up scheme units listed
- **Hybrid:** check category allocation; arbitrage funds using paired/alpha/merger arbitrage take views
- **Gold:** transparent pricing, hedge in turmoil – but loss if gold falls; know Gold sector fund vs Gold ETF
- **Real estate:** subjective valuation, illiquid, high costs, regulatory/litigation risk, weak governance – still less risky than direct property

## Measures of Risk

| Measure | What it shows | Applies to |
| --- | --- | --- |
| Variance | Fluctuation of returns vs own average | Equity & debt |
| Standard deviation | √Variance – total risk | Equity & debt |
| Beta | Sensitivity vs market index (market = 1) | Equity only |
| Modified duration | Price sensitivity to interest rates | Debt |
| Weighted avg maturity | Simpler proxy for rate sensitivity | Debt |
| Credit rating profile | Default risk | Debt |

- **Excel:** =VAR(), =STDEV(); ≥ 30 observations
- **Annualise SD:** weekly × √52 (0.65 → 4.70%), monthly × √12, daily × √252
- Beta 0.8 → moves 8% when market moves 10%; beta 1.2 → 12%
- **WAM:** 70% in 4-yr + 30% in 1-yr = 3.1 years',12,1,54) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l55','nism-5a','nism-5a-m10','Summary notes 5/5: Credit Events & Gating to Segregated Portfolio – Illustration','note','## Credit Events & Gating

- Credit event = default, delay or rating downgrade → paper becomes illiquid
- **Redemption spiral:** ₹10,000 cr scheme with 8% in paper M; 20% redeemed → M rises to 10%; further panic → 20%
- **Single-issuer limit:** max 10%
- Gating (restriction on redemption) – only for systemic crises, not issuer-specific or poor decisions:
  - Market-wide illiquidity; market failure/exchange closure; operational issues (force majeure, blackout)
  - Max 10 working days in any 90-day period; AMC Board + Trustees approval; inform SEBI immediately
  - First ₹2 lakh of every redemption request is always paid
  - Possibility disclosed prominently in scheme documents

## Segregated Portfolio (Side-pocketing)

- Permitted Dec 2018 on credit event (downgrade by SEBI-registered CRA) – optional for AMC
- Nov 2019: unrated debt of issuer with no rated debt – only on actual default; AMC informs AMFI → AMFI informs all AMCs
- All new schemes after 7 Nov 2019 must have enabling provision in SID; trustee-approved written policy
- On trustee approval:
  - Effective from day of credit event; press release immediately
  - NAV of both portfolios from that day; investors get equal units in segregated portfolio
  - No subscription/redemption in segregated portfolio; listed within 10 working days; transfers allowed
  - New investors get only main portfolio units; if not approved, transactions at total portfolio NAV
- **TER:** no advisory fee; other expenses only on recovery, pro-rata, capped at average of main portfolio; legal costs within TER (excess borne by AMC); never charged to main portfolio

## Segregated Portfolio – Illustration

- 30 Sep 2019: 8% XYZ Ltd NCD downgraded A- → C; marked down 50% (₹99.105 → ₹49.552)

| Portfolio | Net assets (₹) | Units | NAV (₹) |
| --- | --- | --- | --- |
| Total before segregation | 1,00,01,227 | 10,000 | 1,000.1227 |
| Main portfolio (AVC, UYV, MNO + cash) | 87,62,427 | 10,000 | 876.2427 |
| Segregated (XYZ Ltd) | 12,38,800 | 10,000 | 123.88 |

- Total value unchanged; investor holds both sets of units
- **Mitigants:** equity – longer holding period narrows return range (10 yrs: negative returns near nil historically); debt – check credit quality and match holding period with portfolio maturity',9,1,55) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z9','nism-5a','nism-5a-m10','Chapter 10 practice',47,50,0,0,0,1,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q0','nism-5a-z9','The single-issuer limit mentioned for credit risk is a maximum of:','["20%","25%","5%","10%"]',3,'Even so, a redemption spiral can raise a defaulted paper''s share.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q1','nism-5a-z9','A top-down approach starts with:','["Derivatives","Stocks first","The economy, then sectors, then stocks","Dividends"]',2,'Bottom-up picks stocks first; sector allocation is a result.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q2','nism-5a-z9','A growth style fund typically holds stocks with:','["High P/E and PEG and low dividend yield","Negative net worth","Low P/E and high dividend yield","No earnings growth"]',0,'They tend to fall more in corrections.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q3','nism-5a-z9','Mid and small cap stocks usually have:','["Lower volatility","Guaranteed dividends","No liquidity risk","Higher volatility and lower liquidity"]',3,'They offer faster growth potential.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q4','nism-5a-z9','The weighted average maturity of a portfolio with 70% in a 4-year paper and 30% in a 1-year paper is:','["3.5 years","2.5 years","3.1 years","2.8 years"]',2,'0.7 × 4 + 0.3 × 1 = 3.1.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q5','nism-5a-z9','Units of a segregated portfolio must be listed within:','["3 months","1 day","30 days","10 working days"]',3,'No subscription or redemption is allowed in them.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q6','nism-5a-z9','Even during gating, the first ___ of each redemption request is paid.','["₹5 lakh","₹2 lakh","₹1 lakh","₹50,000"]',1,'The possibility of gating must be disclosed in scheme documents.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q7','nism-5a-z9','Weekly standard deviation is annualised by multiplying by:','["√252","√12","52","√52"]',3,'Monthly × √12; daily × √252.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q8','nism-5a-z9','Which of these can be diversified away?','["Market risk","Inflation risk","Unsystematic (company-specific) risk","Interest rate risk"]',2,'Systematic risk is non-diversifiable.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q9','nism-5a-z9','In finance theory, which risk is rewarded with a higher expected return?','["Strike-related risk","Unsystematic risk","Systematic risk","Company labour risk"]',2,'Unsystematic risk is not rewarded.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q10','nism-5a-z9','Seasoning in securitisation refers to:','["The proportion of instalments already repaid","The date of NFO","The rating of the SPV","The loan size"]',0,'In the deck, 80% instalments repaid is more seasoned than 10%.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q11','nism-5a-z9','Gating in a mutual fund can be applied for a maximum of:','["5 days in a month","10 working days in any 90-day period","90 days in a year","30 days in a year"]',1,'Only for systemic crises with AMC Board and Trustee approval.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q12','nism-5a-z9','Compounded return is valid using NAV only if:','["There is an exit load","The scheme is debt","No IDCW was paid in the period","The scheme is close-ended"]',2,'Otherwise the SEBI reinvestment method is used.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q13','nism-5a-z9','Derivatives in a fund are leveraged, so a small market move can:','["Have a large impact on NAV","Be ignored","Never affect NAV","Only raise NAV"]',0,'Exchange-traded derivatives mitigate counterparty risk.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q14','nism-5a-z9','Commercial Paper (CP) is issued by:','["Banks for 7 days","Government","RBI","Companies for up to 1 year"]',3,'Certificates of Deposit are issued by banks (7 days–1 year) and FIs (1–3 years).',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q15','nism-5a-z9','Standard deviation measures:','["Systematic risk only","Liquidity risk","Credit risk","Total risk (the volatility of returns)"]',3,'Variance is its square.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q16','nism-5a-z9','Loads and taxes cause investor return to be:','["Higher than scheme return","Lower than scheme return","The same as scheme return","Always zero"]',1,'Advertised returns exclude loads.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q17','nism-5a-z9','A 5% return in 6 months annualises (simple) to:','["15%","10%","2.5%","5%"]',1,'Annualised = simple return × 12 ÷ months.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q18','nism-5a-z9','Rating migration risk means:','["A rating upgrade lowers price","A downgrade (for example AAA to AA+) lowers the price of the paper","Moving from debt to equity","Moving to another rating agency"]',1,'It is a risk in debt funds.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q19','nism-5a-z9','Book value per share is:','["Net worth ÷ number of shares","EPS ÷ growth","Dividend ÷ price","Market price ÷ EPS"]',0,'Price-to-book = market price ÷ book value per share.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q20','nism-5a-z9','A fund with a beta of 1.2 should move about ___ when the market moves 10%.','["20%","12%","10%","8%"]',1,'Beta measures sensitivity to the market index.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q21','nism-5a-z9','Gold fund returns come from:','["Price rise only; there is no current income","Rent","Interest","Dividends"]',0,'A weaker rupee raises gold returns in INR.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q22','nism-5a-z9','Re-investment risk arises when:','["Credit rating improves","NAV rises","Interim cash flows are reinvested at lower rates","Interest rates rise"]',2,'It is "interest on interest".',22) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q23','nism-5a-z9','Credit spread equals:','["Gilt yield minus corporate yield","Repo rate minus reverse repo","Corporate bond yield minus Gilt yield","Corporate yield plus Gilt yield"]',2,'A rating upgrade reduces the spread and raises the price.',23) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q24','nism-5a-z9','A segregated portfolio (side-pocket) was permitted by SEBI from:','["March 2023","April 2020","January 2010","December 2018"]',3,'It is optional for the AMC on a credit event.',24) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q25','nism-5a-z9','Rolling returns are:','["Returns from a single date","Returns after tax","Annual returns only","The average of consecutive period returns, removing start and end bias"]',3,'For example all 1-year returns over 3 years.',25) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q26','nism-5a-z9','If interest rates are expected to rise, the better strategy for debt funds is:','["Shorter tenor or floaters","Gold funds only","Long-duration fixed-rate bonds","No change at all"]',0,'Expecting a fall means long fixed-rate bonds.',26) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q27','nism-5a-z9','EIC framework stands for:','["Earnings, Interest, Cash","Equity, Income, Credit","Economy, Industry, Company","Exposure, Index, Cap"]',2,'It is used in fundamental analysis.',27) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q28','nism-5a-z9','PEG ratio below 1 is generally seen as:','["Impossible","Overvalued","Undervalued","Fairly valued"]',2,'PEG = P/E ÷ earnings growth; 1 = fair.',28) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q29','nism-5a-z9','In a mutual fund, which risk is MOSTLY borne by the investor rather than the fund manager?','["Market-wide risk","Stock selection risk","Duration positioning risk","Credit analysis risk"]',0,'The fund manager can reduce it only by holding cash within SEBI limits.',29) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q30','nism-5a-z9','In the SEBI CAGR method with IDCW, the IDCW is assumed to be:','["Paid out and ignored","Reinvested at the next day''s NAV","Reinvested at face value","Reinvested at the ex-IDCW NAV"]',3,'This increases the number of units.',30) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q31','nism-5a-z9','The sponsor''s liability for a mutual fund scheme is:','["Zero and no contribution is made","Limited to its initial contribution","Equal to total corpus","Unlimited"]',1,'This is a standard risk statement.',31) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q32','nism-5a-z9','In a segregated portfolio, the investment and advisory fee is:','["Charged by the distributor","Not charged","Charged at half rate","Charged at the full rate"]',1,'Other expenses are charged only on recovery.',32) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q33','nism-5a-z9','A lower Loan-to-Value ratio in a securitised pool indicates:','["Higher prepayment only","No recovery","Lower default risk","Higher default risk"]',2,'The borrower has more own money in the asset.',33) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q34','nism-5a-z9','An NAV rising from ₹12 to ₹15 gives a simple return of:','["25%","15%","20%","30%"]',0,'(15 − 12) ÷ 12 = 25%.',34) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q35','nism-5a-z9','Basis risk in derivatives is:','["The risk of NAV rounding","The risk of IDCW","The mismatch between the hedge and the underlying exposure","The credit risk of the issuer"]',2,'It is a specific risk of derivatives.',35) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q36','nism-5a-z9','In securitised debt, investors receive:','["Equity shares of the originator","Fixed deposits","Rated Pass-Through Certificates (PTCs)","Government bonds"]',2,'The originator sells receivables to an SPV trust.',36) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q37','nism-5a-z9','₹10,000 invested at 10% compounded for 3 years becomes:','["₹14,000","₹13,310","₹13,000","₹13,100"]',1,'10,000 × 1.1³ = 13,310.',37) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z9-q38','nism-5a-z9','Which fund has no credit risk and the lowest yield among debt instruments?','["Floater of AA bonds","Corporate bond fund","Gilt/G-Sec","Credit risk fund"]',2,'It carries interest rate risk, not credit risk.',38) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('nism-5a-m11','nism-5a','Ch 11: Mutual Fund Scheme Performance',7,11) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('nism-5a-v-PFVAmw3oHOA','nism-5a','nism-5a-m11','Video lesson: Chapter 11: Mutual Fund Scheme Performance','video','PFVAmw3oHOA','',35,'N V Finance',1,56) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l57','nism-5a','nism-5a-m11','Summary notes 1/3: Benchmarks to Benchmarks for Debt & Other Schemes','note','## Benchmarks

- Benchmark = pre-defined comparable to judge scheme performance
- A credible benchmark must be in sync with the scheme''s:
  - Investment objective · Asset allocation pattern · Investment strategy
- Calculated independently and transparently; published regularly (exchanges, rating agencies, research houses, publications)
- **Index fund:** the tracked index is the benchmark; others – chosen by AMC with trustees, stated in SID
- Benchmark performance shown alongside scheme''s past performance
- Change of benchmark (new objective, index change, better index) – AMC with trustees, justified & documented
- Past returns are NOT a basis for choosing a benchmark

## Price Return Index vs Total Return Index

- **PRI:** captures only price changes (capital gains) of constituents
- **TRI:** price changes + dividends/interest notionally reinvested on ex-date
- From 1 Feb 2018 all schemes benchmarked to TRI
  - Scheme returns include dividends (IDCW option measured by reinvestment method) – PRI gave unfair advantage
  - Fewer schemes appear to beat benchmark; gap = index dividend yield (~1.5–2.5% historically)
- **Where TRI unavailable for a period:** use composite CAGR – PRI until TRI starts, TRI thereafter

## Benchmarks for Equity Schemes

- **Scheme type:** diversified → broad index (Sensex, Nifty 50, BSE 200/500, Nifty 100/500); sectoral/thematic → sector index (BSE Bankex, BSE FMCG, Nifty Infrastructure, Nifty Energy)
- **Investment universe:** large caps → Sensex (30) / Nifty 50; mid caps → Nifty Midcap 50 / BSE Midcap
- **Portfolio concentration:** fewer stocks → narrow index (Sensex, Nifty 50); more stocks → BSE/Nifty 100, 200, 500

## Benchmarks for Debt & Other Schemes

- Debt benchmarks from AMFI-recommended agencies: CRISIL, ICICI Securities, NSE
  - **NSE:** Nifty Composite G-sec, Nifty 4–8 Year G-sec, Nifty 10-yr benchmark G-sec; BSE: India Sovereign Bond, Govt Bill indices
  - **ICICI Securities I-Bex:** Si-Bex (1–3 yrs), Mi-Bex (3–7 yrs), Li-Bex (> 7 yrs)
- Liquid funds → NSE Liquid / CRISIL Liquid Fund Index; Gilt funds → G-sec indices; diversified debt → mixed-debt index
- **Hybrid:** blended index, e.g. 65% Sensex + 35% I-Bex
- **Gold ETF:** price of gold; Real estate: young, less accepted indices
- **International:** index of target market (Shanghai Composite for China, S&P 500 for US) or synthetic blend
- Standard additional benchmarks (Sensex/Nifty, 1-yr T-Bill, 10-yr GoI) – as in Ch 4; part of SAI & ads',12,1,57) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l58','nism-5a','nism-5a-m11','Summary notes 2/3: Two-Tier Benchmarking (from 1 Jan 2022) to Scheme Performance Disclosure','note','## Two-Tier Benchmarking (from 1 Jan 2022)

| Scheme type | Benchmark structure |
| --- | --- |
| Debt-oriented | Tier 1: broad market index per category (e.g. CRISIL Ultra Short Term Debt Index); Tier 2: bespoke to style (e.g. AAA Bond Index) |
| Equity-oriented | Tier 1: broad index (e.g. BSE 100 / NSE 100 for large cap); Tier 2: style index (e.g. Nifty 50) |
| Hybrid & solution-oriented | Single broad or bespoke benchmark |
| Thematic / sectoral | Single benchmark |
| Index funds & ETFs | Single – the replicated index |
| FoFs | Single underlying → its benchmark; multiple → broad market index |

- All benchmarks must be TRI; debt Tier 1 aligned to Potential Risk Class (from 1 Apr 2022)

## Relative & Risk-adjusted Returns

- **Relative return:** scheme vs benchmark/peers → initial view of out/under-performance; AMCs & trustees review periodically
- **Weakness:** ignores different risk levels taken for the same objective
- **Risk-adjusted returns:** return should be commensurate with risk

| Measure | Formula | Example | Best used for |
| --- | --- | --- | --- |
| Sharpe ratio | (Rs − Rf) ÷ Standard deviation | (7% − 5%) ÷ 0.5% = 4 | Comparable schemes (equity vs equity) |
| Treynor ratio | (Rs − Rf) ÷ Beta | (8% − 5%) ÷ 1.2 = 2.5 | Diversified equity |
| Alpha | Actual return − optimal (beta-based) return | Positive = outperformance | Diversified equity |

- Rf = risk-free return (T-Bill index); higher ratio = better
- Calculations are arithmetic; evaluation is an art – don''t rely blindly on historical metrics

## Information Ratio & Tracking Error

- Information Ratio = (Portfolio return − Benchmark return) ÷ Standard deviation of excess return
  - Uses Tier-1 benchmark; SD from daily returns
  - Only risk-adjusted measure mandatory to disclose – daily on AMC website; comparable format on AMFI (SEBI circular Jan 2025)
- Tracking error = standard deviation of excess returns
  - Index fund (beta 1) should match index – tracking error ideally zero
  - Now also gauges consistency of outperformance – lower is better
  - Denominator of the Information Ratio

## Scheme Performance Disclosure

- Mandatory performance disclosures in scheme documents & AMC websites; SID updated twice a year
- Monthly factsheet (not statutory) – subject to SEBI ad guidelines
- Product literature covers:
  - Suitability – product label (wealth creation / regular income / liquidity), asset class, holding period, risk-o-meter
  - Returns – cumulative over periods, vs benchmark; discrete annual returns show consistency
  - Portfolio description – diversification, market cap, growth/value; debt tenor & credit quality; hybrid allocation
- **AMFI website:** performance of all schemes by period & category; data vendors (e.g. Morningstar, Value Research) for NAV/IDCW feeds',12,1,58) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('nism-5a-l59','nism-5a','nism-5a-m11','Summary notes 3/3: Market Metrics in Factsheets','note','## Market Metrics in Factsheets

| Metric | Why it matters |
| --- | --- |
| Index levels & yields | Assess scheme performance |
| Corporate results, earnings revisions, margins | Tone for equity markets |
| Government spending / fiscal deficit | Growth vs higher borrowing & interest rates |
| Inflation | Demand, costs, possible monetary tightening |
| Interest rate changes | Consumption, corporate expansion |
| Domestic & foreign portfolio flows | Expectations from Indian markets |
| Commodity & input prices | Company profitability; oil affects currency & trade |
| GDP numbers | Economic cycle and growth |
| Overseas economic & rate data | Export demand and fund flows to emerging markets |',3,1,59) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO quizzes (id,course_id,module_id,title,minutes,pass_pct,negative,is_exam,mock,published,sort) VALUES ('nism-5a-z10','nism-5a','nism-5a-m11','Chapter 11 practice',30,50,0,0,0,1,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,minutes=excluded.minutes,pass_pct=excluded.pass_pct,negative=excluded.negative,is_exam=excluded.is_exam,mock=excluded.mock,published=excluded.published,sort=excluded.sort WHERE quizzes.course_id IS NOT excluded.course_id OR quizzes.module_id IS NOT excluded.module_id OR quizzes.title IS NOT excluded.title OR quizzes.minutes IS NOT excluded.minutes OR quizzes.pass_pct IS NOT excluded.pass_pct OR quizzes.negative IS NOT excluded.negative OR quizzes.is_exam IS NOT excluded.is_exam OR quizzes.mock IS NOT excluded.mock OR quizzes.published IS NOT excluded.published OR quizzes.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q0','nism-5a-z10','Where a TRI is unavailable for a period, the benchmark return is shown using:','["The AMC''s own estimate","The risk-free rate","No benchmark","A composite CAGR: PRI until TRI starts and TRI thereafter"]',3,'This was permitted for older periods.',0) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q1','nism-5a-z10','Tracking error is the standard deviation of:','["Dividends","Expenses","NAV","Excess returns over the benchmark"]',3,'For an index fund it should ideally be zero.',1) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q2','nism-5a-z10','An investment of ₹44,000 grows to ₹1,12,867 in 6 years. The compounded annual growth rate (CAGR) is closest to:','["15.0%","19.0%","17.0%","26.1%"]',2,'CAGR = (end/start)^(1/6) − 1 ≈ 17%.',2) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q3','nism-5a-z10','Relative return has the weakness that it:','["Excludes IDCW","Ignores the different risk levels taken","Cannot be computed","Includes taxes"]',1,'Hence risk-adjusted returns are used.',3) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q4','nism-5a-z10','From 1 February 2018 all schemes must be benchmarked to:','["Price Return Index (PRI)","Gold price","Bank FD rate","Total Return Index (TRI)"]',3,'TRI includes reinvested dividends.',4) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q5','nism-5a-z10','Product label categories in product literature include:','["Gold, silver, platinum","Speculation, hedging, arbitrage","Short, medium, long duration only","Wealth creation, regular income, liquidity"]',3,'Together with asset class, holding period and risk-o-meter.',5) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q6','nism-5a-z10','With a scheme return of 8%, risk-free 5% and beta 1.2, the Treynor ratio is:','["1.5","3.0","2.5","0.6"]',2,'(8 − 5) ÷ 1.2 = 2.5.',6) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q7','nism-5a-z10','Information Ratio equals:','["Return ÷ beta","Alpha ÷ beta","Return ÷ expenses","(Portfolio return − benchmark return) ÷ standard deviation of excess return"]',3,'The denominator is the tracking error.',7) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q8','nism-5a-z10','A diversified equity scheme should be benchmarked against a:','["Gold index","Sector index only","Broad index such as Nifty 50 / BSE 200 / BSE 500","Bond index"]',2,'Sectoral/thematic schemes use sector indices.',8) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q9','nism-5a-z10','The risk-free return used in the Sharpe ratio is usually based on:','["A corporate bond index","The T-Bill index","The gold price","The sensex"]',1,'Rf is the risk-free return.',9) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q10','nism-5a-z10','The Sharpe ratio is:','["Alpha ÷ beta","(Scheme return − risk-free return) ÷ beta","Return ÷ expenses","(Scheme return − risk-free return) ÷ standard deviation"]',3,'A higher ratio is better.',10) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q11','nism-5a-z10','The monthly fund factsheet is:','["Issued by AMFI","Issued by RBI","Non-statutory but subject to SEBI ad guidelines","Mandatory by SEBI Regulations"]',2,'It is an AMFI best practice.',11) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q12','nism-5a-z10','An investment of ₹75,000 grows to ₹1,04,430 in 2 years. The compounded annual growth rate (CAGR) is closest to:','["16.0%","20.0%","19.6%","18.0%"]',3,'CAGR = (end/start)^(1/2) − 1 ≈ 18%.',12) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q13','nism-5a-z10','A hybrid scheme''s benchmark is typically:','["Gold price","The Nifty only","A single bond index","A blended index such as 65% Sensex + 35% I-Bex"]',3,'It reflects the scheme''s asset mix.',13) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q14','nism-5a-z10','Which risk-adjusted measure must mandatorily be disclosed daily by AMCs?','["Alpha","Treynor ratio","Information Ratio","Sharpe ratio"]',2,'Per the SEBI circular of January 2025.',14) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q15','nism-5a-z10','A positive alpha means:','["The scheme has no risk","The scheme has no expenses","The scheme outperformed its beta-based expected return","The scheme underperformed"]',2,'Alpha = actual return − optimal return for its beta.',15) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q16','nism-5a-z10','Index funds and ETFs have:','["A gold benchmark","A single benchmark, which is the replicated index","Two benchmarks","No benchmark"]',1,'Thematic and sectoral also have a single benchmark.',16) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q17','nism-5a-z10','Two-tier benchmarking applies from:','["1 January 2020","1 April 2018","1 April 2025","1 January 2022"]',3,'It applies to debt-oriented and equity-oriented schemes.',17) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q18','nism-5a-z10','A credible benchmark must be in sync with the scheme''s:','["Investment objective, asset allocation and strategy","AMC''s brand","Past returns only","Fund manager''s age"]',0,'Past returns are NOT a basis for choosing a benchmark.',18) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q19','nism-5a-z10','Under two-tier benchmarking, Tier 1 is:','["The risk-free rate","A bespoke index","A broad market index per category","The additional benchmark"]',2,'Tier 2 is more specific to the style.',19) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q20','nism-5a-z10','The Price Return Index captures:','["Dividends only","Price changes only","Interest only","Price changes plus reinvested dividends"]',1,'This gave schemes an unfair advantage over PRI.',20) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
INSERT INTO questions (id,quiz_id,question,options,answer,explanation,sort) VALUES ('nism-5a-z10-q21','nism-5a-z10','An investment of ₹19,000 grows to ₹41,657 in 5 years. The compounded annual growth rate (CAGR) is closest to:','["17.0%","19.0%","23.8%","15.0%"]',0,'CAGR = (end/start)^(1/5) − 1 ≈ 17%.',21) ON CONFLICT(id) DO UPDATE SET quiz_id=excluded.quiz_id,question=excluded.question,options=excluded.options,answer=excluded.answer,explanation=excluded.explanation,sort=excluded.sort WHERE questions.quiz_id IS NOT excluded.quiz_id OR questions.question IS NOT excluded.question OR questions.options IS NOT excluded.options OR questions.answer IS NOT excluded.answer OR questions.explanation IS NOT excluded.explanation OR questions.sort IS NOT excluded.sort;
