# Omni Sentinel AI – USB Activity Logger

Write-Host "`n🔌 Scanning USB device connection history..."

# Query USB plug/unplug events
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-DriverFrameworks-UserMode/Operational';
    ID = 2003, 2100
} -MaxEvents 50

foreach ($event in $events) {
    $eventTime = $event.TimeCreated
    $msg = $event.Message

    if ($msg -like "*USB*") {
        Write-Host "`n🕒 Time: $eventTime"
        Write-Host "🔍 $msg"
    }
}

Write-Host "`n✅ USB activity check complete.`n"
