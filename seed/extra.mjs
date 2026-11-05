// Hand-written notes for tool / foundation courses.
// IMPORTANT: these describe the tools in general. Replace/extend them in the Admin Portal with your
// company's real SOPs (field names, dispositions, SLAs).

export const EXTRA = {
  zoho: {
    modules: [
      {
        title: 'Zoho CRM essentials',
        lessons: [
          {
            title: 'The Zoho CRM data model: Leads, Contacts, Accounts, Deals',
            minutes: 10,
            body: `# The Zoho CRM data model

Zoho CRM organises everything into **modules**. Knowing which module a record belongs in avoids duplicates and broken reports.

| Module | What it holds | Typical use for us |
|---|---|---|
| **Leads** | Someone who has shown interest but is not yet qualified | Website sign-ups, campaign responses, referrals |
| **Contacts** | A qualified person you actively serve | Onboarded or in-process clients |
| **Accounts** | A company / household | Corporate clients, family groupings |
| **Deals** | A potential sale moving through a pipeline | A lump-sum / SIP opportunity with amount and stage |
| **Tasks / Calls / Events** | Activities | Follow-up calls, review meetings |
| **Notes** | Free-text history on any record | Call summaries |

## Rules of thumb
1. **Search before you create.** Search phone number and e-mail first - duplicates split the client's history.
2. **One owner per record.** The record owner is accountable for follow-up.
3. **Convert, don't re-type.** When a lead qualifies, use **Convert** so history carries over to Contact/Deal.
4. **Log it or it did not happen.** Every call and promise belongs in the CRM, not in WhatsApp or your head.

> Confirm exact field names and mandatory fields with your team lead - they are configured per company.`,
          },
          {
            title: 'Working a lead: from first call to conversion',
            minutes: 12,
            body: `# Working a lead

## Daily routine
1. Open **Leads** -> filter *My open leads* -> sort by *Last activity* (oldest first).
2. Work **overdue Tasks** before new leads.
3. After every call: set the **disposition / status**, write a **call note**, and schedule the **next task**.

## A good call note (4 lines)
- **Situation** - who they are, goal, horizon (e.g. "35 y/o, wants Rs 50L for child education in 12 yrs").
- **Need** - what was asked / the concern raised.
- **Agreement** - what you told them and what they agreed to.
- **Next step** - what, who, and *when* (create the Task with a date).

## Lead statuses (typical)
*New -> Attempted to contact -> Contacted -> Qualified -> Converted* or *Not interested / Junk / Not reachable*.
Never leave a lead in "New" after you have called.

## Compliance reminders
- Do not promise returns. Quote only approved material.
- Record consent for communications (WhatsApp/e-mail) in the record.
- Do not store PAN/Aadhaar images in notes - use the approved document flow.`,
          },
          {
            title: 'Deals, pipeline stages and forecasting',
            minutes: 8,
            body: `# Deals and the pipeline

A **Deal** is an opportunity with an *amount*, *closing date* and *stage*.

## Keep the pipeline honest
- Move the stage only when the **exit criteria** are met (e.g. "KYC complete" before "Ready to invest").
- Update **amount** and **closing date** every time they change - forecasts are built from these.
- Use **Lost reason** when closing as lost; it is the most valuable data for improving the pitch.

## Views that save time
- **Kanban view** of the pipeline for stand-ups.
- **Custom views**: "Closing this week", "No activity in 7 days".
- **Reports/Dashboards**: conversion by source, calls per day, pipeline by owner.

## Weekly hygiene (15 minutes, every Friday)
1. Every open deal has a **next task**.
2. No deal has a **past closing date**.
3. Stale deals (>14 days no activity) are either re-engaged or closed.`,
          },
          {
            title: 'Templates, tasks, blueprints and automation (what to expect)',
            minutes: 8,
            body: `# Templates and automation

Zoho CRM can automate repetitive steps. Your admin configures these; you should know how they affect you.

- **Email / WhatsApp templates** - use only approved templates; placeholders (client name, scheme) are filled from the record, so keep the record clean.
- **Workflow rules** - e.g. auto-create a follow-up task when a lead moves to *Contacted*.
- **Blueprint** - forces a fixed process (you cannot skip steps) and may require notes or documents at a step.
- **Assignment rules** - new leads are routed to owners automatically.
- **Reminders** - tasks trigger notifications; clear them daily.

## If something looks wrong
Do not work around it. Raise it with your admin with: the record link, what you expected, what happened, and a screenshot.`,
          },
        ],
      },
    ],
  },

  tata: {
    modules: [
      {
        title: 'Cloud telephony essentials',
        lessons: [
          {
            title: 'Getting set up: login, browser permissions and headset',
            minutes: 8,
            body: `# Getting set up on the dialer

1. **Sign in** to the telephony portal with your own agent credentials (never share them).
2. Allow the **microphone** when the browser asks. If you clicked Block: lock icon in the address bar -> Site settings -> Microphone -> Allow, then reload.
3. Use a **wired / USB headset with a noise-cancelling mic**. Laptop speakers cause echo.
4. Set your **agent status** deliberately:
   - **Available / Ready** - you will receive calls.
   - **On call / Wrap-up** - finishing notes; keep it short.
   - **Break / Offline** - you will not receive calls.
5. Check your connection: a stable wired or good Wi-Fi connection avoids robotic voice and drops.

> Exact menu names vary by plan. Confirm with your team lead.`,
          },
          {
            title: 'Making and receiving calls; click-to-call from the CRM',
            minutes: 8,
            body: `# Calls and click-to-call

**Click-to-call** usually works in two legs: the system first rings *you*, then dials the client. Pick up promptly so the second leg connects.

## Outbound checklist
- Open the client's record first so you have context.
- Click the phone number in the CRM (or dial from the softphone).
- Open the call with the **approved introduction** and the recording disclosure used by your company.
- After the call: choose the **disposition**, add your **note**, create the **next task**.

## Inbound / IVR
Callers are routed by IVR menu to teams. If a call is for another team, do a **warm transfer**: tell the colleague who the client is and why they are calling *before* connecting them.

## Failed connections
Busy / not reachable / switched off -> log the attempt with the matching disposition and schedule a retry at a different time of day.`,
          },
          {
            title: 'Call recording, dispositions and wrap-up discipline',
            minutes: 7,
            body: `# Recording, dispositions, wrap-up

## Recording
Advisory and service calls may be recorded for compliance and quality. Always follow the company's disclosure script. Never ask a client to share OTPs, passwords or full card numbers on a call.

## Dispositions
A disposition is the outcome you tag on every call. Typical set: *Interested, Call-back, Not reachable, Not interested, Wrong number, Info shared, Docs pending*. Accurate dispositions drive reports and automation, so pick the true one - not the easiest one.

## Wrap-up
- Finish notes **within about a minute** after the call so you are available for the next one.
- Long research? Set status to *Break* or *Offline task* rather than sitting in Wrap-up.`,
          },
          {
            title: 'Troubleshooting: no audio, echo, one-way voice, drops',
            minutes: 6,
            body: `# Troubleshooting

| Problem | Likely cause | Fix |
|---|---|---|
| Mic not detected | Browser permission blocked / wrong input device | Allow mic for the site; pick the headset as default input; reload |
| Echo | Speakers + mic, or two tabs open | Use a headset; close other call tabs |
| One-way audio | Firewall/VPN or wrong output device | Disable VPN, check output device, re-login |
| Robotic voice / drops | Weak internet | Move to wired/better Wi-Fi; close streaming apps |
| Cannot receive calls | Status not Available | Set status to Available |

If it persists: note the **time, number dialled and call ID**, and raise a ticket with IT / the telephony admin.`,
          },
        ],
      },
    ],
  },

  markets: {
    modules: [
      {
        title: 'Reading the markets',
        lessons: [
          {
            title: 'How to follow market changes without noise',
            minutes: 6,
            body: `# Following market changes

Advisors are expected to be **informed, calm and factual**. Use the **Market Updates** page in this hub (live regulatory and market headlines) and build a short daily habit:

## 5-minute daily routine
1. **Indices**: Sensex / Nifty 50 direction, plus mid- and small-cap indices.
2. **Rates & inflation**: any RBI policy action; CPI inflation prints; bond yields.
3. **Flows**: FPI and DII flows; mutual fund SIP inflow data (AMFI monthly).
4. **Regulation**: new SEBI circulars affecting products, fees, KYC or disclosures.
5. **One idea to share**: a single, plain-English point you can tell a client today.

## What to tell clients on volatile days
- Acknowledge the worry; do not argue with it.
- Remind them of their **goal and time horizon**, not the day's index move.
- Never predict. Never promise. Offer the review process instead.

## Sources you can trust
SEBI, AMFI, RBI, exchanges (NSE/BSE) and fund-house factsheets. Treat forwards and social media as unverified.`,
          },
        ],
      },
    ],
  },

  compliance: {
    modules: [
      {
        title: 'Conduct basics',
        lessons: [
          {
            title: 'Ten conduct rules for client conversations',
            minutes: 5,
            body: `# Ten conduct rules

1. Hold the **valid certification and registration** (NISM V-A + AMFI ARN) before advising on mutual funds.
2. Always assess **suitability** - goal, horizon, risk capacity and tolerance - before recommending.
3. **Never promise or guarantee returns.** Past performance is not a guide to future performance.
4. Disclose **fees, commissions and conflicts** when asked and as required.
5. Use only **approved marketing material** and templates.
6. **Never accept** cash/third-party payments or share OTPs/passwords.
7. Protect **client data**: share on need-to-know only; no screenshots on personal phones.
8. **Record** advice and instructions as per company process.
9. **Escalate** grievances within SLA; do not argue with a complaint.
10. When unsure - **stop and ask Compliance.**

> This is a summary for orientation. The binding rules are SEBI/AMFI regulations and your company's policies - read them at the source (see Links on this course).`,
          },
        ],
      },
    ],
  },
};
