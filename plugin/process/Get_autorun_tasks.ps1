<#
.Synopsis
    A Plugin of IR Framework for Get Process related details.
 
.DESCRIPTION
    The function can be used in retriving Process related data for incident analysis.
    Included :-
        Process Name
        Command
        Location
        Username
        SID
        Export
 
.EXAMPLE
    Get_Autorun_tasks -process_name Mozilla
    
    Filter autorun tasks with process name "mozilla".
 
.EXAMPLE
    Get_Autorun_tasks -command mozilla/update

    Filter autorun tasks containing command "mozilla/update"
 
.EXAMPLE
    Get_Autorun_tasks -location windows/CurrentVersion

     Filter autorun tasks including location "windows/CurrentVersion"
 
.EXAMPLE
    Get_Autorun_tasks -Username John

    Filter autorun tasks by username "John"

.EXAMPLE
    Get_Autorun_tasks -SID <SID>

    Filter autorun tasks with SID

.EXAMPLE
    Get_Autorun_tasks -export_details

    export autorun tasks details to a .csv file


       
#>

using module "..\..\.\classes\Process\autoruns.psm1"

$current_location = Get-Location
if($current_location -match 'IFR2$')
{
$A_directory = $current_location
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

[string]$autoruns_path    = Join-Path -Path $A_directory -ChildPath 'output\Autorun_tasks.csv'

Function Get_Autorun_tasks{
param(
    [string]$process_name,
    [string]$command,
    [string]$location,
    [string]$UserName,
    [string]$UserSID,
    [Parameter(Mandatory = $false)][switch]$All = $false,
    [Parameter(Mandatory = $false)][switch]$Export_details = $false
    )
    if ($process_name){
    get_autoruns -process_name $process_name
        }
    if ($command){
    get_autoruns -command $command
        }
    if ($location){
    get_autoruns -location $location
        }
    if ($UserName){
    get_autoruns -UserName $UserName
        }
    if ($UserSID){
    get_autoruns -UserSID $UserSID
        }
    if ($All){
    get_autoruns -All
        }
    if ($Export_details){
    get_autoruns -All | Export-Csv -path $autoruns_path
    Write-Host "Autorun tasks details exported to $autoruns_path " -fore Green
        }

}
