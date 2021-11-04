<#
.Synopsis
    A Plugin of IR Framework for Get TCP connection Status
 
.DESCRIPTION
    The function can be used in retriving TCP connection Status for incident analysis.
     Included :-
        ProcID
        IP
        State
        AllConnections
        Allremoteaddresses
        ActiveConnections
        
 
.EXAMPLE
    Getnet_connections -AllConnections
    
    Get All connection details
 
.EXAMPLE
    Getnet_connections -ID 6789

    Filter Network Connections by process ID "6789"
 
.EXAMPLE
    Getnet_connections -IP 8.8.8.8

    Filter Network Connections by Remote IP  "8.8.8.8"
 
.EXAMPLE
    Getnet_connections -status Listen 

    Filter Network Connections by status  "Listen"

    Avilable Record Types : Listen, Established Internet, Timewait, Closewait, FinWait1, Bound

.EXAMPLE
    Getnet_connections -Allremoteaddresses

    Filter Remote IP Addressess.

.EXAMPLE
    Getnet_connections -ActiveConnections

    Filter Established Internet Connections.

        
#>


using module "..\..\.\classes\Network\TCPconnections.psm1"

Function Getnet_connections{
    param(
        [int]$ID,
        [string]$state,
        [string]$IP,
        [Parameter(Mandatory = $false)][switch]$AllConnections = $false,
        [Parameter(Mandatory = $false)][switch]$Allremoteaddresses = $false,
        [Parameter(Mandatory = $false)][switch]$ActiveConnections = $false
        )
        if ($ID){
        get_connection -procid $ID
        }
        if ($IP){
        get_connection -IP $IP
        }
        if ($state){
        get_connection -state $state
        }
        if ($AllConnections){
        get_connection -AllConnections
        }
        if ($Allremoteaddresses){
        get_connection -Allremoteaddresses
        }
        if ($ActiveConnections){
        get_connection -ActiveConnections
        }
}
