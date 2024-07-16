<#
.SYNOPSIS
Retrieves a list of organizations accessible with the provided authentication token.

.DESCRIPTION
This function fetches a list of all organizations that the provided authentication token has access to. 
It sends a GET request to the Meraki API and returns the list of organizations.

.PARAMETER AuthToken
The authentication token for accessing the Meraki API.

.EXAMPLE
Get-MrkOrganizations -AuthToken $ApiKey

This example retrieves the list of organizations accessible with the specified authentication token.

.NOTES
Ensure that the authentication token has the necessary permissions to access organization information.
#>
Function Get-MrkOrganizations {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken
    )
    $url = "/organizations"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}
