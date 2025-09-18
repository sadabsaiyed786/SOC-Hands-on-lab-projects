# Project 03 — Brute Force Attack Detection

## ✅ Overview

**Objective:** Detect brute-force login attempts in Windows Security Logs by monitoring repeated failed logon events (Event ID `4625`) within a short time window and identify when such attempts lead to a successful logon (Event ID `4624`).

This hands-on lab demonstrates how to simulate brute-force attacks, collect Windows Security events, and implement a SOC-style detection that raises alerts when suspicious authentication patterns are observed.

---

## 🔍 Skills Gained

* Understand Windows Security Event IDs related to authentication (`4624`, `4625`).
* Identify brute-force patterns: multiple `4625` events from the same source (user or IP) within a short time.
* Correlate failed attempts with a subsequent `4624` successful login.
* Write detection scripts (Python / PowerShell) to parse Event Log exports (`.evtx`/`.csv`) and produce alerts.
* Create reproducible attack simulations and document findings for SOC playbooks.

---

## 📁 Repository Folder

`Project-03-Brute-Force-Detection/`

* `scripts/` — detection scripts (Python / PowerShell)
* `log_samples/` — exported event logs (`.evtx`, `.csv`) used for testing
* `screenshots/` — evidence and Event Viewer screenshots
* `README.md` — this file

---

## 🚧 Lab Environment (recommended)

* Host: Windows Server 2016/2019 (Event logging target)
* Attacker: Kali Linux or any machine capable of running brute-force tools (e.g., Hydra, Metasploit modules, custom scripts)
* Virtualization: VirtualBox or VMware

> Use isolated lab networks. Do **not** perform brute-force testing on production systems or systems you do not own.

---

## 🛠️ Detection Logic (high-level)

1. Parse Windows Security logs and filter authentication events:

   * `4625` — Failed logon
   * `4624` — Successful logon
2. Group events by username and source (IP or workstation name).
3. For each group, look for `N` or more `4625` events within a rolling time window `T` (recommended: `N = 5`, `T = 3 minutes`).
4. If a `4624` event occurs for the same username/source immediately after the failed attempts (within `T`), escalate to a higher-severity alert.
5. Output an alert containing: username, source IP, timestamps, count of failed attempts, and the success event (if present).

---

## 💻 Example: Simple Python Detection (usage)

Place a script in `scripts/` (e.g., `detect_bruteforce.py`) that accepts an exported CSV of Event Viewer logs and prints any detections.

**Example command:**

```
python3 scripts/detect_bruteforce.py --input log_samples/security_events.csv --min-fails 5 --window-minutes 3
```

The script should output detections in a clear format (JSON lines or CSV) and save a `detections.json` to the repo for evidence.

---

## 🧾 Expected Artifacts

* `detections.json` — structured alerts produced by the detection script
* `log_samples/` — raw logs used to reproduce the detection
* `screenshots/` — Event Viewer screenshots and script output screenshots

---

## 🧪 Attack Simulation (brief)

1. From attacker machine: run brute-force attempts against a test account on the Windows host.
2. Monitor Event Viewer → Windows Logs → Security on the Windows host and export the relevant timeframe (.evtx or CSV).
3. Run the detection script against the exported logs to verify detection.

---

## 📑 README Checklist (what to include)

* [ ] `scripts/detect_bruteforce.py` (or `detect_bruteforce.ps1`)
* [ ] `log_samples/security_events.csv` or `.evtx`
* [ ] `screenshots/eventviewer_fails.png`, `screenshots/detection_output.png`
* [ ] `detections.json` demonstrating at least one successful detection
* [ ] Short write-up of results and recommended remediation (account lockout, MFA, IP blocking)

---

## 🔐 Recommended Mitigations (short)

* Enforce account lockout policies (threshold and cooldown)
* Enable Multi-Factor Authentication (MFA)
* Block or rate-limit suspicious source IPs
* Monitor and alert on suspicious authentication patterns

---

## References / Notes

* Use only on lab/test environments.
* Tweak thresholds (`N`, `T`) based on environment noise and acceptable false-positive rates.

---

*Created for the SOC Hands-On Lab Projects repository.*




