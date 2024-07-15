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