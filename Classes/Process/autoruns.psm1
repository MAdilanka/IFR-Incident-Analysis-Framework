class autoruns {
    [string]$caption
    [string]$description
    [string]$command
    [string]$location
    [string]$name
    [string]$UserName
    [string]$userSID
    }

$AR = Get-CimInstance -ClassName Win32_StartupCommand | Select-Object -Property *

$Result_autoruns = @()

$AR.ForEach({
    $startup = [autoruns]::new()
    $startup.caption = $_.Caption
    $startup.command = $_.command
    $startup.description = $_.description
    $startup.location = $_.location
    $startup.name = $_.name
    $startup.UserName = $_.user
    $startup.userSID = $_.userSID

    $Result_autoruns += $startup

    })

#getstartup senti

Function get_autoruns{
param(
    [string]$process_name,
    [string]$command,
    [string]$location,
    [string]$UserName,
    [string]$UserSID,
    [Parameter(Mandatory = $false)][switch]$All = $false
    )
    if ($process_name){
    $St1 = $Result_autoruns | where { $_.name -match $process_name -or $_.command -match $process_name -or $_.caption -match $process_name}
    $St1 
        }
    if ($command){
    $St2 = $Result_autoruns | where { $_.command -match $command}
    $St2 
        }
    if ($location){
    $St = $Result_autoruns | where { $_.location -match $location}
    $St 
        }
    if ($UserName){
    $St = $Result_autoruns | where { $_.UserName -match $UserName}
    $St 
        }
    if ($UserSID){
    $St = $Result_autoruns | where { $_.userSID -eq $UserSID}
    $St 
        }
    if ($All){
    $St = $Result_autoruns
    $St 
        }

}

