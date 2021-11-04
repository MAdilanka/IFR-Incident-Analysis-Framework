class DNScache {
    [string]$IPaddress
    [string]$DNS_entry
    [string]$Name
    [string]$Data_length
    [string]$TTL
    [string]$status
    [string]$Record_type

}

#using module "C:\Users\dilankaM\Desktop\research\IFR2\classes\dnscache.psm1"

$DNS = Get-DnsClientCache | Select-Object -Property *

$ResultDNS = @()

$DNS.ForEach({
    $dnsc = [DNScache]::new()
    $dnsc.Name = $_.Name
    $dnsc.DNS_entry = $_.Entry
    $dnsc.IPaddress = $_.Data
    $dnstype = $_.Type
  
    if ($dnstype = '1'){
            $dnsc.Record_type = 'A'
        }
    elseif($dnstype = '2'){
            $dnsc.Record_type = 'NS'
        }
    elseif($dnstype = '5'){
            $dnsc.Record_type = 'CNAME'
        }
    elseif($dnstype = '6'){
            $dnsc.Record_type = 'SOA'
        }
    elseif($dnstype = '12'){
            $dnsc.Record_type = 'PTR'
        }
    elseif($dnstype = '15'){
            $dnsc.Record_type = 'MX'
        }
    elseif($dnstype = '28'){
            $dnsc.Record_type = 'AAAA'
        }
    elseif($dnstype = '33'){
            $dnsc.Record_type = 'SRV'
        }
    else {
            $dnsc.Record_type = $_.Type
        }


    $status = $_.Status
    if ($status = '0'){
            $dnsc.status = 'Success'
        }
    elseif($status = '9003'){
            $dnsc.status = 'NotExist'
        }
    elseif($status = '9701'){
            $dnsc.status = 'NoRecords'
        }
    else {
            $dnsc.status = $status
        }


    $dnsc.TTL = $_.TTL

    $ResultDNS += $dnsc
})


Function getdns{
    param(
        [string]$type,
        [string]$IPaddress,
        [string]$name,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($type){
        $ResultDNS | where { $_.Record_type -eq $type}
        }
        if ($IPaddress){
        $ResultDNS | where { $_.IPaddress -eq $IPaddress}
        }
        if ($name){
        $ResultDNS  | where { $_.Name -match $name}
        }
        if ($All){
        $ResultDNS  | Format-Table -AutoSize
        }
        
}