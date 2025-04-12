# Omni Sentinel AI – Firewall Rule Audit

Write-Host "`n🧱 Auditing Windows Firewall Rules..." -ForegroundColor Cyan

$rules = Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" }

foreach ($rule in $rules) {
    $app = ($rule | Get-NetFirewallApplicationFilter).Program
    $direction = $rule.Direction
    $action = $rule.Action
    $profile = $rule.Profile
    $displayName = $rule.DisplayName

    # Flag risky conditions
    if ($direction -eq "Inbound" -and $action -eq "Allow") {
        Write-Host "⚠️ Inbound Allow Rule Detected: $displayName" -ForegroundColor Yellow
        if ($app) {
            Write-Host "  └▶ Application: $app"
        }
    }
}

# Check logging settings
$fwProfile = Get-NetFirewallProfile
foreach ($profile in $fwProfile) {
    if (-not $profile.LoggingAllowed) {
        Write-Host "❌ Logging is disabled on $($profile.Name) profile!" -ForegroundColor Red
    } else {
        Write-Host "✅ Logging is enabled on $($profile.Name) profile." -ForegroundColor Green
    }
}
