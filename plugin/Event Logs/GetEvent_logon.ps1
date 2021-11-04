<#
.Synopsis
    A Plugin of IR Framework for Logon Event Logs.
 
.DESCRIPTION
    The function can be used in retriving Logon Event detials for incident analysis.
 
.EXAMPLE
    getevents_logon -All
    
    Get All Logon events. Events with IDs 4672,4624,4625
 
.EXAMPLE
    getevents_logon -eventID 4672

    Filter Logon events by Event ID "4672"
 
.EXAMPLE
    getevents_logon -time MM/DD/YYYY HH:MM:SS

    Filter Logon events by time.
 
.EXAMPLE
    getevents_logon -Extended_details 

    Get all details for logon events.

.EXAMPLE
    getevents_logon -Special_privilage_logon

    Filter Logon Events with Special privileges(Event Id = 4672).

.EXAMPLE
    getevents_logon -Successful_logon

    Filter Successfull Logon Events (Event Id = 4624).

.EXAMPLE
    getevents_logon -logon_Failiures

    Filter Failed Logon Events (Event Id = 4625).
       
#>

using module "..\..\classes\eventLogs\LogonEvents.psm1"


Function getevent_logon{
    param(
        [string]$eventID,
        [string]$accountname,
        [string]$time,
        [Parameter(Mandatory = $false)][switch]$All = $false,
        [Parameter(Mandatory = $false)][switch]$Extended_details = $false,
        [Parameter(Mandatory = $false)][switch]$Special_privilage_logon = $false,
        [Parameter(Mandatory = $false)][switch]$Successful_logon = $false,
        [Parameter(Mandatory = $false)][switch]$logon_Failiures = $false
        )
        if ($eventID){
        get_logon_events -eventID $eventID
        }
        if ($accountname){
        get_logon_events -accountname $accountname
        }
        if ($time){
        get_logon_events -time $time
        }
        if ($All){
        get_logon_events -All
        }
        if ($Extended_details){
        get_logon_events -Extended_details
        }
        if ($Special_privilage_logon){
        get_logon_events -Special_privilage_logon
        }
        if ($Successful_logon){
        get_logon_events -Successful_logon
        }
        if ($logon_Failiures){
        get_logon_events -logon_Failiures
        }
        
}