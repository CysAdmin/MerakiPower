<#
.SYNOPSIS
Retrieves the VLANs configured for a specified network.

.DESCRIPTION
This function fetches the VLANs configured for a given network in the Meraki dashboard. 
It requires an authentication token and the network ID as parameters. The function can also 
return the result in JSON format if the -AsJson switch is specified.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network from which the VLANs will be retrieved.

.PARAMETER AsJson
If specified, the function returns the result in JSON format.

.EXAMPLE
Get-NetworkApplianceVlans -AuthToken $ApiKey -NetworkId $NetworkId

This example retrieves the VLANs for the specified network.

.EXAMPLE
Get-NetworkApplianceVlans -AuthToken $ApiKey -NetworkId $NetworkId -AsJson

This example retrieves the VLANs for the specified network and returns the result in JSON format.
#>
Function Get-NetworkApplianceVlans{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,
        [switch]$AsJson
    )
    $url = "/networks/$($NetworkId)/appliance/vlans"

    if ($AsJson) {
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken | ConvertTo-Json -Depth 10
    } else {
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
    }
}
