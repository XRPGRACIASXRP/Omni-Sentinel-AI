# Omni Sentinel AI – Boot Time & Startup Check Script

Write-Host "`n⏱️ Boot Status Report"

# Get system boot time
$bootTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptime = New-TimeSpan -Start $bootTime -End (Get-Date)

Write-Host "`n📅 Last Boot Time: $bootTime"
Write-Host "🔁 Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"

# Get recent shutdowns and restarts
Write-Host "`n📜 Recent Shutdown/Restart Events:"
Get-WinEvent -FilterHashtable @{LogName='System'; ID=1074} -MaxEvents 5 |
    Select-Object TimeCreated, Message | Format-Table -AutoSize

# Show startup applications
Write-Host "`n🚦 Startup Programs:"
Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table -Wrap

Write-Host "`n✅ Boot check complete.`n"
