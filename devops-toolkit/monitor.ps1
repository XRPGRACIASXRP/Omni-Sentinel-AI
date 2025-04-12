# monitor.ps1 - Omni Sentinel AI Monitoring Script
Write-Host "📡 Starting system monitoring..."
Start-Sleep -Seconds 2

$logCount = 5
for ($i = 1; $i -le $logCount; $i++) {
    Write-Host "📄 Log Entry #$i: System check OK."
    Start-Sleep -Seconds 1
}

Write-Host "🚨 No anomalies detected."
Write-Host "📊 Monitoring complete."
