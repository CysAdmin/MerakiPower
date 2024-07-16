Function Add-NetworkApplianceL3InboundFirewallRule{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,
        [Parameter(Mandatory = $true)][string]$Comment,
        [Parameter(Mandatory = $true)][ValidateSet("deny", "allow")][string]$Policy,
        [Parameter(Mandatory = $true)][ValidateSet("tcp", "udp")][string]$Protocol,
        [Parameter(Mandatory = $true)][string]$SrcPort,
        [Parameter(Mandatory = $true)][string]$SrcCidr,
        [Parameter(Mandatory = $true)][string]$DestPort,
        [Parameter(Mandatory = $true)][string]$DestCidr,
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
            Write-Output "Rule already Exists!"
            return
        }
    }

    # Add Rule on Top of the Existing Rules Array
    $Rules.rules += $newRule

    # If only one Rule is present, ensure it's an Array - important for API
    if($Rules.rules.Count -eq 1){
        $Rules.rules = @($Rules.rules)
    }

    # Remove syslogDefaultRule Property since its optional Parameter
    $Rules.psobject.Properties.Remove('syslogDefaultRule')
    Write-Output $Rules.rules
    if ($PSCmdlet.ShouldProcess("Appliance Firewall Rules", "Update")) {
        Invoke-MrkRequest -Method Put -Resource $url -AuthToken $AuthToken -Body ( $Rules | ConvertTo-Json)     
    }
}