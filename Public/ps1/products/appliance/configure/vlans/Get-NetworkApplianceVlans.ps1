Function Get-NetworkApplianceVlans{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$NetworkId
    )
    $url = "/networks/$($NetworkId)/appliance/vlans"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}