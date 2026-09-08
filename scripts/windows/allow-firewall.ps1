# Allow inbound TCP 52413-52415 so other LAN nodes can join this exo process.
# PAIR's Windows installer does the equivalent for its proxy ports.

#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'
$RuleName = 'exo local cluster'
$Ports = '52413-52415'

if (Get-NetFirewallRule -DisplayName $RuleName -ErrorAction SilentlyContinue) {
    Remove-NetFirewallRule -DisplayName $RuleName
}

New-NetFirewallRule -DisplayName $RuleName -Direction Inbound -Action Allow `
    -Protocol TCP -LocalPort 52413,52414,52415 | Out-Null
Write-Host "Firewall rule '$RuleName' allows TCP $Ports inbound."
