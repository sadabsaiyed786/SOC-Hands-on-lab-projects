# bruteforce.ps1  - safe local brute-force simulation for lab
# Run as Administrator (or run via powershell.exe -ExecutionPolicy Bypass -File ...)

$user = "bruteuser1"
$target = "\\localhost\IPC$"

# many wrong passwords, last is correct
$passwords = @(
  "pass123","12345","letmein","wrongpass","admin2020",
  "Brute@123"  # <-- correct password (replace if you created a different password)
)

foreach ($pwd in $passwords) {
    Write-Host "======== Trying password: $pwd ========" -ForegroundColor Cyan
    net use $target /user:$user $pwd
    Write-Host "LASTEXITCODE = $LASTEXITCODE" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 700
}
