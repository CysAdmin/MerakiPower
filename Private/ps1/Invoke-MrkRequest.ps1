Function Invoke-MrkRequest{
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

    $result =  Invoke-RestMethod -Method $Method -Uri $Resource -Headers $header -Body $Body -ContentType "application/json"
    return $result
}