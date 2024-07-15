Function Get-MrkOrganizationDevices{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$OrganizationId
    )
    $url = "/organizations/$($OrganizationId)/devices"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}