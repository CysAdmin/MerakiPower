Function Get-MerakiNetworkClients{
    [CmdletBinding(SupportsShouldProcess)] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
    }
    $url = $ApiBaseUrl + "/networks/$($NetworkId)/clients"

    $result = Invoke-RestMethod -Method Get -Uri $url -Headers $header 
    return $result
}