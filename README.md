# PowerShell Meraki Module

A PowerShell module for interacting with the Cisco Meraki Dashboard API. This module allows you to manage various aspects of your Meraki network using PowerShell cmdlets.

## Overview

This module provides cmdlets for common operations with Cisco Meraki's API, including managing networks, devices, clients, and firewall rules.

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

This project is licensed under the MIT License. See the LICENSE file for details.
