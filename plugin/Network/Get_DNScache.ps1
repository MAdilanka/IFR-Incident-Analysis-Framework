<#
.Synopsis
    Plugin of IR Framework for Collect DNS cache data
 
.DESCRIPTION
    The function can be used in retriving DNS client cache data for incident analysis.
    Included :-
        Type
        IP Address
        Name
        All

.EXAMPLE
    Get_DNScache -All
    
    Get complete DNS client cache
 
.EXAMPLE
    Get_DNScache -Name Google.com

    Filter "Google.com" in DNS clent cache
 
.EXAMPLE
    Get_DNScache -IP 8.8.8.8

    Filter "8.8.8.8" IP in DNS clent cache
 
.EXAMPLE
    Get_DNScache -type A

    Filter and get A records.

    Avilable Record Types : A, NS, CNAME, SOA, PTR, MX, AAAA, SRV
        
#>

using module "..\..\.\classes\Network\DNScache.psm1"

function Get_DNScache{
[CmdletBinding()]
param(
        [string]$type,
        [string]$IPaddress,
        [string]$name,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($type){
        getdns -type $type
        }
        if ($IPaddress){
        getdns -IPaddress $IPaddress
        }
        if ($name){
        getdns -name $name
        }
        if ($All){
        getdns -All
        }
        
}

