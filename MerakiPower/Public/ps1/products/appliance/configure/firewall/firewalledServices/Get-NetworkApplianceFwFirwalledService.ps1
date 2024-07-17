<#
.SYNOPSIS
Retrieves the configuration for a specific firewalled service in a network.

.DESCRIPTION
This function retrieves the configuration details for a specified firewalled service 
within a given network using the Meraki API.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to retrieve the firewalled service configuration.

.PARAMETER Service
The name of the service to retrieve configuration details for (ICMP, WEB, SNMP).

.EXAMPLE
PS C:\> Get-NetworkApplianceFwFirewalledService -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef" -Service "WEB"
Retrieves the firewalled service configuration for the 'WEB' service in the specified network.
#>
Function Get-NetworkApplianceFwFirewalledService {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,        
        [ValidateSet("ICMP", "WEB", "SNMP")]
        [Parameter(Mandatory = $true)]
        [string]$Service
    )
    
    $url = "/networks/$($NetworkId)/appliance/firewall/firewalledServices/$($Service)"
    
    # Invoke the API request and return the result
    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}
