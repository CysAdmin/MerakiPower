<#
.SYNOPSIS
Sets the configuration for a specified firewalled service in a network.

.DESCRIPTION
This function updates the configuration for a specified firewalled service within a given network using the Meraki API. The user can set the access type and allowed IP addresses for the service.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to set the firewalled service configuration.

.PARAMETER Service
The service to configure. Valid values are "ICMP", "WEB", and "SNMP".

.PARAMETER Access
The access type for the service. Valid values are "unrestricted" and "restricted".

.PARAMETER AllowedIps
An array of allowed IP addresses for the service when access is set to "restricted".

.EXAMPLE
PS C:\> Set-NetworkApplianceFwFirewalledService -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef" -Service "WEB" -Access "restricted" -AllowedIps @("192.168.1.1", "192.168.1.2")
Updates the WEB service to be restricted to the specified IP addresses.
#>
Function Set-NetworkApplianceFwFirewalledService{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact="HIGH")]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,        
        [Parameter(Mandatory = $true)]
        [ValidateSet("ICMP", "WEB", "SNMP")]
        [string]$Service,
        [Parameter(Mandatory = $true)]
        [ValidateSet("unrestricted", "restricted")]
        [string]$Access,
        [Parameter(Mandatory = $true)]
        [string[]]$AllowedIps
    )
    
    # Create the confirmation object
    $confirmObject = [PSCustomObject]@{
        service    = $Service
        access     = $Access
        allowedIps = $AllowedIps
    }
    
    # Display the confirmation object in a formatted table
    $confirmObject | Format-Table -AutoSize | Out-String | Write-Host
           
    if ($PSCmdlet.ShouldProcess("Firewalled Service $($Service)", "Update")) { 
        $url = "/networks/$($NetworkId)/appliance/firewall/firewalledServices/$($Service)"  
        $body = [PSCustomObject]@{
            access     = $Access
            allowedIps = $AllowedIps
        } 
        Invoke-MrkRequest -Method Put -Resource $url -AuthToken $AuthToken -Body ($body | ConvertTo-Json)   
    }
}
