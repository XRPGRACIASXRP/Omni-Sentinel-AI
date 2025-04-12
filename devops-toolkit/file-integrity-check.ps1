# Omni Sentinel AI – File Integrity Checker

# CONFIG: Set the folder you want to monitor
$targetFolder = "C:\ImportantData"
$hashFile = "$targetFolder\file-hashes.txt"

Function Get-FileHashList {
    Get-ChildItem -Path $targetFolder -Recurse -File | ForEach-Object {
        $hash = Get-FileHash $_.FullName -Algorithm SHA256
        "$($hash.Hash) $($_.FullName)"
    }
}

# If no hash file exists, create baseline
if (-not (Test-Path $hashFile)) {
    Write-Host "🧾 No baseline found. Creating hash record..."
    Get-FileHashList | Out-File $hashFile
    Write-Host "✅ Baseline hash file created: $hashFile"
} else {
    Write-Host "🔍 Comparing current files to baseline..."

    $current = Get-FileHashList
    $baseline = Get-Content $hashFile

    $diff = Compare-Object -ReferenceObject $baseline -DifferenceObject $current

    if ($diff) {
        Write-Host "⚠️ File changes detected:"
        $diff | Format-Table -AutoSize
    } else {
        Write-Host "✅ No file changes found. Integrity intact."
    }
}
