class TCPconnections {
    [int]$owningPID
    [string]$state
    [string]$applied_Setting
    [string]$offload_Setting
    [string]$creation_time
    [string]$local_address
    [string]$local_port
    [string]$remote_address
    [string]$remote_port
}

$N = Get-NetTCPConnection | Select-Object -Property *

$Result_netTcp = @()

$N.ForEach({
    $netconnections_all = [TCPconnections]::new()
    $netconnections_all.owningPID = $_.OwningProcess
    $netconnections_all.state = $_.State
    $netconnections_all.applied_Setting = $_.AppliedSetting
    $netconnections_all.offload_Setting = $_.OffloadState
    $netconnections_all.creation_time = $_.CreationTime
    $netconnections_all.local_address = $_.LocalAddress
    $netconnections_all.local_port = $_.LocalPort
    $netconnections_all.remote_address = $_.RemoteAddress
    $netconnections_all.remote_port = $_.RemotePort

    $Result_netTcp += $netconnections_all
})


Function get_connection{
    param(
        [int]$procid,
        [string]$state,
        [string]$IP,
        [Parameter(Mandatory = $false)][switch]$AllConnections = $false,
        [Parameter(Mandatory = $false)][switch]$Allremoteaddresses = $false,
        [Parameter(Mandatory = $false)][switch]$ActiveConnections = $false
        )
        if ($procid){
        $Result_netTcp | where { $_.owningPID -eq $procid}
        }
        if ($IP){
        $Result_netTcp | where { $_.remote_address -match $IP}
        }
        if ($state){
        $Result_netTcp | where { $_.state -match $state}
        }
        if ($AllConnections){
        $Result_netTcp | Format-Table -AutoSize
        }
        if ($Allremoteaddresses){
        $Result_netTcp.remote_address
        }
        if ($ActiveConnections){
        $Result_netTcp | where { $_.state -match "Established"}
        }
}
