# Omni Sentinel AI – Service Status Checker

$servicesToCheck = @(
    "WinDefend",      # Windows Defender
    "wuauserv",       # Windows Update
    "bits",           # Background Intelligent Transfer
    "EventLog",       # Event Log service
    "LanmanWorkstation",  # Workstation (network shares)
    "Spooler"         # Print Spooler
)

foreach ($serviceName in $servicesToCheck) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($null -eq $service) {
        Write-Host "❌ Service $serviceName not found!" -ForegroundColor Red
    } elseif ($service.Status -ne 'Running') {
        Write-Host "⚠️ Service $serviceName is not running (Status: $($service.Status))" -ForegroundColor Yellow
    } else {
        Write-Host "✅ Service $serviceName is running." -ForegroundColor Green
    }
}
