<#
.SYNOPSIS
    Network Credentials Dumper
.DESCRIPTION
    Extracts cached credentials from local system and connected shares.
#>

Write-Host "`n[*] Gathering cached user info..." -ForegroundColor Cyan

# Cached domain users
Get-WmiObject -Class Win32_UserProfile | Where-Object {
    $_.LocalPath -like "C:\Users\*"
} | ForEach-Object {
    Write-Host "  [+] Found user: $($_.LocalPath.Split('\')[-1])"
}

Write-Host "`n[*] Checking mapped network drives..." -ForegroundColor Cyan

# Map drives and credentials
$drives = net use
if ($drives -match "\\\\") {
    $drives -split "`n" | Where-Object { $_ -match "\\\\" } | ForEach-Object {
        Write-Host "  [+] $_"
    }
} else {
    Write-Host "  [-] No network drives found." -ForegroundColor DarkGray
}

Write-Host "`n[*] Dumping network session tokens..." -ForegroundColor Cyan
$query = "SELECT * FROM Win32_NetworkLoginProfile"
Get-WmiObject -Query $query | Select-Object Name, FullName, LastLogon | ForEach-Object {
    Write-Host "  [!] User: $($_.Name) | Full Name: $($_.FullName) | Last Login: $($_.LastLogon)"
}
