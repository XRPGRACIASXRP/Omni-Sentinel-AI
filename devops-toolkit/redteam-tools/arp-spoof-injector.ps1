<#
.SYNOPSIS
    ARP Spoofing Injection (LAB ONLY)
.DESCRIPTION
    Spoofs ARP entries between two hosts to perform a Man-in-the-Middle.
    Requires admin rights and lab setup.
#>

Write-Host "`n⚠️ Starting ARP Spoofing Tool (Simulation Mode)" -ForegroundColor Red

$targetIP = Read-Host "Enter victim IP address"
$gatewayIP = Read-Host "Enter gateway IP address"

Write-Host "`n[*] Spoofing ARP table of victim ($targetIP) to think YOU are the gateway ($gatewayIP)..."
Write-Host "[*] Sending forged ARP replies every 5 seconds..."

while ($true) {
    # Simulate packet sending (lab mode)
    Write-Host "🧬 [SEND] Forged ARP -> $targetIP | Telling it: $gatewayIP = YOUR MAC"
    Start-Sleep -Seconds 5
}

# To run real version, integrate with Scapy (Python) or use arpspoof.exe
