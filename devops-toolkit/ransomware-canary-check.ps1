# Omni Sentinel AI – Ransomware Canary Check

Write-Host "`n🧬 Scanning for ransomware indicators..."

$indicators = @("*.lock", "*.crypt", "*.enc", "*.cry", "*.locked")
$scanPath = "C:\Users"

foreach ($pattern in $indicators) {
    $hits = Get-ChildItem -Path $scanPath -Recurse -Include $pattern -ErrorAction SilentlyContinue
    if ($hits) {
        Write-Host "`n❌ Possible ransomware files detected:" -ForegroundColor Red
        $hits | Select-Object FullName, Length | Format-Table -AutoSize
    }
}

# Check backup volume
$volShadow = (Get-WmiObject Win32_ShadowCopy -ErrorAction SilentlyContinue)
if (-not $volShadow) {
    Write-Host "`n⚠️ No shadow copies found (backups may have been deleted)" -ForegroundColor Yellow
} else {
    Write-Host "`n✅ System backups appear intact."
}

Write-Host "`n✅ Ransomware canary check complete."
