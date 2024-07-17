Function Get-NetworkApplianceFwInboundCFRules{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
    }
    $url = $ApiBaseUrl + "/networks/$($NetworkId)/appliance/firewall/inboundCellularFirewallRules"    

    $result = Invoke-RestMethod -Method Get -Uri $url -Headers $header 
    return $result
}