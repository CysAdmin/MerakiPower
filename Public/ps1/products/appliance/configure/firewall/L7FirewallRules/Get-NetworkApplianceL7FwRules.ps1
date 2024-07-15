Function Get-NetworkApplianceL7FwRules {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
    }
    $url = $ApiBaseUrl + "/networks/$($NetworkId)/appliance/firewall/l7FirewallRules"   

    $result = Invoke-RestMethod -Method Get -Uri $url -Headers $header 
    return $result
}