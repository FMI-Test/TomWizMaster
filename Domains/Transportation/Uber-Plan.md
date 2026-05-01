# Uber-Plan: Hospitality & Direct Fleet (x1000 Redo)
> **Status:** REDO x1000 | **Strategy:** Direct/Hospitality | **Date:** 2026-03-02

## 🚀 Executive Summary (The "1000x" Vision)
The Strategy is maximizing ROI by pivoting from generic "transportation" to **High-End Hospitality Logistics**. We eliminate efficiency leaks (middlemen) and focus on high-yield assets (Luxury EVs) managed directly via our own tech stack.

### 🛑 Strategic Pivot
- **❌ OLD MODEL:** Generic Fleet, Middlemen Managers, Commodity Vehicles (Toyota Camry).
- **✅ NEW MODEL:** Direct Contractor Relations, Hospitality Focus, Premium Assets (Cadillac Escalade IQ).

---

## 💎 Pillars of Execution

### 1. The Asset Strategy (ROI Max)
*   **Vehicle:** Cadillac Escalade IQ (Electric Luxury).
*   **Why:** Higher tier rates (Uber Black/SUV/Lux), lower operating costs (EV), better asset retention value than high-mileage ICE vehicles.
*   **Math:** 1 Escalade IQ > 6 Camrys in terms of net margin/effort ratio.
    *   *Lower churn, higher clientele quality, premium pricing power.*

### 2. The Labor Model (Hospitality & Contractors)
*   **Role:** NOT just "Drivers", but **Service Professionals** (Sub-contractors).
*   **Relationship:** Direct. **No Middlemen.**
    *   *Middlemen are net-negative:* They take a cut (~20-30%) and dilute the brand standard.
*   **Requirement:** Hospitality training. The ride is the product; the driver is the concierge.
*   **Action:** Recruit leads directly for LA Market & neighboring cities.

### 3. The Tech Stack (Direct Control)
*   We own the platform instructions. We build the pipeline to manage the fleet, the data, and the deployment without reliance on third-party fleet management software.
*   *See "Technical Infrastructure" below.*

---

## 📋 ACTION PLAN: Business Operations

### Phase A: Intelligence & Analysis
- [ ] **A.1** Run full ROI analysis: Lease cost vs. Insurance vs. Black/SUV Rate Card.
- [ ] **A.2** Finalize "Implicit & Explicit" data points: Charging logistics, downtime costs, cleaning fees.
- [ ] **A.3** Market Analysis: Identifying high-demand zones for Luxury vs. Standard.

### Phase B: Fleet Acquisition
- [ ] **B.1** Source 6x Cadillac Escalade IQs.
- [ ] **B.2** Secure commercial insurance/licensing (TCP/PUC).

### Phase C: Talent Pipeline
- [ ] **C.1** Create "Driver-Partner" intake portal (Hospitality focused).
- [ ] **C.2** Develop "Service Standard" training (The "Hospitality" edge).
- [ ] **C.3** Launch lead gen for drivers in LA market.

---

# 🛠️ Technical Infrastructure (Web Publication Pipeline)
For ref see & read full repo of: https://github.com/TomWiz.io/TomWizMaster

---

# TODOS — End-to-End Web Publication Pipeline
> Generated: 2026-03-02 | Scope: www + WSO + TomWizMaster → Domain Publication → Smoke Test 2.0

---

## 🔴 PHASE 0 — SYSCONFIG / ENV SMOKE TEST (Run First)
- [x] **0.1** ✅ Python 3.14.3 — PASS
- [x] **0.2** ✅ pip3 — PASS (`/usr/local/bin/pip3`)
- [x] **0.3** ✅ git 2.50.1 — PASS
- [x] **0.4** ✅ AWS CLI — Installed via pip 1.44.49 (Requires `aws configure`)
- [x] **0.5** ✅ Node/npm — Installed manual v22.13.0
- [ ] **0.6** ❌ Docker — Install Docker Desktop (macOS arm64)
- [x] **0.7** ✅ SAM CLI — Installed via pip 1.151.0
- [ ] **0.8** Verify `~/.aws/credentials` has WSO/prod profile
- [ ] **0.9** `python3 -m sysconfig` — full dump logged to `logs/sysconfig-$(date).txt`

---

## 🟠 PHASE 1 — SOURCE DATA COLLECTION (www + WSO + TomWizMaster)
- [ ] **1.1** Audit `www/WSO` — extract publishable content (Portfolio, Projects, Services, Contacts)
- [x] **1.2** Audit `www/TomWizMaster` — Initial audit found 229 refs. Reduced to ~30 generic refs.
- [x] **1.3** Resolve 229 internal path refs — Bulk sed cleanup complete.
- [x] **1.4** Exclude NSFW (`Assets/NFSW/`), `Love/`, `Meta/` from pub build — DELETED from git history.
- [ ] **1.5** Review `Ugly-Truth/` — legal clearance for Iran/regime content
- [x] **1.6** Sanitize git history — NUKED & PAVED. Repo size 2.2GB -> 104MB.
- [x] **1.7** Extract Caspian (PHP) content → static HTML for CDN publish — DONE (`dist/` folder generated).
- [x] **1.8** Collect TomWizMaster media assets (`media/output/`) → CDN-ready — Staged in `media/dist`.

---

