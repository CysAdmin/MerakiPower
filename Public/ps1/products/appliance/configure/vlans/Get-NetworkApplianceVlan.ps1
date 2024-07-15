Function Get-NetworkApplianceVlan{
    param(
        [Parameter(Mandatory = $true)]
        [string]$AuthToken,    
        [Parameter(Mandatory = $true)]
        [string]$NetworkId,        
        [Parameter(Mandatory = $true)]
        [string]$VlanId,
        [switch]$AsJson
    )
    $url = "/networks/$($NetworkId)/appliance/vlans/$($VlanId)"

    if($AsJson){
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken | ConvertTo-Json -Depth 10
    }else {
        Invoke-MrkRequest -Method Get -Resource $url -AuthToken $AuthToken 
    }
    
}