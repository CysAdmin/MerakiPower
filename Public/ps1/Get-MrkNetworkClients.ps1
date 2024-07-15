Function Get-MrkNetworkClients{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $url = "/networks/$($NetworkId)/clients"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}