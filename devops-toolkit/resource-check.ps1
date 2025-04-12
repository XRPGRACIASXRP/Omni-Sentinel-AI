# Omni Sentinel AI - Resource Health Check Script
Write-Host "`n📊 Running Resource Health Check..."

# 1. CPU Queue Length
Write-Host "`n🌀 CPU Queue Length:"
Get-Counter '\System\Processor Queue Length' |
  Select-Object -ExpandProperty CounterSamples |
  Select-Object InstanceName, CookedValue |
  Format-Table -AutoSize

# 2. Available Memory
Write-Host "`n💾 Available Memory (MB):"
(Get-Counter '\Memory\Available MBytes').CounterSamples |
  Select-Object CookedValue |
  Format-Table -AutoSize

# 3. Disk Queue
Write-Host "`n🛠️ Disk Queue Length:"
Get-Counter '\PhysicalDisk(_Total)\Avg. Disk Queue Length' |
  Select-Object -ExpandProperty CounterSamples |
  Select-Object InstanceName, CookedValue |
  Format-Table -AutoSize

# 4. Paging File Usage
Write-Host "`n📄 Paging File Usage:"
Get-Counter '\Paging File(_Total)\% Usage' |
  Select-Object -ExpandProperty CounterSamples |
  Select-Object InstanceName, CookedValue |
  Format-Table -AutoSize

# 5. System Uptime
Write-Host "`n⏱️ System Uptime (Days):"
$uptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$days = (New-TimeSpan -Start $uptime -End (Get-Date)).Days
Write-Host "$days days"

# Summary
Write-Host "`n✅ Resource Check Complete."
