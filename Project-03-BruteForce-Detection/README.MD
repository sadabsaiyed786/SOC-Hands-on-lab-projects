# Project 03 – Brute Force Attack Detection 🔐

This project demonstrates detection of a brute-force login attempt using **Windows Security Logs**.  
We simulate multiple failed logins (Event ID **4625**) followed by a successful login (Event ID **4624**).

---

## 🔑 Objective
- Simulate brute force attempts with multiple wrong passwords.
- Detect the pattern of failed logins followed by a successful login.
- Understand how SOC analysts investigate brute-force attacks in Windows logs.

---

## 🛠 Lab Setup
- Windows Server 2016 / 2019 (VM in VirtualBox/VMware)
- PowerShell (run as Administrator)
- Event Viewer → `Windows Logs > Security`
- Test account: `bruteuser1`

---

## 📜 Steps Performed

### 1️⃣ Create a test user
```powershell
net user bruteuser1 Brute@123 /add

### 2️⃣ Enable auditing for logon events
```powershell
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Account Logon" /success:enable /failure:enable

### 3️⃣ Run brute-force simulation script

Save the scripts/bruteforce.ps1

Run the script:

powershell.exe -ExecutionPolicy Bypass -File .\scripts\bruteforce.ps1

📊 Expected Output

Wrong passwords → error 1326 (The user name or password is incorrect)

Correct password → The command completed successfully. and Exit Code: 0

🔍 Event Viewer Analysis

Open Event Viewer → Windows Logs → Security.

Click Filter Current Log... and enter Event IDs: 4625, 4624 then apply.

Observe:

Multiple 4625 — Failed Logon events for bruteuser1 (short time window).

A single 4624 — Successful Logon (when correct password used).

Fields to inspect in 4625/4624 events:

Account Name (should show bruteuser1)

Logon Type (e.g., 3 = Network, 2 = Interactive)

Failure Information (Status/Substatus — helps identify bad password vs. locked account)

Source Network Address / Workstation Name (if present)

📂 Project Structure
Project-03-BruteForce-Detection/
│── README.md
│── scripts/
│   └── bruteforce.ps1
│── screenshots/
│   ├── multiple_failed_logins.png
│   └── successful_login.png
│── log_samples/
│   └── brute_force_logs.evtx

📌 Screenshots to Capture

PowerShell console showing the brute-force loop output.

Event Viewer list showing multiple 4625 events (expand one to view details).

Event Viewer showing the 4624 success event details.

🗂 Exporting Evidence (.evtx)

GUI (recommended for filtered logs):

After filtering (4625,4624): Right-click the filtered view → Save Filtered Log File As... → save as log_samples/brute_force_logs.evtx.

CLI (exports entire Security log):

wevtutil epl Security "Project-03-BruteForce-Detection\log_samples\brute_force_logs.evtx"

🧾 Analysis & Findings (example)

Observed multiple 4625 events for bruteuser1 within a short time period → consistent with automated credential guessing.

Observed a 4624 event after the failed attempts → brute-force succeeded.

Recommended SOC actions:

Block the attacker source (network/IP) if identified.

Force password reset for the compromised account.

Search for lateral movement and persistence (review 4688/other telemetry).

Tune SIEM rules to alert on rapid consecutive 4625s for same account/source.

⚙️ SOC Relevance

Brute-force detection is fundamental for early threat detection.

Typical detection rule: alert when count(4625) > X for same account or source IP within Y minutes.

Correlate with endpoint (Sysmon 4688) and network logs for context and blocking decisions.

✅ Deliverables

scripts/bruteforce.ps1 — simulation script

screenshots/multiple_failed_logins.png

screenshots/successful_login.png

log_samples/brute_force_logs.evtx — exported filtered logs

README.md — this file





