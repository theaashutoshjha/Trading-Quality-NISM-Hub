# FundsIndia Learning Hub

Internal learning platform for FundsIndia employees — FundsIndia Academy videos, NISM preparation (V-A, V-B, V-D, VII, VIII, X-A, X-B, XII, XIII, XV, XVI, XXI-A), sales & service skills, Zoho CRM, Tata Tele and live market updates. Neumorphic UI with FundsIndia branding, **real server-side authentication**, and two separate portals.

| | URL | Who |
|---|---|---|
| **Learner Portal** | `https://learning-hub.fingtaj.online/` or `https://www.learning-hub.fingtaj.online/` | Employees — each has a private dashboard, progress, resume points, quiz history, certificates |
| **Admin Portal** | `https://learning-hub.fingtaj.online/<ADMIN_PATH>` | Admins & trainers (password + optional authenticator-app 2FA) |

Both hostnames use HTTPS; HTTP requests are redirected to HTTPS.

Stack: **Cloudflare Workers** (API + assets) · **D1** (SQLite) · React + Vite.

## Security model
* PBKDF2-SHA256 password hashing; random 256-bit session tokens (only their SHA-256 hash is stored); `HttpOnly; Secure; SameSite=Strict` cookies.
* Separate learner / admin sessions — a learner cookie can never call an admin API, and vice-versa.
* The **admin app bundle is served only to signed-in staff** (404 otherwise); the admin URL shows a bare sign-in page.
* 5 failed sign-ins per account or IP → 15-minute lockout; staff **TOTP 2FA**; first admin created via one-time `SETUP_TOKEN`.
* All learner data (progress, resume points, attempts, certificates) is keyed to the signed-in user server-side; the browser never supplies a user id.
* Quizzes graded server-side; CSP, HSTS, frame denial, cross-origin write blocking, audit log.

## Accounts & data safety
* **Only administrators create or delete accounts.** There is no self-registration; trainers (content editors) cannot manage users.
* Administrators: `rajesh.chakravarthi@fundsindia.com`, `ashutosh.kumar@fundsindia.com`, `ashwini.prabhu@fundsindia.com`. Create/refresh them with the password kept **out of the repository**:
  ```bash
  # PowerShell:  $env:ADMIN_PASSWORD='<password>'; node scripts/create-admins.mjs --local  rajesh.chakravarthi@fundsindia.com ashutosh.kumar@fundsindia.com ashwini.prabhu@fundsindia.com
  # use --remote for the live Cloudflare database
  ```
  The three admins share one password by request — change it under *My security* after first sign-in (new passwords must be 10+ characters with upper-case, lower-case and a number) and turn on 2-step verification.
* A learner's progress, video resume points, quiz history and certificates are stored against their account. Signing out only ends the session; signing back in shows exactly the same data. Admin password resets, suspensions and re-seeding the catalogue do **not** touch it. Only an admin **Delete** erases a person's data (it asks them to type the e-mail); prefer **Suspend**.
* `scripts/smoke3.ps1` tests all of this (admin-only account management, trainer/learner blocked, data identical after sign-out/sign-in).

## Learning content
* **FundsIndia Academy** — education videos from FundsIndia's own channel (investor mindset, SIPs & mutual funds, bonds & SIFs, stocks & IPOs, markets). Excluded on purpose: weekly/yearly market roundups, single-stock analyses, ads/promos, festival clips, PR interviews and anything older than ~2 years.
* **Freshness rule** — third-party series keep only videos published in the last ~12 months (`MAX_AGE_DAYS` in `seed/catalog.mjs`). Objection Handling uses the playlist you specified in full.
* **Learning paths** — 9 step-by-step journeys (Investing from zero, SIP mastery, Bonds & SIFs, Stocks & IPOs, Markets, NISM V-A track, Adviser track, Client conversations, Tools onboarding). Admins can build more.
* **Per-user experience** — resume where you stopped, auto-complete at 90% watched, streak, time learning, path progress.
* **Market updates** — a few high-signal RSS feeds fetched server-side: SEBI, RBI, ET Mutual Funds, ET Markets, Business Standard (cached ~20 min). Edit `worker/feeds.ts` to change them. Plus admin-posted bulletins.
* **Admin tools** — add a single video by link, import a whole playlist as a module (with a "recent only" switch), edit notes in Markdown, bulk-import quiz questions, manage paths, view any learner's progress.

### Refreshing the video catalog
```bash
node seed/tools/fetch-fi.mjs          # FundsIndia channel list -> seed/data/fi-channel.json
node seed/tools/fetch-playlists.mjs   # third-party series       -> seed/data/playlists.json
node seed/tools/list-fresh.mjs 400    # review what is recent
npm run seed:build                    # re-checks every video can be embedded, then writes seed/out/*.sql
```
(Re-seeding overwrites seeded rows; for a live site prefer adding videos from the Admin Portal.)

## Deploy to Cloudflare
```bash
npm install
npx wrangler login
npx wrangler d1 create fundsindia-hub          # paste database_id into wrangler.jsonc
npm run db:migrate:remote
npm run seed:build && npm run db:seed:remote
npx wrangler secret put SETUP_TOKEN            # long random value
# edit wrangler.jsonc -> "ADMIN_PATH": "/choose-a-secret-path"
npm run deploy
```
The configured custom domains are `learning-hub.fingtaj.online` and `www.learning-hub.fingtaj.online`; the domain must be an active Cloudflare zone in the deploying account. Open `https://learning-hub.fingtaj.online/<ADMIN_PATH>` → create the first admin → *My security* → enable 2-step verification → *Users & access* → add learners (single or CSV).

## Run locally
```bash
npm install
# .dev.vars (never commit):  SETUP_TOKEN=local-dev-setup-token-123456  /  COOKIE_SECURE=0
npm run db:migrate:local && npm run seed:build && npm run db:seed:local
npm run dev            # http://127.0.0.1:8787
```
Windows: keep the project in a **short path** (e.g. `C:\fihub`) — long folder paths break local D1. `scripts/smoke.ps1` and `scripts/smoke2.ps1` are end-to-end tests against `npm run dev`.

## Video player note
Videos play in the portal's own player (custom controls, speed, resume, end card, no outbound links). The stream is delivered by an embedded player that is kept non-interactive; its own small overlays (title strip at start, corner logo) are drawn inside that embed and are intentionally **not** masked, because hiding a video platform's branding is against its terms. Presenter names are credited on each lesson. To get a fully white-labelled player, host **your own** videos (e.g. Cloudflare Stream or R2) — appropriate for FundsIndia-owned content; other creators' videos need their permission.

## Before going live
- [ ] Change `ADMIN_PATH`, set `SETUP_TOKEN`, create admin, enable 2FA.
- [ ] Subject-matter expert review of seeded notes/questions (AI-generated in the original hub; contain illustrative figures).
- [ ] Spot-check videos and re-run the catalog refresh periodically — videos can be removed by their owners.
- [ ] Zoho / Tata Tele notes are generic: replace with your SOPs. Tata Tele has only official product explainers (few recent videos).
- [ ] The internal certificate is not an NISM/SEBI certificate.
