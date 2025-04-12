# Omni Sentinel AI - Basic Port Scanner Script

param (
    [string]$Target = "localhost",
    [int[]]$Ports = @(22, 80, 443, 445, 3389, 8080)
)

Write-Host "`n🌐 Scanning TCP Ports on $Target...`n"

foreach ($port in $Ports) {
    try {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $async = $tcp.BeginConnect($Target, $port, $null, $null)
        $wait = $async.AsyncWaitHandle.WaitOne(1000, $false)
        
        if ($wait -and $tcp.Connected) {
            Write-Host "✅ Port $port is OPEN"
            $tcp.Close()
        } else {
            Write-Host "❌ Port $port is CLOSED or FILTERED"
        }
    } catch {
        Write-Host "⚠️ Error scanning port $port: $_"
    }
}

Write-Host "`n✅ Scan complete.`n"
