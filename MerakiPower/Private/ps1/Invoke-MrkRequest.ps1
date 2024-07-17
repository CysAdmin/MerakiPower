<#
.SYNOPSIS
Invokes an HTTP request to the Meraki Dashboard API.

.DESCRIPTION
This function sends an HTTP request to the Meraki Dashboard API. It supports GET, POST, PUT, and DELETE methods, and handles the construction of the request headers and error handling. The function takes the API endpoint resource, the HTTP method, an authentication token, and an optional request body as parameters.

.PARAMETER Method
The HTTP method to use for the request. Valid values are 'Get', 'Post', 'Put', 'Delete'.

.PARAMETER Resource
The API resource endpoint to be accessed. This should be the path after the base URI (e.g., '/networks/{networkId}/clients').

.PARAMETER AuthToken
The authentication token to be used for the API request. This should be a valid Meraki Dashboard API key.

.PARAMETER Body
The body of the request, if applicable (e.g., for POST or PUT requests). This should be a JSON string.

.EXAMPLE
Invoke-MrkRequest -Method Get -Resource "/organizations" -AuthToken "your_api_key"

#>
Function Invoke-MrkRequest {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("Get", "Post", "Put", "Delete")]
        [string]$Method,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Resource,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$AuthToken,
        [string]$Body = ""
    )
    $BaseUri = "https://api.meraki.com/api/v1"
    $header = @{
        "Authorization" = "Bearer $($AuthToken)"
        "Accept"        = "application/json"
    }
    $Resource = $BaseUri + $Resource
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    try {
        $result = Invoke-RestMethod -Method $Method -Uri $Resource -Headers $header -Body $Body -ContentType "application/json"
    }
    catch [Microsoft.PowerShell.Commands.HttpResponseException] {
        # Check if a Solid Error is Present, otherwise return Status Code             
        if ($_.ErrorDetails.Message) {
            return Get-MrkError -ErrorMessage ($_.ErrorDetails.Message | ConvertFrom-Json).Errors
        } else {
            return Get-MrkError -ErrorMessage $_.Exception.Response.ReasonPhrase
        }
    }
    return $result
}
