# Omni Sentinel AI – Public IP Watcher

$knownSafeIP = "1.2.3.4"  # Replace with real static IP if needed
$currentIP = Invoke-RestMethod -Uri "https://api.ipify.org"

Write-Host "`n🌐 Current Public IP: $currentIP"

if ($currentIP -ne $knownSafeIP) {
    Write-Host "⚠️ IP address has changed! Possible VPN, proxy, or MITM." -ForegroundColor Yellow
} else {
    Write-Host "✅ IP matches known-safe value." -ForegroundColor Green
}

# Log entry
$log = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] IP: $currentIP"
Add-Content -Path "$env:TEMP\ip-watch-log.txt" -Value $log
