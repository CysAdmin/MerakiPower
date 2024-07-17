<#
.SYNOPSIS
Sets the cellular firewall rules for a specified network.

.DESCRIPTION
This function sets the cellular firewall rules for a specified network using the Meraki API. 
It takes an authentication token, a network ID, and a configuration object for the rules.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to set the cellular firewall rules.

.PARAMETER RuleConfig
An array of objects representing the configuration of the firewall rules.

.EXAMPLE
PS C:\> $ruleConfig = Get-NetworkApplianceFwCFRules -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef"
PS C:\> $ruleConfig.rules[0].comment = "CHANGE ANY VALUE HERE"
PS C:\> Set-NetworkApplianceFwCFRules -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef" -RuleConfig $ruleConfig
Sets the specified firewall rules for the given network.
#>
Function Set-NetworkApplianceFwCFRules{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,
        [Parameter(Mandatory = $true)]
        [object[]]$RuleConfig
    )
    $url = "/networks/$($NetworkId)/appliance/firewall/cellularFirewallRules"
    $RuleConfig.rules = $RuleConfig.rules | Where-Object {$_.comment -ne "Default rule"}
    
    Write-Output $RuleConfig.rules
    if ($PSCmdlet.ShouldProcess("Appliance CF Firewall Rules", "Update")) {
        Invoke-MrkRequest -Method Put -Resource $url -AuthToken $AuthToken -Body ($RuleConfig | ConvertTo-Json)     
    }
}