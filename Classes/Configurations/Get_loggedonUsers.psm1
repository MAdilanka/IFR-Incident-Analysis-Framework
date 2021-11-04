class loggedonusers{
    [string]$session
    [string]$user
    [string]$type
    [string]$auth
    [string]$starttime
}


function get_loggedonuser{

$regexa = '.+Domain="(.+)",Name="(.+)"$'
$regexd = '.+LogonId="(\d+)"$'

$logontype = @{
"0"="Local System"
"2"="Interactive" #(Local logon)
"3"="Network" # (Remote logon)
"4"="Batch" # (Scheduled task)
"5"="Service" # (Service account logon)
"7"="Unlock" #(Screen saver)
"8"="NetworkCleartext" # (Cleartext network logon)
"9"="NewCredentials" #(RunAs using alternate credentials)
"10"="RemoteInteractive" #(RDP\TS\RemoteAssistance)
"11"="CachedInteractive" #(Local w\cached credentials)
}

$computerp = get_computerinfo
$computername = $computerp.name
$logon_sessions = @(gwmi win32_logonsession -ComputerName $computername)
$logon_users = @(gwmi win32_loggedonuser -ComputerName $computername)

$session_user = @{}

$logon_users |% {
$_.antecedent -match $regexa > $nul
$username = $matches[1] + "\" + $matches[2]
$_.dependent -match $regexd > $nul
$session = $matches[1]
$session_user[$session] += $username
}


$logon_sessions |%{
$starttime = [management.managementdatetimeconverter]::todatetime($_.starttime)

$loggedonuser = [loggedonusers]::new()
$loggedonuser.session = $_.logonid
$loggedonuser.user = $session_user[$_.logonid]
$loggedonuser.type = $logontype[$_.logontype.tostring()]
$loggedonuser.auth = $_.authenticationpackage
$loggedonuser.StartTime = $starttime

$loggedonuser
}

}
