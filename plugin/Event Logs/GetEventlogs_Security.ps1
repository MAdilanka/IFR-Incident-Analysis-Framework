<#
.Synopsis
    A Plugin of IR Framework for Get Security event logs.
 
.DESCRIPTION
    The function can be used in retriving Security event logs for incident analysis.
 
.EXAMPLE
    GetEventlogs_Security -All
    
    Get All security event Logons.
 
.EXAMPLE
    GetEventlogs_Security -eventID 4672

    Filter Logon events by Event ID "4672"
 
.EXAMPLE
    GetEventlogs_Security -timegenerated MM/DD/YYYY HH:MM:SS

    Filter Logon events by time.
 
.EXAMPLE
    GetEventlogs_Security -content  google.com

    Filter security event details by the content.

.EXAMPLE
    GetEventlogs_Security -Export_details

    Export all the security logs to .CSV file

.EXAMPLE
    GetEventlogs_Security_Extended -eventID 4347 -content 10.10.10.1

    Filter security logs by eventID and the content.
       
#>

using module "..\..\.\classes\eventLogs\Eventlogs_Security.psm1"

$current_location = Get-Location
if($current_location -match 'IFR2$')
{
$out_directory = $current_location
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

[string]$security_details_export_path    = Join-Path -Path $out_directory -ChildPath 'output\Getsecurity_log_details.csv'


Function GetEventlogs_Security{
    param(
        [int]$eventID,
        [string]$timegenerated,
        [string]$content,
        [string]$replacementstring,
        [string]$eventID_with_content,
        [Parameter(Mandatory = $false)][switch]$Export_details = $false,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($eventID){
        get_seclogs -eventID $eventID
        #| Select-Object eventID,timegenerated,message_brief
        }
        if ($timegenerated){
        get_seclogs  -timegenerated $timegenerated
        }
        if ($replacementstring){
        get_seclogs -replacementstring $replacementstring
        }
        if ($content){
        get_seclogs -content $content
        }
        if ($All){
        get_seclogs -All
        }
        if ($Export_details){
        get_seclogs -All | Export-Csv -path $security_details_export_path
        Write-Host "Security Log details exported to $security_details_export_path " -fore Green
        }

}

Function GetEventlogs_Security_Extended{
    param(
        [Parameter(Mandatory=$true)] [int32] $eventID,
        [Parameter(Mandatory=$true)] [string] $content
        )
        get_seclogs_extended $eventID $content
}