Function Get-MerakiOrganizationDevices{
    [CmdletBinding(SupportsShouldProcess)] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,
        [Parameter(Mandatory = $true)]
        [string]$OrganizationId
    )
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
    }
    $url = $ApiBaseUrl + "/organizations/$($OrganizationId)/devices"

    $result = Invoke-RestMethod -Method Get -Uri $url -Headers $header 
    return $result
}