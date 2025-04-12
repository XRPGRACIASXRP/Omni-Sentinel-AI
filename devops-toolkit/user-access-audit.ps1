# Omni Sentinel AI - User Access Audit Script

Write-Host "`n🔐 Auditing User Access...`n"

# Get local user accounts
$users = Get-LocalUser

foreach ($user in $users) {
    $lastLogon = ($user.LastLogon).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "👤 User: $($user.Name)"
    Write-Host "    Enabled: $($user.Enabled)"
    Write-Host "    Last Logon: $lastLogon`n"
}

Write-Host "`n✅ User Access Audit Complete.`n"
