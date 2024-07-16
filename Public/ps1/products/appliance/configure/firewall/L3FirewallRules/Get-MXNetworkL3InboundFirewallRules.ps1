<#
.SYNOPSIS
Retrieves the Layer 3 inbound firewall rules for a specified MX network.

.DESCRIPTION
This function fetches the current Layer 3 inbound firewall rules configured for a given network in the Meraki dashboard.
It requires an authentication token and the network ID as parameters.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network from which the firewall rules will be retrieved.

.EXAMPLE
Get-NetworkApplianceL3InboundFirewallRules -AuthToken $ApiKey -NetworkId $NetworkId

This example retrieves the Layer 3 inbound firewall rules for the specified network.

#>
Function Get-MXNetworkL3InboundFirewallRules{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $url = "/networks/$($NetworkId)/appliance/firewall/inboundFirewallRules"

    $result = Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
    return $result
}
