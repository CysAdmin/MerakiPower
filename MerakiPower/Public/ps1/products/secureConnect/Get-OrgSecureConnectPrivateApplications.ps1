Function Get-OrgSecureConnectPrivateApplications{
    [CmdletBinding()] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$OrganizationId
    )    
    $url = "/organizations/$($OrganizationId)/secureConnect/privateApplications"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}