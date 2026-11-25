// Customer-support process documents for FundsIndia (source: "Templates - New.docx").
// Each process lists the documents required, the steps, turnaround time, notes and the customer reply template.
// Placeholders in [square brackets] are filled in by the agent. build-seed.mjs turns this into course lessons.

export const SUPPORT_EMAIL = 'contact@fundsindia.com';
export const SUPPORT_ADDRESS = 'Wealth India Financial Services Pvt. Ltd.,\n3rd Floor, IndiQube Wave, No 438/1, T.R Sundaram Avenue,\nAnna Salai, Thousand Lights, Chennai - 600006,\nTamil Nadu, India.';

const RE_KYC_PATH = 'Login to FundsIndia website (www.fundsindia.com) > Profile icon > Re-KYC > Initiate Re-KYC > CAMS e-KYC page > Email and mobile number > PAN details > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > Address preview > Additional details > Live selfie > Wet signature > Preview form > e-Sign.';
const ADD_BANK = 'Login to the web portal > Profile icon (top right) > Bank details > Add another bank > Scan the QR code > pay ₹1 for verification (refunded within 24–48 hours).';

export const MF_MODULES = [
  {
    title: 'Bank details',
    blurb: 'Changing or adding a bank account and correcting IFSC details.',
    processes: [
      {
        title: 'Change of bank',
        summary: 'The investor wants to replace the bank registered in the fund house and FundsIndia records.',
        docs: [
          'Online route (net worth below ₹10 lakh): bank proof of the NEW bank – cancelled cheque or self-attested bank statement of the last 3 months',
          'Online route: proof of the OLD bank and the investor signature (all uploaded in the portal, confirmed with OTP)',
          'Offline route (net worth above ₹10 lakh): request letter downloaded from the portal, printed and signed',
          'Offline route: cancelled cheque leaf of the OLD bank with name and account number pre-printed',
          'Offline route: cancelled cheque leaf of the NEW bank with name and account number pre-printed',
        ],
        steps: [
          ADD_BANK,
          'Once the new bank is active, click **Change redemption bank**.',
          'Choose **Online** (net worth below ₹10 lakh): keep the bank proof ready > select the folios > submit proof of old bank, new bank and signature > confirm with OTP.',
          'Or choose **Offline** (net worth above ₹10 lakh): download the request letter > print, sign and email the scan with both cancelled cheque leaves.',
          'To map an existing SIP to the new mandate, the investor replies with the mandate number; the SIP is mapped and auto-debit starts as per the SIP date once the mandate is approved.',
        ],
        tat: 'Online: 3–5 business days. Offline: 10 business days at folio level. (An earlier version of this template quoted 15 business days for the offline route – confirm the current TAT with the operations team.)',
        notes: [
          'Ask the investor not to place new investments or redemptions until the bank is changed at the fund house and in FundsIndia records. Pause any SIP until the update is complete.',
          'Documents must be clear scans, emailed to the support mailbox.',
        ],
        sendTo: 'email',
        template: `Dear [Investor name],
Greetings from FundsIndia!

In response to your e-mail, a change of bank procedure needs to be followed to update the bank details in the fund house and FundsIndia records.

Login to the web portal > click on the profile icon (top right corner) > Bank details > Add another bank > scan the QR code. A payment of ₹1 is required for verification and will be refunded within 24–48 hours.

Once the bank is activated, click on "Change redemption bank" and select Online or Offline mode.

Online (net worth below 10 lakhs): keep a bank proof available (cancelled cheque or self-attested statement of the last 3 months) > select the folios > submit proof of old bank, new bank and signature > confirm with OTP. It may take 3–5 business days to update the details.

Offline (net worth more than 10 lakhs): download the request letter > print, sign and send the scanned copy along with the old bank's and new bank's cancelled cheque leaf with the name and account number pre-printed. It takes 10 business days to update the bank details at the folio level.

Kindly do not make any new investments or redemptions until your bank is changed in the fund house and FundsIndia records.

Please share the clear scanned documents to contact@fundsindia.com. Upon receipt, we will do the needful.
Please contact us for further assistance.`,
      },
      {
        title: 'Change of bank - old bank proof not available',
        summary: 'The investor cannot provide a cancelled cheque of the old bank.',
        docs: [
          'Coloured bank statement of the old bank, self-attested; OR a closure letter attested by the banker (with employee name, employee code, designation, signature and bank seal)',
          'IPV form (attached by the agent) together with a self-attested PAN copy – required by fund houses such as DSP and Kotak to process the change without the old bank cheque',
          'Bank statement attested by the investor (for the IPV route)',
        ],
        steps: [
          'Explain that the old-bank cheque is the normal proof and that these alternatives are accepted instead.',
          'Attach the IPV form to the reply and ask for the scanned documents.',
        ],
        tat: 'Same as the normal change of bank process.',
        notes: ['Banker attestation must show name, employee code, designation, signature and bank seal.'],
        sendTo: 'email',
        template: `If the cheque proof of the old bank is not available, kindly submit a coloured bank statement with self-attestation, or a closure letter attested by the banker with the employee name, employee code, designation, signature and bank seal.

Fund houses like DSP and Kotak require an IPV letter along with a self-attested PAN copy to process a change of bank request without the old bank cheque. Please share the attached IPV form along with your self-attested PAN card and bank statement with your attestation.`,
      },
      {
        title: 'Change of bank - new bank proof not available',
        summary: 'The investor cannot provide a cancelled cheque of the new bank.',
        docs: ['Self-attested coloured bank statement of the new bank, attested by the banker with employee name, employee code, designation, signature and bank seal'],
        steps: ['Ask for the attested statement in place of the cancelled cheque; all other documents stay the same.'],
        tat: 'Same as the normal change of bank process.',
        notes: [],
        sendTo: 'email',
        template: `If the cancelled cheque of the new bank is not available, please share a self-attested coloured bank statement attested by the banker with the employee name, employee code, designation, signature and bank seal.`,
      },
      {
        title: 'Second bank activation',
        summary: 'The investor wants to add and activate another bank account.',
        docs: ['No documents – fully online. A ₹1 verification payment (refunded within 24–48 hours).'],
        steps: [ADD_BANK],
        tat: 'Activation is online once the ₹1 verification succeeds; refund in 24–48 hours.',
        notes: [],
        sendTo: '',
        template: `Login to the web portal > click on the profile icon (top right corner) > Bank details > Add another bank > scan the QR code. A payment of ₹1 is required for verification and will be refunded within 24–48 hours.`,
      },
      {
        title: 'Change of IFSC',
        summary: 'The bank has changed its IFSC code and the folio needs the new one.',
        docs: ['IFSC change request form (attached by the agent), filled and signed', 'Cheque of the bank with name and account number pre-printed'],
        steps: ['Send the IFSC change request form to the investor.', 'Investor fills it and returns a clear scan with the cheque to the support mailbox.'],
        tat: 'The fund house takes 10–15 business days to update the details.',
        notes: [],
        sendTo: 'email',
        template: `Please fill in and share the attached IFSC change request along with a cheque of the bank with the name and account number pre-printed.

Kindly share the clear scanned copy to contact@fundsindia.com. The fund house takes 10–15 business days to update the details.`,
      },
    ],
  },
  {
    title: 'Contact details, address & KYC',
    blurb: 'Updating mobile, e-mail, address and KYC status.',
    processes: [
      {
        title: 'Change of contact details (mobile / e-mail)',
        summary: 'The investor wants to change the mobile number or e-mail ID linked to the folios.',
        docs: [
          'Online route: none – OTP is sent to the existing e-mail / mobile',
          'Offline route (no access to old contact details): Contact change form (CAMS and KARVY), filled and signed – e-mail ID written in CAPITAL LETTERS in the declaration',
          'Re-KYC (for KYC records): completed online, no paper documents',
        ],
        steps: [
          'Login to the FundsIndia website > Manage Investor > "You can update contact details linked to existing folio\'s here" > choose mobile number or e-mail ID > select the details to change > Continue > enter the new e-mail / mobile > select the relationship > OTP goes to the existing e-mail / mobile > verify.',
          'If the investor has no access to the old contact details, use the offline route: send the CAMS / KARVY contact change form.',
          'Then update the KYC records through Re-KYC (see the Re-KYC process).',
        ],
        tat: 'Offline: 8–10 business days at fund-house level. Re-KYC: 3–5 business days; the Re-KYC option is enabled in the account in T+2 business days.',
        notes: ['Fill the e-mail ID in CAPITAL letters in the declaration form.', 'If the investor hits an error, ask for a screen recording of the error.'],
        sendTo: 'email',
        template: `Dear [Investor name],
Greetings from FundsIndia!

Please follow the procedure below to update the contact details online:
Login to the FundsIndia website > Manage Investor > "You can update contact details linked to existing folio's here" > choose to update mobile number or e-mail ID > select the details you wish to change > Continue > enter your new e-mail ID or mobile number > select the relationship > an OTP will be sent to your existing e-mail ID or mobile number > verify.

If you do not have access to your existing contact details for OTP verification, please use the offline process: fill and sign the contact change form (CAMS and KARVY, attached) and share a clear scanned copy to contact@fundsindia.com. Kindly write the e-mail ID in CAPITAL letters in the declaration form. It takes 8–10 business days to update the new contact details at fund-house level.

To update the contact details in KYC, please complete Re-KYC on the FundsIndia website (Profile icon > Re-KYC). It will be updated within 3–5 business days.
In case of any issue or error, please share a screen recording of the error so that we can assist you further.`,
      },
      {
        title: 'Re-KYC (online pathway)',
        summary: 'Used to update contact details, address or other details in the KYC record.',
        docs: ['No paper documents – done online with Aadhaar, DigiLocker, live selfie and e-sign'],
        steps: [
          RE_KYC_PATH,
          'Once KYC is validated, the FundsIndia account is enabled for investments.',
          'For accounts activated on Aadhaar (Aadhaar to ON) the pathway is shorter: Initiate Re-KYC > Email and mobile number > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > Wet signature > Preview form > e-Sign.',
        ],
        tat: '3–5 business days after the investor submits. The Re-KYC option appears in the account in T+2 business days.',
        notes: ['In case of any issue or error, ask the investor to share a screen recording of the error.'],
        sendTo: '',
        template: `To update the details in KYC, please login to the FundsIndia website (www.fundsindia.com) and follow this pathway:
Profile icon > Re-KYC > Initiate Re-KYC > redirect to the CAMS e-KYC page > e-mail and mobile number > PAN details > DigiLocker screen > Aadhaar number > OTP > DigiLocker PIN > address preview > additional details > live selfie > wet signature > preview form > e-Sign.

It will be updated within 3–5 business days. Once the KYC is validated, your FundsIndia account will be enabled for investments.
In case of any issue or error, please share a screen recording of the error so that we can assist you further.`,
      },
      {
        title: 'Address updation',
        summary: 'The investor wants to change or correct the address.',
        docs: ['No paper documents – completed through Re-KYC. The address must match Aadhaar.'],
        steps: [
          RE_KYC_PATH,
          'Once the address is changed / corrected in the KYC records, it is changed in the mutual fund folios.',
        ],
        tat: '3–5 business days for KYC, then the mutual fund records are updated.',
        notes: ['As per the new SEBI guidelines, a Resident Indian investor can update the address only as per Aadhaar.'],
        sendTo: '',
        template: `To update the address in KYC, please login to the FundsIndia website and complete Re-KYC: Profile icon > Re-KYC > Initiate Re-KYC > ... > Preview form > e-Sign.
It will be updated within 3–5 business days. Once the address is changed in the KYC records, it will be changed in your mutual fund folios.
Please note: as per the new SEBI guidelines, a Resident Indian investor can update the address only as per Aadhaar.`,
      },
      {
        title: 'Full activation (Aadhaar to ON)',
        summary: 'The account was activated on Aadhaar, so FundsIndia holds no signature record; changes need full activation first.',
        docs: [
          'Duly signed investor account opening form (PFA)',
          'PAN copy, self-attested',
          'Original cancelled cheque of the registered bank with the name printed on it',
        ],
        steps: ['Ask for the three documents as clear scans.', 'After receipt, the account is fully activated; then the investor completes Re-KYC if contact details need validating.'],
        tat: 'Re-KYC takes 3–5 business days; the account is enabled for investment once KYC is validated.',
        notes: [],
        sendTo: 'email',
        template: `Your account is activated based on your Aadhaar, hence we do not hold your signature records. Any change in your account can be made only if you fully activate your account. Please share scanned copies, duly signed, of:
1. Investor account opening form (PFA), duly signed
2. PAN copy, self-attested
3. Original cancelled cheque of the registered bank with your name printed on it

Please share the clear scanned documents to contact@fundsindia.com. Upon receipt, we will do the needful.`,
      },
    ],
  },
  {
    title: 'Nominee, folios & transfers',
    blurb: 'Nomination, merging folios and bringing existing mutual funds to FundsIndia.',
    processes: [
      {
        title: 'Nominee',
        summary: 'The investor wants to add or change nominees.',
        docs: ['No documents – online with OTP'],
        steps: [
          'Up to 3 nominees can be added.',
          'Login to the FundsIndia account > Profile icon (top right) > Manage Nominees > new and all folios > Change nomination > fill the details > Update > enter the OTP > Submit.',
          'The OTP goes to the investor\'s registered e-mail and mobile number. The update applies to all new folios created in the account.',
        ],
        tat: 'Online; applied to new folios created afterwards.',
        notes: [],
        sendTo: '',
        template: `You can add up to 3 nominees for your folios. To update the nominee for new and all folios:
Login to your FundsIndia account > click on the profile icon (top right corner) > Manage Nominees > new and all folios > Change nomination > fill in the details > Update > enter the OTP > Submit.
The OTP is sent to your registered e-mail address and mobile number. Upon submission, the nominee update will apply to all new folios created in your account.`,
      },
      {
        title: 'Consolidation of folios',
        summary: 'The investor wants several folios of the same fund house merged into one.',
        docs: ['Consolidation of folios request form (attached by the agent) – filled, printed, signed and scanned'],
        steps: [
          'Check the conditions below before sending the form.',
          'Send the consolidation format; the investor returns a clear scan to the support mailbox.',
          'Keep the folio with the active SIP as the target folio.',
        ],
        tat: '10–15 business days at the fund house. The investor is informed of any discrepancy in the document.',
        notes: [
          'Mode of holding must be the same in all folios.',
          'Nominee must be the same in all folios.',
          'Bank accounts must be the same in all folios.',
          'If an SIP is registered in any folio, that folio must be the target folio.',
        ],
        sendTo: 'email',
        template: `Greetings from FundsIndia.
With reference to your mail, folios can be merged into one by providing a consolidation of folios request. Please fill in, print, sign and send the scanned copy of the attached format.

Conditions for consolidation of folios:
• Mode of holding should be the same in all folios
• Nominee should be the same in all folios
• Bank accounts should be the same in all folios
• If an SIP is registered in any of the folios, that folio should be the target folio

Kindly share clear scanned documents to contact@fundsindia.com. The consolidation takes 10–15 business days at the fund house. We will inform you if there is any discrepancy in the document.`,
      },
      {
        title: 'Easy Transfer (bring existing mutual funds to FundsIndia)',
        summary: 'The investor holds mutual funds elsewhere and wants them moved to the FundsIndia account.',
        docs: [
          'Transfer request letter – generated in the portal (Downloads section), printed, signed and scanned',
          'Cancelled cheque of the bank registered in the folio – only if it differs from the bank in the FundsIndia account',
          'Direct plans: switch request form (sent to the FundsIndia address)',
        ],
        steps: [
          'Log in to the web portal > Mutual funds > More > Bring in existing MF holdings > Register Easy transfer > Next > select the AMC, search and select the scheme, investor name, held individually or jointly > enter the folio number > Add > Submit.',
          'If the folio shows under external portfolio: Mutual Funds > External Transfer via eCAS > More > Fetch the latest external funds > select funds for transfer > Transfer Fund > download the letter > sign > upload it (Status tab). FundsIndia processes the rest.',
          'Where the registered folio bank differs, the investor sends the cancelled cheque of that bank; the bank in FundsIndia records is updated while converting to online mode.',
        ],
        tat: 'Processed after the signed letter and documents are received.',
        notes: [
          'A zero-balance folio cannot be transferred.',
          'Direct plans can be moved to FundsIndia with a switch request form.',
          'A demat-held fund cannot be transferred; the investor contacts the DP for a rematerialisation request to convert it to a normal folio.',
          'For a joint holding, the other holder must also be a registered FundsIndia investor.',
          'For a folio with an active SIP, advise the investor to stop the SIP, transfer the folio, then restart the SIP.',
        ],
        sendTo: 'both',
        template: `Please follow this pathway to move your existing mutual funds to FundsIndia:
Log onto your FundsIndia account (web portal) > Mutual funds > More > Bring in existing MF holdings > Register Easy transfer > Next > select the AMC, search and select the scheme and investor name, specify whether the investment is held individually or jointly, enter the folio number > Add > Submit.

If the folio is reflecting in external portfolio: Mutual Funds > External Transfer via eCAS > More > Fetch the latest external funds > select funds for transfer > Transfer Fund > download the letter > sign the letter > upload the letter (Status tab). FundsIndia will process the rest.

The request letter is generated in the Downloads section of your account. Please print, sign and send us the scanned copy. If the bank registered in the folio is different from the bank in your FundsIndia account, please send a cancelled cheque of the bank registered in the folio.

Notes:
• A zero balance folio is not accepted for transfer.
• Direct plans can be moved to FundsIndia by giving a switch request form.
• A demat account cannot be transferred; contact your DP to submit a rematerialisation form to convert it to a normal folio.
• For a joint holding, the other person must also be a registered FundsIndia investor.
• For a folio with an active SIP, we recommend stopping the SIP, transferring the folio and then restarting it.`,
      },
    ],
  },
  {
    title: 'Status change: RI, NRI & minor',
    blurb: 'Changing tax / residential status or converting a minor account to major.',
    processes: [
      {
        title: 'RI to NRI',
        summary: 'A Resident Indian account must be changed to NRI when the investor stays abroad more than 185 days.',
        docs: [
          'KYC change form (attached) – photograph pasted and signed across it (name as per the Income Tax database)',
          'PAN copy, self-attested',
          'Foreign address proof, self-attested, in English (driving licence, latest gas bill, bank statement with recent transactions or utility bill). Indian address proof as well if the Indian address is also filled in',
          'Cancelled cheque leaf of the old bank (savings) and of the new NRO bank – name, account number and account type shown; old-bank proof only if the bank is changing',
          'Passport copy, self-attested',
          'Signed status change request letter (residency status and bank account details)',
          'Declaration forms for contact updation in folios – only if contact details are also changing',
          'FATCA form, filled and signed (fill both correspondence and permanent address in the KYC form)',
        ],
        steps: [
          'Share the document list and the Income Tax name-check link: https://eportal.incometax.gov.in/iec/foservices/#/pre-login/knowYourAO',
          'After receipt, documents are verified; then an e-IPV (online verification by video call) is scheduled between 10 AM–1 PM and 2 PM–6 PM IST. The investor shows all submitted documents in original.',
          'NRO bank: existing investments move from RI to NRI tax status. NRE bank: existing investments cannot be changed to NRE – the investor either redeems everything or moves holdings offline so NRI requests can run with NRE bank details.',
        ],
        tat: 'On document verification and e-IPV; fund-house update follows.',
        notes: [
          'Once the tax status changes, the existing mandate is deleted and the SIP is deactivated; the investor re-registers the SIP.',
          'Once investments are moved offline, online transactions are not possible; redemptions are by physical request to the fund house.',
          'The OTP is not sent to an overseas number for transactions.',
        ],
        sendTo: 'email',
        template: `We notice that your FundsIndia account is registered as an RI (Resident Indian) account. Changing your status from RI to NRI is essential (if your stay abroad is more than 185 days) to keep your investment records and taxation correct. We request you to submit:
1. KYC change form (attached – paste your photo and sign across). Name as per the Income Tax database: https://eportal.incometax.gov.in/iec/foservices/#/pre-login/knowYourAO
2. Self-attested PAN copy
3. Self-attested foreign address proof (driving licence, latest gas bill, bank statement with recent transactions or utility bill, in English). Share Indian address proof as well if you fill the Indian address.
4. Cancelled cheque leaf of the old bank (savings) and new bank (Savings-NRO) with name, account number and bank type; old bank proof only if you are changing the bank account
5. Self-attested passport copy
6. Signed status change request letter (residency status and bank account details)
7. Declaration forms for contact updation (only if you wish to update contact details)
8. FATCA form duly filled and signed (fill both correspondence and permanent address in the KYC form)

If you update the NRO bank account, existing investments move from RI to NRI tax status. If you update the NRE bank account, existing investments cannot be changed to NRE – please redeem all investments or move them offline to process NRI requests with NRE bank details. Once investments are offline, online transactions cannot be done; redemptions need a physical request to the fund house.

Please share clear scanned documents to contact@fundsindia.com. After verification we will schedule an e-IPV (video call) between 10 AM–1 PM and 2 PM–6 PM IST, where you must show all submitted documents in original. When the tax status changes, the existing mandate is deleted and the SIP is deactivated; you can re-register it afterwards.`,
      },
      {
        title: 'NRI to RI',
        summary: 'The investor has returned to India and the status must change from NRI to Resident Indian.',
        docs: [
          'KYC form – photograph affixed with signature across it (enclosed)',
          'PAN copy, self-attested',
          'Indian address proof, self-attested (Aadhaar must contain the QR code and a masked Aadhaar number)',
          'Original cancelled cheque leaf of the savings bank account with the name printed on it',
          'Original cancelled cheque leaf of the old bank (NRO or NRE registered in FundsIndia) with the name printed on it',
          'Tax status change request, signed (enclosed)',
          'FATCA forms (enclosed)',
          'Passport copy, self-attested',
          'CAMS and KARVY declaration form (enclosed)',
        ],
        steps: [
          'Send the forms attached below your signature.',
          'e-Aadhaar can be downloaded from https://eaadhaar.uidai.gov.in/genricDownloadAadhaar (Aadhaar number, captcha, OTP to the mobile).',
          'If the account has active investments, ask for e-mail confirmation to move them offline first – the fund house does not accept a tax-status change with investments. Folios return online after the change is complete.',
        ],
        tat: 'On receipt of all documents; fund-house update follows.',
        notes: [
          'Offline folios cannot transact further; redemption is by physical request to the fund house.',
          'Without investment confirmation to move offline, the request cannot be processed.',
        ],
        sendTo: 'both',
        template: `Changing your investment status from NRI to RI is essential to keep your investment records and taxation correct. To change your status, please share:
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

With active investments we cannot process the change of tax status, as the fund house does not accept it. Please give us e-mail confirmation to move the existing investments offline; we will then process the change. Offline folios move back online after the tax status is changed. Once folios are offline you cannot make further transactions; you can redeem them by a physical redemption request to the fund house.`,
      },
      {
        title: 'Minor to Major',
        summary: 'The investor has turned 18 and the minor folio must be converted to a major account.',
        docs: [
          'Request letter from the investor',
          'Investor account opening form, duly filled and signed',
          'Bank details in the name of the major, with the new signature attested by the bank manager',
          'Cheque copy pre-printed with the name and account number of the major',
          'PAN copy in the name of the major, self-attested',
          'KYC application form',
          'Attested copy of date of birth proof',
          'Address proof, self-attested',
          'FATCA form',
          'Nominee form (AMC-wise)',
        ],
        steps: ['Send the list; the investor couriers the documents to the FundsIndia address.'],
        tat: 'On receipt of the documents.',
        notes: [],
        sendTo: 'address',
        template: `To convert the minor account to major, please send the following documents to the address below:
• Request letter from the investor
• Investor account opening form, duly filled and signed
• Bank details in the name of the major along with the new signature attested by the bank manager
• Cheque copy pre-printed in the name and account number of the major
• PAN copy in the name of the major, self-attested
• KYC application form
• Attested copy of date of birth proof
• Address proof, self-attested
• FATCA form
• Nominee form (AMC-wise)`,
      },
    ],
  },
  {
    title: 'Name & signature changes',
    blurb: 'Name change after marriage / divorce, voluntary change, correction, and signature updates.',
    processes: [
      {
        title: 'Name change - marriage / divorce',
        summary: 'The investor\'s name has changed after marriage or divorce.',
        docs: [
          'Name change request letter – signed; a separate request for each AMC (format attached)',
          'KYC form – photograph affixed with signature across it',
          'Marriage / divorce certificate – original notary-attested copy, also self-attested',
          'PAN copy in the new name, self-attested',
          'Address proof in the new name, self-attested',
          'Bank details in the new name with the new signature attested by the registered banker (bank seal, employee number, employee name, designation)',
          'Request letter for new signature updation showing old and new signature (if required)',
          'Cancelled cheque leaf of the registered bank account with name and account number pre-printed',
        ],
        steps: ['Send the list and the AMC-wise request format; the investor couriers the documents.'],
        tat: 'KYC level: 15–20 business days; then fund house: 10–15 business days. E-mail intimation is sent if there is any discrepancy.',
        notes: [],
        sendTo: 'address',
        template: `For a name change after marriage / divorce, please send the following documents to the address below:
• Name change request letter, duly signed (a separate request for each AMC – format attached)
• KYC form (photograph affixed with signature across it)
• Marriage / divorce certificate – originally attested by a notary public and self-attested
• PAN copy in the new name, self-attested
• Address proof in the new name, self-attested
• Bank details in the new name along with the new signature attested by the registered banker with bank seal, employee number, employee name and designation
• Request letter for new signature updation with old and new signature (if required)
• Cancelled cheque leaf of the registered bank account with name and account number pre-printed

The name change is processed at the KYC level, which takes 15–20 business days. Once the name is updated in KYC we process the request with the fund house, which takes a further 10–15 business days. We will e-mail you if there is any discrepancy.`,
      },
      {
        title: 'Name change - voluntary',
        summary: 'The investor has legally changed the name by choice (not marriage / divorce).',
        docs: [
          'Name change request letter for each fund house (attached – one per fund house)',
          'Name change request letter for FundsIndia (attached)',
          'KYC change form (attached) – passport-size photograph with cross signature',
          'PAN copy with the new name, self-attested',
          'Cancelled cheque leaf with the new name and account number pre-printed',
          'Address proof with the new name, self-attested',
          'Gazette notification, notary-attested original and self-attested',
          'Affidavit on ₹200 stamp paper – only for SBI',
          'If the signature also changes: CKYC signature update form (attested by the banker with manager name, designation, employee code, signature and seal), banker verification letter (same attestation), and signature update letter',
        ],
        steps: ['Send the list and attached formats; the investor couriers the documents.'],
        tat: 'KYC level: 15–20 business days; then fund house: 10–15 business days.',
        notes: [],
        sendTo: 'address',
        template: `For a voluntary name change, please send the following documents to the address below:
1. Name change request letter for each fund house (attached – one for each fund house)
2. Name change request letter for FundsIndia (attached)
3. KYC change form (attached) with a passport-size photograph and cross signature
4. PAN copy with the new name, self-attested
5. Cancelled cheque leaf with the new name and account number pre-printed
6. Address proof with the new name, self-attested
7. Gazette notification, notary-attested original and self-attested
8. Affidavit on ₹200 stamp paper (only for SBI)

If the signature is also changing: (1) CKYC signature update form, (2) banker verification letter – both attested by the banker with manager name, designation, employee code, signature and bank seal, and (3) signature update letter (attached).

The name change is processed at the KYC level (15–20 business days); then the request goes to the fund house (10–15 business days). We will e-mail you if there is any discrepancy.`,
      },
      {
        title: 'Name correction',
        summary: 'The name is recorded wrongly (spelling / format) and must be corrected.',
        docs: [
          'Name change request letter for each fund house (attached – one per fund house)',
          'Name change request letter for FundsIndia (attached)',
          'Document with the correct name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)',
          'Cancelled cheque leaf with the corrected name, existing bank and account number – name and account number pre-printed',
          'To change the name in KYC: KYC form (attached), filled and signed, with self-attested PAN',
        ],
        steps: ['Send the list and attached formats.'],
        tat: 'KYC level then fund house, as for name change.',
        notes: [],
        sendTo: 'address',
        template: `For a name correction, please share:
• Name change request letter for each fund house (attached – one for each fund house)
• Name change request letter for FundsIndia (attached)
• A document with the correct name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
• Cancelled cheque leaf with the corrected name, with the existing bank and account number and your name pre-printed
• To correct the name in KYC: the attached KYC form, duly filled and signed, with a self-attested PAN`,
      },
      {
        title: 'Removal or addition of father\'s name',
        summary: 'The father\'s name must be added to or removed from the records.',
        docs: [
          'Name change request letter (as per the IT site) for each fund house (attached – one per fund house)',
          'Name change request letter for FundsIndia (attached)',
          'Document with the new name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)',
          'Cancelled cheque leaf with the corrected name, existing bank and account number pre-printed',
        ],
        steps: ['First check the name in KYC and on the Income Tax site. Only if the new name is already updated in those records, ask for the documents.'],
        tat: 'KYC level then fund house, as for name change.',
        notes: ['The name must already match KYC and the IT site before the request is raised.'],
        sendTo: 'address',
        template: `We have checked the name in KYC and on the IT site. Since the new name is updated in those records, please share:
• Name change request letter (as per the IT site) for each fund house (attached – one for each fund house)
• Name change request letter for FundsIndia (attached)
• A document with the new name and registered address (Aadhaar, Voter ID, ration card, passport or driving licence)
• Cancelled cheque leaf with the corrected name, with the existing bank and account number pre-printed`,
      },
      {
        title: 'Signature updation',
        summary: 'The investor wants to update the signature on record.',
        docs: [
          'Signature updation form, duly signed',
          'Signature verification form with the banker\'s attestation (bank manager\'s name, designation, employee code, seal and signature)',
        ],
        steps: ['Send the forms and ask for the attested copies.'],
        tat: 'On receipt of the documents.',
        notes: ['For DSP, Kotak and Nippon the investor must visit the fund house directly.'],
        sendTo: 'email',
        template: `Please share the signature updation form, duly signed, and the signature verification form with the banker's attestation (the attestation should carry the bank manager's name, designation, employee code, seal and signature).
Please note: for DSP, Kotak and Nippon the investor has to visit the fund house directly.`,
      },
    ],
  },
  {
    title: 'Account closure',
    blurb: 'Handling requests to close the FundsIndia account.',
    processes: [
      {
        title: 'Account closure',
        summary: 'The investor asks to close the FundsIndia account.',
        docs: ['No documents – there is no closure form. The account is free for life with no maintenance fee.'],
        steps: [
          'Explain the value of staying: aggregation across AMCs and one point of service; unbiased expert advisory; portfolio design and review online at any time; value-added services; aggregation of investment products and of family investments; access on computer, mobile and tablet; all free with no account or transaction charges.',
          'If the investor still wants to close: an account with active investments cannot be closed – they must redeem or move out all folios.',
          'Once all units are redeemed or moved out, the account status becomes INACTIVE by default. It becomes active again when they invest in future.',
        ],
        tat: 'Status becomes INACTIVE automatically once there are no active investments.',
        notes: ['No deactivation procedure is needed.'],
        sendTo: '',
        template: `Your account with FundsIndia is free, and the advantages of a good value-adding distributor like FundsIndia are many:
• Aggregation across AMCs and a convenient single point of service
• Unbiased, expert advisory services
• Anytime portfolio design and review available online
• Numerous value-added services
• Aggregation of investment products, and of family investments in one place
• Multi-platform access – computer, mobile and tablet
• All of this FREE, without any account or transaction charges, along with great customer support.

If you are still interested in closing your account: an account with active investments cannot be closed – you need to redeem your investments. Once you move out your folios / redeem all units from your FundsIndia portfolio, your account status will be INACTIVE by default. Since your account is a lifetime FREE account with no transaction or maintenance fees, there is no deactivation procedure to follow. If you invest again in future, your account will become active again.`,
      },
      {
        title: 'Account closure - no active investments',
        summary: 'The investor asks to close the account but holds no investments.',
        docs: ['No documents'],
        steps: ['Confirm there are no active investments; reply that the status is already INACTIVE.'],
        tat: 'Immediate.',
        notes: [],
        sendTo: '',
        template: `In reference to your e-mail, we noticed that your FundsIndia account does not have any active investments, so your mutual fund account status is INACTIVE by default.
Please contact us for further assistance.`,
      },
    ],
  },
  {
    title: 'Purchases & redemptions',
    blurb: 'Purchase status, failed payments, redemptions and payout delays.',
    processes: [
      {
        title: 'Purchase related',
        summary: 'The investor asks for the status of a purchase.',
        docs: ['No documents. Paste the transaction details (date, amount, scheme) into the reply.'],
        steps: ['Check the transaction and confirm it has been sent to the fund house; paste the details.'],
        tat: 'Reflects in the account when the fund house sends the feed; units are allotted at the applicable NAV.',
        notes: [],
        sendTo: '',
        template: `Greetings from FundsIndia!
The purchase transaction below has been sent to the fund house for processing:
[Paste transaction details – date / amount / scheme]

The units will be processed at the applicable NAV (unit realisation). The transaction will reflect in your FundsIndia account once we receive the feed from the respective fund house. You will receive an e-mail confirmation from FundsIndia, and the account statement directly from the fund house, once the transaction is processed.`,
      },
      {
        title: 'Payment not received',
        summary: 'The purchase shows "Payment not received" although the investor says money was debited.',
        docs: ['Latest bank statement – only if the refund is not received in time (proof that the amount has not been credited back)', 'Screenshot of the transaction status (agent pastes into the reply)'],
        steps: [
          'Paste the screenshot of the "Payment not received" status.',
          'If debited but failed at the payment gateway, the amount is refunded within 3–4 working days of the transaction (net-banking cases: 2–5 business days).',
          'If not refunded, ask for the bank statement and escalate.',
          'To find NEFT / RTGS / IMPS details: Login > Mutual Funds > Invest > Lumpsum > Add scheme > select the amount > Confirm > click NEFT / RTGS / IMPS to see the virtual account number.',
        ],
        tat: 'Refund: 3–4 working days (gateway errors) / 2–5 business days (net-banking).',
        notes: [
          'Fund realisation rule: effective 1 February 2021, the applicable NAV for a purchase depends on realisation and availability of the funds in the mutual fund\'s bank account before the cut-off, irrespective of the amount, under all schemes.',
        ],
        sendTo: 'email',
        template: `Greetings from FundsIndia!
At the outset, we regret the inconvenience caused. The payment status of the purchase transaction below is "Payment not received":
[Paste screenshot]

If the amount has been debited from your account but the payment failed due to a payment gateway error, the amount will be refunded to your bank account within 3–4 working days from the date of the transaction. If you have not received the refund, please send us your latest bank statement as proof so that we can investigate.

OR

The online payment gateway for net-banking usually works without issues, but on rare occasions such problems occur and we do not receive the amount to process your transaction. The money will be put back in your bank account within 2–5 business days. If that does not happen, let us know and we will follow up with your bank on your behalf.

Fund realisation: effective 1 February 2021, the applicable NAV for a purchase of units is subject to realisation and availability of the funds in the mutual fund's bank account before the applicable cut-off time, irrespective of the amount invested, under all mutual fund schemes.

To check NEFT bank details: Login to your FundsIndia account > Mutual Funds > Invest > Lumpsum > Add scheme > select the amount > Confirm > click NEFT / RTGS / IMPS (you will find the virtual account number).`,
      },
      {
        title: 'Redemption',
        summary: 'The investor wants to redeem, or asks how redemption works.',
        docs: ['No documents – online with OTP. Ask the investor to verify the primary bank details before redeeming.'],
        steps: [
          'Mention that market conditions may favour staying invested, but proceed if the investor still wishes to redeem.',
          'Login to the FundsIndia account on the website > Mutual funds > Portfolio > select the scheme > click the dots > Redeem > select the redemption reason > Proceed > select units / amount > enter OTP > Proceed.',
          'The OTP goes to the mobile number and e-mail ID registered in the folio; either OTP can be used.',
          'Verify the bank before redeeming: Website > My account > View investor details > Primary bank information.',
        ],
        tat: 'Payout TAT: International funds T+6 to T+10 business days; ELSS T+2; Equity funds T+2; Debt funds T+2; Liquid funds T+1 (business days).',
        notes: [
          'Saturdays, Sundays and public holidays are non-business days. The FundsIndia cut-off time is 2 PM.',
          'A request received before the cut-off gets the closing NAV of that business day.',
          'Exit load is charged if the SIP / lump sum investment has not completed its holding duration; some schemes have a different exit load.',
        ],
        sendTo: '',
        template: `We would like to inform you that the current market scenario favours staying invested rather than redeeming. However, if you still wish to proceed, please follow this pathway:
Login to your FundsIndia account on the website > Mutual funds > Portfolio > select the scheme > click the dots > Redeem > select the redemption reason > Proceed > select the units / amount > enter OTP > Proceed.
An OTP is sent to the mobile number and e-mail ID registered in the folio; please enter either one.

Note: exit load will be charged on the NAV if each SIP / lump sum investment has not completed its duration; some schemes have a different exit load. Saturdays, Sundays and public holidays are non-business days. The cut-off time is 2 PM. The closing NAV of the business day is applied if we receive the request before the cut-off.

Redemption payout TAT by scheme type: International funds T+6/10 business days; ELSS T+2; Equity funds T+2; Debt funds T+2; Liquid funds T+1.
Please verify your bank details before placing the request: Website > My account > View investor details > Primary bank information.`,
      },
      {
        title: 'Non-receipt of redemption',
        summary: 'The investor has not received the redemption proceeds.',
        docs: ['Bank statement for the relevant dates – only if the amount is still not received after the TAT'],
        steps: [
          'Check the scheme type and apply the correct payout TAT (equity: T+2 business days, T = transaction date).',
          'Count only business days (exclude weekends and public holidays).',
          'Tell the investor the date by which the proceeds will be credited. If still not received, ask for the bank statement covering the transaction period.',
        ],
        tat: 'Equity: T+2 business days; see the Redemption process for other scheme types.',
        notes: ['Replace the dates in the template with the investor\'s actual dates; the sample in the source used 2023 dates.'],
        sendTo: 'email',
        template: `The redemption payout TAT (turn-around time) for equity schemes is T+2 business days (T being the date of transaction). As you redeemed from an equity scheme, the proceeds will be credited by [date] before EOD.
Please note [dates] were non-business days.
If you have not received the amount by tomorrow EOD, please send us a copy of your bank statement from [start date] to [end date] so that we can check and assist you better.`,
      },
    ],
  },
  {
    title: 'SIPs & mandates',
    blurb: 'Registering, changing and pausing SIPs; setting up eNACH / NACH mandates.',
    processes: [
      {
        title: 'SIP registration',
        summary: 'The investor wants to start an SIP in a scheme.',
        docs: ['No documents – online with OTP; a valid mandate is needed'],
        steps: ['Login to the FundsIndia online account > Mutual fund (rupee icon, top left) > Invest > SIP > select the scheme > Proceed to Basket > amount, date, tenure and mandate > Proceed to confirm > Proceed to verify > enter the OTP.'],
        tat: 'Online.',
        notes: [],
        sendTo: '',
        template: `To register an SIP in the scheme, please follow this pathway:
Login to your FundsIndia online account > click on Mutual fund (rupee icon, top left) > Invest > SIP > select the scheme > Proceed to Basket > amount, date, tenure and select the mandate > Proceed to confirm > Proceed to verify > enter the OTP.`,
      },
      {
        title: 'SIP amount change',
        summary: 'The investor wants to change the SIP amount.',
        docs: ['No documents – online'],
        steps: [
          'Website: Mutual Funds > Systematic Plans > click Edit SIP.',
          'Mobile app: Mutual Funds > Systematic Plans > click the scheme name > edit (pencil) > Change SIP.',
        ],
        tat: 'Online. Place the change 3–7 business days before the SIP date.',
        notes: ['Any change should be placed 3–7 business days before the SIP date.'],
        sendTo: '',
        template: `You can change the SIP amount on the FundsIndia website or mobile app:
Website: Mutual Funds > Systematic Plans > click Edit SIP.
Mobile app: Mutual Funds > Systematic Plans > click the scheme name > click the edit option (pencil) > Change SIP.
Please place the change 3–7 business days before the SIP date.`,
      },
      {
        title: 'SIP pause',
        summary: 'The investor wants to skip an SIP instalment.',
        docs: ['No documents – online'],
        steps: ['Login to the FundsIndia portal > Mutual Funds > Systematic Plans > click Skip Next Installment.'],
        tat: 'Online. Place the request 3–7 business days before the SIP date.',
        notes: ['A pause request applies to one month only.', 'Two consecutive instalments cannot be paused.', 'Any change or pause request must be placed 3–7 business days before the SIP date.'],
        sendTo: '',
        template: `To pause an SIP instalment: login to the FundsIndia portal > Mutual Funds > Systematic Plans > click Skip Next Installment.
1. A pause request is applicable for one month only.
2. You cannot pause 2 consecutive instalments.
3. Any change / pause request should be placed 3–7 business days before the SIP date.`,
      },
      {
        title: 'eNACH mandate',
        summary: 'The investor wants a mandate set up fully online for SIP auto-debit.',
        docs: ['No paper documents – a token transaction of ₹2 through net-banking'],
        steps: [
          'Login to the FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > make a token transaction of ₹2 through net-banking; the mandate is then ready.',
          'Ask the investor to tell you after generating the eNACH so the SIP can be mapped to the new mandate.',
        ],
        tat: 'Ready after the ₹2 token transaction and bank approval; the SIP is then mapped to the new mandate.',
        notes: [],
        sendTo: '',
        template: `To set up an e-NACH mandate, login to your FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > make a token transaction of ₹2 through net-banking and your mandate will be ready.
Please let us know after you generate the e-NACH mandate so that we can map your SIP to the new mandate.`,
      },
      {
        title: 'NACH mandate (physical)',
        summary: 'The investor wants a paper (physical) mandate for SIP auto-debit.',
        docs: ['Signed physical NACH mandate form (generated in the portal), scanned and emailed'],
        steps: [
          'Login to the FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit > Generate mandate > sign it and send the scanned copy to the support mailbox.',
          'To map an existing SIP to the new mandate, the investor replies with the mandate number; auto-debit starts as per the SIP date once the mandate is approved.',
        ],
        tat: 'After the signed mandate is received and approved by the bank.',
        notes: [],
        sendTo: 'email',
        template: `To set up a NACH mandate, login to your FundsIndia account > My accounts > Bank details > Add bank mandate > select the mandate limit from the drop-down > Generate mandate > sign it and send the scanned copy to contact@fundsindia.com.
If you wish to map your existing SIP to the new mandate, reply with the mandate number so that we can map it. Once the new mandate is approved, the auto-debit will start as per the SIP date.`,
      },
    ],
  },
];
