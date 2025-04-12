# Omni Sentinel AI – Process Watchdog Script

Write-Host "`n🧠 Scanning for suspicious processes..."

# Define blacklist of dangerous or unwanted process names
$blacklist = @("mimikatz", "powersploit", "nc", "metasploit", "Empire", "cmd.exe", "ftp.exe")

# Scan all running processes
$found = $false
foreach ($proc in Get-Process) {
    if ($blacklist -contains $proc.Name.ToLower()) {
        Write-Host "❌ Suspicious Process Detected: $($proc.Name) (PID: $($proc.Id))" -ForegroundColor Red
        $found = $true
    }
}

# Optional: Flag high memory usage processes
Write-Host "`n🔎 Top Memory Consumers:"
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 Name, Id, WorkingSet | Format-Table -AutoSize

if (-not $found) {
    Write-Host "`n✅ No blacklisted processes found." -ForegroundColor Green
}

Write-Host "`n🧪 Watchdog complete."
