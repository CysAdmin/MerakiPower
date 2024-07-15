Function Get-MrkOrganizationAdmins{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$OrganizationId
    )
    $url = "/organizations/$($OrganizationId)/admins"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}