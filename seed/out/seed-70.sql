INSERT INTO lessons (id,course_id,module_id,title,kind,video_id,body,minutes,author,published,sort) VALUES ('tata-tele-v-yT36kHHuzJA','tata-tele','tata-tele-m1','Redefine the future of customer engagement with Smartflo.','video','yT36kHHuzJA','',1,'Tata Tele Business Services',1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,video_id=excluded.video_id,body=excluded.body,minutes=excluded.minutes,author=excluded.author,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.video_id IS NOT excluded.video_id OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.author IS NOT excluded.author OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
UPDATE courses SET hours = 0.5 WHERE id = 'tata-tele' AND hours IS NOT 0.5;
INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('process-mf-support','MF SUPPORT','MF customer support','Customer support · process documents & reply templates','process','For every mutual-fund customer-support process: the documents required, the exact steps, turnaround times, where to send documents, and the ready-to-copy customer reply. Bank, KYC, nominee, NRI status, name change, transactions, SIPs and mandates.','Customer support',0,'[]','[]',1,1,19) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort WHERE courses.code IS NOT excluded.code OR courses.title IS NOT excluded.title OR courses.subtitle IS NOT excluded.subtitle OR courses.category IS NOT excluded.category OR courses.description IS NOT excluded.description OR courses.level IS NOT excluded.level OR courses.hours IS NOT excluded.hours OR courses.playlists IS NOT excluded.playlists OR courses.links IS NOT excluded.links OR courses.published IS NOT excluded.published OR courses.popular IS NOT excluded.popular OR courses.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m0','process-mf-support','Start here',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l0','process-mf-support','process-mf-support-m0','How to use process documents','note','# How to use process documents

This section holds every customer-support process in one place. For each process you will find:

1. **Documents required** - a checklist to share with the investor
2. **Steps** - the exact pathway on the portal / app
3. **Turnaround time** and **where to send** the documents
4. **Notes for the agent** - conditions, exceptions and fund-house specifics
5. **Customer reply template** - use the 📋 Copy button, then fill the [bracketed] fields

Processes are grouped by topic: Bank details · Contact details, address & KYC · Nominee, folios & transfers · Status change: RI, NRI & minor · Name & signature changes · Account closure · Purchases & redemptions · SIPs & mandates.

> Source: the FundsIndia customer-support templates document. Turnaround times are fund-house / operations estimates - confirm with Operations if a case is urgent.',3,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l1','process-mf-support','process-mf-support-m0','Document checklist - all processes','note','# Document checklist - all processes

What the customer must provide for each process. Open the process lesson for the steps and the reply template.

## Bank details

### Change of bank
*Turnaround: Online: 3–5 business days. Offline: 10 business days at folio level. (An earlier version of this template quoted 15 business days for the offline route – confirm the current TAT with the operations team.)*

- Online route (net worth below ₹10 lakh): bank proof of the NEW bank – cancelled cheque or self-attested bank statement of the last 3 months
- Online route: proof of the OLD bank and the investor signature (all uploaded in the portal, confirmed with OTP)
- Offline route (net worth above ₹10 lakh): request letter downloaded from the portal, printed and signed
- Offline route: cancelled cheque leaf of the OLD bank with name and account number pre-printed
- Offline route: cancelled cheque leaf of the NEW bank with name and account number pre-printed

### Change of bank - old bank proof not available
*Turnaround: Same as the normal change of bank process.*

- Coloured bank statement of the old bank, self-attested; OR a closure letter attested by the banker (with employee name, employee code, designation, signature and bank seal)
- IPV form (attached by the agent) together with a self-attested PAN copy – required by fund houses such as DSP and Kotak to process the change without the old bank cheque
- Bank statement attested by the investor (for the IPV route)

### Change of bank - new bank proof not available
*Turnaround: Same as the normal change of bank process.*

- Self-attested coloured bank statement of the new bank, attested by the banker with employee name, employee code, designation, signature and bank seal

### Second bank activation
*Turnaround: Activation is online once the ₹1 verification succeeds; refund in 24–48 hours.*

- No documents – fully online. A ₹1 verification payment (refunded within 24–48 hours).

### Change of IFSC
*Turnaround: The fund house takes 10–15 business days to update the details.*

- IFSC change request form (attached by the agent), filled and signed
- Cheque of the bank with name and account number pre-printed

## Contact details, address & KYC

### Change of contact details (mobile / e-mail)
*Turnaround: Offline: 8–10 business days at fund-house level. Re-KYC: 3–5 business days; the Re-KYC option is enabled in the account in T+2 business days.*

- Online route: none – OTP is sent to the existing e-mail / mobile
- Offline route (no access to old contact details): Contact change form (CAMS and KARVY), filled and signed – e-mail ID written in CAPITAL LETTERS in the declaration
- Re-KYC (for KYC records): completed online, no paper documents

### Re-KYC (online pathway)
*Turnaround: 3–5 business days after the investor submits. The Re-KYC option appears in the account in T+2 business days.*

- No paper documents – done online with Aadhaar, DigiLocker, live selfie and e-sign

### Address updation
*Turnaround: 3–5 business days for KYC, then the mutual fund records are updated.*

- No paper documents – completed through Re-KYC. The address must match Aadhaar.

### Full activation (Aadhaar to ON)
*Turnaround: Re-KYC takes 3–5 business days; the account is enabled for investment once KYC is validated.*

- Duly signed investor account opening form (PFA)
- PAN copy, self-attested
- Original cancelled cheque of the registered bank with the name printed on it

## Nominee, folios & transfers

### Nominee
*Turnaround: Online; applied to new folios created afterwards.*

- No documents – online with OTP

### Consolidation of folios
*Turnaround: 10–15 business days at the fund house. The investor is informed of any discrepancy in the document.*

- Consolidation of folios request form (attached by the agent) – filled, printed, signed and scanned

### Easy Transfer (bring existing mutual funds to FundsIndia)
*Turnaround: Processed after the signed letter and documents are received.*

- Transfer request letter – generated in the portal (Downloads section), printed, signed and scanned
- Cancelled cheque of the bank registered in the folio – only if it differs from the bank in the FundsIndia account
- Direct plans: switch request form (sent to the FundsIndia address)

## Status change: RI, NRI & minor

### RI to NRI
*Turnaround: On document verification and e-IPV; fund-house update follows.*

- KYC change form (attached) – photograph pasted and signed across it (name as per the Income Tax database)
- PAN copy, self-attested
- Foreign address proof, self-attested, in English (driving licence, latest gas bill, bank statement with recent transactions or utility bill). Indian address proof as well if the Indian address is also filled in
- Cancelled cheque leaf of the old bank (savings) and of the new NRO bank – name, account number and account type shown; old-bank proof only if the bank is changing
- Passport copy, self-attested
- Signed status change request letter (residency status and bank account details)
- Declaration forms for contact updation in folios – only if contact details are also changing
- FATCA form, filled and signed (fill both correspondence and permanent address in the KYC form)

### NRI to RI
*Turnaround: On receipt of all documents; fund-house update follows.*

- KYC form – photograph affixed with signature across it (enclosed)
- PAN copy, self-attested
- Indian address proof, self-attested (Aadhaar must contain the QR code and a masked Aadhaar number)
- Original cancelled cheque leaf of the savings bank account with the name printed on it
- Original cancelled cheque leaf of the old bank (NRO or NRE registered in FundsIndia) with the name printed on it
- Tax status change request, signed (enclosed)
- FATCA forms (enclosed)
- Passport copy, self-attested
- CAMS and KARVY declaration form (enclosed)

### Minor to Major
*Turnaround: On receipt of the documents.*

- Request letter from the investor
- Investor account opening form, duly filled and signed
- Bank details in the name of the major, with the new signature attested by the bank manager
- Cheque copy pre-printed with the name and account number of the major
- PAN copy in the name of the major, self-attested
- KYC application form
- Attested copy of date of birth proof
- Address proof, self-attested
- FATCA form
- Nominee form (AMC-wise)

## Name & signature changes

### Name change - marriage / divorce
*Turnaround: KYC level: 15–20 business days; then fund house: 10–15 business days. E-mail intimation is sent if there is any discrepancy.*

- Name change request letter – signed; a separate request for each AMC (format attached)
- KYC form – photograph affixed with signature across it
- Marriage / divorce certificate – original notary-attested copy, also self-attested
- PAN copy in the new name, self-attested
- Address proof in the new name, self-attested
- Bank details in the new name with the new signature attested by the registered banker (bank seal, employee number, employee name, designation)
- Request letter for new signature updation showing old and new signature (if required)
- Cancelled cheque leaf of the registered bank account with name and account number pre-printed

### Name change - voluntary
*Turnaround: KYC level: 15–20 business days; then fund house: 10–15 business days.*

- Name change request letter for each fund house (attached – one per fund house)
- Name change request letter for FundsIndia (attached)
- KYC change form (attached) – passport-size photograph with cross signature
- PAN copy with the new name, self-attested
- Cancelled cheque leaf with the new name and account number pre-printed
- Address proof with the new name, self-attested
- Gazette notification, notary-attested original and self-attested
- Affidavit on ₹200 stamp paper – only for SBI
- If the signature also changes: CKYC signature update form (attested by the banker with manager name, designation, employee code, signature and seal), banker verification letter (same attestation), and signature update letter

### Name correction
*Turnaround: KYC level then fund house, as for name change.*

- Name change request letter for each fund house (attached – one per fund house)
- Name change request letter for FundsIndia (attached)
- Document with the correct name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
- Cancelled cheque leaf with the corrected name, existing bank and account number – name and account number pre-printed
- To change the name in KYC: KYC form (attached), filled and signed, with self-attested PAN

### Removal or addition of father''s name
*Turnaround: KYC level then fund house, as for name change.*

- Name change request letter (as per the IT site) for each fund house (attached – one per fund house)
- Name change request letter for FundsIndia (attached)
- Document with the new name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
- Cancelled cheque leaf with the corrected name, existing bank and account number pre-printed

### Signature updation
*Turnaround: On receipt of the documents.*

- Signature updation form, duly signed
- Signature verification form with the banker''s attestation (bank manager''s name, designation, employee code, seal and signature)

## Account closure

### Account closure
*Turnaround: Status becomes INACTIVE automatically once there are no active investments.*

- No documents – there is no closure form. The account is free for life with no maintenance fee.

### Account closure - no active investments
*Turnaround: Immediate.*

- No documents

## Purchases & redemptions

### Purchase related
*Turnaround: Reflects in the account when the fund house sends the feed; units are allotted at the applicable NAV.*

- No documents. Paste the transaction details (date, amount, scheme) into the reply.

### Payment not received
*Turnaround: Refund: 3–4 working days (gateway errors) / 2–5 business days (net-banking).*

- Latest bank statement – only if the refund is not received in time (proof that the amount has not been credited back)
- Screenshot of the transaction status (agent pastes into the reply)

### Redemption
*Turnaround: Payout TAT: International funds T+6 to T+10 business days; ELSS T+2; Equity funds T+2; Debt funds T+2; Liquid funds T+1 (business days).*

- No documents – online with OTP. Ask the investor to verify the primary bank details before redeeming.

### Non-receipt of redemption
*Turnaround: Equity: T+2 business days; see the Redemption process for other scheme types.*

- Bank statement for the relevant dates – only if the amount is still not received after the TAT

## SIPs & mandates

### SIP registration
*Turnaround: Online.*

- No documents – online with OTP; a valid mandate is needed

### SIP amount change
*Turnaround: Online. Place the change 3–7 business days before the SIP date.*

- No documents – online

### SIP pause
*Turnaround: Online. Place the request 3–7 business days before the SIP date.*

- No documents – online

### eNACH mandate
*Turnaround: Ready after the ₹2 token transaction and bank approval; the SIP is then mapped to the new mandate.*

- No paper documents – a token transaction of ₹2 through net-banking

### NACH mandate (physical)
*Turnaround: After the signed mandate is received and approved by the bank.*

- Signed physical NACH mandate form (generated in the portal), scanned and emailed',10,1,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m1','process-mf-support','Bank details',NULL,1) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l2','process-mf-support','process-mf-support-m1','Change of bank','note','# Change of bank

*Bank details · MF customer support*

**When it applies:** The investor wants to replace the bank registered in the fund house and FundsIndia records.

## Documents required
- [ ] Online route (net worth below ₹10 lakh): bank proof of the NEW bank – cancelled cheque or self-attested bank statement of the last 3 months
- [ ] Online route: proof of the OLD bank and the investor signature (all uploaded in the portal, confirmed with OTP)
- [ ] Offline route (net worth above ₹10 lakh): request letter downloaded from the portal, printed and signed
- [ ] Offline route: cancelled cheque leaf of the OLD bank with name and account number pre-printed
- [ ] Offline route: cancelled cheque leaf of the NEW bank with name and account number pre-printed

## Steps
1. Login to the web portal > Profile icon (top right) > Bank details > Add another bank > Scan the QR code > pay ₹1 for verification (refunded within 24–48 hours).
2. Once the new bank is active, click **Change redemption bank**.
3. Choose **Online** (net worth below ₹10 lakh): keep the bank proof ready > select the folios > submit proof of old bank, new bank and signature > confirm with OTP.
4. Or choose **Offline** (net worth above ₹10 lakh): download the request letter > print, sign and email the scan with both cancelled cheque leaves.
5. To map an existing SIP to the new mandate, the investor replies with the mandate number; the SIP is mapped and auto-debit starts as per the SIP date once the mandate is approved.

## Turnaround time
Online: 3–5 business days. Offline: 10 business days at folio level. (An earlier version of this template quoted 15 business days for the offline route – confirm the current TAT with the operations team.)

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Ask the investor not to place new investments or redemptions until the bank is changed at the fund house and in FundsIndia records. Pause any SIP until the update is complete.
- Documents must be clear scans, emailed to the support mailbox.

## Customer reply template (copy & paste)
```text
Dear [Investor name],
Greetings from FundsIndia!

In response to your e-mail, a change of bank procedure needs to be followed to update the bank details in the fund house and FundsIndia records.

Login to the web portal > click on the profile icon (top right corner) > Bank details > Add another bank > scan the QR code. A payment of ₹1 is required for verification and will be refunded within 24–48 hours.

Once the bank is activated, click on "Change redemption bank" and select Online or Offline mode.

Online (net worth below 10 lakhs): keep a bank proof available (cancelled cheque or self-attested statement of the last 3 months) > select the folios > submit proof of old bank, new bank and signature > confirm with OTP. It may take 3–5 business days to update the details.

Offline (net worth more than 10 lakhs): download the request letter > print, sign and send the scanned copy along with the old bank''s and new bank''s cancelled cheque leaf with the name and account number pre-printed. It takes 10 business days to update the bank details at the folio level.

Kindly do not make any new investments or redemptions until your bank is changed in the fund house and FundsIndia records.

Please share the clear scanned documents to contact@fundsindia.com. Upon receipt, we will do the needful.
Please contact us for further assistance.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l3','process-mf-support','process-mf-support-m1','Change of bank - old bank proof not available','note','# Change of bank - old bank proof not available

*Bank details · MF customer support*

**When it applies:** The investor cannot provide a cancelled cheque of the old bank.

## Documents required
- [ ] Coloured bank statement of the old bank, self-attested; OR a closure letter attested by the banker (with employee name, employee code, designation, signature and bank seal)
- [ ] IPV form (attached by the agent) together with a self-attested PAN copy – required by fund houses such as DSP and Kotak to process the change without the old bank cheque
- [ ] Bank statement attested by the investor (for the IPV route)

## Steps
1. Explain that the old-bank cheque is the normal proof and that these alternatives are accepted instead.
2. Attach the IPV form to the reply and ask for the scanned documents.

## Turnaround time
Same as the normal change of bank process.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Banker attestation must show name, employee code, designation, signature and bank seal.

## Customer reply template (copy & paste)
```text
If the cheque proof of the old bank is not available, kindly submit a coloured bank statement with self-attestation, or a closure letter attested by the banker with the employee name, employee code, designation, signature and bank seal.

Fund houses like DSP and Kotak require an IPV letter along with a self-attested PAN copy to process a change of bank request without the old bank cheque. Please share the attached IPV form along with your self-attested PAN card and bank statement with your attestation.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l4','process-mf-support','process-mf-support-m1','Change of bank - new bank proof not available','note','# Change of bank - new bank proof not available

