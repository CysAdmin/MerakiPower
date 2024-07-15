Function Get-NetworkApplianceVlan{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,    
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,        
        [Parameter(Mandatory = $true)]
        [string]$VlanId
    )
    $url = "/networks/$($NetworkId)/appliance/vlans/$($VlanId)"

    Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken
}