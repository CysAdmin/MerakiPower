<#
.SYNOPSIS
Retrieves the configuration for all firewalled services in a network.

.DESCRIPTION
This function retrieves the configuration details for all firewalled services within a given network using the Meraki API.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to retrieve the firewalled services configuration.

.EXAMPLE
PS C:\> Get-NetworkApplianceFwFirewalledServices -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef"
Retrieves the firewalled services configuration for the specified network.
#>
Function Get-NetworkApplianceFwFirewalledServices {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    
    $url = "/networks/$($NetworkId)/appliance/firewall/firewalledServices"
    
    # Invoke the API request and return the result
    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}
