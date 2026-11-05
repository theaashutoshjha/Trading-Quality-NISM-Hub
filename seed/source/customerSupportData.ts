export interface SupportEscalationContact {
  level: string;
  contact: string;
  timeframe: string;
}

export interface SupportWorkflow {
  id: string;
  workflowTitle: string;
  category: string;
  slaHours: number;
  triggerCondition: string;
  rootCauses: string[];
  stepByStepResolution: string[];
  clientCommunicationTemplate: string;
  escalationMatrix: SupportEscalationContact[];
}

export const CUSTOMER_SUPPORT_WORKFLOWS: SupportWorkflow[] = [
  {
    id: 'supp-wf-1',
    workflowTitle: 'CKYC Modification & Name Mismatch Resolution',
    category: 'KYC & Compliance',
    slaHours: 24,
    triggerCondition: 'Client KYC status rejected by KRA (NDML / CVL / CAMS / Karvy) due to PAN-Aadhaar name difference or expired address proof.',
    rootCauses: [
      'Discrepancy in middle name or initials between Income Tax Department PAN registry and UIDAI Aadhaar database',
      'Blurry or cropped PDF/JPEG upload of official identity documentation',
      'Signature mismatch against bank account cheque leaf or PAN signature',
      'Incomplete Video In-Person Verification (IPV) recording with insufficient lighting or missing OTP readout',
    ],
    stepByStepResolution: [
      'Step 1: Check internal KRA sync status on FundsIndia CRM to identify the exact KRA rejection code (e.g., CVL-ERR-104: Name Mismatch).',
      'Step 2: Reach out to client via WhatsApp and registered email with the exact pre-filled CKYC Annexure form.',
      'Step 3: Guide client to complete digital IPV on FundsIndia mobile web portal with camera permissions enabled.',
      'Step 4: Verify uploaded identity documents meet SEBI 300 DPI resolution requirements.',
      'Step 5: Dispatch certified bundle via KRA API bridge and flag for express verification.',
    ],
    clientCommunicationTemplate: 'Dear [Client Name], your FundsIndia account setup is nearly complete! Our compliance team noticed a slight spelling difference between your PAN record and Aadhaar identity card. To protect your investments under SEBI guidelines, please click this secure one-touch verification link [Link] to upload a clear photograph of your Aadhaar card and complete a 10-second video check. Our priority desk will clear your KYC within 4 business hours.',
    escalationMatrix: [
      { level: 'L1 Operations Desk', contact: 'kyc-desk@learninghub.support', timeframe: '2 to 4 hours' },
      { level: 'L2 Compliance Officer', contact: 'compliance@learninghub.support', timeframe: '12 hours' },
      { level: 'L3 Principal Officer', contact: 'po-escalations@learninghub.support', timeframe: '24 hours' },
    ],
  },
  {
    id: 'supp-wf-2',
    workflowTitle: 'e-NACH Mandate Rejection & SIP Auto-Debit Failure',
    category: 'Banking & Mandates',
    slaHours: 12,
    triggerCondition: 'NPCI or destination bank returns rejection code for recurring e-Mandate registration (e.g., R08: Mandate rejected by customer bank, R03: Insufficient Funds, R10: Signature / Account closed).',
    rootCauses: [
      'Net banking credentials or debit card authentication timed out during NPCI Digio verification',
      'Bank account type mismatch (e.g., trying to set up mandate on a NRE/NRO or PPF account without proper permissions)',
      'Joint account requiring dual-signatory physical mandate rather than single digital e-sign',
      'Daily debit limit on client savings account lower than scheduled SIP installment',
    ],
    stepByStepResolution: [
      'Step 1: Pull NPCI mandate failure response from payment gateway dashboard.',
      'Step 2: If failure was due to technical gateway timeout, trigger automated 1-click re-authorization link to client.',
      'Step 3: If failure is bank limitation, check if client has alternate verified bank on FundsIndia (e.g. HDFC, ICICI, SBI).',
      'Step 4: Assist client to switch primary SIP mandate to alternate account or initiate physical NACH upload.',
      'Step 5: Ensure upcoming SIP schedule is adjusted to prevent double billing or late fees.',
    ],
    clientCommunicationTemplate: 'Dear [Client Name], your recurring SIP mandate for [Scheme Name] of ₹[Amount] could not be activated by your bank due to [Reason]. Don\'t worry—your investments remain safe and no charges have been deducted. Please tap here [Link] to instantly authenticate using Netbanking or UPI AutoPay in just 60 seconds.',
    escalationMatrix: [
      { level: 'L1 Banking Operations', contact: 'mandates@learninghub.support', timeframe: '2 hours' },
      { level: 'L2 Payment Gateway Liaison', contact: 'pg-ops@learninghub.support', timeframe: '6 hours' },
      { level: 'L3 Banking Relations Head', contact: 'banking@learninghub.support', timeframe: '12 hours' },
    ],
  },
  {
    id: 'supp-wf-3',
    workflowTitle: 'Mutual Fund Redemption Settlement & T+1/T+2 Payout Query',
    category: 'Redemptions & Settlements',
    slaHours: 8,
    triggerCondition: 'Client redeemed units from Equity or Debt fund and funds have not hit bank account by expected time.',
    rootCauses: [
      'SEBI T+1 / T+2 settlement calendar difference due to state-specific bank holidays or non-business clearing days',
      'AMC cut-off time: Order submitted post 3:00 PM resulting in next business day NAV and cycle shift',
      'Bank account registered with AMC differs from primary FundsIndia disbursement bank',
      'Penny-drop verification pending on recently updated bank beneficiary',
    ],
    stepByStepResolution: [
      'Step 1: Fetch RTA (CAMS / KFintech) transaction order reference number and timestamp.',
      'Step 2: Verify order execution NAV date and exact SEBI settlement cycle (Liquid: T+1, Equity: T+2, International Feeder: T+3).',
      'Step 3: Query NEFT/RTGS UTR (Unique Transaction Reference) number from AMC disbursement log.',
      'Step 4: Provide client with AMC UTR number to enable rapid tracking with their receiving branch.',
    ],
    clientCommunicationTemplate: 'Dear [Client Name], your redemption request of ₹[Amount] for [Scheme Name] was processed at NAV date [Date]. As per SEBI settlement guidelines, payout is scheduled for [Expected Date]. Your bank transfer UTR is [UTR Number]. The funds should reflect in your [Bank Name] account ending in [Last 4 Digits] by 4:00 PM today.',
    escalationMatrix: [
      { level: 'L1 Settlement Desk', contact: 'rta-settlement@learninghub.support', timeframe: '2 hours' },
      { level: 'L2 AMC Relationship Desk', contact: 'amc-liaison@learninghub.support', timeframe: '4 hours' },
      { level: 'L3 Customer Grievance Officer', contact: 'grievance@learninghub.support', timeframe: '8 hours' },
    ],
  },
  {
    id: 'supp-wf-4',
    workflowTitle: 'Annual Capital Gains Statement & Tax Loss Harvesting Extraction',
    category: 'Tax & Capital Gains',
    slaHours: 6,
    triggerCondition: 'Client requests consolidated capital gains tax report (LTCG / STCG under Section 112A / 111A) for ITR-2 / ITR-3 filing.',
    rootCauses: [
      'Client held external mutual fund folios not yet imported into FundsIndia consolidated CAS view',
      'Grandfathering calculation clarification needed for units acquired prior to January 31, 2018',
      'Dividend distribution tax / TDS credit reconciliation against AIS (Annual Information Statement) / Form 26AS',
    ],
    stepByStepResolution: [
      'Step 1: Open Client Portfolio Tax Analytics console on FundsIndia platform.',
      'Step 2: Generate Consolidated Capital Gains Statement for Financial Year with grandfathered NAV benchmarks.',
      'Step 3: Verify all external CAS folios are mapped to client PAN.',
      'Step 4: Export standardized Excel and PDF reports pre-formatted for direct import into ClearTax or CA tax software.',
      'Step 5: Send direct download link with executive summary of STCG, LTCG, and available ₹1.25 Lakh exemption limit.',
    ],
    clientCommunicationTemplate: 'Dear [Client Name], your Consolidated Capital Gains Tax Report for FY 2025-26 is ready! Under the latest Finance Act provisions, your net LTCG is ₹[Amount] and STCG is ₹[Amount]. You can download the ITR-ready report with complete grandfathering calculations here: [Report Link].',
    escalationMatrix: [
      { level: 'L1 Tax Support Desk', contact: 'tax-help@learninghub.support', timeframe: '2 hours' },
      { level: 'L2 Financial Analyst', contact: 'wealth-tax@learninghub.support', timeframe: '4 hours' },
      { level: 'L3 Head of Research', contact: 'research-head@learninghub.support', timeframe: '6 hours' },
    ],
  },
];
