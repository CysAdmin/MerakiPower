<#
.SYNOPSIS
Retrieves the list of devices for a specified organization.

.DESCRIPTION
This function fetches the list of devices associated with a given organization in the Meraki dashboard.
It requires an authentication token and the organization ID as parameters. The function sends a GET
request to the Meraki API and returns the list of organization devices.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.PARAMETER OrganizationId
The unique identifier of the organization from which the devices will be retrieved.

.EXAMPLE
Get-MrkOrganizationDevices -AuthToken $ApiKey -OrganizationId $OrganizationId

This example retrieves the list of devices for the specified organization.

.NOTES
Ensure that the authentication token has the necessary permissions to access the organization information.
#>
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
