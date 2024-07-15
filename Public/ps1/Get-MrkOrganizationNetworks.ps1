Function Get-MrkOrganizationNetworks {
    [CmdletBinding()] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$OrganizationId
    )
    $url = "/organizations/$($OrganizationId)/networks"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}