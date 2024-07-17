<#
.SYNOPSIS
Fetches information about a specific VLAN on the network appliance.

.DESCRIPTION
This function retrieves detailed information about a specific VLAN configured on the network appliance. 
The information can be returned as a JSON object if the -AsJson switch is provided.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network containing the VLAN.

.PARAMETER VlanId
The unique identifier of the VLAN to retrieve information for.

.PARAMETER AsJson
Switch to specify if the output should be in JSON format. If not provided, the output will be in the default object format.

.EXAMPLE
Get-NetworkApplianceVlan -AuthToken $ApiKey -NetworkId $NetworkId -VlanId 1 -AsJson

This example retrieves the VLAN with ID 1 in the specified network and returns the information in JSON format.

#>
Function Get-NetworkApplianceVlan{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,    
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,        
        [Parameter(Mandatory = $true)]
        [string]$VlanId,
        [switch]$AsJson
    )
    $url = "/networks/$($NetworkId)/appliance/vlans/$($VlanId)"

    if($AsJson){
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken | ConvertTo-Json -Depth 10
    }else {
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken 
    }
}