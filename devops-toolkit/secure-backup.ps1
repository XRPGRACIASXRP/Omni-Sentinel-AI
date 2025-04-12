# Omni Sentinel AI - Secure Backup Script

param (
    [string]$SourcePath = "C:\ImportantData",
    [string]$BackupRoot = "C:\OmniBackups"
)

# Create backup folder if needed
if (-not (Test-Path $BackupRoot)) {
    New-Item -ItemType Directory -Path $BackupRoot | Out-Null
}

# Generate timestamped folder name
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFolder = Join-Path $BackupRoot "Backup_$timestamp"

# Perform backup
Write-Host "📦 Backing up $SourcePath to $backupFolder..."
Copy-Item -Path $SourcePath -Destination $backupFolder -Recurse -Force

# Confirm success
Write-Host "✅ Backup complete: $backupFolder"