*Bank details · MF customer support*

**When it applies:** The investor cannot provide a cancelled cheque of the new bank.

## Documents required
- [ ] Self-attested coloured bank statement of the new bank, attested by the banker with employee name, employee code, designation, signature and bank seal

## Steps
1. Ask for the attested statement in place of the cancelled cheque; all other documents stay the same.

## Turnaround time
Same as the normal change of bank process.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Customer reply template (copy & paste)
```text
If the cancelled cheque of the new bank is not available, please share a self-attested coloured bank statement attested by the banker with the employee name, employee code, designation, signature and bank seal.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l5','process-mf-support','process-mf-support-m1','Second bank activation','note','# Second bank activation

*Bank details · MF customer support*

**When it applies:** The investor wants to add and activate another bank account.

## Documents required
- [ ] No documents – fully online. A ₹1 verification payment (refunded within 24–48 hours).

## Steps
1. Login to the web portal > Profile icon (top right) > Bank details > Add another bank > Scan the QR code > pay ₹1 for verification (refunded within 24–48 hours).

## Turnaround time
Activation is online once the ₹1 verification succeeds; refund in 24–48 hours.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
Login to the web portal > click on the profile icon (top right corner) > Bank details > Add another bank > scan the QR code. A payment of ₹1 is required for verification and will be refunded within 24–48 hours.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l6','process-mf-support','process-mf-support-m1','Change of IFSC','note','# Change of IFSC

*Bank details · MF customer support*

**When it applies:** The bank has changed its IFSC code and the folio needs the new one.

## Documents required
- [ ] IFSC change request form (attached by the agent), filled and signed
- [ ] Cheque of the bank with name and account number pre-printed

## Steps
1. Send the IFSC change request form to the investor.
2. Investor fills it and returns a clear scan with the cheque to the support mailbox.

## Turnaround time
The fund house takes 10–15 business days to update the details.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Customer reply template (copy & paste)
```text
Please fill in and share the attached IFSC change request along with a cheque of the bank with the name and account number pre-printed.

Kindly share the clear scanned copy to contact@fundsindia.com. The fund house takes 10–15 business days to update the details.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m2','process-mf-support','Contact details, address & KYC',NULL,2) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l7','process-mf-support','process-mf-support-m2','Change of contact details (mobile / e-mail)','note','# Change of contact details (mobile / e-mail)

*Contact details, address & KYC · MF customer support*

**When it applies:** The investor wants to change the mobile number or e-mail ID linked to the folios.

## Documents required
- [ ] Online route: none – OTP is sent to the existing e-mail / mobile
- [ ] Offline route (no access to old contact details): Contact change form (CAMS and KARVY), filled and signed – e-mail ID written in CAPITAL LETTERS in the declaration
- [ ] Re-KYC (for KYC records): completed online, no paper documents

## Steps
1. Login to the FundsIndia website > Manage Investor > "You can update contact details linked to existing folio''s here" > choose mobile number or e-mail ID > select the details to change > Continue > enter the new e-mail / mobile > select the relationship > OTP goes to the existing e-mail / mobile > verify.
2. If the investor has no access to the old contact details, use the offline route: send the CAMS / KARVY contact change form.
3. Then update the KYC records through Re-KYC (see the Re-KYC process).

## Turnaround time
Offline: 8–10 business days at fund-house level. Re-KYC: 3–5 business days; the Re-KYC option is enabled in the account in T+2 business days.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Fill the e-mail ID in CAPITAL letters in the declaration form.
- If the investor hits an error, ask for a screen recording of the error.

## Customer reply template (copy & paste)
```text
Dear [Investor name],
Greetings from FundsIndia!

Please follow the procedure below to update the contact details online:
Login to the FundsIndia website > Manage Investor > "You can update contact details linked to existing folio''s here" > choose to update mobile number or e-mail ID > select the details you wish to change > Continue > enter your new e-mail ID or mobile number > select the relationship > an OTP will be sent to your existing e-mail ID or mobile number > verify.

If you do not have access to your existing contact details for OTP verification, please use the offline process: fill and sign the contact change form (CAMS and KARVY, attached) and share a clear scanned copy to contact@fundsindia.com. Kindly write the e-mail ID in CAPITAL letters in the declaration form. It takes 8–10 business days to update the new contact details at fund-house level.

To update the contact details in KYC, please complete Re-KYC on the FundsIndia website (Profile icon > Re-KYC). It will be updated within 3–5 business days.
In case of any issue or error, please share a screen recording of the error so that we can assist you further.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l8','process-mf-support','process-mf-support-m2','Re-KYC (online pathway)','note','# Re-KYC (online pathway)

*Contact details, address & KYC · MF customer support*

**When it applies:** Used to update contact details, address or other details in the KYC record.

## Documents required
- [ ] No paper documents – done online with Aadhaar, DigiLocker, live selfie and e-sign

## Steps
1. Login to FundsIndia website (www.fundsindia.com) > Profile icon > Re-KYC > Initiate Re-KYC > CAMS e-KYC page > Email and mobile number > PAN details > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > Address preview > Additional details > Live selfie > Wet signature > Preview form > e-Sign.
2. Once KYC is validated, the FundsIndia account is enabled for investments.
3. For accounts activated on Aadhaar (Aadhaar to ON) the pathway is shorter: Initiate Re-KYC > Email and mobile number > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > Wet signature > Preview form > e-Sign.

## Turnaround time
3–5 business days after the investor submits. The Re-KYC option appears in the account in T+2 business days.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- In case of any issue or error, ask the investor to share a screen recording of the error.

## Customer reply template (copy & paste)
```text
To update the details in KYC, please login to the FundsIndia website (www.fundsindia.com) and follow this pathway:
Profile icon > Re-KYC > Initiate Re-KYC > redirect to the CAMS e-KYC page > e-mail and mobile number > PAN details > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > address preview > additional details > live selfie > wet signature > preview form > e-Sign.

It will be updated within 3–5 business days. Once the KYC is validated, your FundsIndia account will be enabled for investments.
In case of any issue or error, please share a screen recording of the error so that we can assist you further.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l9','process-mf-support','process-mf-support-m2','Address updation','note','# Address updation

*Contact details, address & KYC · MF customer support*

**When it applies:** The investor wants to change or correct the address.

## Documents required
- [ ] No paper documents – completed through Re-KYC. The address must match Aadhaar.

## Steps
1. Login to FundsIndia website (www.fundsindia.com) > Profile icon > Re-KYC > Initiate Re-KYC > CAMS e-KYC page > Email and mobile number > PAN details > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > Address preview > Additional details > Live selfie > Wet signature > Preview form > e-Sign.
2. Once the address is changed / corrected in the KYC records, it is changed in the mutual fund folios.

## Turnaround time
3–5 business days for KYC, then the mutual fund records are updated.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- As per the new SEBI guidelines, a Resident Indian investor can update the address only as per Aadhaar.

## Customer reply template (copy & paste)
```text
To update the address in KYC, please login to the FundsIndia website and complete Re-KYC: Profile icon > Re-KYC > Initiate Re-KYC > ... > Preview form > e-Sign.
It will be updated within 3–5 business days. Once the address is changed in the KYC records, it will be changed in your mutual fund folios.
Please note: as per the new SEBI guidelines, a Resident Indian investor can update the address only as per Aadhaar.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,9) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l10','process-mf-support','process-mf-support-m2','Full activation (Aadhaar to ON)','note','# Full activation (Aadhaar to ON)

*Contact details, address & KYC · MF customer support*

**When it applies:** The account was activated on Aadhaar, so FundsIndia holds no signature record; changes need full activation first.

## Documents required
- [ ] Duly signed investor account opening form (PFA)
- [ ] PAN copy, self-attested
- [ ] Original cancelled cheque of the registered bank with the name printed on it

## Steps
1. Ask for the three documents as clear scans.
2. After receipt, the account is fully activated; then the investor completes Re-KYC if contact details need validating.

## Turnaround time
Re-KYC takes 3–5 business days; the account is enabled for investment once KYC is validated.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Customer reply template (copy & paste)
```text
Your account is activated based on your Aadhaar, hence we do not hold your signature records. Any change in your account can be made only if you fully activate your account. Please share scanned copies, duly signed, of:
1. Investor account opening form (PFA), duly signed
2. PAN copy, self-attested
3. Original cancelled cheque of the registered bank with your name printed on it

Please share the clear scanned documents to contact@fundsindia.com. Upon receipt, we will do the needful.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,10) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m3','process-mf-support','Nominee, folios & transfers',NULL,3) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l11','process-mf-support','process-mf-support-m3','Nominee','note','# Nominee

*Nominee, folios & transfers · MF customer support*

**When it applies:** The investor wants to add or change nominees.

## Documents required
- [ ] No documents – online with OTP

## Steps
1. Up to 3 nominees can be added.
2. Login to the FundsIndia account > Profile icon (top right) > Manage Nominees > new and all folios > Change nomination > fill the details > Update > enter the OTP > Submit.
3. The OTP goes to the investor''s registered e-mail and mobile number. The update applies to all new folios created in the account.

## Turnaround time
Online; applied to new folios created afterwards.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
You can add up to 3 nominees for your folios. To update the nominee for new and all folios:
Login to your FundsIndia account > click on the profile icon (top right corner) > Manage Nominees > new and all folios > Change nomination > fill in the details > Update > enter the OTP > Submit.
The OTP is sent to your registered e-mail address and mobile number. Upon submission, the nominee update will apply to all new folios created in your account.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,11) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l12','process-mf-support','process-mf-support-m3','Consolidation of folios','note','# Consolidation of folios

*Nominee, folios & transfers · MF customer support*

**When it applies:** The investor wants several folios of the same fund house merged into one.

## Documents required
- [ ] Consolidation of folios request form (attached by the agent) – filled, printed, signed and scanned

## Steps
1. Check the conditions below before sending the form.
2. Send the consolidation format; the investor returns a clear scan to the support mailbox.
3. Keep the folio with the active SIP as the target folio.

## Turnaround time
10–15 business days at the fund house. The investor is informed of any discrepancy in the document.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Mode of holding must be the same in all folios.
- Nominee must be the same in all folios.
- Bank accounts must be the same in all folios.
- If an SIP is registered in any folio, that folio must be the target folio.

## Customer reply template (copy & paste)
```text
Greetings from FundsIndia.
With reference to your mail, folios can be merged into one by providing a consolidation of folios request. Please fill in, print, sign and send the scanned copy of the attached format.

Conditions for consolidation of folios:
• Mode of holding should be the same in all folios
• Nominee should be the same in all folios
• Bank accounts should be the same in all folios
• If an SIP is registered in any of the folios, that folio should be the target folio

Kindly share clear scanned documents to contact@fundsindia.com. The consolidation takes 10–15 business days at the fund house. We will inform you if there is any discrepancy in the document.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,12) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l13','process-mf-support','process-mf-support-m3','Easy Transfer (bring existing mutual funds to FundsIndia)','note','# Easy Transfer (bring existing mutual funds to FundsIndia)

*Nominee, folios & transfers · MF customer support*

**When it applies:** The investor holds mutual funds elsewhere and wants them moved to the FundsIndia account.

## Documents required
- [ ] Transfer request letter – generated in the portal (Downloads section), printed, signed and scanned
- [ ] Cancelled cheque of the bank registered in the folio – only if it differs from the bank in the FundsIndia account
- [ ] Direct plans: switch request form (sent to the FundsIndia address)

## Steps
1. Log in to the web portal > Mutual funds > More > Bring in existing MF holdings > Register Easy transfer > Next > select the AMC, search and select the scheme, investor name, held individually or jointly > enter the folio number > Add > Submit.
2. If the folio shows under external portfolio: Mutual Funds > External Transfer via eCAS > More > Fetch the latest external funds > select funds for transfer > Transfer Fund > download the letter > sign > upload it (Status tab). FundsIndia processes the rest.
3. Where the registered folio bank differs, the investor sends the cancelled cheque of that bank; the bank in FundsIndia records is updated while converting to online mode.

## Turnaround time
Processed after the signed letter and documents are received.

## Where to send
Email the scanned letter and documents to **contact@fundsindia.com**. Where originals or physical forms are required, send them to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Notes for the agent
- A zero-balance folio cannot be transferred.
- Direct plans can be moved to FundsIndia with a switch request form.
- A demat-held fund cannot be transferred; the investor contacts the DP for a rematerialisation request to convert it to a normal folio.
- For a joint holding, the other holder must also be a registered FundsIndia investor.
- For a folio with an active SIP, advise the investor to stop the SIP, transfer the folio, then restart the SIP.

## Customer reply template (copy & paste)
```text
Please follow this pathway to move your existing mutual funds to FundsIndia:
Log onto your FundsIndia account (web portal) > Mutual funds > More > Bring in existing MF holdings > Register Easy transfer > Next > select the AMC, search and select the scheme and investor name, specify whether the investment is held individually or jointly, enter the folio number > Add > Submit.

If the folio is reflecting in external portfolio: Mutual Funds > External Transfer via eCAS > More > Fetch the latest external funds > select funds for transfer > Transfer Fund > download the letter > sign the letter > upload the letter (Status tab). FundsIndia will process the rest.

The request letter is generated in the Downloads section of your account. Please print, sign and send us the scanned copy. If the bank registered in the folio is different from the bank in your FundsIndia account, please send a cancelled cheque of the bank registered in the folio.

Notes:
• A zero balance folio is not accepted for transfer.
• Direct plans can be moved to FundsIndia by giving a switch request form.
• A demat account cannot be transferred; contact your DP to submit a rematerialisation form to convert it to a normal folio.
• For a joint holding, the other person must also be a registered FundsIndia investor.
• For a folio with an active SIP, we recommend stopping the SIP, transferring the folio and then restarting it.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,13) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m4','process-mf-support','Status change: RI, NRI & minor',NULL,4) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l14','process-mf-support','process-mf-support-m4','RI to NRI','note','# RI to NRI

*Status change: RI, NRI & minor · MF customer support*

**When it applies:** A Resident Indian account must be changed to NRI when the investor stays abroad more than 185 days.

## Documents required
- [ ] KYC change form (attached) – photograph pasted and signed across it (name as per the Income Tax database)
- [ ] PAN copy, self-attested
- [ ] Foreign address proof, self-attested, in English (driving licence, latest gas bill, bank statement with recent transactions or utility bill). Indian address proof as well if the Indian address is also filled in
- [ ] Cancelled cheque leaf of the old bank (savings) and of the new NRO bank – name, account number and account type shown; old-bank proof only if the bank is changing
- [ ] Passport copy, self-attested
- [ ] Signed status change request letter (residency status and bank account details)
- [ ] Declaration forms for contact updation in folios – only if contact details are also changing
- [ ] FATCA form, filled and signed (fill both correspondence and permanent address in the KYC form)

## Steps
1. Share the document list and the Income Tax name-check link: https://eportal.incometax.gov.in/iec/foservices/#/pre-login/knowYourAO
2. After receipt, documents are verified; then an e-IPV (online verification by video call) is scheduled between 10 AM–1 PM and 2 PM–6 PM IST. The investor shows all submitted documents in original.
3. NRO bank: existing investments move from RI to NRI tax status. NRE bank: existing investments cannot be changed to NRE – the investor either redeems everything or moves holdings offline so NRI requests can run with NRE bank details.

## Turnaround time
On document verification and e-IPV; fund-house update follows.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Once the tax status changes, the existing mandate is deleted and the SIP is deactivated; the investor re-registers the SIP.
- Once investments are moved offline, online transactions are not possible; redemptions are by physical request to the fund house.
- The OTP is not sent to an overseas number for transactions.

