Project 03 – Brute Force Attack Detection 🔐
Objective

Simulate a brute-force login scenario on a Windows machine and detect it using Windows Security logs (Event Viewer).
This lab demonstrates how repeated failed logins (Event ID 4625) followed by a successful login (Event ID 4624) indicate a brute-force attack pattern.

Lab Setup (requirements)

Windows Server 2016 / 2019 (VM)

PowerShell (run as Administrator)

Event Viewer (Windows Logs → Security)

(Optional) Shared folder between host and guest for transferring files/screenshots

Project Structure

Project-03-BruteForce-Detection/
│── README.md
│── scripts/
│ └── bruteforce.ps1
│── screenshots/
│ ├── multiple_failed_logins.png
│ └── successful_login.png
│── log_samples/
│ └── brute_force_logs.evtx

Commands & Files used
1) Create test user

Run in elevated PowerShell:

net user bruteuser1 Brute@123 /add

2) Enable auditing for logon events

(Ensure failures are recorded)

auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Account Logon" /success:enable /failure:enable

3) Bruteforce simulation script

Save the following as scripts/bruteforce.ps1 and run it (Admin PowerShell):

# bruteforce.ps1  - safe local brute-force simulation for lab
$user = "bruteuser1"
$target = "\\localhost\IPC$"

$passwords = @(
  "pass123","12345","letmein","wrongpass","admin2020",
  "Brute@123"  # correct password used in this lab
)

foreach ($pwd in $passwords) {
    Write-Host "======== Trying password: $pwd ========" -ForegroundColor Cyan
    net use $target /user:$user $pwd
    Write-Host "LASTEXITCODE = $LASTEXITCODE" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 700
}


Run with ExecutionPolicy bypass if needed:

powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\scripts\bruteforce.ps1"

Expected PowerShell Output

For wrong passwords:

System error 1326 has occurred.
The user name or password is incorrect.
LASTEXITCODE = 1326


For the correct password:

The command completed successfully.
LASTEXITCODE = 0

Detecting in Event Viewer

Open Event Viewer → Windows Logs → Security.

Click Filter Current Log... and enter Event IDs: 4625,4624.

Apply filter — you should see multiple 4625 entries (failed logons) and one 4624 (successful logon).

Important fields to inspect in a 4625 event:

Account Name → bruteuser1

Failure Information → Status / Substatus (e.g., 0xC000006A = bad password)

Logon Type (e.g., 3 = Network)

Source Network Address / Workstation Name (if present)

Exporting evidence (.evtx)

GUI (recommended for filtered logs):

With the filtered view (4625,4624) applied: Right-click → Save Filtered Log File As... and save to log_samples/brute_force_logs.evtx.

CLI (exports entire Security log):

wevtutil epl Security "Project-03-BruteForce-Detection\log_samples\brute_force_logs.evtx"

Screenshots to capture (for repo & report)

screenshots/multiple_failed_logins.png — Event Viewer showing multiple 4625 entries (expand one to show details).

screenshots/successful_login.png — Event Viewer showing the 4624 successful login details.

(Optional) PowerShell console screenshot showing the loop output.

Analysis & Findings (example)

Observed multiple 4625 events for bruteuser1 in quick succession → indicates automated attempts.

Observed 4624 for bruteuser1 after failures → brute-force success.

Recommended SOC response: block source IP, reset credentials, investigate for lateral movement and persistence.

SOC Relevance

Brute-force detection is a core SOC use-case: alert on many 4625s from same account/source in a short time.

Correlate with firewall/IDS and host logs (process creation 4688, network connections) for full context.

In SIEM, implement a rule like: alert when count(4625) > X within Y minutes for same username or source IP.

Deliverables

scripts/bruteforce.ps1 — simulation script

screenshots/multiple_failed_logins.png

screenshots/successful_login.png

log_samples/brute_force_logs.evtx — exported filtered logs

README.md — this file

Git Commands to Upload
git add Project-03-BruteForce-Detection/
git commit -m "Add Project 03 - Brute Force Detection (script, README, screenshots, logs)"
git pull --rebase origin main
git push origin main


(If push is rejected, run git pull --rebase origin main, resolve conflicts, then git push origin main.)

Troubleshooting (if you don’t see events)

Ensure PowerShell was run as Administrator.

Verify the test user exists:

net user bruteuser1


Check auditing settings:

auditpol /get /category:"Logon/Logoff"


If failures are not enabled, enable them (see section above).

Test a single manual authentication:

net use \\localhost\IPC$ /user:bruteuser1 wrongpass


You should see System error 1326 on failure which corresponds to a 4625 log entry.

Extensions / Next steps

Re-run test using a separate attacker VM (Kali) with tools like hydra for SMB/RDP brute force — capture network traffic (Wireshark) and host logs.

Forward logs to SIEM (Splunk/Wazuh/ELK) and create correlation rules/dashboards for brute-force detection.

Add Sysmon for enhanced telemetry (process creation, network connection events) and correlate with Security logs.

Author

Sadab Saiyed
LinkedIn: https://www.linkedin.com/in/saiyed-mohammadsadab-074ba8206
