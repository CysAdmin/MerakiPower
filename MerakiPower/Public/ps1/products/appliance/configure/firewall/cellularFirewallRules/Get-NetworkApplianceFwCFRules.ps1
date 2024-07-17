<#
.SYNOPSIS
Retrieves the cellular firewall rules for a specified network.

.DESCRIPTION
This function retrieves the cellular firewall rules for a specified network using the Meraki API. 
The API request requires an authentication token and the network ID.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to retrieve the cellular firewall rules.

.EXAMPLE
PS C:\> Get-NetworkApplianceFwCFRules -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef"
Retrieves the cellular firewall rules for the specified network using the provided authentication token.

#>
Function Get-NetworkApplianceFwCFRules{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )

    $url = "/networks/$($NetworkId)/appliance/firewall/cellularFirewallRules"
   
    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}