## Customer reply template (copy & paste)
```text
We notice that your FundsIndia account is registered as an RI (Resident Indian) account. Changing your status from RI to NRI is essential (if your stay abroad is more than 185 days) to keep your investment records and taxation correct. We request you to submit:
1. KYC change form (attached – paste your photo and sign across). Name as per the Income Tax database: https://eportal.incometax.gov.in/iec/foservices/#/pre-login/knowYourAO
2. Self-attested PAN copy
3. Self-attested foreign address proof (driving licence, latest gas bill, bank statement with recent transactions or utility bill, in English). Share Indian address proof as well if you fill the Indian address.
4. Cancelled cheque leaf of the old bank (savings) and new bank (Savings-NRO) with name, account number and bank type; old bank proof only if you are changing the bank account
5. Self-attested passport copy
6. Signed status change request letter (residency status and bank account details)
7. Declaration forms for contact updation (only if you wish to update contact details)
8. FATCA form duly filled and signed (fill both correspondence and permanent address in the KYC form)

If you update the NRO bank account, existing investments move from RI to NRI tax status. If you update the NRE bank account, existing investments cannot be changed to NRE – please redeem all investments or move them offline to process NRI requests with NRE bank details. Once investments are offline, online transactions cannot be done; redemptions need a physical request to the fund house.

Please share clear scanned documents to contact@fundsindia.com. After verification we will schedule an e-IPV (video call) between 10 AM–1 PM and 2 PM–6 PM IST, where you must show all submitted documents in original. When the tax status changes, the existing mandate is deleted and the SIP is deactivated; you can re-register it afterwards.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,14) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l15','process-mf-support','process-mf-support-m4','NRI to RI','note','# NRI to RI

*Status change: RI, NRI & minor · MF customer support*

**When it applies:** The investor has returned to India and the status must change from NRI to Resident Indian.

## Documents required
- [ ] KYC form – photograph affixed with signature across it (enclosed)
- [ ] PAN copy, self-attested
- [ ] Indian address proof, self-attested (Aadhaar must contain the QR code and a masked Aadhaar number)
- [ ] Original cancelled cheque leaf of the savings bank account with the name printed on it
- [ ] Original cancelled cheque leaf of the old bank (NRO or NRE registered in FundsIndia) with the name printed on it
- [ ] Tax status change request, signed (enclosed)
- [ ] FATCA forms (enclosed)
- [ ] Passport copy, self-attested
- [ ] CAMS and KARVY declaration form (enclosed)

## Steps
1. Send the forms attached below your signature.
2. e-Aadhaar can be downloaded from https://eaadhaar.uidai.gov.in/genricDownloadAadhaar (Aadhaar number, captcha, OTP to the mobile).
3. If the account has active investments, ask for e-mail confirmation to move them offline first – the fund house does not accept a tax-status change with investments. Folios return online after the change is complete.

## Turnaround time
On receipt of all documents; fund-house update follows.

## Where to send
Email the scanned letter and documents to **contact@fundsindia.com**. Where originals or physical forms are required, send them to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Notes for the agent
- Offline folios cannot transact further; redemption is by physical request to the fund house.
- Without investment confirmation to move offline, the request cannot be processed.

## Customer reply template (copy & paste)
```text
Changing your investment status from NRI to RI is essential to keep your investment records and taxation correct. To change your status, please share:
• KYC form (photograph affixed with signature across it) – enclosed
• PAN copy, self-attested
• Indian address proof, self-attested
• Original cancelled cheque leaf of your Savings bank account with your name printed
• Original cancelled cheque leaf of the old bank (NRO or NRE registered in FundsIndia) with your name printed
• Tax status change request, signed – enclosed
• FATCA forms – enclosed
• Passport copy, self-attested
• CAMS and KARVY declaration form – enclosed

If you provide Aadhaar as address proof it must contain the QR code and a masked Aadhaar number. e-Aadhaar can be downloaded from https://eaadhaar.uidai.gov.in/genricDownloadAadhaar (enter Aadhaar number and captcha; an OTP is sent to your mobile).

With active investments we cannot process the change of tax status, as the fund house does not accept it. Please give us e-mail confirmation to move the existing investments offline; we will then process the change. Offline folios move back online after the tax status is changed. Once folios are offline you cannot make further transactions; you can redeem them by a physical redemption request to the fund house.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,15) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l16','process-mf-support','process-mf-support-m4','Minor to Major','note','# Minor to Major

*Status change: RI, NRI & minor · MF customer support*

**When it applies:** The investor has turned 18 and the minor folio must be converted to a major account.

## Documents required
- [ ] Request letter from the investor
- [ ] Investor account opening form, duly filled and signed
- [ ] Bank details in the name of the major, with the new signature attested by the bank manager
- [ ] Cheque copy pre-printed with the name and account number of the major
- [ ] PAN copy in the name of the major, self-attested
- [ ] KYC application form
- [ ] Attested copy of date of birth proof
- [ ] Address proof, self-attested
- [ ] FATCA form
- [ ] Nominee form (AMC-wise)

## Steps
1. Send the list; the investor couriers the documents to the FundsIndia address.

## Turnaround time
On receipt of the documents.

## Where to send
Send the documents by post / courier to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Customer reply template (copy & paste)
```text
To convert the minor account to major, please send the following documents to the address below:
• Request letter from the investor
• Investor account opening form, duly filled and signed
• Bank details in the name of the major along with the new signature attested by the bank manager
• Cheque copy pre-printed in the name and account number of the major
• PAN copy in the name of the major, self-attested
• KYC application form
• Attested copy of date of birth proof
• Address proof, self-attested
• FATCA form
• Nominee form (AMC-wise)
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,16) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m5','process-mf-support','Name & signature changes',NULL,5) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l17','process-mf-support','process-mf-support-m5','Name change - marriage / divorce','note','# Name change - marriage / divorce

*Name & signature changes · MF customer support*

**When it applies:** The investor''s name has changed after marriage or divorce.

## Documents required
- [ ] Name change request letter – signed; a separate request for each AMC (format attached)
- [ ] KYC form – photograph affixed with signature across it
- [ ] Marriage / divorce certificate – original notary-attested copy, also self-attested
- [ ] PAN copy in the new name, self-attested
- [ ] Address proof in the new name, self-attested
- [ ] Bank details in the new name with the new signature attested by the registered banker (bank seal, employee number, employee name, designation)
- [ ] Request letter for new signature updation showing old and new signature (if required)
- [ ] Cancelled cheque leaf of the registered bank account with name and account number pre-printed

## Steps
1. Send the list and the AMC-wise request format; the investor couriers the documents.

## Turnaround time
KYC level: 15–20 business days; then fund house: 10–15 business days. E-mail intimation is sent if there is any discrepancy.

## Where to send
Send the documents by post / courier to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Customer reply template (copy & paste)
```text
For a name change after marriage / divorce, please send the following documents to the address below:
• Name change request letter, duly signed (a separate request for each AMC – format attached)
• KYC form (photograph affixed with signature across it)
• Marriage / divorce certificate – originally attested by a notary public and self-attested
• PAN copy in the new name, self-attested
• Address proof in the new name, self-attested
• Bank details in the new name along with the new signature attested by the registered banker with bank seal, employee number, employee name and designation
• Request letter for new signature updation with old and new signature (if required)
• Cancelled cheque leaf of the registered bank account with name and account number pre-printed

The name change is processed at the KYC level, which takes 15–20 business days. Once the name is updated in KYC we process the request with the fund house, which takes a further 10–15 business days. We will e-mail you if there is any discrepancy.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,17) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l18','process-mf-support','process-mf-support-m5','Name change - voluntary','note','# Name change - voluntary

*Name & signature changes · MF customer support*

**When it applies:** The investor has legally changed the name by choice (not marriage / divorce).

## Documents required
- [ ] Name change request letter for each fund house (attached – one per fund house)
- [ ] Name change request letter for FundsIndia (attached)
- [ ] KYC change form (attached) – passport-size photograph with cross signature
- [ ] PAN copy with the new name, self-attested
- [ ] Cancelled cheque leaf with the new name and account number pre-printed
- [ ] Address proof with the new name, self-attested
- [ ] Gazette notification, notary-attested original and self-attested
- [ ] Affidavit on ₹200 stamp paper – only for SBI
- [ ] If the signature also changes: CKYC signature update form (attested by the banker with manager name, designation, employee code, signature and seal), banker verification letter (same attestation), and signature update letter

## Steps
1. Send the list and attached formats; the investor couriers the documents.

## Turnaround time
KYC level: 15–20 business days; then fund house: 10–15 business days.

## Where to send
Send the documents by post / courier to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Customer reply template (copy & paste)
```text
For a voluntary name change, please send the following documents to the address below:
1. Name change request letter for each fund house (attached – one for each fund house)
2. Name change request letter for FundsIndia (attached)
3. KYC change form (attached) with a passport-size photograph and cross signature
4. PAN copy with the new name, self-attested
5. Cancelled cheque leaf with the new name and account number pre-printed
6. Address proof with the new name, self-attested
7. Gazette notification, notary-attested original and self-attested
8. Affidavit on ₹200 stamp paper (only for SBI)

If the signature is also changing: (1) CKYC signature update form, (2) banker verification letter – both attested by the banker with manager name, designation, employee code, signature and bank seal, and (3) signature update letter (attached).

The name change is processed at the KYC level (15–20 business days); then the request goes to the fund house (10–15 business days). We will e-mail you if there is any discrepancy.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,18) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l19','process-mf-support','process-mf-support-m5','Name correction','note','# Name correction

*Name & signature changes · MF customer support*

**When it applies:** The name is recorded wrongly (spelling / format) and must be corrected.

## Documents required
- [ ] Name change request letter for each fund house (attached – one per fund house)
- [ ] Name change request letter for FundsIndia (attached)
- [ ] Document with the correct name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
- [ ] Cancelled cheque leaf with the corrected name, existing bank and account number – name and account number pre-printed
- [ ] To change the name in KYC: KYC form (attached), filled and signed, with self-attested PAN

## Steps
1. Send the list and attached formats.

## Turnaround time
KYC level then fund house, as for name change.

## Where to send
Send the documents by post / courier to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Customer reply template (copy & paste)
```text
For a name correction, please share:
• Name change request letter for each fund house (attached – one for each fund house)
• Name change request letter for FundsIndia (attached)
• A document with the correct name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
• Cancelled cheque leaf with the corrected name, with the existing bank and account number and your name pre-printed
• To correct the name in KYC: the attached KYC form, duly filled and signed, with a self-attested PAN
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,19) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l20','process-mf-support','process-mf-support-m5','Removal or addition of father''s name','note','# Removal or addition of father''s name

*Name & signature changes · MF customer support*

**When it applies:** The father''s name must be added to or removed from the records.

## Documents required
- [ ] Name change request letter (as per the IT site) for each fund house (attached – one per fund house)
- [ ] Name change request letter for FundsIndia (attached)
- [ ] Document with the new name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
- [ ] Cancelled cheque leaf with the corrected name, existing bank and account number pre-printed

## Steps
1. First check the name in KYC and on the Income Tax site. Only if the new name is already updated in those records, ask for the documents.

## Turnaround time
KYC level then fund house, as for name change.

## Where to send
Send the documents by post / courier to:

> Wealth India Financial Services Pvt. Ltd.,  
> 3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,  
> Anna Salai, Thousand Lights, Chennai - 600006,  
> Tamil Nadu, India.

## Notes for the agent
- The name must already match KYC and the IT site before the request is raised.

## Customer reply template (copy & paste)
```text
We have checked the name in KYC and on the IT site. Since the new name is updated in those records, please share:
• Name change request letter (as per the IT site) for each fund house (attached – one for each fund house)
• Name change request letter for FundsIndia (attached)
• A document with the new name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
• Cancelled cheque leaf with the corrected name, with the existing bank and account number pre-printed
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,20) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l21','process-mf-support','process-mf-support-m5','Signature updation','note','# Signature updation

*Name & signature changes · MF customer support*

**When it applies:** The investor wants to update the signature on record.

## Documents required
- [ ] Signature updation form, duly signed
- [ ] Signature verification form with the banker''s attestation (bank manager''s name, designation, employee code, seal and signature)

## Steps
1. Send the forms and ask for the attested copies.

## Turnaround time
On receipt of the documents.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- For DSP, Kotak and Nippon the investor must visit the fund house directly.

## Customer reply template (copy & paste)
```text
Please share the signature updation form, duly signed, and the signature verification form with the banker''s attestation (the attestation should carry the bank manager''s name, designation, employee code, seal and signature).
Please note: for DSP, Kotak and Nippon the investor has to visit the fund house directly.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,21) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m6','process-mf-support','Account closure',NULL,6) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l22','process-mf-support','process-mf-support-m6','Account closure','note','# Account closure

*Account closure · MF customer support*

**When it applies:** The investor asks to close the FundsIndia account.

## Documents required
- [ ] No documents – there is no closure form. The account is free for life with no maintenance fee.

## Steps
1. Explain the value of staying: aggregation across AMCs and one point of service; unbiased expert advisory; portfolio design and review online at any time; value-added services; aggregation of investment products and of family investments; access on computer, mobile and tablet; all free with no account or transaction charges.
2. If the investor still wants to close: an account with active investments cannot be closed – they must redeem or move out all folios.
3. Once all units are redeemed or moved out, the account status becomes INACTIVE by default. It becomes active again when they invest in future.

## Turnaround time
Status becomes INACTIVE automatically once there are no active investments.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- No deactivation procedure is needed.

## Customer reply template (copy & paste)
```text
Your account with FundsIndia is free, and the advantages of a good value-adding distributor like FundsIndia are many:
• Aggregation across AMCs and a convenient single point of service
• Unbiased, expert advisory services
• Anytime portfolio design and review available online
• Numerous value-added services
• Aggregation of investment products, and of family investments in one place
• Multi-platform access – computer, mobile and tablet
• All of this FREE, without any account or transaction charges, along with great customer support.

If you are still interested in closing your account: an account with active investments cannot be closed – you need to redeem your investments. Once you move out your folios / redeem all units from your FundsIndia portfolio, your account status will be INACTIVE by default. Since your account is a lifetime FREE account with no transaction or maintenance fees, there is no deactivation procedure to follow. If you invest again in future, your account will become active again.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,22) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l23','process-mf-support','process-mf-support-m6','Account closure - no active investments','note','# Account closure - no active investments

*Account closure · MF customer support*

**When it applies:** The investor asks to close the account but holds no investments.

## Documents required
- [ ] No documents

## Steps
1. Confirm there are no active investments; reply that the status is already INACTIVE.

## Turnaround time
Immediate.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
In reference to your e-mail, we noticed that your FundsIndia account does not have any active investments, so your mutual fund account status is INACTIVE by default.
Please contact us for further assistance.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,23) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m7','process-mf-support','Purchases & redemptions',NULL,7) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l24','process-mf-support','process-mf-support-m7','Purchase related','note','# Purchase related

*Purchases & redemptions · MF customer support*

**When it applies:** The investor asks for the status of a purchase.

## Documents required
- [ ] No documents. Paste the transaction details (date, amount, scheme) into the reply.

## Steps
1. Check the transaction and confirm it has been sent to the fund house; paste the details.

## Turnaround time
Reflects in the account when the fund house sends the feed; units are allotted at the applicable NAV.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
Greetings from FundsIndia!
The purchase transaction below has been sent to the fund house for processing:
[Paste transaction details – date / amount / scheme]

The units will be processed at the applicable NAV (unit realisation). The transaction will reflect in your FundsIndia account once we receive the feed from the respective fund house. You will receive an e-mail confirmation from FundsIndia, and the account statement directly from the fund house, once the transaction is processed.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,24) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l25','process-mf-support','process-mf-support-m7','Payment not received','note','# Payment not received

*Purchases & redemptions · MF customer support*

**When it applies:** The purchase shows "Payment not received" although the investor says money was debited.

## Documents required
- [ ] Latest bank statement – only if the refund is not received in time (proof that the amount has not been credited back)
- [ ] Screenshot of the transaction status (agent pastes into the reply)

## Steps
1. Paste the screenshot of the "Payment not received" status.
2. If debited but failed at the payment gateway, the amount is refunded within 3–4 working days of the transaction (net-banking cases: 2–5 business days).
3. If not refunded, ask for the bank statement and escalate.
4. To find NEFT / RTGS / IMPS details: Login > Mutual Funds > Invest > Lumpsum > Add scheme > select the amount > Confirm > click NEFT / RTGS / IMPS to see the virtual account number.

## Turnaround time
Refund: 3–4 working days (gateway errors) / 2–5 business days (net-banking).

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Fund realisation rule: effective 1 February 2021, the applicable NAV for a purchase depends on realisation and availability of the funds in the mutual fund''s bank account before the cut-off, irrespective of the amount, under all schemes.

## Customer reply template (copy & paste)
```text
Greetings from FundsIndia!
At the outset, we regret the inconvenience caused. The payment status of the purchase transaction below is "Payment not received":
[Paste screenshot]

