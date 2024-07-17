<#
.SYNOPSIS
Copies an existing VLAN configuration to a new VLAN on the network appliance.

.DESCRIPTION
This function copies the configuration of an existing VLAN and creates a new VLAN with the specified parameters. 
It allows the user to define a new VLAN name, ID, subnet, and interface IP for the new VLAN.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network containing the VLAN.

.PARAMETER VlanId
The unique identifier of the VLAN to be copied.

.PARAMETER NewVlanName
The name for the new VLAN.

.PARAMETER NewVlanId
The unique identifier for the new VLAN.

.PARAMETER NewVlanSubnet
The subnet for the new VLAN.

.PARAMETER NewVlanInterfaceIp
The interface IP for the new VLAN.

.EXAMPLE
Copy-NetworkApplianceVlan -AuthToken $ApiKey -NetworkId $NetworkId -VlanId 1 -NewVlanName "New VLAN" -NewVlanId 2 -NewVlanSubnet "192.168.2.0/24" -NewVlanInterfaceIp "192.168.2.1"

This example copies the VLAN with ID 1 to a new VLAN with the specified parameters in the given network.

#>
Function Copy-NetworkApplianceVlan{    
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,
        [Parameter(Mandatory = $true)]
        [string]$VlanId,        
        [Parameter(Mandatory = $true)]
        [string]$NewVlanName,        
        [Parameter(Mandatory = $true)]
        [string]$NewVlanId,       
        [Parameter(Mandatory = $true)]
        [string]$NewVlanSubnet,
        [Parameter(Mandatory = $true)]
        [string]$NewVlanInterfaceIp
    )
    $url = "/networks/$($NetworkId)/appliance/vlans/$($VlanId)"
    $urlNewVlan = "/networks/$($NetworkId)/appliance/vlans/"
    $referenceVlan = Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
    $newVlan = $referenceVlan
    $newVlan.name = $NewVlanName
    $newVlan.id = $NewVlanId
    $newVlan.subnet = $NewVlanSubnet
    $newVlan.applianceIp = $NewVlanInterfaceIp
    $url = $urlNewVlan

    Write-Output $newVlan
    if ($PSCmdlet.ShouldProcess("Copy VLAN", "Copy VLAN: $($VlanId) to VLAN: $($NewVlanId)")) {
        Invoke-MrkRequest -Method Post -Resource $url -AuthToken $AuthToken -Body ($newVlan | ConvertTo-Json)    
    }
}


<#
    "id": "1234",
    "name": "My VLAN",
    "subnet": "192.168.1.0/24",
    "applianceIp": "192.168.1.2",
    "groupPolicyId": "101",
    "templateVlanType": "same",
    "cidr": "192.168.1.0/24",
    "mask": 28,
    "ipv6": {
        "enabled": true,
        "prefixAssignments": [
            {
                "autonomous": false,
                "staticPrefix": "2001:db8:3c4d:15::/64",
                "staticApplianceIp6": "2001:db8:3c4d:15::1",
                "origin": {
                    "type": "internet",
                    "interfaces": [ "wan0" ]
                }
            }
        ]
    },
    "dhcpHandling": "Run a DHCP server",
    "dhcpLeaseTime": "30 minutes",
    "mandatoryDhcp": { "enabled": true },
    "dhcpBootOptionsEnabled": true,
    "dhcpOptions": [
        {
            "code": "3",
            "type": "text",
            "value": "five"
        }
    ]
#>