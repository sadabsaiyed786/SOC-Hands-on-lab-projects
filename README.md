# SOC Hands-On Lab Projects 🛡️

This repository is a collection of **SOC (Security Operations Center) hands-on projects** designed for beginners to intermediate learners in cybersecurity.  
Each project simulates real-world attack & defense scenarios and focuses on **log analysis, detection, and SOC analyst workflows**.  

---

## 📂 Project List

### ✅ Project 01 - Login Detection
- **Objective**: Detect successful and failed logon attempts in Windows Event Viewer.  
- **Skills Gained**:
  - Understand Windows Security Event IDs
  - Detect Event ID **4624 (Successful Logon)** and **4625 (Failed Logon)**
  - Analyze login activity using Event Viewer  
- **Folder**: [Project-01-Login-Detection](./Project-01-Login-Detection)

---

### ✅ Project 02 - PowerShell Monitoring
- **Objective**: Simulate suspicious PowerShell activity and detect logs in Event Viewer.  
- **Skills Gained**:
  - Understand Event ID **4104 (Script Block Logging)**  
  - Detect **process creation via PowerShell (Event ID 4688)**  
  - Learn how attackers abuse PowerShell and how SOC analysts detect it  
- **Folder**: [Project-02-PowerShell-Monitoring](./Project-02-PowerShell-Monitoring)

---

## Upcoming Projects
🔑 Windows Log Analysis

- Project 03 – Brute Force Detection (Multiple 4625 → 4624)

- Project 04 – File Integrity Monitoring with Sysmon

- Project 05 – Suspicious Network Connections (5156 + Sysmon 3)

- Project 06 – Detect Persistence Techniques (Registry + Scheduled Tasks)

🐧 Linux Log Analysis

- Project 07 – Linux Login Monitoring (/var/log/auth.log)

- Project 08 – Linux Brute Force Simulation (Hydra → detect in logs)

📊 Centralized Log Management

- Project 09 – Windows Log Forwarding (to Loggly/Graylog)

- Project 10 – Linux Log Forwarding with Rsyslog

⚡ SIEM Basics

- Project 11 – Splunk Basics (Ingest logs & detect failed logins)

- Project 12 – Wazuh Basics (Windows/Linux log collection & alerts)

- Project 13 – ELK Stack Monitoring (Collect & visualize login activity)

🛠 Tools Used

- Windows Server 2016/2019

- Linux (Ubuntu/Kali)

- PowerShell, Event Viewer

- Sysmon, Rsyslog, Hydra

- Splunk, Wazuh, ELK, Loggly/Graylog

🎯 Purpose

- Build practical SOC skills step by step

- Showcase projects on GitHub & LinkedIn for recruiters

- Create a portfolio demonstrating hands-on detection & analysis

👨‍💻 Author: Sadab Saiyed

📌 Connect with me on [LinkedIn](www.linkedin.com/in/saiyed-mohammadsadab-074ba8206)  
