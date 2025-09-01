# Project 02 - PowerShell Monitoring ⚡

This project demonstrates how to monitor and detect PowerShell activity on a Windows system.  
SOC analysts often need to track suspicious PowerShell usage because attackers frequently use it for **living-off-the-land (LotL)** attacks.

---

## Key Points:
- Focused on **Event ID 4104** (PowerShell script block logging AND local user list).
- Simulated execution of a PowerShell command:
  ```powershell
  Start-Process "notepad.exe" -ArgumentList "C:\Windows\System32\drivers\etc\hosts"
  Get-LocalUser | Select-Object Name, Enabled
