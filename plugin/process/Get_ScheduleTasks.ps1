<#
.Synopsis
    A Plugin of IR Framework for Get Schedule task details
 
.DESCRIPTION
    The function can be used in retriving Schedule tasks details for incident analysis.
 
.EXAMPLE
    Get_ScheduleTasks -All
    
    Get All Schedule tasks
 
.EXAMPLE
    Get_ScheduleTasks -username John

    Filter schedule tasks by username "John"
 
.EXAMPLE
    Get_ScheduleTasks -application Mozilla

    Filter schedule tasks by Application name  "mozilla"
 
.EXAMPLE
    Get_ScheduleTasks -taskpath mozilla

    Filter schedule tasks by taskpath "\mozilla"
    

.EXAMPLE
   Get_ScheduleTasks -taskname Firefox browser

   Filter schedule tasks by task name "Firefox browser"

.EXAMPLE
    Get_ScheduleTasks -created_date MM/DD/YYYY HH:MM:SS

    Filter schedule tasks by created time
        
#>

using module "..\..\.\classes\Process\schtask.psm1"

Function Get_ScheduleTasks{
    param(
        [string]$username,
        [string]$application,
        [string]$taskpath,
        [string]$taskname,
        [string]$created_date,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($username){
        get_schedule_task -username $username
        }
        if ($application){
        get_schedule_task -application
        }
        if ($taskpath){
        get_schedule_task -taskpath $taskpath
        }
        if ($taskname){
        get_schedule_task -taskname $taskname
        }
        if ($created_date){
        get_schedule_task -created_date $created_date
        }
        if ($All){
        get_schedule_task -All
        }
        
}

Function Get_ScheduleTasks_Extended{
    param(
        [Parameter(Mandatory=$true)] [string] $string
        )
        get_schedule_task_extended $string
}