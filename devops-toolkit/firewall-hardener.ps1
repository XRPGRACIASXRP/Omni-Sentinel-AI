# Omni Sentinel AI - Firewall Hardener Script
Write-Host "`n🛡️  Starting Firewall Hardening..."

# 1. Block inbound connections except allowed
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultOutboundAction Allow

# 2. Enable firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# 3. Allow essential services
Write-Host "✅ Allowing RDP, HTTP, HTTPS..."
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow HTTPS" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# 4. Block SMB ports (445)
Write-Host "⛔ Blocking SMB..."
New-NetFirewallRule -DisplayName "Block SMB" -Direction Inbound -LocalPort 445 -Protocol TCP -Action Block

# 5. Enable logging
Set-NetFirewallProfile -LogAllowed True -LogBlocked True -LogFileName '%systemroot%\system32\LogFiles\Firewall\pfirewall.log'

Write-Host "`n✅ Firewall hardening complete."
