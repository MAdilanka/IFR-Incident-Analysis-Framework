class schtask {
    [string]$state
    [string]$author
    [string]$taskName
    [string]$taskpath
    [string]$executable
    [string]$date
    [string]$description
    [string]$settings
    [string]$source
    [string]$version
    [string]$URI
    [string]$arguments
    [string]$actions
}

$task = Get-ScheduledTask | Select-Object -Property *

$Resultscheduletask = @()

$task.ForEach({
    $task_all = [schtask]::new()
    $task_all.state = $_.State
    $task_all.actions = $_.Actions
    $task_all.author = $_.Author
    $task_all.date = $_.Date
    $task_all.description = $_.Description
    $task_all.settings = $_.Settings
    $task_all.source = $_.Source
    $task_all.taskName = $_.TaskName
    $task_all.taskpath = $_.TaskPath
    $task_all.URI = $_.URI
    $task_all.version = $_.Version
    $task_all.arguments = $_.Actions.Arguments
    $task_all.executable = $_.Actions.execute

    $Resultscheduletask += $task_all

    })

Function get_schedule_task{
    param(
        [string]$username,
        [string]$application,
        [string]$taskpath,
        [string]$taskname,
        [string]$created_date,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($username){
        $Resultscheduletask | where { $_.author -match $type}
        }
        if ($application){
        $Resultscheduletask | where { $_.executable -match $application}
        }
        if ($taskpath){
        $Resultscheduletask  | where { $_.taskpath -match $taskpath}
        }
        if ($taskname){
        $Resultscheduletask  | where { $_.taskName -match $taskname}
        }
        if ($created_date){
        $Resultscheduletask  | where { $_.date -match $created_date}
        }
        if ($All){
        $Resultscheduletask  | Format-Table -AutoSize
        }
        
}

Function get_schedule_task_extended{
    param(
        [Parameter(Mandatory=$true)] [string] $string
        )
        $Resultscheduletask | Where-Object {($_.executable -match $string) -or ($_.taskpath -match $string) -or ($_.taskName -match $string)} 
}