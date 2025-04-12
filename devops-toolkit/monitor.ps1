# Omni Sentinel AI - System Monitoring Script

Write-Host "🧠 Monitoring System Health...`n"

# CPU Usage
$cpuUsage = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
Write-Host "CPU Usage: $([math]::Round($cpuUsage, 2))%"

# Memory Usage
$memory = Get-WmiObject Win32_OperatingSystem
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
$freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
$usedMemory = $totalMemory - $freeMemory
Write-Host "RAM Usage: $usedMemory GB / $totalMemory GB"

# Disk Usage
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
foreach ($d in $disk) {
    $used = [math]::Round(($d.Size - $d.FreeSpace) / 1GB, 2)
    $total = [math]::Round($d.Size / 1GB, 2)
    Write-Host "Disk [$($d.DeviceID)]: $used GB / $total GB"
}

# Network Stats
$netStats = Get-NetAdapterStatistics
foreach ($adapter in $netStats) {
    Write-Host "`nAdapter: $($adapter.Name)"
    Write-Host "  Bytes Sent: $($adapter.OutboundBytes)"
    Write-Host "  Bytes Received: $($adapter.InboundBytes)"
}

Write-Host "`n✅ Monitoring complete."