## 🟡 PHASE 2 — DOMAIN + DNS SETUP (BLOCKED: AWS CREDENTIALS)
- [x] **2.1** Register `TomWizMaster.ai` — Status: TAKEN (Owned?)
- [x] **2.2** Register `TomWiz.dev` — Status: TAKEN (Owned?)
- [x] **2.3** Register/verify Caspian domain — Status: TAKEN (GoDaddy Managed)
- [ ] **2.4** **ACTION REQUIRED:** Run `aws configure` (See `www/DOMAINS/setup_aws_instructions.md`)
- [ ] **2.5** Create Route 53 Hosted Zones for `.ai` and `.dev`
- [ ] **2.6** Point Namecheap NS → Route 53 nameservers
- [ ] **2.6** SSL/TLS via ACM — `*.TomWizMaster.ai` wildcard cert
- [ ] **2.7** Configure root `wso.alpha@gmail.com` as AWS account root (MFA on)

---

## 🟢 PHASE 3 — WEB BUILD + PUBLISH
- [ ] **3.1** Static site generator — choose: Hugo / Next.js / plain HTML
- [ ] **3.2** Build WSO portfolio → S3 static site (`www.TomWiz.dev`)
- [ ] **3.3** Build TomWizMaster docs site → S3 (`docs.TomWizMaster.ai`)
- [ ] **3.4** Caspian PHP → convert/deploy to managed PHP host or AWS Lambda (PHP runtime)
- [ ] **3.5** S3 bucket: `public-read` + `website` mode + versioning ON
- [ ] **3.6** CloudFront distribution → S3 origin + ACM cert
- [ ] **3.7** Set `index.html` + `404.html` error pages
- [ ] **3.8** `robots.txt` + `sitemap.xml` deployed to root

---

## 🔵 PHASE 4 — PUB/SUB + MULTIMEDIA + ANY-TO-ANY
- [ ] **4.1** SNS topic: `pub-web-events` → subscribers: email, SMS, Lambda
- [ ] **4.2** S3 event → SNS → Lambda pipeline (new content auto-publish)
- [ ] **4.3** Media pipeline: images/video → S3 → CloudFront CDN (`media.TomWizMaster.ai`)
- [ ] **4.4** iOS — PWA manifest (`manifest.json`) + `apple-touch-icon` + viewport meta
- [ ] **4.5** Android — PWA `manifest.webmanifest` + service worker (`sw.js`)
- [ ] **4.6** Multimedia — WebP images, MP4/HLS video, MP3 audio via CloudFront
- [ ] **4.7** RSS/Atom feed for blog/changelog auto-publish
- [ ] **4.8** GitHub Actions CI/CD → `main` push → S3 sync → CloudFront invalidation

---

## 🟣 PHASE 5 — AWS PRODUCTION HARDENING
- [ ] **5.1** AWS account root MFA — hardware key required (`wso.alpha@gmail.com`)
- [ ] **5.2** Delete root access keys (if any exist)
- [ ] **5.3** SCP: deny root API actions across all Org member accounts
- [ ] **5.4** CloudTrail → S3 + CloudWatch alert on root `ConsoleLogin`
- [ ] **5.5** S3 bucket: block all public access except CloudFront OAC
- [ ] **5.6** WAF v2 on CloudFront — rate limit + geo block if needed
- [ ] **5.7** AWS Budget alert — $50/mo threshold → SNS → email
- [ ] **5.8** IAM: least-privilege deploy role for GitHub Actions (OIDC, no long-term keys)

---

## ⚪ PHASE 6 — SMOKE TEST 2.0 (Lift-Off Checklist)
- [ ] **6.1** `curl -I https://TomWizMaster.ai` → 200 OK
- [ ] **6.2** `curl -I https://www.TomWiz.dev` → 200 OK
- [ ] **6.3** SSL check — `openssl s_client -connect TomWizMaster.ai:443` → valid cert
- [ ] **6.4** macOS Chrome — load all pages, check console errors
- [ ] **6.5** iOS Safari — PWA installable, icons load
- [ ] **6.6** Android Chrome — PWA installable, service worker registered
- [ ] **6.7** CloudFront cache hit — `X-Cache: Hit from cloudfront`
- [ ] **6.8** Lighthouse score ≥ 90 (Performance, Accessibility, SEO)
- [ ] **6.9** `aws s3 ls s3://your-bucket/` → objects visible
- [ ] **6.10** SNS pub/sub test — publish event → confirm email received
- [ ] **6.11** GitHub Actions deploy run — green ✅
- [ ] **6.12** `python3 -m sysconfig` log archived in `logs/`

---

## 🚀 HOUSTON — DO WE HAVE LIFT-OFF?
```
Phase 0 (Sysconfig):  ⚠️  0.4/0.5/0.6/0.7 need installs
Phase 1 (Data):       ❌  OSS cleanup pending (256 path refs)
Phase 2 (DNS):        ❌  Domains not yet registered
Phase 3 (Build):      ❌  Not started
Phase 4 (Pub/Sub):    ❌  Not started
Phase 5 (AWS Prod):   ❌  Root MFA + hardening pending
Phase 6 (Smoke 2.0):  ❌  Blocked by above

VERDICT: NOT LIFT-OFF YET — 33 TODOs remaining
```

---
_Ref: [TomWizMaster](https://github.com/TomWiz.io/TomWizMaster) | sysconfig: Python 3.14.3 · Darwin arm64 · 14 CPUs_
