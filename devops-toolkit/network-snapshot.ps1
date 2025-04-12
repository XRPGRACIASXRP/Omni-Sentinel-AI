# Omni Sentinel AI – Network Snapshot Tool

Write-Host "`n🌐 Capturing real-time network connection snapshot..."

Get-NetTCPConnection | ForEach-Object {
    $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        LocalAddress  = $_.LocalAddress
        LocalPort     = $_.LocalPort
        RemoteAddress = $_.RemoteAddress
        RemotePort    = $_.RemotePort
        State         = $_.State
        Process       = $proc.Name
        PID           = $_.OwningProcess
    }
} | Format-Table -AutoSize

Write-Host "`n✅ Snapshot complete."
