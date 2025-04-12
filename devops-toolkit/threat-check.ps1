# Omni Sentinel AI - Threat Check Script
Write-Host "`n🛡️ Running Threat Check..."

# 1. Check for Failed Logon Attempts
Write-Host "`n🔐 Checking Failed Logons:"
Get-EventLog -LogName Security -InstanceId 4625 -Newest 5 |
  Select-Object TimeGenerated, EntryType, Message |
  Format-Table -AutoSize

# 2. Check for Antivirus Status
Write-Host "`n🧪 Checking Antivirus Status:"
Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName AntiVirusProduct |
  Select-Object displayName, productState, timestamp

# 3. Check for Suspicious Processes
Write-Host "`n🧠 Checking for Suspicious Processes (e.g., mimikatz, powersploit):"
$suspicious = "mimikatz","powersploit","Empire","nc","netcat"
Get-Process | Where-Object { $suspicious -contains $_.Name } |
  Select-Object Name, Id, Path |
  Format-Table -AutoSize

# 4. Admin Accounts Check
Write-Host "`n🧑‍💼 Checking for Unusual Admin Accounts:"
Get-LocalGroupMember -Group "Administrators" |
  Select-Object Name, PrincipalSource

# 5. Summary
Write-Host "`n✅ Threat Check Complete."
