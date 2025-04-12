# Omni Sentinel AI - Incident Logger

Write-Host "`n📝 Incident Logging Script"
$incident = Read-Host "🔐 Enter a brief incident description"

$log = @{
    Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    User = $env:USERNAME
    Host = $env:COMPUTERNAME
    IP = (Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } |
        Select-Object -First 1 -ExpandProperty IPAddress)
    Description = $incident
}

# Format log entry
$entry = "`n--- Incident Logged ---`n" +
         "Time: $($log.Timestamp)`n" +
         "User: $($log.User)`n" +
         "Host: $($log.Host)`n" +
         "IP: $($log.IP)`n" +
         "Details: $($log.Description)`n"

# Output and log to file
Write-Host "`n$entry"
Add-Content -Path "incident-log.txt" -Value $entry
Write-Host "✅ Incident saved to incident-log.txt"
