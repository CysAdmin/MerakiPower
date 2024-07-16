<#
.SYNOPSIS
Adds a new Layer 3 inbound firewall rule to a specified MX network.

.DESCRIPTION
This function adds a new Layer 3 inbound firewall rule to a specified network in the Meraki dashboard. 
It requires an authentication token, network ID, and details about the firewall rule. 
The function checks for existing rules to prevent duplicates, and updates the firewall rules.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER NetworkId
The unique identifier of the network to which the firewall rule will be added.

.PARAMETER Comment
A comment for the firewall rule, typically used to describe the rule's purpose.

.PARAMETER Policy
The policy of the firewall rule, either "deny" or "allow".

.PARAMETER Protocol
The protocol of the firewall rule, either "tcp" or "udp".

.PARAMETER SrcPort
The source port for the firewall rule.

.PARAMETER SrcCidr
The source CIDR block or VLAN ID in the format VLAN(1).*

.PARAMETER DestPort
The destination port for the firewall rule.

.PARAMETER DestCidr
The destination CIDR block or VLAN ID in the format VLAN(1).*

.PARAMETER SyslogEnabled
Boolean value to enable or disable syslog for the firewall rule.

.EXAMPLE
Add-NetworkApplianceL3InboundFirewallRule -AuthToken $ApiKey -NetworkId $NetworkId -Comment "Allow HTTPS traffic" 
-Policy "allow" -Protocol "tcp" -SrcPort "Any" -SrcCidr "Any" -DestPort "443" -DestCidr "192.168.1.0/24" -SyslogEnabled $false

This example adds a firewall rule to allow HTTPS traffic to the specified destination CIDR block.

.NOTES
The SrcCidr and DestCidr parameters can also accept VLAN IDs in the format VLAN(1).*
#>
Function Add-MXNetworkL3InboundFirewallRule{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param(
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$AuthToken,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$NetworkId,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Comment,
        [Parameter(Mandatory = $true)][ValidateSet("deny", "allow")][string]$Policy,
        [Parameter(Mandatory = $true)][ValidateSet("tcp", "udp")][string]$Protocol,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$SrcPort,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$SrcCidr,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$DestPort,
        [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$DestCidr,
        [Parameter(Mandatory = $true)][boolean]$SyslogEnabled
    )
    $url = "/networks/$($NetworkId)/appliance/firewall/inboundFirewallRules" 
    $newRule = [PSCustomObject]@{
        comment = $Comment
        policy = $Policy
        protocol = $Protocol
        destPort = $DestPort
        destCidr = $DestCidr
        srcPort = $SrcPort
        srcCidr = $SrcCidr
        syslogEnabled = $SyslogEnabled
    }
    $Rules = Get-NetworkApplianceL3InboundFirewallRules -AuthToken $AuthToken -NetworkId $NetworkId
    # Remove the Default rule, as it will be added as an extra rule. Default is always present
    [object[]]$Rules.rules = $Rules.rules | Where-Object {$_.comment -ne "Default rule"}

    # Check if Rule already exists
    foreach($rule in $Rules.rules){
        if(
            ($rule.comment -eq $newRule.comment) -and
            ($rule.policy -eq $newRule.policy) -and
            ($rule.protocol -eq $newRule.protocol) -and
            ($rule.destPort -eq $newRule.destPort) -and
            ($rule.destCidr -eq $newRule.destCidr) -and
            ($rule.srcPort -eq $newRule.srcPort) -and
            ($rule.srcCidr -eq $newRule.srcCidr)
        ){
            Write-Output $rule
            Write-Output "Rule already exists!"
            return
        }
    }

    # Add Rule on Top of the Existing Rules Array
    $Rules.rules += $newRule

    # If only one Rule is present, ensure it's an Array - important for API
    if($Rules.rules.Count -eq 1){
        $Rules.rules = @($Rules.rules)
    }

    # Remove syslogDefaultRule Property since it's an optional parameter
    $Rules.PSObject.Properties.Remove('syslogDefaultRule')
    Write-Output $Rules.rules
    if ($PSCmdlet.ShouldProcess("Appliance Firewall Rules", "Update")) {
        Invoke-MrkRequest -Method Put -Resource $url -AuthToken $AuthToken -Body ($Rules | ConvertTo-Json)     
    }
}
