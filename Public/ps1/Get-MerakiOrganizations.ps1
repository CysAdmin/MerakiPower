Function Get-MerakiOrganizations {
    [CmdletBinding(SupportsShouldProcess)] 
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken
    )
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
    }
    $url = $ApiBaseUrl + "/organizations"

    $result = Invoke-RestMethod -Method Get -Uri $url -Headers $header 
    return $result
}