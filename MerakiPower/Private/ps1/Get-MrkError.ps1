<#
.SYNOPSIS
Constructs a standardized error object for Meraki API responses.

.DESCRIPTION
This function takes an error message as input and constructs a standardized error object. This can be useful for consistent error handling and logging when interacting with the Meraki API.

.PARAMETER ErrorMessage
The error message to be included in the error object.

.EXAMPLE
$ErrorObject = Get-MrkError -ErrorMessage "An error occurred"
Write-Output $ErrorObject

#>
Function Get-MrkError {
    param(
        [string]$ErrorMessage
    )
    $errorObject = New-Object psobject
    $errorObject | Add-Member -MemberType NoteProperty -Name "Error" -Value $ErrorMessage
    return $errorObject
}
