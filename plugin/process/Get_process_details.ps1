<#
.Synopsis
    A Plugin of IR Framework for Get Process related details.
 
.DESCRIPTION
    The function can be used in retriving Process related data for incident analysis.
    Included :-
        process ID
        Process Name
        Username
        Process image file path
        Process start time
        Image signature verification
        Network connections
        Autoruns path
        Autoruns command
        Shedule task name
        Shedule task executable
        Shedule task arguments
 
.EXAMPLE
    Get_process_details -All
    
    Get All process details.
 
.EXAMPLE
    Get_process_details -ID 6789

    Filter Details by process ID "6789".
 
.EXAMPLE
    Get_process_details -Pname Firefox

    Filter Process details by process name "Firefox".
 
.EXAMPLE
    Get_process_details -with_AC 

    Filter Running processes with Active Network Connections.

.EXAMPLE
    Get_process_details -with_UI

    Filter Running processes with Unsigned Image paths.

.EXAMPLE
    Get_process_details -with_AR

    Filter Running processes with Autoruns.

.EXAMPLE
    Get_process_details -with_ST

    Filter Running processes with Scheduletasks.

.EXAMPLE
    Get_process_details -Export

    Export all process details

        
#>

using module "..\..\.\classes\Process\process.psm1" 
using module "..\..\.\classes\Network\tcpconnections.psm1"
using module "..\..\.\classes\Process\autoruns.psm1"
using module "..\..\.\classes\Process\schtask.psm1"
using module "..\..\.\classes\configurations\get_signature_runningProcess.psm1"


#custom class
class process_details{
    [String]$Process_name
    [Int]$Process_ID
    [String]$Username
    [String]$File_path
    [String]$Start_Time
    [String]$File_Signature
    [String]$Network_connections
    [String]$Autoruns_path
    [String]$Autoruns_command
    [string]$Schedule_task_name
    [string]$Schedule_task_executable
    [string]$Schedule_task_arguments
}

$proclist = getprocess -Allprocesses

$Result_processP = @()


$proclist.ForEach({
    $proclist1 = [process_details]::new()
    $proclist1.process_name = $_.pname
    $proclist1.Process_ID = $_.PId
    $proclist1.File_path = $_.Path
    $proclist1.Username = $_.UserName
    $proclist1.Start_Time = $_.StartTime
    $procpath = $proclist1.File_path

    if ($procpath -ne ''){
        $verification = check_signature "$procpath"
        $proclist1.File_Signature = $verification.status
            }
    else {
        $proclist1.File_Signature = "undefined file path"
    }

    $procname = $proclist1.process_name
    $startup_process = get_autoruns -process_name $procname
        if ($startup_process.name -match $procname -or $startup_process.command -match $procname -or $startup_process.caption -match $procname){
            $Ap = $startup_process.location
            $Ap2 = $Ap -replace ' ',"`r`n"
            $proclist1.Autoruns_path = $Ap2 
            $proclist1.Autoruns_command = $startup_process.command
            }
        else{
            $proclist1.Autoruns_path = "No Autoruns"
            $proclist1.Autoruns_command = "No Autoruns"
        }

    $proid = $proclist1.Process_ID
    $available_connections = get_connection -procid $proid
        if ($available_connections.owningPID -eq $proid -and $available_connections.state -eq "Established"){
            $NC = $available_connections.remote_address
            $proclist1.Network_connections = $NC 
            }
        else{
            $proclist1.Network_connections = "No active connections"
        }

    $procname = $proclist1.process_name
    $Shedule_task = get_schedule_task -application $procname
        if ($Shedule_task.taskname -match $procname -or $Shedule_task.executable -match $procname -or $Shedule_task.arguments -match $procname){
            $schName = $Shedule_task.taskname
            $schExe = $Shedule_task.executable
            $schArg = $Shedule_task.arguments
            $proclist1.Schedule_task_name = $schName 
            $proclist1.Schedule_task_executable = $schExe
            $proclist1.Schedule_task_arguments = $schArg
            }
        else{
            $proclist1.Schedule_task_name = "No schedule tasks"
            $proclist1.Schedule_task_executable = "No schedule tasks"
            $proclist1.Schedule_task_arguments  = "No schedule tasks"
        }

    $Result_processP += $proclist1
    

    })



$current_location = Get-Location

if($current_location -match 'IFR2$')
{
$p_directory = $current_location
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

[string]$process_details_export_path    = Join-Path -Path $p_directory -ChildPath 'Exported Files\Getproc_details.csv'


Function Get_process_details{
    param(
        [int]$ID,
        [string]$Pname,
        [Parameter(Mandatory = $false)][switch]$with_AC = $false,
        [Parameter(Mandatory = $false)][switch]$with_AR = $false,
        [Parameter(Mandatory = $false)][switch]$with_UI = $false,
        [Parameter(Mandatory = $false)][switch]$with_ST = $false,
        [Parameter(Mandatory = $false)][switch]$All = $false,
        [Parameter(Mandatory = $false)][switch]$Export = $false,
        [Parameter(Mandatory = $false)][switch]$Brief = $false
        )
        if ($ID){
        $Result_processP | where { $_.Process_ID -eq $ID}
        }
        if ($Pname){
        $Result_processP | where { $_.process_name -eq $Pname}
        }
        if ($with_AC){
        $Result_processP  | where { $_.Network_connections -ne 'No active connections'}
        }
        if ($with_UI){
        $Result_processP  | where { $_.File_Signature -eq "NotSigned"}
        }
        if ($with_AR){
        $Result_processP  | where { $_.Autoruns_path -ne 'No Autoruns' -or $_.Autoruns_command -ne 'No Autoruns'}
        }
        if ($with_ST){
        $Result_processP  | where { ( $_.Schedule_task_name -ne 'No schedule tasks' -or $_.Schedule_task_executable -ne 'No schedule tasks' -or $_.Schedule_task_arguments -ne 'No schedule tasks') } 
        }
        if ($All){
        $Result_processP
        }
        if ($Brief){
        $Result_processP |select process_name,Process_ID,File_path
        }
        if ($Export){
        $Result_processP | Export-Csv -path $process_details_export_path
        Write-Host "Process details exported to $process_details_export_path " -fore Green
        }
        
}
