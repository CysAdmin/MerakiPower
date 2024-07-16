<#
.SYNOPSIS
Retrieves the list of clients connected to a specified network.

.DESCRIPTION
This function fetches the list of clients connected to a given network in the Meraki dashboard. 
It requires an authentication token and the network ID as parameters. The function sends a GET 
request to the Meraki API and returns the list of clients.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network from which the clients will be retrieved.

.EXAMPLE
Get-MrkNetworkClients -AuthToken $ApiKey -NetworkId $NetworkId

This example retrieves the list of clients connected to the specified network.

.NOTES
Ensure that the authentication token has the necessary permissions to access the network information.
#>
Function Get-MrkNetworkClients{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $url = "/networks/$($NetworkId)/clients"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}