If the amount has been debited from your account but the payment failed due to a payment gateway error, the amount will be refunded to your bank account within 3–4 working days from the date of the transaction. If you have not received the refund, please send us your latest bank statement as proof so that we can investigate.

OR

The online payment gateway for net-banking usually works without issues, but on rare occasions such problems occur and we do not receive the amount to process your transaction. The money will be put back in your bank account within 2–5 business days. If that does not happen, let us know and we will follow up with your bank on your behalf.

Fund realisation: effective 1 February 2021, the applicable NAV for a purchase of units is subject to realisation and availability of the funds in the mutual fund''s bank account before the applicable cut-off time, irrespective of the amount invested, under all mutual fund schemes.

To check NEFT bank details: Login to your FundsIndia account > Mutual Funds > Invest > Lumpsum > Add scheme > select the amount > Confirm > click NEFT / RTGS / IMPS (you will find the virtual account number).
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,25) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l26','process-mf-support','process-mf-support-m7','Redemption','note','# Redemption

*Purchases & redemptions · MF customer support*

**When it applies:** The investor wants to redeem, or asks how redemption works.

## Documents required
- [ ] No documents – online with OTP. Ask the investor to verify the primary bank details before redeeming.

## Steps
1. Mention that market conditions may favour staying invested, but proceed if the investor still wishes to redeem.
2. Login to the FundsIndia account on the website > Mutual funds > Portfolio > select the scheme > click the dots > Redeem > select the redemption reason > Proceed > select units / amount > enter OTP > Proceed.
3. The OTP goes to the mobile number and e-mail ID registered in the folio; either OTP can be used.
4. Verify the bank before redeeming: Website > My account > View investor details > Primary bank information.

## Turnaround time
Payout TAT: International funds T+6 to T+10 business days; ELSS T+2; Equity funds T+2; Debt funds T+2; Liquid funds T+1 (business days).

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- Saturdays, Sundays and public holidays are non-business days. The FundsIndia cut-off time is 2 PM.
- A request received before the cut-off gets the closing NAV of that business day.
- Exit load is charged if the SIP / lump sum investment has not completed its holding duration; some schemes have a different exit load.

## Customer reply template (copy & paste)
```text
We would like to inform you that the current market scenario favours staying invested rather than redeeming. However, if you still wish to proceed, please follow this pathway:
Login to your FundsIndia account on the website > Mutual funds > Portfolio > select the scheme > click the dots > Redeem > select the redemption reason > Proceed > select the units / amount > enter OTP > Proceed.
An OTP is sent to the mobile number and e-mail ID registered in the folio; please enter either one.

Note: exit load will be charged on the NAV if each SIP / lump sum investment has not completed its duration; some schemes have a different exit load. Saturdays, Sundays and public holidays are non-business days. The cut-off time is 2 PM. The closing NAV of the business day is applied if we receive the request before the cut-off.

Redemption payout TAT by scheme type: International funds T+6/10 business days; ELSS T+2; Equity funds T+2; Debt funds T+2; Liquid funds T+1.
Please verify your bank details before placing the request: Website > My account > View investor details > Primary bank information.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,26) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l27','process-mf-support','process-mf-support-m7','Non-receipt of redemption','note','# Non-receipt of redemption

*Purchases & redemptions · MF customer support*

**When it applies:** The investor has not received the redemption proceeds.

## Documents required
- [ ] Bank statement for the relevant dates – only if the amount is still not received after the TAT

## Steps
1. Check the scheme type and apply the correct payout TAT (equity: T+2 business days, T = transaction date).
2. Count only business days (exclude weekends and public holidays).
3. Tell the investor the date by which the proceeds will be credited. If still not received, ask for the bank statement covering the transaction period.

## Turnaround time
Equity: T+2 business days; see the Redemption process for other scheme types.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Notes for the agent
- Replace the dates in the template with the investor''s actual dates; the sample in the source used 2023 dates.

## Customer reply template (copy & paste)
```text
The redemption payout TAT (turn-around time) for equity schemes is T+2 business days (T being the date of transaction). As you redeemed from an equity scheme, the proceeds will be credited by [date] before EOD.
Please note [dates] were non-business days.
If you have not received the amount by tomorrow EOD, please send us a copy of your bank statement from [start date] to [end date] so that we can check and assist you better.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,27) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-mf-support-m8','process-mf-support','SIPs & mandates',NULL,8) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l28','process-mf-support','process-mf-support-m8','SIP registration','note','# SIP registration

*SIPs & mandates · MF customer support*

**When it applies:** The investor wants to start an SIP in a scheme.

## Documents required
- [ ] No documents – online with OTP; a valid mandate is needed

## Steps
1. Login to the FundsIndia online account > Mutual fund (rupee icon, top left) > Invest > SIP > select the scheme > Proceed to Basket > amount, date, tenure and mandate > Proceed to confirm > Proceed to verify > enter the OTP.

## Turnaround time
Online.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
To register an SIP in the scheme, please follow this pathway:
Login to your FundsIndia online account > click on Mutual fund (rupee icon, top left) > Invest > SIP > select the scheme > Proceed to Basket > amount, date, tenure and select the mandate > Proceed to confirm > Proceed to verify > enter the OTP.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,28) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l29','process-mf-support','process-mf-support-m8','SIP amount change','note','# SIP amount change

*SIPs & mandates · MF customer support*

**When it applies:** The investor wants to change the SIP amount.

## Documents required
- [ ] No documents – online

## Steps
1. Website: Mutual Funds > Systematic Plans > click Edit SIP.
2. Mobile app: Mutual Funds > Systematic Plans > click the scheme name > edit (pencil) > Change SIP.

## Turnaround time
Online. Place the change 3–7 business days before the SIP date.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- Any change should be placed 3–7 business days before the SIP date.

## Customer reply template (copy & paste)
```text
You can change the SIP amount on the FundsIndia website or mobile app:
Website: Mutual Funds > Systematic Plans > click Edit SIP.
Mobile app: Mutual Funds > Systematic Plans > click the scheme name > click the edit option (pencil) > Change SIP.
Please place the change 3–7 business days before the SIP date.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,29) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l30','process-mf-support','process-mf-support-m8','SIP pause','note','# SIP pause

*SIPs & mandates · MF customer support*

**When it applies:** The investor wants to skip an SIP instalment.

## Documents required
- [ ] No documents – online

## Steps
1. Login to the FundsIndia portal > Mutual Funds > Systematic Plans > click Skip Next Installment.

## Turnaround time
Online. Place the request 3–7 business days before the SIP date.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Notes for the agent
- A pause request applies to one month only.
- Two consecutive instalments cannot be paused.
- Any change or pause request must be placed 3–7 business days before the SIP date.

## Customer reply template (copy & paste)
```text
To pause an SIP instalment: login to the FundsIndia portal > Mutual Funds > Systematic Plans > click Skip Next Installment.
1. A pause request is applicable for one month only.
2. You cannot pause 2 consecutive instalments.
3. Any change / pause request should be placed 3–7 business days before the SIP date.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,30) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l31','process-mf-support','process-mf-support-m8','eNACH mandate','note','# eNACH mandate

*SIPs & mandates · MF customer support*

**When it applies:** The investor wants a mandate set up fully online for SIP auto-debit.

## Documents required
- [ ] No paper documents – a token transaction of ₹2 through net-banking

## Steps
1. Login to the FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > make a token transaction of ₹2 through net-banking; the mandate is then ready.
2. Ask the investor to tell you after generating the eNACH so the SIP can be mapped to the new mandate.

## Turnaround time
Ready after the ₹2 token transaction and bank approval; the SIP is then mapped to the new mandate.

## Where to send
Nothing needs to be sent - the investor completes this online.

