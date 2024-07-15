Function Get-MrkOrganizations {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken
    )
    $url = "/organizations"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}