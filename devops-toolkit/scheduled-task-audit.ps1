# Omni Sentinel AI – Scheduled Task Audit

Write-Host "`n⏰ Scheduled Task Audit Started"

# Get all scheduled tasks
$tasks = Get-ScheduledTask | Where-Object { $_.TaskPath -notlike '\Microsoft*' }

foreach ($task in $tasks) {
    $details = Get-ScheduledTaskInfo -TaskName $task.TaskName -TaskPath $task.TaskPath

    Write-Host "`n📌 Task: $($task.TaskName)"
    Write-Host "  Path: $($task.TaskPath)"
    Write-Host "  Last Run Time: $($details.LastRunTime)"
    Write-Host "  Next Run Time: $($details.NextRunTime)"
    Write-Host "  Status: $($details.LastTaskResult)"
}

# Highlight recently added tasks
Write-Host "`n🕵️ Highlighting tasks added in last 7 days:"
$recentTasks = Get-ScheduledTask |
    Where-Object {
        ($_.Date -ne $null) -and
        ((Get-Date) - $_.Date).Days -lt 7
    }

if ($recentTasks) {
    $recentTasks | Select-Object TaskName, TaskPath | Format-Table -AutoSize
} else {
    Write-Host "✅ No new tasks in the last 7 days."
}

Write-Host "`n✅ Scheduled Task Audit Complete"
