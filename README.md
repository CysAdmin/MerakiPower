# PowerShell Meraki Module

A PowerShell module for interacting with the Cisco Meraki Dashboard API. This module allows you to manage various aspects of your Meraki network using PowerShell cmdlets.<br>
Whats the difference to Modules like [Meraki-Powershell-Modul](https://github.com/DocNougat/Meraki-Powershell-Module/) ? <br>Nothing
Every Developer knows it, if its not made by yourself its not made by yourself 😀

## Overview

This module provides cmdlets for common operations with Cisco Meraki's API, including managing networks and firewall rules.

## Contribution

Contributions are welcome! Please fork the repository and submit a pull request.

## Installation

To install the module, you can simply download it from the repository and import it into your PowerShell session.

```powershell
# Clone the repository
git clone https://github.com/cysadmin/MerakiPower.git

# Navigate to the module directory
cd MerakiPower

# Import the module
Import-Module ./MerakiPower.psd1
```

# Usage
## Get a list of organizations
```powershell
$authToken = "your_meraki_api_key"
Get-MrkOrganizations -AuthToken $authToken
```

## Get a list of networks in an organization
```powershell
$organizationId = "your_organization_id"
Get-MrkOrganizationNetworks -AuthToken $authToken -OrganizationId $organizationId
```

## Add a new inbound firewall rule
```powershell
$arguments = @{
    AuthToken =   $AuthToken
    NetworkId =   {your_network_id}
    Comment   =   "Allow HTTPS"
    Policy    =    "Allow"
    Protocol  =    "TCP"
    SrcPort   =    "Any"
    SrcCidr   =    "Any"
    DestPort  =    "443"
    DestCidr  =    "Any"
    SyslogEnabled = $false
}
Add-NetworkApplianceL3InboundFirewallRule @arguments
```
## Function Overview

- **Add-MXNetworkL3InboundFirewallRule**
  - Adds an inbound firewall rule for MX network devices.

- **Add-MXNetworkL3OutboundFirewallRule**
  - Adds an outbound firewall rule for MX network devices.

- **Copy-NetworkApplianceVlan**
  - Copies a VLAN configuration on a network appliance.

- **Get-MrkNetworkClients**
  - Retrieves information about clients connected to a Meraki network.

- **Get-MrkOrganizationAdmins**
  - Retrieves information about administrators in a Meraki organization.

- **Get-MrkOrganizationDevices**
  - Retrieves information about devices in a Meraki organization.

- **Get-MrkOrganizationNetworks**
  - Retrieves information about networks in a Meraki organization.

- **Get-MrkOrganizations**
  - Retrieves information about Meraki organizations.

- **Get-MXNetworkL3InboundFirewallRules**
  - Retrieves inbound firewall rules for MX network devices.

- **Get-MXNetworkL3OutboundFirewallRules**
  - Retrieves outbound firewall rules for MX network devices.

- **Get-NetworkApplianceFwCFRules**
  - Retrieves cellular firewall rules for a network appliance.

- **Get-NetworkApplianceFwInboundCFRules**
  - Retrieves inbound cellular firewall rules for a network appliance.

- **Get-NetworkApplianceFwOneToManyNatRules**
  - Retrieves one-to-many NAT rules for a cellular firewall on a network appliance.

- **Get-NetworkApplianceFwOneToOneNatRules**
  - Retrieves one-to-one NAT rules for a cellular firewall on a network appliance.

- **Get-NetworkApplianceFwPortForwardingRules**
  - Retrieves port forwarding rules for a cellular firewall on a network appliance.

- **Get-NetworkApplianceL7FwApplicationCategories**
  - Retrieves application categories for Layer 7 firewall rules on a network appliance.

- **Get-NetworkApplianceL7FwRules**
  - Retrieves Layer 7 firewall rules for a network appliance.

- **Get-NetworkApplianceVlan**
  - Retrieves VLAN configuration for a network appliance.

- **Get-NetworkApplianceVlans**
  - Retrieves VLANs configured on a network appliance.

- **Get-OrgSecureConnectPrivateApplications**
  - Retrieves private applications configured for Secure Connect in an organization.

- **New-NetworkApplianceFwCFRules**
  - Creates new cellular firewall rules for a network appliance.

- **Set-NetworkApplianceFwCFRules**
  - Updates cellular firewall rules for a network appliance.

- **Set-NetworkApplianceFwFirewalledService**
  - Sets firewalled services on a network appliance.




This project is licensed under the MIT License. See the LICENSE file for details.
