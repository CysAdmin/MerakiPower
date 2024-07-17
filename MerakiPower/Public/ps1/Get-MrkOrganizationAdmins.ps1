<#
.SYNOPSIS
Retrieves the list of administrators for a specified organization.

.DESCRIPTION
This function fetches the list of administrators associated with a given organization in the Meraki dashboard. 
It requires an authentication token and the organization ID as parameters. The function sends a GET 
request to the Meraki API and returns the list of organization administrators.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER OrganizationId
The unique identifier of the organization from which the administrators will be retrieved.

.EXAMPLE
Get-MrkOrganizationAdmins -AuthToken $ApiKey -OrganizationId $OrganizationId

This example retrieves the list of administrators for the specified organization.

.NOTES
Ensure that the authentication token has the necessary permissions to access the organization information.
#>
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