## Customer reply template (copy & paste)
```text
To set up an e-NACH mandate, login to your FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > make a token transaction of ₹2 through net-banking and your mandate will be ready.
Please let us know after you generate the e-NACH mandate so that we can map your SIP to the new mandate.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,31) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-mf-support-l32','process-mf-support','process-mf-support-m8','NACH mandate (physical)','note','# NACH mandate (physical)

*SIPs & mandates · MF customer support*

**When it applies:** The investor wants a paper (physical) mandate for SIP auto-debit.

## Documents required
- [ ] Signed physical NACH mandate form (generated in the portal), scanned and emailed

## Steps
1. Login to the FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit > Generate mandate > sign it and send the scanned copy to the support mailbox.
2. To map an existing SIP to the new mandate, the investor replies with the mandate number; auto-debit starts as per the SIP date once the mandate is approved.

## Turnaround time
After the signed mandate is received and approved by the bank.

## Where to send
Email clear scanned copies to **contact@fundsindia.com**.

## Customer reply template (copy & paste)
```text
To set up a NACH mandate, login to your FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > sign it and send the scanned copy to contact@fundsindia.com.
If you wish to map your existing SIP to the new mandate, reply with the mandate number so that we can map it. Once the new mandate is approved, the auto-debit will start as per the SIP date.
```

*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',4,1,32) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
UPDATE courses SET hours = 2.3 WHERE id = 'process-mf-support' AND hours IS NOT 2.3;
INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('process-equity-support','EQUITY SUPPORT','Equity customer support','Customer support · process documents & reply templates','process','Process documents and reply templates for equity (broking) customer support. Content is added by the Training & Quality team.','Customer support',0,'[]','[]',1,0,20) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort WHERE courses.code IS NOT excluded.code OR courses.title IS NOT excluded.title OR courses.subtitle IS NOT excluded.subtitle OR courses.category IS NOT excluded.category OR courses.description IS NOT excluded.description OR courses.level IS NOT excluded.level OR courses.hours IS NOT excluded.hours OR courses.playlists IS NOT excluded.playlists OR courses.links IS NOT excluded.links OR courses.published IS NOT excluded.published OR courses.popular IS NOT excluded.popular OR courses.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('process-equity-support-m0','process-equity-support','Equity process documents',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('process-equity-support-l0','process-equity-support','process-equity-support-m0','Equity customer support - templates to be added','note','# Equity customer support

**Process documents for equity (broking) customer support will appear here.**

The customer-support templates document supplied so far covers mutual-fund processes only (see **MF customer support**). Equity templates - the documents required, steps, turnaround times and reply text for each equity process - are added here by the Training & Quality team through the Admin Portal (Courses & videos > Equity customer support).

Until then, use the MF customer support section for shared processes such as KYC and Re-KYC, and address and contact updates.',2,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
UPDATE courses SET hours = 0 WHERE id = 'process-equity-support' AND hours IS NOT 0;
INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('markets-basics','MARKETS','Following the Markets','A daily 5-minute routine','foundation','How to follow market and regulatory changes without noise. Live headlines are on the Market Updates page.','All staff',0,'[]','[]',1,0,21) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort WHERE courses.code IS NOT excluded.code OR courses.title IS NOT excluded.title OR courses.subtitle IS NOT excluded.subtitle OR courses.category IS NOT excluded.category OR courses.description IS NOT excluded.description OR courses.level IS NOT excluded.level OR courses.hours IS NOT excluded.hours OR courses.playlists IS NOT excluded.playlists OR courses.links IS NOT excluded.links OR courses.published IS NOT excluded.published OR courses.popular IS NOT excluded.popular OR courses.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('markets-basics-m0','markets-basics','Reading the markets',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('markets-basics-l0','markets-basics','markets-basics-m0','How to follow market changes without noise','note','# Following market changes

Advisors are expected to be **informed, calm and factual**. Use the **Market Updates** page in this hub (live regulatory and market headlines) and build a short daily habit:

## 5-minute daily routine
1. **Indices**: Sensex / Nifty 50 direction, plus mid- and small-cap indices.
2. **Rates & inflation**: any RBI policy action; CPI inflation prints; bond yields.
3. **Flows**: FPI and DII flows; mutual fund SIP inflow data (AMFI monthly).
4. **Regulation**: new SEBI circulars affecting products, fees, KYC or disclosures.
5. **One idea to share**: a single, plain-English point you can tell a client today.

## What to tell clients on volatile days
- Acknowledge the worry; do not argue with it.
- Remind them of their **goal and time horizon**, not the day''s index move.
- Never predict. Never promise. Offer the review process instead.

## Sources you can trust
SEBI, AMFI, RBI, exchanges (NSE/BSE) and fund-house factsheets. Treat forwards and social media as unverified.',6,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
UPDATE courses SET hours = 0.1 WHERE id = 'markets-basics' AND hours IS NOT 0.1;
INSERT INTO courses (id,code,title,subtitle,category,description,level,hours,playlists,links,published,popular,sort) VALUES ('compliance','COMPLIANCE','Regulators & Compliance Library','SEBI, AMFI, RBI, NISM','foundation','Conduct rules and the official sources every employee should know.','All staff',0,'[]','[{"title":"SEBI - Circulars","url":"https://www.sebi.gov.in/sebiweb/home/HomeAction.do?doListing=yes&sid=1&ssid=7&smid=0"},{"title":"AMFI India","url":"https://www.amfiindia.com/"},{"title":"Mutual Funds Sahi Hai","url":"https://www.mutualfundssahihai.com/"},{"title":"RBI - Press releases","url":"https://www.rbi.org.in/Scripts/Pr_View.aspx"},{"title":"SEBI Investor Website","url":"https://investor.sebi.gov.in/"}]',1,0,22) ON CONFLICT(id) DO UPDATE SET code=excluded.code,title=excluded.title,subtitle=excluded.subtitle,category=excluded.category,description=excluded.description,level=excluded.level,hours=excluded.hours,playlists=excluded.playlists,links=excluded.links,published=excluded.published,popular=excluded.popular,sort=excluded.sort WHERE courses.code IS NOT excluded.code OR courses.title IS NOT excluded.title OR courses.subtitle IS NOT excluded.subtitle OR courses.category IS NOT excluded.category OR courses.description IS NOT excluded.description OR courses.level IS NOT excluded.level OR courses.hours IS NOT excluded.hours OR courses.playlists IS NOT excluded.playlists OR courses.links IS NOT excluded.links OR courses.published IS NOT excluded.published OR courses.popular IS NOT excluded.popular OR courses.sort IS NOT excluded.sort;
INSERT INTO modules (id,course_id,title,weight,sort) VALUES ('compliance-m0','compliance','Conduct basics',NULL,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,title=excluded.title,weight=excluded.weight,sort=excluded.sort WHERE modules.course_id IS NOT excluded.course_id OR modules.title IS NOT excluded.title OR modules.weight IS NOT excluded.weight OR modules.sort IS NOT excluded.sort;
INSERT INTO lessons (id,course_id,module_id,title,kind,body,minutes,published,sort) VALUES ('compliance-l0','compliance','compliance-m0','Ten conduct rules for client conversations','note','# Ten conduct rules

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

> This is a summary for orientation. The binding rules are SEBI/AMFI regulations and your company''s policies - read them at the source (see Links on this course).',5,1,0) ON CONFLICT(id) DO UPDATE SET course_id=excluded.course_id,module_id=excluded.module_id,title=excluded.title,kind=excluded.kind,body=excluded.body,minutes=excluded.minutes,published=excluded.published,sort=excluded.sort WHERE lessons.course_id IS NOT excluded.course_id OR lessons.module_id IS NOT excluded.module_id OR lessons.title IS NOT excluded.title OR lessons.kind IS NOT excluded.kind OR lessons.body IS NOT excluded.body OR lessons.minutes IS NOT excluded.minutes OR lessons.published IS NOT excluded.published OR lessons.sort IS NOT excluded.sort;
UPDATE courses SET hours = 0.1 WHERE id = 'compliance' AND hours IS NOT 0.1;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-investing-zero','Investing from zero','Start here. Build the right mindset, understand what good advice looks like, and learn how mutual funds fit in — before your first SIP.','Beginner','🌱',1,0) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-QmCKI5RHTGU',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-1yJcubWlynY',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-SScgY97HoCo',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-pIGL4DTDfuU',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-XFVW7XNLJcQ',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-QZEZlZuPmCk',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-z2R3wD7DgvE',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-enoWBas3jNM',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-0QbW0uLdScc',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-hSRsO9Ej1vA',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-P70OfEboDhQ',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-QYxyYwu7dvE',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-Mde1tgG_aUI',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-investing-zero','fi-academy-v-Q8scqQA8RD0',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-sip-mastery','SIP mastery','Why SIPs work, how long to stay invested, step-up SIPs, and how to judge mutual funds sensibly.','Beginner → Intermediate','📈',1,1) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-6YSk4SySuCg',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-WMxzWMsv20o',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-14qhtgSuTXA',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-DHwoXHXM6Wo',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-NmsCMKyXUIw',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-VtYNfqv_poY',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-48YYtbKltN4',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-ebjAoOEoCFk',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-KqWir9FKbS8',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-t1A-RSyCzUs',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-LxTE4CMudoQ',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-TON5OMjvHKI',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-RNVc-sKlfRM',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sip-mastery','fi-academy-v-EfJSvo8G1jg',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-bonds-sif','Bonds & Specialised Investment Funds','What bonds are, what to check before buying, and how SIFs differ across equity, debt and hybrid.','Intermediate','🏦',1,2) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-pTXA4FFsdds',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-bJrM2cdiPkA',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-kTt6LJmBmcY',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-1G303rytQhc',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-_uMEDzinY_M',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-HKAElEMOO4A',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-bonds-sif','fi-academy-v-38FSNxHMXvE',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-stocks-ipo','Stocks & IPOs on FundsIndia','Why invest in stocks, stock SIPs, Alpha research reports, placing orders and improving IPO allotment chances.','Intermediate','💹',1,3) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-zgTfMnIXrHA',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-2HKGeaYx7f4',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-mOcXD4PBRjg',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-x4rRsovVRUQ',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-2RX4B3KuwPw',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-gGxeRoqDzJQ',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-wA5CgGp1bFs',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-U9LgJq7HH3M',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-jw-Wzaf6Jhc',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-0vVrni9bCbU',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-OTZz7oGNSis',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-68PcpVmgjB4',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-UjhWOJdW79c',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-stocks-ipo','fi-academy-v-prwC2xkOPdI',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-markets','Markets & budget literacy','Understand the Union Budget and how to navigate market volatility with your goals in mind.','All','🌐',1,4) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-Xmqqw3x0Jgs',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-jSCrCWL_b4Q',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-5YuZXiCFBMM',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-quPeSPo2Q5k',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-mtNlBhXjNcY',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-0VGtZFvogBA',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-GBkylwEZquQ',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-DpMhkw2dO2A',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-9SeS_wYLmWE',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-XEtXB4ph6OA',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-l5ABt2eN7HU',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-MYBtVh1FDX0',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-rkpoGf0TUA0',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-markets','fi-academy-v-IKnth3FOXqA',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-amfi-distributor','Become an AMFI-certified distributor (NISM V-A)','The complete V-A track: exam overview, then each chapter as video → study notes → practice quiz, finishing with the mock exam.','Certification','🎓',1,5) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l0',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-kTSSHzaUsTw',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-D4PqE1whQOw',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l3',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l4',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l5',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l6',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-BJWh2ncpLlA',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l8',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l9',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l10',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l11',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l12',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l13',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-AA8Y_k69Wh0',14) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l15',15) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l16',16) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l17',17) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-QBiKF20D4h4',18) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l19',19) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l20',20) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l21',21) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l22',22) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-Y5qUlpr4HZo',23) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l24',24) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l25',25) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l26',26) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-nAwcRqSLALo',27) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l28',28) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l29',29) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l30',30) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l31',31) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-KSGriBaTAD0',32) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l33',33) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l34',34) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l35',35) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-GLq8szwqf3s',36) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l37',37) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l38',38) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-Pxg32Lmp3vU',39) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l40',40) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l41',41) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l42',42) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l43',43) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l44',44) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l45',45) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l46',46) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l47',47) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l48',48) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-O22YjSIKbOY',49) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-UHdBKjBUD5I',50) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l51',51) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l52',52) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l53',53) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l54',54) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l55',55) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-PFVAmw3oHOA',56) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l57',57) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l58',58) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l59',59) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-zaN_FpDa-K0',60) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l61',61) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l62',62) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l63',63) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-ls_5PfGBOWI',64) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-vPoIc0fSH2E',65) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-v-13RFQzlq3ds',66) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l67',67) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-amfi-distributor','nism-5a-l68',68) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-adviser','Investment adviser track (NISM X-A → X-B)','Financial planning and risk profiling (Level 1) followed by advanced advisory topics (Level 2).','Certification','🧭',1,6) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-l0',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-l1',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-l2',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-h86FGFwlpOs',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-oOcHTJf5ILc',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-_0oy9TCg9t8',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-X6qU6epUwwA',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-xmISFjxM3eY',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-1h9TNn6D9SM',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-AxCpcfD979g',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-Sfh2zCevdgE',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-WZE2sZviFtA',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-LwR_P9E6NXk',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-uwq1AUGGiFQ',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-WgWkN_lr7ik',14) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-4kfdhB_aRnU',15) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-MMdPBj9Kmbo',16) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-_kWdbrKBjL8',17) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-VN7wQ5L1hjs',18) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-EnX6njLT4zo',19) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-GhO_SJkxda0',20) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-IhMwnFbAWdw',21) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-ouv7CWoVNOI',22) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-AwJr5vyfg70',23) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-hJMWf5vp8Og',24) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-h3q0VNAFdAc',25) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-YxQfg1P4z10',26) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-MQi9ttXQJ3Q',27) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-NKVVhXhQyBA',28) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-9gRM8hN74yI',29) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-5Eqwi_ESoAE',30) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-8LAB3lcChQw',31) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-ZqZyb70IE4o',32) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-h0GEyzQ7zsU',33) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-O0g-rE2hVE0',34) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-gOf9qwZInEI',35) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-5tRh2H6u8iQ',36) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-c3SKDXioZl4',37) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-4UJ_QjLyF7s',38) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10a-v-zq_xr-_JQgk',39) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-l0',40) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-l1',41) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-l2',42) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-fAQLjIaPsP0',43) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-h-TheQFziEQ',44) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-tACqZ1uhkik',45) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-HHidhHXUeig',46) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-fp9IGWddc8E',47) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-AyWIKFXIKQQ',48) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-4yXxYRZYNtI',49) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-f1hT6_CKKmw',50) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-yVmWJZ2lKUc',51) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-R7BlFyX0ITM',52) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-8LQiqbGsFEw',53) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-KiuvdAfJqBo',54) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-WbgwaIgcbR0',55) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-8SWqZVsmdco',56) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-6pF-bHXViJs',57) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-MizgXS16bV8',58) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-jTUoA9ukxzs',59) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-BxauZgPz_sE',60) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-crMoPmwE8-8',61) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-SImHjpxv944',62) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-AwJr5vyfg70',63) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-hJMWf5vp8Og',64) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-h3q0VNAFdAc',65) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-YxQfg1P4z10',66) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-MQi9ttXQJ3Q',67) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-NKVVhXhQyBA',68) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-9gRM8hN74yI',69) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-5Eqwi_ESoAE',70) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-8LAB3lcChQw',71) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-ZqZyb70IE4o',72) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-h0GEyzQ7zsU',73) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-O0g-rE2hVE0',74) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-gOf9qwZInEI',75) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-5tRh2H6u8iQ',76) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-c3SKDXioZl4',77) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-4UJ_QjLyF7s',78) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-adviser','nism-10b-v-zq_xr-_JQgk',79) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-sales-conversations','Client conversations & objection handling','Scenario notes on common client objections, then the full objection-handling video series.','Skills','🗣️',1,7) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-l0',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-l1',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-l2',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-l3',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-aA6Br0wHKlE',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-qmnMyuqoO3Y',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-tBmkTwY-Id8',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-lAYGPXvBnj4',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-I4isQL4BBxc',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-K5l3HXrb2UI',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-2kk9ZhVnpbg',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-W7pgvTQJ4lI',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-pPrsJr9Wv4k',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-hGhFhFzdU60',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-zqTVv50K38U',14) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-sales-conversations','objection-handling-v-BJGjTFnEIic',15) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO paths (id,title,description,level,icon,published,sort) VALUES ('path-tools','Tools onboarding: Zoho CRM & Tata Tele','Get productive on the CRM and the dialer: guides first, then video tutorials.','Onboarding','🛠️',1,8) ON CONFLICT(id) DO UPDATE SET title=excluded.title,description=excluded.description,level=excluded.level,icon=excluded.icon,published=excluded.published,sort=excluded.sort WHERE paths.title IS NOT excluded.title OR paths.description IS NOT excluded.description OR paths.level IS NOT excluded.level OR paths.icon IS NOT excluded.icon OR paths.published IS NOT excluded.published OR paths.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-l0',0) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-l1',1) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-l2',2) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-l3',3) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-UNYcJMRxZ1o',4) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-iopxES5j_xU',5) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-7J8ZnEtDEws',6) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-1BiMCFBen64',7) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-H00tOWyR2r8',8) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','zoho-crm-v-AUOBnlUB_ck',9) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','tata-tele-l0',10) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','tata-tele-l1',11) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','tata-tele-l2',12) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','tata-tele-l3',13) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
INSERT INTO path_items (path_id,lesson_id,sort) VALUES ('path-tools','tata-tele-v-yT36kHHuzJA',14) ON CONFLICT(path_id,lesson_id) DO UPDATE SET sort=excluded.sort WHERE path_items.sort IS NOT excluded.sort;
DELETE FROM lessons WHERE course_id='fi-academy' AND (id LIKE 'fi-academy-l%' OR id LIKE 'fi-academy-v-%') AND id NOT IN ('fi-academy-v-QmCKI5RHTGU','fi-academy-v-1yJcubWlynY','fi-academy-v-SScgY97HoCo','fi-academy-v-pIGL4DTDfuU','fi-academy-v-XFVW7XNLJcQ','fi-academy-v-QZEZlZuPmCk','fi-academy-v-z2R3wD7DgvE','fi-academy-v-enoWBas3jNM','fi-academy-v-0QbW0uLdScc','fi-academy-v-hSRsO9Ej1vA','fi-academy-v-P70OfEboDhQ','fi-academy-v-QYxyYwu7dvE','fi-academy-v-Mde1tgG_aUI','fi-academy-v-Q8scqQA8RD0','fi-academy-v-psGBBGROXRM','fi-academy-v-UhGGYwxRWOI','fi-academy-v-g9OhCpnfX14','fi-academy-v-1YUMa8PEwZ4','fi-academy-v-ZCvHa913oZU','fi-academy-v-P_POWz3pxZQ','fi-academy-v-oD-pKYG62jk','fi-academy-v-7BEZ26n4W44','fi-academy-v-2m5gTM7bDRY','fi-academy-v-GAUbeLXr33Q','fi-academy-v-dC4sqAg1PV0','fi-academy-v-zuh46r0YcIg','fi-academy-v-LCcojjNJH3M','fi-academy-v-ZgMR5DbSAyQ','fi-academy-v-2q-_eTVw4ZY','fi-academy-v-66vqXGyi6aM','fi-academy-v-JCaUSWBrgsg','fi-academy-v-z_HO0E87Y5E','fi-academy-v-nm8BpFKBNoE','fi-academy-v-6NJpXIO7Uxw','fi-academy-v-8xRkmFqVqTI','fi-academy-v-J8ossyN0eEs','fi-academy-v-uON4zMHjZcg','fi-academy-v-gx3SGuwRcsw','fi-academy-v-Q1Ec6s7D5hA','fi-academy-v-LNq4Ojogvx0','fi-academy-v-FNdbpHqyLpk','fi-academy-v-1PHSQtcV06M','fi-academy-v-3Qam3Gm9588','fi-academy-v-QBy1h0t6KeQ','fi-academy-v-YgX3LID0GQQ','fi-academy-v-6YSk4SySuCg','fi-academy-v-WMxzWMsv20o','fi-academy-v-14qhtgSuTXA','fi-academy-v-DHwoXHXM6Wo','fi-academy-v-NmsCMKyXUIw','fi-academy-v-VtYNfqv_poY','fi-academy-v-48YYtbKltN4','fi-academy-v-ebjAoOEoCFk','fi-academy-v-KqWir9FKbS8','fi-academy-v-t1A-RSyCzUs','fi-academy-v-LxTE4CMudoQ','fi-academy-v-TON5OMjvHKI','fi-academy-v-RNVc-sKlfRM','fi-academy-v-EfJSvo8G1jg','fi-academy-v-1m586YpeYss','fi-academy-v-n4OqlyBildM','fi-academy-v-LwN3iwDXuAA','fi-academy-v-9ehbY24Ysns','fi-academy-v-05a4iVh8Wu0','fi-academy-v-Wg-MMT4rshU','fi-academy-v-8RTfHWsJ_TA','fi-academy-v-0rq9FBPOMKM','fi-academy-v-up6laNhYD0U','fi-academy-v-SLZK6zDL8BI','fi-academy-v-3fOy1tqLgp0','fi-academy-v-s4YofbPmFRc','fi-academy-v-BWypUHxs7ck','fi-academy-v-RKFsagBxtuk','fi-academy-v-sZ5Uv3duh80','fi-academy-v-Nxl8qOOkwA0','fi-academy-v-QmU00ZEW6Io','fi-academy-v-72IocNPzY58','fi-academy-v-QdTX5qBpWlI','fi-academy-v--kqG-vssD-I','fi-academy-v-WTTObWHpa2k','fi-academy-v-D2E7DjhHG44','fi-academy-v-ssL4nZH4DTc','fi-academy-v-rPb-M-fStuk','fi-academy-v-BFrkcap5gdA','fi-academy-v-EkfgCX2QlJc','fi-academy-v-vPHXMLfrH3g','fi-academy-v-5Sx_InmdNyY','fi-academy-v-UwD9jqSQHws','fi-academy-v-8vIyMbfSMI4','fi-academy-v-Zw7MYpW9i-w','fi-academy-v-e16XjGrIcis','fi-academy-v-pTXA4FFsdds','fi-academy-v-bJrM2cdiPkA','fi-academy-v-kTt6LJmBmcY','fi-academy-v-1G303rytQhc','fi-academy-v-_uMEDzinY_M','fi-academy-v-HKAElEMOO4A','fi-academy-v-38FSNxHMXvE','fi-academy-v-zgTfMnIXrHA','fi-academy-v-2HKGeaYx7f4','fi-academy-v-mOcXD4PBRjg','fi-academy-v-x4rRsovVRUQ','fi-academy-v-2RX4B3KuwPw','fi-academy-v-gGxeRoqDzJQ','fi-academy-v-wA5CgGp1bFs','fi-academy-v-U9LgJq7HH3M','fi-academy-v-jw-Wzaf6Jhc','fi-academy-v-0vVrni9bCbU','fi-academy-v-OTZz7oGNSis','fi-academy-v-68PcpVmgjB4','fi-academy-v-UjhWOJdW79c','fi-academy-v-prwC2xkOPdI','fi-academy-v-l7vSQad9L5Y','fi-academy-v-Gm5JJ_fTqfU','fi-academy-v-d0aWncCDBQo','fi-academy-v-B7YtxTERVqE','fi-academy-v-TTDz4GMIbiY','fi-academy-v-krafBXib5S0','fi-academy-v-I8T6We19qNs','fi-academy-v-KjcthL4isKY','fi-academy-v-a0jme8t--cQ','fi-academy-v-1A_rXTlsxWs','fi-academy-v-9LDUKcS-x7g','fi-academy-v-YJ-Q2_i7ll0','fi-academy-v-qT53rI_9KiQ','fi-academy-v-BY3iWRG-5rs','fi-academy-v-aTBwHmm1Kvk','fi-academy-v-vMtUUwOcU0k','fi-academy-v-W72Tg3fm4Hw','fi-academy-v-905NV93OEXk','fi-academy-v-O1oI7WfpfW0','fi-academy-v-Xmqqw3x0Jgs','fi-academy-v-jSCrCWL_b4Q','fi-academy-v-5YuZXiCFBMM','fi-academy-v-quPeSPo2Q5k','fi-academy-v-mtNlBhXjNcY','fi-academy-v-0VGtZFvogBA','fi-academy-v-GBkylwEZquQ','fi-academy-v-DpMhkw2dO2A','fi-academy-v-9SeS_wYLmWE','fi-academy-v-XEtXB4ph6OA','fi-academy-v-l5ABt2eN7HU','fi-academy-v-MYBtVh1FDX0','fi-academy-v-rkpoGf0TUA0','fi-academy-v-IKnth3FOXqA','fi-academy-v-ONfunOc956A','fi-academy-v-IJuyurfAvwg','fi-academy-v-BrPc60V9Re0','fi-academy-v-xrUJh3KWbiA','fi-academy-v-wkM_X4pHMNY','fi-academy-v-NOzv8NT_A4I','fi-academy-v-7QZBEFbCloQ','fi-academy-v-rfEpFqREWM0','fi-academy-v-qkoRzFDepT8','fi-academy-v-2YNZWDce9Ao','fi-academy-v-BXrM1u5RcEI','fi-academy-v-2hV1yTYEctA','fi-academy-v-C43qdhtpISM','fi-academy-v-W-9csd0neZ4','fi-academy-v-GFK-z5SA6RI','fi-academy-v-9cb6wzoJsLY','fi-academy-v-9u4Udgn2ipU','fi-academy-v-JUfONG6y8x4','fi-academy-v-usvWNxX4fWk','fi-academy-v-sNkayWd_fQY','fi-academy-v-grLCmSWERkE','fi-academy-v-isyHpszet80','fi-academy-v-EHNAWQj1BPU','fi-academy-v-wwt9OD9Bwic','fi-academy-v-QKgRJ8CAGWQ','fi-academy-v-ge9mmeVIKls','fi-academy-v-2MrA8buzf40','fi-academy-v-RuZOvo2TxW0','fi-academy-v-lZQgh9BL8F8','fi-academy-v-YPnZG04Eub8','fi-academy-v-Q-o2MoQ1udc','fi-academy-v-wUtYNhjlw9s','fi-academy-v-GW6mXclom54','fi-academy-v-9LgEL8-LZwg','fi-academy-v-jnBbaq3Rbic','fi-academy-v-TNzgo0Pu1n0','fi-academy-v-n9OiNKRVKfA','fi-academy-v-FGyAY8LNE-4','fi-academy-v-Ff9oUjLPN7I','fi-academy-v-c-H9EirSgms','fi-academy-v-walUddO62x0','fi-academy-v-4btSqebBQ88','fi-academy-v-BDxRe_Ffeek','fi-academy-v-GC-7xF2CD18','fi-academy-v-F-EZpc1Q72k','fi-academy-v-lA6jCDq5saI','fi-academy-v-3iqJid-UbYw','fi-academy-v-hKLh-7ZyDXg','fi-academy-v-j8fmKkUE5RY','fi-academy-v-HQDY1MfHLXE','fi-academy-v-TJ4kEnAV850','fi-academy-v-1D2slk7daWI','fi-academy-v-udnDm4I8ed4','fi-academy-v-JENU8-ro9pY','fi-academy-v-gc_xDznuLA4','fi-academy-v-xF0jL15KWw8','fi-academy-v-9NipFPxWBl4','fi-academy-v-74xLvlUMdUc','fi-academy-v-ck_lq0jPQDI','fi-academy-v-nKePEWbeYmM','fi-academy-v-qOHN08iQdpA','fi-academy-v-mxHSzCUMfsw','fi-academy-v-TBNu2ppc1R0','fi-academy-v-1geq9qbO5VM','fi-academy-v-atRblnDOZiU','fi-academy-v-Q-j7gWb3Oiw','fi-academy-v-djSGmY6LIXw','fi-academy-v-W3TwD2pu40M','fi-academy-v-zcktRVNUiMA','fi-academy-v-UEoksgh9cNM','fi-academy-v-dh6HlxDv43w','fi-academy-v-srvfkOB7Bhc','fi-academy-v-JNAeGrYhFY4','fi-academy-v-ZQpkbJ7IN00','fi-academy-v-qLGoXtFxGuA','fi-academy-v-uUanCKiDENM','fi-academy-v-AQ0VwXTXbww','fi-academy-v-kmaiT2Ws8M0','fi-academy-v-mEZc3yKiCUo','fi-academy-v-zwwP1BCl3oU','fi-academy-v-ReR6Ac3DyHA','fi-academy-v-W0LMTJgvmks','fi-academy-v-iEk9lIJAsvQ','fi-academy-v-TeRjm9XIpXI','fi-academy-v-xTfEULfT3gk','fi-academy-v-qUt91AKHjrI','fi-academy-v-Fw02aodH8fE','fi-academy-v-aQJWU2xxMLw','fi-academy-v-YUJMRj4-p8M','fi-academy-v-lny77q0UqRk','fi-academy-v-s_FK9rgc5i8','fi-academy-v-v8lpy1ayXyA','fi-academy-v-0PxpY4tbiSE','fi-academy-v-vLulDfejzys','fi-academy-v-dvkzfN2Kdyg','fi-academy-v-Zy6oNsStTLo','fi-academy-v-oobO4TcZwic','fi-academy-v-Q9tJP8_1qZU','fi-academy-v-WGHh3PYdmYo','fi-academy-v-sRz5m6cbQEc','fi-academy-v-G22a613Oa64','fi-academy-v-wpt_XEOLxio','fi-academy-v-s9dnbc5Zi_o','fi-academy-v-_aezsIKv1KA','fi-academy-v-vZiSYBIGooQ','fi-academy-v-PxJrmHffsa4','fi-academy-v-9ZIk9QCJB_0','fi-academy-v-w0rZ4Ie88wQ','fi-academy-v-qfYt1ZXxPec','fi-academy-v-UeSp2a4wQgo','fi-academy-v-J2eAzNjwiU8','fi-academy-v-joy1e5SFDNg','fi-academy-v-Hg1u8FIHfj0','fi-academy-v-4XtPsd730_I','fi-academy-v-DbKNMgPYHqM','fi-academy-v-mwWDLNE-Q30','fi-academy-v-eTBn_nAdvfI','fi-academy-v-ZJDfkX39ulA','fi-academy-v-cKtDZEDa5Rc','fi-academy-v-LnVHSaDlK1w','fi-academy-v-w1aEKS1YYd8','fi-academy-v-Ebw7hOJ2j8Q','fi-academy-v-5tr7jV_g_AA','fi-academy-v-9IKs-IdFJ8s','fi-academy-v-kfxlmQArG28','fi-academy-v-fJx-YvpsLkA','fi-academy-v-6ANSCTEWc_M','fi-academy-v-xfN6Zh1hM9M','fi-academy-v-Gg0gIwp7Be8','fi-academy-v-fxgzFiEJxQI','fi-academy-v-6RbfCgUiqMM','fi-academy-v-h88a8R0k76Q');
DELETE FROM quizzes WHERE course_id='fi-academy' AND id LIKE 'fi-academy-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='fi-academy' AND id LIKE 'fi-academy-m%' AND id NOT IN ('fi-academy-m0','fi-academy-m1','fi-academy-m2','fi-academy-m3','fi-academy-m4','fi-academy-m5','fi-academy-m6','fi-academy-m7','fi-academy-m8','fi-academy-m9','fi-academy-m10');
DELETE FROM lessons WHERE course_id='nism-5a' AND (id LIKE 'nism-5a-l%' OR id LIKE 'nism-5a-v-%') AND id NOT IN ('nism-5a-l0','nism-5a-v-kTSSHzaUsTw','nism-5a-v-D4PqE1whQOw','nism-5a-l3','nism-5a-l4','nism-5a-l5','nism-5a-l6','nism-5a-v-BJWh2ncpLlA','nism-5a-l8','nism-5a-l9','nism-5a-l10','nism-5a-l11','nism-5a-l12','nism-5a-l13','nism-5a-v-AA8Y_k69Wh0','nism-5a-l15','nism-5a-l16','nism-5a-l17','nism-5a-v-QBiKF20D4h4','nism-5a-l19','nism-5a-l20','nism-5a-l21','nism-5a-l22','nism-5a-v-Y5qUlpr4HZo','nism-5a-l24','nism-5a-l25','nism-5a-l26','nism-5a-v-nAwcRqSLALo','nism-5a-l28','nism-5a-l29','nism-5a-l30','nism-5a-l31','nism-5a-v-KSGriBaTAD0','nism-5a-l33','nism-5a-l34','nism-5a-l35','nism-5a-v-GLq8szwqf3s','nism-5a-l37','nism-5a-l38','nism-5a-v-Pxg32Lmp3vU','nism-5a-l40','nism-5a-l41','nism-5a-l42','nism-5a-l43','nism-5a-l44','nism-5a-l45','nism-5a-l46','nism-5a-l47','nism-5a-l48','nism-5a-v-O22YjSIKbOY','nism-5a-v-UHdBKjBUD5I','nism-5a-l51','nism-5a-l52','nism-5a-l53','nism-5a-l54','nism-5a-l55','nism-5a-v-PFVAmw3oHOA','nism-5a-l57','nism-5a-l58','nism-5a-l59','nism-5a-v-zaN_FpDa-K0','nism-5a-l61','nism-5a-l62','nism-5a-l63','nism-5a-v-ls_5PfGBOWI','nism-5a-v-vPoIc0fSH2E','nism-5a-v-13RFQzlq3ds','nism-5a-l67','nism-5a-l68');
DELETE FROM quizzes WHERE course_id='nism-5a' AND id LIKE 'nism-5a-z%' AND id NOT IN ('nism-5a-z0','nism-5a-z1','nism-5a-z2','nism-5a-z3','nism-5a-z4','nism-5a-z5','nism-5a-z6','nism-5a-z7','nism-5a-z8','nism-5a-z9','nism-5a-z10','nism-5a-z11','nism-5a-z12','nism-5a-z13','nism-5a-z14','nism-5a-z15','nism-5a-z16','nism-5a-z17','nism-5a-z18','nism-5a-z19','nism-5a-z20','nism-5a-z21','nism-5a-z22','nism-5a-z23','nism-5a-z24','nism-5a-z25','nism-5a-z26','nism-5a-z27','nism-5a-z28','nism-5a-z29','nism-5a-z30','nism-5a-z31','nism-5a-z32');
DELETE FROM modules WHERE course_id='nism-5a' AND id LIKE 'nism-5a-m%' AND id NOT IN ('nism-5a-m0','nism-5a-m1','nism-5a-m2','nism-5a-m3','nism-5a-m4','nism-5a-m5','nism-5a-m6','nism-5a-m7','nism-5a-m8','nism-5a-m9','nism-5a-m10','nism-5a-m11','nism-5a-m12','nism-5a-m13','nism-5a-m14','nism-5a-m15','nism-5a-m16','nism-5a-m17');
DELETE FROM questions WHERE quiz_id='nism-5a-z0' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z1' AND sort >= 53;
DELETE FROM questions WHERE quiz_id='nism-5a-z2' AND sort >= 20;
DELETE FROM questions WHERE quiz_id='nism-5a-z3' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z4' AND sort >= 17;
DELETE FROM questions WHERE quiz_id='nism-5a-z5' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z6' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z7' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z8' AND sort >= 50;
DELETE FROM questions WHERE quiz_id='nism-5a-z9' AND sort >= 39;
DELETE FROM questions WHERE quiz_id='nism-5a-z10' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z11' AND sort >= 25;
DELETE FROM questions WHERE quiz_id='nism-5a-z12' AND sort >= 673;
DELETE FROM questions WHERE quiz_id='nism-5a-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z20' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z21' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z22' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z23' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z24' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z25' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z26' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z27' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z28' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z29' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z30' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z31' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5a-z32' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-5b' AND (id LIKE 'nism-5b-l%' OR id LIKE 'nism-5b-v-%') AND id NOT IN ('nism-5b-l0','nism-5b-l1','nism-5b-l2','nism-5b-v-OdU189lVu-A','nism-5b-v-4kkDzOaRlG4','nism-5b-v-1kPXichd_wM','nism-5b-v-bzKGhu3KODE','nism-5b-v-TUmZj44xZ0g','nism-5b-v-Q9mMt4wgItU','nism-5b-v-1TcMWHQ8I8g');
DELETE FROM quizzes WHERE course_id='nism-5b' AND id LIKE 'nism-5b-z%' AND id NOT IN ('nism-5b-z0','nism-5b-z1','nism-5b-z2','nism-5b-z3','nism-5b-z4','nism-5b-z5','nism-5b-z6','nism-5b-z7','nism-5b-z8','nism-5b-z9','nism-5b-z10','nism-5b-z11','nism-5b-z12','nism-5b-z13','nism-5b-z14','nism-5b-z15','nism-5b-z16','nism-5b-z17','nism-5b-z18','nism-5b-z19','nism-5b-z20');
DELETE FROM modules WHERE course_id='nism-5b' AND id LIKE 'nism-5b-m%' AND id NOT IN ('nism-5b-m0','nism-5b-m1','nism-5b-m2','nism-5b-m3','nism-5b-m4');
DELETE FROM questions WHERE quiz_id='nism-5b-z0' AND sort >= 771;
DELETE FROM questions WHERE quiz_id='nism-5b-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-5b-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-5d' AND (id LIKE 'nism-5d-l%' OR id LIKE 'nism-5d-v-%') AND id NOT IN ('nism-5d-v-fGBrGD1CSPA','nism-5d-v-CDlwNk_OEI4','nism-5d-v-SWCKxt8SiQY','nism-5d-v-ag0TvS-dLF4','nism-5d-v-pIWURioZyTQ','nism-5d-v-7LtDZjPalCQ','nism-5d-v-qqIfHvu1BwY','nism-5d-v-xhjMtmbrME4','nism-5d-v-FdlgfemdXFI','nism-5d-v-u2tLVXvjRC0','nism-5d-v-oRVwMO2xTKY','nism-5d-v-XRajRbOItkc','nism-5d-v-5vjFYAqUHYc','nism-5d-v-vgolAH0hELI','nism-5d-v-jZxZKCr1IZo','nism-5d-v-ypDu1JKGiWo','nism-5d-v-rr9XFtVEoGI','nism-5d-v-CRQomA0scUQ','nism-5d-v-awLVu5JS8R8','nism-5d-v-ZRNSEoIpAG0','nism-5d-v-ws1kOrtiVg0','nism-5d-v-6YjsraXP2yI','nism-5d-v-ZTO0D6CDjFA','nism-5d-v-2fq80r8H9TI','nism-5d-v-EjMjsVSPX3Q','nism-5d-v-sKNKGEDswyk','nism-5d-v-BAc78i-UmaI','nism-5d-v-8UMX0wWpbMI','nism-5d-v-41sqjZ-1l18','nism-5d-v-yl8lShKQn-8','nism-5d-v-PyuOQDxKAF0','nism-5d-v-k5bv6EY6mFw','nism-5d-v-Flh0I-NlXg8','nism-5d-v-dDYnBEjUB1o','nism-5d-v-_FEW4X1Zt7I','nism-5d-v-_nA66lla6E4','nism-5d-v-JWjHSjRRyLY','nism-5d-v-cAIc5-jCpx4','nism-5d-v-2eg7sD-zFC0','nism-5d-v-6E6HLwyo1Zw','nism-5d-v-Vl37UNp9cns','nism-5d-v-npZSchjSqoI','nism-5d-v-__4EWpB9tuU','nism-5d-v-Y2TS9Mnc8GY','nism-5d-v-LRSM4YWtypE');
DELETE FROM quizzes WHERE course_id='nism-5d' AND id LIKE 'nism-5d-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='nism-5d' AND id LIKE 'nism-5d-m%' AND id NOT IN ('nism-5d-m0');
DELETE FROM lessons WHERE course_id='nism-7' AND (id LIKE 'nism-7-l%' OR id LIKE 'nism-7-v-%') AND id NOT IN ('nism-7-v-pNgUWlgYuEw','nism-7-v-SdeuLTMidGQ','nism-7-v-qGyZuhYd8lI','nism-7-v-Z7EUI2-W2j0','nism-7-v-6V4g3P6hm-0','nism-7-v-ozHuR3LzByo','nism-7-v-fYJC5Yi_EDI','nism-7-v-KuN8iVELovA','nism-7-v-UIqDzqQpgPw','nism-7-v-w1Y7VPaw7AE','nism-7-v-yWBOq6yuevE','nism-7-v-Bw_LQz3jYdg','nism-7-v-ekx_iA0iDQA','nism-7-v-xxVF0qXkvE0','nism-7-v-8uHiLdJETMA','nism-7-v-Kbx-V3vevn4','nism-7-v-6tZL5R44kzM','nism-7-v-CGg6i1eWcTg','nism-7-v-g5v7BP6_Khs');
DELETE FROM quizzes WHERE course_id='nism-7' AND id LIKE 'nism-7-z%' AND id NOT IN ('nism-7-z0','nism-7-z1','nism-7-z2','nism-7-z3','nism-7-z4','nism-7-z5','nism-7-z6','nism-7-z7','nism-7-z8','nism-7-z9','nism-7-z10','nism-7-z11','nism-7-z12','nism-7-z13','nism-7-z14','nism-7-z15','nism-7-z16','nism-7-z17','nism-7-z18','nism-7-z19');
DELETE FROM modules WHERE course_id='nism-7' AND id LIKE 'nism-7-m%' AND id NOT IN ('nism-7-m0','nism-7-m1');
DELETE FROM questions WHERE quiz_id='nism-7-z0' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-7-z19' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-8' AND (id LIKE 'nism-8-l%' OR id LIKE 'nism-8-v-%') AND id NOT IN ('nism-8-l0','nism-8-l1','nism-8-l2','nism-8-l3','nism-8-v-8d2ec3UzFiE','nism-8-v-3Z7-qrnEqmQ','nism-8-v-e7e2xGnpH38','nism-8-v-2t9noNydzDA','nism-8-v-GHl7ALznF4w','nism-8-v-6NBeJEMaB8o','nism-8-v-Yo_hn966O-Q','nism-8-v-wybClrNlllM','nism-8-v--m0m-VSe5Zk','nism-8-v-2eRUDOSvYa4','nism-8-v-FLKaxIOkJ7Q','nism-8-v-tUTUv1V4PK8','nism-8-v-IirBdaBpSz0','nism-8-v-k14GCY-88PE');
DELETE FROM quizzes WHERE course_id='nism-8' AND id LIKE 'nism-8-z%' AND id NOT IN ('nism-8-z0','nism-8-z1','nism-8-z2','nism-8-z3','nism-8-z4','nism-8-z5','nism-8-z6','nism-8-z7','nism-8-z8','nism-8-z9','nism-8-z10','nism-8-z11','nism-8-z12','nism-8-z13','nism-8-z14','nism-8-z15','nism-8-z16','nism-8-z17','nism-8-z18','nism-8-z19','nism-8-z20');
DELETE FROM modules WHERE course_id='nism-8' AND id LIKE 'nism-8-m%' AND id NOT IN ('nism-8-m0','nism-8-m1','nism-8-m2','nism-8-m3','nism-8-m4','nism-8-m5');
DELETE FROM questions WHERE quiz_id='nism-8-z0' AND sort >= 1252;
DELETE FROM questions WHERE quiz_id='nism-8-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-8-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-10a' AND (id LIKE 'nism-10a-l%' OR id LIKE 'nism-10a-v-%') AND id NOT IN ('nism-10a-l0','nism-10a-l1','nism-10a-l2','nism-10a-v-h86FGFwlpOs','nism-10a-v-oOcHTJf5ILc','nism-10a-v-_0oy9TCg9t8','nism-10a-v-X6qU6epUwwA','nism-10a-v-xmISFjxM3eY','nism-10a-v-1h9TNn6D9SM','nism-10a-v-AxCpcfD979g','nism-10a-v-Sfh2zCevdgE','nism-10a-v-WZE2sZviFtA','nism-10a-v-LwR_P9E6NXk','nism-10a-v-uwq1AUGGiFQ','nism-10a-v-WgWkN_lr7ik','nism-10a-v-4kfdhB_aRnU','nism-10a-v-MMdPBj9Kmbo','nism-10a-v-_kWdbrKBjL8','nism-10a-v-VN7wQ5L1hjs','nism-10a-v-EnX6njLT4zo','nism-10a-v-GhO_SJkxda0','nism-10a-v-IhMwnFbAWdw','nism-10a-v-ouv7CWoVNOI','nism-10a-v-AwJr5vyfg70','nism-10a-v-hJMWf5vp8Og','nism-10a-v-h3q0VNAFdAc','nism-10a-v-YxQfg1P4z10','nism-10a-v-MQi9ttXQJ3Q','nism-10a-v-NKVVhXhQyBA','nism-10a-v-9gRM8hN74yI','nism-10a-v-5Eqwi_ESoAE','nism-10a-v-8LAB3lcChQw','nism-10a-v-ZqZyb70IE4o','nism-10a-v-h0GEyzQ7zsU','nism-10a-v-O0g-rE2hVE0','nism-10a-v-gOf9qwZInEI','nism-10a-v-5tRh2H6u8iQ','nism-10a-v-c3SKDXioZl4','nism-10a-v-4UJ_QjLyF7s','nism-10a-v-zq_xr-_JQgk');
DELETE FROM quizzes WHERE course_id='nism-10a' AND id LIKE 'nism-10a-z%' AND id NOT IN ('nism-10a-z0','nism-10a-z1','nism-10a-z2','nism-10a-z3','nism-10a-z4','nism-10a-z5','nism-10a-z6','nism-10a-z7','nism-10a-z8','nism-10a-z9','nism-10a-z10','nism-10a-z11','nism-10a-z12','nism-10a-z13','nism-10a-z14','nism-10a-z15','nism-10a-z16','nism-10a-z17','nism-10a-z18','nism-10a-z19','nism-10a-z20');
DELETE FROM modules WHERE course_id='nism-10a' AND id LIKE 'nism-10a-m%' AND id NOT IN ('nism-10a-m0','nism-10a-m1','nism-10a-m2','nism-10a-m3','nism-10a-m4','nism-10a-m5');
DELETE FROM questions WHERE quiz_id='nism-10a-z0' AND sort >= 1259;
DELETE FROM questions WHERE quiz_id='nism-10a-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10a-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-10b' AND (id LIKE 'nism-10b-l%' OR id LIKE 'nism-10b-v-%') AND id NOT IN ('nism-10b-l0','nism-10b-l1','nism-10b-l2','nism-10b-v-fAQLjIaPsP0','nism-10b-v-h-TheQFziEQ','nism-10b-v-tACqZ1uhkik','nism-10b-v-HHidhHXUeig','nism-10b-v-fp9IGWddc8E','nism-10b-v-AyWIKFXIKQQ','nism-10b-v-4yXxYRZYNtI','nism-10b-v-f1hT6_CKKmw','nism-10b-v-yVmWJZ2lKUc','nism-10b-v-R7BlFyX0ITM','nism-10b-v-8LQiqbGsFEw','nism-10b-v-KiuvdAfJqBo','nism-10b-v-WbgwaIgcbR0','nism-10b-v-8SWqZVsmdco','nism-10b-v-6pF-bHXViJs','nism-10b-v-MizgXS16bV8','nism-10b-v-jTUoA9ukxzs','nism-10b-v-BxauZgPz_sE','nism-10b-v-crMoPmwE8-8','nism-10b-v-SImHjpxv944','nism-10b-v-AwJr5vyfg70','nism-10b-v-hJMWf5vp8Og','nism-10b-v-h3q0VNAFdAc','nism-10b-v-YxQfg1P4z10','nism-10b-v-MQi9ttXQJ3Q','nism-10b-v-NKVVhXhQyBA','nism-10b-v-9gRM8hN74yI','nism-10b-v-5Eqwi_ESoAE','nism-10b-v-8LAB3lcChQw','nism-10b-v-ZqZyb70IE4o','nism-10b-v-h0GEyzQ7zsU','nism-10b-v-O0g-rE2hVE0','nism-10b-v-gOf9qwZInEI','nism-10b-v-5tRh2H6u8iQ','nism-10b-v-c3SKDXioZl4','nism-10b-v-4UJ_QjLyF7s','nism-10b-v-zq_xr-_JQgk');
DELETE FROM quizzes WHERE course_id='nism-10b' AND id LIKE 'nism-10b-z%' AND id NOT IN ('nism-10b-z0','nism-10b-z1','nism-10b-z2','nism-10b-z3','nism-10b-z4','nism-10b-z5','nism-10b-z6','nism-10b-z7','nism-10b-z8','nism-10b-z9','nism-10b-z10','nism-10b-z11','nism-10b-z12','nism-10b-z13','nism-10b-z14','nism-10b-z15','nism-10b-z16','nism-10b-z17','nism-10b-z18','nism-10b-z19','nism-10b-z20');
DELETE FROM modules WHERE course_id='nism-10b' AND id LIKE 'nism-10b-m%' AND id NOT IN ('nism-10b-m0','nism-10b-m1','nism-10b-m2','nism-10b-m3','nism-10b-m4','nism-10b-m5');
DELETE FROM questions WHERE quiz_id='nism-10b-z0' AND sort >= 1071;
DELETE FROM questions WHERE quiz_id='nism-10b-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-10b-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-12' AND (id LIKE 'nism-12-l%' OR id LIKE 'nism-12-v-%') AND id NOT IN ('nism-12-v-HZXpRq9BUgQ','nism-12-v-nefw_hktnGU','nism-12-v-3PqfAhr3E6w','nism-12-v-jucvJIOOkA0','nism-12-v-yaECn6K8qg8','nism-12-v-x3SkFoWT4Wg','nism-12-v-n_mrcAJLMyw');
DELETE FROM quizzes WHERE course_id='nism-12' AND id LIKE 'nism-12-z%' AND id NOT IN ('nism-12-z0','nism-12-z1','nism-12-z2','nism-12-z3','nism-12-z4','nism-12-z5','nism-12-z6','nism-12-z7','nism-12-z8','nism-12-z9','nism-12-z10','nism-12-z11','nism-12-z12','nism-12-z13','nism-12-z14','nism-12-z15','nism-12-z16','nism-12-z17','nism-12-z18','nism-12-z19');
DELETE FROM modules WHERE course_id='nism-12' AND id LIKE 'nism-12-m%' AND id NOT IN ('nism-12-m0','nism-12-m1');
DELETE FROM questions WHERE quiz_id='nism-12-z0' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-12-z19' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-13' AND (id LIKE 'nism-13-l%' OR id LIKE 'nism-13-v-%') AND id NOT IN ('nism-13-v-khc3dJrW86s','nism-13-v-bgy_LtbwY8I','nism-13-v-rKqYpdu5tLo','nism-13-v-S8ZozoUDo8A','nism-13-v-2iNFwFxjCfM','nism-13-v-cuaUYsPUVMg','nism-13-v-qbnT174JlX8','nism-13-v-sS7OXJNjnSc','nism-13-v-LJQHFO8Q3ro','nism-13-v-2yr6Jk1O-Vo','nism-13-v-johE0agC8yU','nism-13-v-62Yo6_W_rTM','nism-13-v-ZaxbXR7xsiw','nism-13-v-I09oIf7HsOM','nism-13-v-Krbrl8Nmd28','nism-13-v-wiYyRJU1AkI','nism-13-v-Hvm0N4i1BsQ','nism-13-v-GmkWLp9y0Sg','nism-13-v-fUN4wkMVl0s','nism-13-v-kZpA5njbddo','nism-13-v-hJiJrOMZ2wQ','nism-13-v-65KDkfPeutI','nism-13-v-skqpBcbnj9k','nism-13-v-XDoikOtaAkQ','nism-13-v-5S-c7EzY-to','nism-13-v-J-BimlZpd6k','nism-13-v-d-pQmzYA2KE');
DELETE FROM quizzes WHERE course_id='nism-13' AND id LIKE 'nism-13-z%' AND id NOT IN ('nism-13-z0','nism-13-z1','nism-13-z2','nism-13-z3','nism-13-z4','nism-13-z5','nism-13-z6','nism-13-z7','nism-13-z8','nism-13-z9','nism-13-z10','nism-13-z11','nism-13-z12','nism-13-z13','nism-13-z14','nism-13-z15','nism-13-z16','nism-13-z17','nism-13-z18','nism-13-z19');
DELETE FROM modules WHERE course_id='nism-13' AND id LIKE 'nism-13-m%' AND id NOT IN ('nism-13-m0','nism-13-m1');
DELETE FROM questions WHERE quiz_id='nism-13-z0' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-13-z19' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-15' AND (id LIKE 'nism-15-l%' OR id LIKE 'nism-15-v-%') AND id NOT IN ('nism-15-l0','nism-15-l1','nism-15-l2','nism-15-v-nDLFlu1kB-0','nism-15-v-_ftzFfdOYn4','nism-15-v-BGbymD_8Dac','nism-15-v-USHOANaW1hU','nism-15-v-CuCVlF3QCVY','nism-15-v-rdCJHIapeCI','nism-15-v-omy_1bH-msM','nism-15-v-FINqggfOKHo','nism-15-v-lk6CvFAzdgY','nism-15-v--ELuz1I3sQ4','nism-15-v-wDA1_N8Ow8U','nism-15-v-DtrA0OcInmU','nism-15-v-KhQ9f-aliWI','nism-15-v-L9Zh0XMCAvg','nism-15-v-W2ednwxIXXs','nism-15-v-d9TywV4BAy4','nism-15-v-AXRvBaO6GU8','nism-15-v-OQ0cBxWcqZU','nism-15-v-SUKcp9OSmfU','nism-15-v-ciXadVyAZN8','nism-15-v-maD-cxqPpS8','nism-15-v-5mEduqDcAgc','nism-15-v-3OGmd18s1X0','nism-15-v-1QWeLtqGNgA','nism-15-v-9nnVWQS7bQU','nism-15-v-5qwzCNXsdgU','nism-15-v-s2TGNC6mhn4','nism-15-v-MmiwCgAvgtw','nism-15-v-nB3w1EWbygk','nism-15-v-wUrERJZtoX0','nism-15-v-ZR5JOeM8A88');
DELETE FROM quizzes WHERE course_id='nism-15' AND id LIKE 'nism-15-z%' AND id NOT IN ('nism-15-z0','nism-15-z1','nism-15-z2','nism-15-z3','nism-15-z4','nism-15-z5','nism-15-z6','nism-15-z7','nism-15-z8','nism-15-z9','nism-15-z10','nism-15-z11','nism-15-z12','nism-15-z13','nism-15-z14','nism-15-z15','nism-15-z16','nism-15-z17','nism-15-z18','nism-15-z19','nism-15-z20');
DELETE FROM modules WHERE course_id='nism-15' AND id LIKE 'nism-15-m%' AND id NOT IN ('nism-15-m0','nism-15-m1','nism-15-m2','nism-15-m3','nism-15-m4','nism-15-m5');
DELETE FROM questions WHERE quiz_id='nism-15-z0' AND sort >= 1286;
DELETE FROM questions WHERE quiz_id='nism-15-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-15-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-16' AND (id LIKE 'nism-16-l%' OR id LIKE 'nism-16-v-%') AND id NOT IN ('nism-16-v-F33f5_Xroyc','nism-16-v-k8yzyMnakEg','nism-16-v-rqZiLh2SFXM','nism-16-v-0KiwbOQ7gwc','nism-16-v-vf0lGFHJV3Y','nism-16-v-Xl9kvPKXJHw','nism-16-v-fjnblainhhA','nism-16-v-ELmJl_4az8E','nism-16-v-0qd-8XS2Dio','nism-16-v-Owtu7FO5Cb4','nism-16-v-XdgXH6-1aSc');
DELETE FROM quizzes WHERE course_id='nism-16' AND id LIKE 'nism-16-z%' AND id NOT IN ('nism-16-z0','nism-16-z1','nism-16-z2','nism-16-z3','nism-16-z4','nism-16-z5','nism-16-z6','nism-16-z7','nism-16-z8','nism-16-z9','nism-16-z10','nism-16-z11','nism-16-z12','nism-16-z13','nism-16-z14','nism-16-z15','nism-16-z16','nism-16-z17','nism-16-z18','nism-16-z19');
DELETE FROM modules WHERE course_id='nism-16' AND id LIKE 'nism-16-m%' AND id NOT IN ('nism-16-m0','nism-16-m1');
DELETE FROM questions WHERE quiz_id='nism-16-z0' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-16-z19' AND sort >= 100;
DELETE FROM lessons WHERE course_id='nism-21a' AND (id LIKE 'nism-21a-l%' OR id LIKE 'nism-21a-v-%') AND id NOT IN ('nism-21a-l0','nism-21a-l1','nism-21a-l2','nism-21a-v--lE26OfXVo4','nism-21a-v-WN3eX7R6DkY','nism-21a-v-mBTUEjV9sJs','nism-21a-v-n9MikOXiVSE','nism-21a-v--YtPaQeskOM','nism-21a-v-D99z8IXTJFQ','nism-21a-v--WiqMFDVqes','nism-21a-v-ud5rg3Z1Egk','nism-21a-v-d-5y3HcXafs','nism-21a-v-IPpXs2q4u9Y','nism-21a-v-JdV6zt_Ljug','nism-21a-v-Au_FDx6b0OI','nism-21a-v-HlNzjITAfik');
DELETE FROM quizzes WHERE course_id='nism-21a' AND id LIKE 'nism-21a-z%' AND id NOT IN ('nism-21a-z0','nism-21a-z1','nism-21a-z2','nism-21a-z3','nism-21a-z4','nism-21a-z5','nism-21a-z6','nism-21a-z7','nism-21a-z8','nism-21a-z9','nism-21a-z10','nism-21a-z11','nism-21a-z12','nism-21a-z13','nism-21a-z14','nism-21a-z15','nism-21a-z16','nism-21a-z17','nism-21a-z18','nism-21a-z19','nism-21a-z20');
DELETE FROM modules WHERE course_id='nism-21a' AND id LIKE 'nism-21a-m%' AND id NOT IN ('nism-21a-m0','nism-21a-m1','nism-21a-m2','nism-21a-m3','nism-21a-m4','nism-21a-m5');
DELETE FROM questions WHERE quiz_id='nism-21a-z0' AND sort >= 1512;
DELETE FROM questions WHERE quiz_id='nism-21a-z1' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z2' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z3' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z4' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z5' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z6' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z7' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z8' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z9' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z10' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z11' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z12' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z13' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z14' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z15' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z16' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z17' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z18' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z19' AND sort >= 100;
DELETE FROM questions WHERE quiz_id='nism-21a-z20' AND sort >= 100;
DELETE FROM lessons WHERE course_id='product-school' AND (id LIKE 'product-school-l%' OR id LIKE 'product-school-v-%') AND id NOT IN ('product-school-l0','product-school-l1','product-school-l2','product-school-l3');
DELETE FROM quizzes WHERE course_id='product-school' AND id LIKE 'product-school-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='product-school' AND id LIKE 'product-school-m%' AND id NOT IN ('product-school-m0','product-school-m1','product-school-m2');
DELETE FROM lessons WHERE course_id='objection-handling' AND (id LIKE 'objection-handling-l%' OR id LIKE 'objection-handling-v-%') AND id NOT IN ('objection-handling-l0','objection-handling-l1','objection-handling-l2','objection-handling-l3','objection-handling-v-aA6Br0wHKlE','objection-handling-v-qmnMyuqoO3Y','objection-handling-v-tBmkTwY-Id8','objection-handling-v-lAYGPXvBnj4','objection-handling-v-I4isQL4BBxc','objection-handling-v-K5l3HXrb2UI','objection-handling-v-2kk9ZhVnpbg','objection-handling-v-W7pgvTQJ4lI','objection-handling-v-pPrsJr9Wv4k','objection-handling-v-hGhFhFzdU60','objection-handling-v-zqTVv50K38U','objection-handling-v-BJGjTFnEIic','objection-handling-v-yjVNR32a6Fw','objection-handling-v-YLC-tRk2RYQ','objection-handling-v-CrZ24M64MwI','objection-handling-v-Rxfj7v-hgM0','objection-handling-v-fQfezsZmZgQ','objection-handling-v-MszlUu8Be2w','objection-handling-v-6g1TNLwK-iw','objection-handling-v-Oth_ALW2IGA','objection-handling-v-w-8PokDUB3E','objection-handling-v-BpOlIftdhic','objection-handling-v-CvhN9t5dv3o','objection-handling-v--uT2ntOA-DU','objection-handling-v-Yzhjg5a8R7k','objection-handling-v-unqj_uwmgXk','objection-handling-v-03UdKxgJziw','objection-handling-v-29oXwKCo84s','objection-handling-v-9Sjds6O0Uuw','objection-handling-v-GvVAAuGmIRY','objection-handling-v-2AwKBrvPY9E','objection-handling-v-bOAgt00OcKk','objection-handling-v-e0Mh4XdL8oo','objection-handling-v-AJ75vDNYPbE','objection-handling-v-2FF2KfYlL9c');
DELETE FROM quizzes WHERE course_id='objection-handling' AND id LIKE 'objection-handling-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='objection-handling' AND id LIKE 'objection-handling-m%' AND id NOT IN ('objection-handling-m0','objection-handling-m1','objection-handling-m2','objection-handling-m3','objection-handling-m4');
DELETE FROM lessons WHERE course_id='call-excellence' AND (id LIKE 'call-excellence-l%' OR id LIKE 'call-excellence-v-%') AND id NOT IN ('call-excellence-l0','call-excellence-l1','call-excellence-l2','call-excellence-v-9kNOwspGksw','call-excellence-v-3fuwPJfymI4','call-excellence-v-wfS5EJr_wZ8','call-excellence-v-wzXLVDiHYyg','call-excellence-v-bkPsq1lWiw0','call-excellence-v-OaM3XuRPLIg','call-excellence-v-_-LyGTe_ukQ','call-excellence-v-KuzPe-EFpco','call-excellence-v-Q_VUd749Cxg','call-excellence-v-7E2fEAYZ8_w','call-excellence-v-8j8QuB11Cus','call-excellence-v-3gvzjCx5tj4','call-excellence-v-cieyigxPC8U','call-excellence-v-DQaiTBiLSDU','call-excellence-v-_SQRzhW2bKw','call-excellence-v-pRojAcUjiRY','call-excellence-v-YEgytvNNlo0');
DELETE FROM quizzes WHERE course_id='call-excellence' AND id LIKE 'call-excellence-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='call-excellence' AND id LIKE 'call-excellence-m%' AND id NOT IN ('call-excellence-m0','call-excellence-m1');
DELETE FROM lessons WHERE course_id='customer-support' AND (id LIKE 'customer-support-l%' OR id LIKE 'customer-support-v-%') AND id NOT IN ('customer-support-l0','customer-support-l1','customer-support-l2','customer-support-l3','customer-support-v-oL-hSWGqHlU','customer-support-v-XY6lW5Gs-qs','customer-support-v-MVH1DymxyBc','customer-support-v-ZiKPH4w7hX0','customer-support-v-t_Lvba1maZ0','customer-support-v-b5J3f9vQ4tM','customer-support-v-07BlL5Ppj5U','customer-support-v-ABU_a_H8sL0','customer-support-v-eIj7KpobUzc','customer-support-v-Y6KK3HXcQ14','customer-support-v-2-3HnMsRPoY');
DELETE FROM quizzes WHERE course_id='customer-support' AND id LIKE 'customer-support-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='customer-support' AND id LIKE 'customer-support-m%' AND id NOT IN ('customer-support-m0','customer-support-m1','customer-support-m2','customer-support-m3','customer-support-m4','customer-support-m5');
DELETE FROM lessons WHERE course_id='zoho-crm' AND (id LIKE 'zoho-crm-l%' OR id LIKE 'zoho-crm-v-%') AND id NOT IN ('zoho-crm-l0','zoho-crm-l1','zoho-crm-l2','zoho-crm-l3','zoho-crm-v-UNYcJMRxZ1o','zoho-crm-v-iopxES5j_xU','zoho-crm-v-7J8ZnEtDEws','zoho-crm-v-1BiMCFBen64','zoho-crm-v-H00tOWyR2r8','zoho-crm-v-AUOBnlUB_ck','zoho-crm-v-BcAr6LneS1Q','zoho-crm-v-UU4dbelc0r0','zoho-crm-v-IUAy26BN4IQ','zoho-crm-v-69s_gKtb5Zg','zoho-crm-v-s8PPTFPNLbU','zoho-crm-v-CJtqyyYNOyU','zoho-crm-v-qii-rfD537k','zoho-crm-v-VU_At3TUpEw','zoho-crm-v-iEpSPctIklI');
DELETE FROM quizzes WHERE course_id='zoho-crm' AND id LIKE 'zoho-crm-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='zoho-crm' AND id LIKE 'zoho-crm-m%' AND id NOT IN ('zoho-crm-m0','zoho-crm-m1','zoho-crm-m2');
DELETE FROM lessons WHERE course_id='tata-tele' AND (id LIKE 'tata-tele-l%' OR id LIKE 'tata-tele-v-%') AND id NOT IN ('tata-tele-l0','tata-tele-l1','tata-tele-l2','tata-tele-l3','tata-tele-v-yT36kHHuzJA');
DELETE FROM quizzes WHERE course_id='tata-tele' AND id LIKE 'tata-tele-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='tata-tele' AND id LIKE 'tata-tele-m%' AND id NOT IN ('tata-tele-m0','tata-tele-m1');
DELETE FROM lessons WHERE course_id='process-mf-support' AND (id LIKE 'process-mf-support-l%' OR id LIKE 'process-mf-support-v-%') AND id NOT IN ('process-mf-support-l0','process-mf-support-l1','process-mf-support-l2','process-mf-support-l3','process-mf-support-l4','process-mf-support-l5','process-mf-support-l6','process-mf-support-l7','process-mf-support-l8','process-mf-support-l9','process-mf-support-l10','process-mf-support-l11','process-mf-support-l12','process-mf-support-l13','process-mf-support-l14','process-mf-support-l15','process-mf-support-l16','process-mf-support-l17','process-mf-support-l18','process-mf-support-l19','process-mf-support-l20','process-mf-support-l21','process-mf-support-l22','process-mf-support-l23','process-mf-support-l24','process-mf-support-l25','process-mf-support-l26','process-mf-support-l27','process-mf-support-l28','process-mf-support-l29','process-mf-support-l30','process-mf-support-l31','process-mf-support-l32');
DELETE FROM quizzes WHERE course_id='process-mf-support' AND id LIKE 'process-mf-support-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='process-mf-support' AND id LIKE 'process-mf-support-m%' AND id NOT IN ('process-mf-support-m0','process-mf-support-m1','process-mf-support-m2','process-mf-support-m3','process-mf-support-m4','process-mf-support-m5','process-mf-support-m6','process-mf-support-m7','process-mf-support-m8');
DELETE FROM lessons WHERE course_id='process-equity-support' AND (id LIKE 'process-equity-support-l%' OR id LIKE 'process-equity-support-v-%') AND id NOT IN ('process-equity-support-l0');
DELETE FROM quizzes WHERE course_id='process-equity-support' AND id LIKE 'process-equity-support-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='process-equity-support' AND id LIKE 'process-equity-support-m%' AND id NOT IN ('process-equity-support-m0');
DELETE FROM lessons WHERE course_id='markets-basics' AND (id LIKE 'markets-basics-l%' OR id LIKE 'markets-basics-v-%') AND id NOT IN ('markets-basics-l0');
DELETE FROM quizzes WHERE course_id='markets-basics' AND id LIKE 'markets-basics-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='markets-basics' AND id LIKE 'markets-basics-m%' AND id NOT IN ('markets-basics-m0');
DELETE FROM lessons WHERE course_id='compliance' AND (id LIKE 'compliance-l%' OR id LIKE 'compliance-v-%') AND id NOT IN ('compliance-l0');
DELETE FROM quizzes WHERE course_id='compliance' AND id LIKE 'compliance-z%' AND id NOT IN ('');
DELETE FROM modules WHERE course_id='compliance' AND id LIKE 'compliance-m%' AND id NOT IN ('compliance-m0');
DELETE FROM lessons WHERE kind='video' AND video_id IN ('CRVil9vTqKg','ja4hkcpawD4','TCmxOeX-1rg','myOvWky2aG8','nFK68w4kPVs','66Wdrypmghw','R1HMurUwVWY','12cK5xpUlgc','Vt-Df8vJH0w','s_IWoDNNeYw','pXVpROYVvRw','OS1cv0FlMiY','gm6VzrbGqxk','01EWj8iXZ4k','08bNDgdQAVI','fJXlNyxngaI','OFkDdPBX9fY','U-v9s7AiFDk','Hyp9N5MX5Xg','vHhYYgODvAM','HWHQ6CZfLz8','juwyOl0XqYo','y2UAucFqXYo','JhhClsWwHzc','EuHRVjN4aw8','lA4CqlXfhKg','LLc3M1yw_CQ','523qpN9_uFE','NFW12xPDzh8','2Yg1iSsqP8c','Y8JGvUnuuK0','H41X0hB2fd0','WTTKce9ozcQ','FTSlIMrlCpw','SesRohvqKnY','h-q-Qdqs2eE','3YvGjXuxyKg','ri1qOObg_as','I1t9BOzXPJ0','l3_DFwkpiWE','ystZSRlanc4','QTWTNnWCeMQ','kdwecji1ooU','cGQtAL0-m30','Iz6yfV-1Dvc','V4s1OPezxKM','dz_-XaqtpVo');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','nism-5a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','nism-5b' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5b');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','customer-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='customer-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','nism-5a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','nism-5b' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5b');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','nism-5d' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5d');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','objection-handling' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='objection-handling');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','nism-5a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','nism-5b' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5b');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','objection-handling' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='objection-handling');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','nism-5a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','nism-5d' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5d');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','nism-10a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-10a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','objection-handling' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='objection-handling');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','nism-5a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','nism-5d' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5d');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','nism-10a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-10a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','nism-10b' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-10b');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','nism-21a' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-21a');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','objection-handling' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='objection-handling');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','nism-7' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-7');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','nism-8' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-8');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','nism-12' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-12');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','customer-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='customer-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-7' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-7');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-8' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-8');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-12' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-12');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-13' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-13');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-15' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-15');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','nism-16' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-16');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','objection-handling' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='objection-handling');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','fi-academy' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='fi-academy');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','product-school' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='product-school');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','compliance' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='compliance');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','markets-basics' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='markets-basics');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','nism-5b' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='nism-5b');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','customer-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='customer-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','call-excellence' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='call-excellence');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','zoho-crm' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='zoho-crm');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','tata-tele' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='tata-tele');
INSERT OR IGNORE INTO settings (key,value) VALUES ('team_access_seeded','1');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Onboarding','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Digital','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Silver','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Gold','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'MF Platinum','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Onboarding','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Equity Regular','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','process-mf-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-mf-support');
INSERT OR IGNORE INTO team_access (team,course_id) SELECT 'Customer Support','process-equity-support' WHERE NOT EXISTS (SELECT 1 FROM settings WHERE key='team_access_process_seeded') AND EXISTS (SELECT 1 FROM courses WHERE id='process-equity-support');
INSERT OR IGNORE INTO settings (key,value) VALUES ('team_access_process_seeded','1');
INSERT INTO news (id,title,body,category,pinned,published) VALUES ('seed-news-0','Welcome to the FundsIndia Learning Hub','Your one place for NISM preparation, sales and service skills, and market updates. Check the Market Updates page daily.','Announcement',1,1) ON CONFLICT(id) DO UPDATE SET title=excluded.title,body=excluded.body,category=excluded.category,pinned=excluded.pinned,published=excluded.published WHERE news.title IS NOT excluded.title OR news.body IS NOT excluded.body OR news.category IS NOT excluded.category OR news.pinned IS NOT excluded.pinned OR news.published IS NOT excluded.published;
INSERT INTO news (id,title,body,category,pinned,published) VALUES ('seed-news-1','Reminder: keep your NISM V-A certificate valid','AMFI ARN holders must keep NISM V-A certification current. Check the validity on your certificate and re-certify in time.','Compliance',0,1) ON CONFLICT(id) DO UPDATE SET title=excluded.title,body=excluded.body,category=excluded.category,pinned=excluded.pinned,published=excluded.published WHERE news.title IS NOT excluded.title OR news.body IS NOT excluded.body OR news.category IS NOT excluded.category OR news.pinned IS NOT excluded.pinned OR news.published IS NOT excluded.published;
