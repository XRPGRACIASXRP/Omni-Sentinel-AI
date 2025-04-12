# Omni Sentinel AI – DNS Resolution Check

$dnsServers = @("1.1.1.1", "8.8.8.8", "9.9.9.9") # Cloudflare, Google, Quad9
$testDomains = @("microsoft.com", "github.com", "google.com", "openai.com")

foreach ($server in $dnsServers) {
    Write-Host "`n🔍 Testing DNS Server: $server" -ForegroundColor Cyan
    foreach ($domain in $testDomains) {
        try {
            $result = Resolve-DnsName -Name $domain -Server $server -ErrorAction Stop
            if ($result) {
                Write-Host "✅ $domain resolved via $server" -ForegroundColor Green
            }
        } catch {
            Write-Host "❌ Failed to resolve $domain via $server" -ForegroundColor Red
        }
    }
}
