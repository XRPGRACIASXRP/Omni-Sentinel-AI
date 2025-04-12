# Omni Sentinel AI - Patch Verifier Script

Write-Host "`n🩹 Checking Installed and Missing Patches...`n"

# List installed updates
Write-Host "📋 Installed Updates:"
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10 | Format-Table -AutoSize

# Search for missing security updates
Write-Host "`n🛡️ Missing Security Updates (if any):"
$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$results = $searcher.Search("IsInstalled=0 and Type='Software' and IsAssigned=1")

if ($results.Updates.Count -eq 0) {
    Write-Host "✅ System is fully patched!"
} else {
    foreach ($update in $results.Updates) {
        Write-Host "⚠️ $($update.Title)"
    }
}

Write-Host "`n✔️ Patch Verification Complete.`n"
