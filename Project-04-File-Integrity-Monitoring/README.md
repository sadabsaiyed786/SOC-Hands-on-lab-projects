# 🔍 Project 04 – File Integrity Monitoring with Sysmon

## 🎯 Objective
Set up **Sysmon** with the community-recommended **SwiftOnSecurity configuration** to monitor and detect file creation events (potential indicators of malware or attacker activity).

---

## 🛠️ Environment
- Windows Server 2016/2019 (VM on VirtualBox/VMware)
- Attacker machine (optional: Kali Linux or another Windows VM)
- Tools:
  - [Sysmon (Sysinternals)](https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon)
  - [SwiftOnSecurity Sysmon Config](https://github.com/SwiftOnSecurity/sysmon-config)

---

## 📌 Steps Performed

### 1. Prepare Sysmon Folder
```powershell
New-Item -Path "C:\Tools\Sysmon" -ItemType Directory -Force
2. Download Sysmon (manual step)
Download from: Sysmon Download

Extract Sysmon64.exe → place in C:\Tools\Sysmon\

3. Download SwiftOnSecurity Config
Fix TLS issue and download config:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile "C:\Tools\Sysmon\sysmonconfig-export.xml"
```
4. Install Sysmon with Config
```powershell
cd C:\Tools\Sysmon
.\sysmon64.exe -i sysmonconfig-export.xml -accepteula
```
5. Verify Installation
```powershell
Get-Service sysmon64
```
Should show Running ✅

Check Event Viewer:

Applications and Services Logs > Microsoft > Windows > Sysmon > Operational
🧪 Simulation – File Creation
Create or copy a file in any directory, e.g.:

```powershell
copy C:\Windows\System32\notepad.exe C:\Users\Administrator\Desktop\notepad_copy.exe
```
Open Sysmon log → look for Event ID 11 (File Create).

Note details:

Who created the file (user/process)

What file was created

Where it was created

When it happened

📊 Skills Gained
Install and configure Sysmon with community rules

Detect file creation events (Event ID 11)

Correlate logs to identify suspicious file drops

Build foundation for SIEM rules later

📸 Screenshots (add after testing)
Sysmon installed successfully

Config file in C:\Tools\Sysmon

Event Viewer showing Event ID 11 – File Create

📂 Folder Structure
```
Project-04-File-Integrity-Monitoring/
│── scripts/              # (if any helper scripts later)
│── screenshots/          # screenshots of logs & config
│── log_samples/          # exported Sysmon events
│── README.md             # project documentation
```
✅ Learning Outcome
You can now monitor file integrity in Windows using Sysmon.

This is a real SOC skill: spotting attacker behavior like malware drops, persistence files, and lateral movement tools.

No coding required — only log analysis and interpretation.