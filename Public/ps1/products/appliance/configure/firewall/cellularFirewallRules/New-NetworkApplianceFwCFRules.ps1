<#
.SYNOPSIS
Creates a new cellular firewall rule for a specified network.

.DESCRIPTION
This function creates a new cellular firewall rule for a specified network using the Meraki API.
The API request requires an authentication token and the network ID along with the details of the rule to be created.

.PARAMETER AuthToken
The authentication token used to authorize the API request.

.PARAMETER NetworkId
The ID of the network for which to create the cellular firewall rule.

.PARAMETER Comment
A comment for the firewall rule.

.PARAMETER Policy
The policy for the firewall rule (e.g., "allow" or "deny").

.PARAMETER Protocol
The protocol for the firewall rule (e.g., "tcp" or "udp").

.PARAMETER SrcPort
The source port for the firewall rule.

.PARAMETER SrcCidr
The source CIDR for the firewall rule.

.PARAMETER DestPort
The destination port for the firewall rule.

.PARAMETER DestCidr
The destination CIDR for the firewall rule.

.PARAMETER SyslogEnabled
Boolean indicating whether syslog is enabled for the rule.

.EXAMPLE
PS C:\> New-NetworkApplianceFwCFRules -AuthToken "123456789abcdef" -NetworkId "N_1234567890abcdef" -Comment "Allow HTTP" -Policy "allow" -Protocol "tcp" -SrcPort "Any" -SrcCidr "Any" -DestPort "80" -DestCidr "192.168.1.0/24" -SyslogEnabled $false
Creates a new rule that allows HTTP traffic to the specified destination CIDR.

#>
Function New-NetworkApplianceFwCFRules{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,
        [Parameter(Mandatory = $true)][string]$Comment,
        [Parameter(Mandatory = $true)][string]$Policy,
        [Parameter(Mandatory = $true)][string]$Protocol,
        [Parameter(Mandatory = $true)][string]$SrcPort,
        [Parameter(Mandatory = $true)][string]$SrcCidr,
        [Parameter(Mandatory = $true)][string]$DestPort,
        [Parameter(Mandatory = $true)][string]$DestCidr,
        [Parameter(Mandatory = $true)][boolean]$SyslogEnabled
    )
    $url = "/networks/$($NetworkId)/appliance/firewall/cellularFirewallRules"
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
    $Rules = Get-NetworkApplianceFwCFRules -AuthToken $AuthToken -NetworkId $NetworkId
    $Rules.rules = $Rules.rules | Where-Object {$_.comment -ne "Default rule"}
    $Rules.rules += $newRule

    # Ensure if only one Rule is present its an array
    if($Rules.rules.Count -eq 1){
        $Rules.rules = @($Rules.rules)
    }
    Write-Output $Rules.rules
    if ($PSCmdlet.ShouldProcess("Appliance CF Firewall Rules", "Update")) {
        Invoke-MrkRequest -Method Put -Resource $url -AuthToken $AuthToken -Body ( $Rules | ConvertTo-Json)     
    }
    <#
    $payload = [PSCustomObject]@{
        rules = @(
            [PSCustomObject]@{
                comment = "Test."
                policy = "allow"
                protocol = "tcp"
                destPort = "443"
                destCidr = "any"
                srcPort = "Any"
                srcCidr = "Any"
                syslogEnabled = $false
            }
        )
    }#>
    
}