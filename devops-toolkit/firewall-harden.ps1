# Omni Sentinel AI - Firewall Hardening Script
Write-Host "`n🛡️ Applying Firewall Hardening Policies..."

# 1. Enable Firewall on all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Write-Host "✅ Firewall enabled on all profiles."

# 2. Set default inbound/outbound rules
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultOutboundAction Allow
Write-Host "✅ Inbound blocked / Outbound allowed"

# 3. Allow specific ports
Write-Host "🔓 Allowing safe services..."
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow PowerShell Remoting" -Direction Inbound -LocalPort 5985,5986 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow HTTPS" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow ICMP (Ping)" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow

# 4. Block SMB (port 445)
Write-Host "⛔ Blocking SMB (port 445)..."
New-NetFirewallRule -DisplayName "Block SMB" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Block

# 5. Enable Logging
Set-NetFirewallProfile -LogFileName '%systemroot%\system32\LogFiles\Firewall\pfirewall.log' -LogMaxSizeKilobytes 4096 -LogAllowed True -LogBlocked True

Write-Host "`n✅ Firewall hardened and logging enabled. Stay safe, Commander."
