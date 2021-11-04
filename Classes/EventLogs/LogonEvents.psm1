class slog2 {
    [string]$eventID
    [string]$timegenerated
    [string]$accountname
    [string]$SID
    [string]$message
}

class slog {
    [string]$eventID
    [string]$data
    [string]$entrytype
    [string]$message
    [string]$replacementstring
    [string]$timegenerated
    [string]$username

    [slog2[]]$userdetails = [slog2[]]::new(100000)

    slog(){   
    }

    [void] Addmodule([slog2]$mod ,[int]$slot ){
        $this.userdetails[$slot] = $mod
    }

}


$PL = Get-EventLog -LogName 'Security' | where { $_.eventID -eq 4625 -or ($_.eventID -eq 4672) -or ($_.message -eq 4624)}  
$Result_logon_all = @()
$Result_logon_account = @()


$PL.ForEach({
    $slogall = [slog]::new()
    $slogall.eventID = $_.EventID
    $slogall.message = $_.Message
    $slogall.timegenerated = $_.TimeGenerated
    $slogall.entrytype = $_.EntryType
    $slogall.replacementstring = $_.ReplacementStrings

    $UL = $slogall.replacementstring
    foreach ($B in $UL) {
        $CharArray =$B.Split(" ")
        $aname = $CharArray[1]
        $aSID = $CharArray[0]

        $smessage = $slogall.message
        $CharArray2 = $smessage.Split(".")
        $shortmessage = $CharArray2[0]
        $slog1 = [slog2]::new()
        $slog1.eventID = $slogall.eventID
        $slog1.timegenerated = $slogall.timegenerated
        $slog1.accountname = $aname
        $slog1.SID = $aSID
        $slog1.message = $shortmessage
        
        

        #$slogall.Addmodule($slog1,$_.SID)

        $Result_logon_account += $slog1
   }

   
    $Result_logon_all += $slogall

 })

Function get_logon_events{
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
        $Result_logon_account | where { $_.eventID -eq $eventID}
        }
        if ($accountname){
        $Result_logon_account | where { $_.accountname -match $accountname}
        }
        if ($time){
        $Result_logon_account  | where { $_.timegenerated -match $time}
        }
        if ($All){
        $Result_logon_account
        }
        if ($Extended_details){
        $Result_logon_all
        }
        if ($Special_privilage_logon){
        $Result_logon_account | where { $_.eventID -eq 4672}
        }
        if ($Successful_logon){
        $Result_logon_account | where { $_.eventID -eq 4625}
        }
        if ($logon_Failiures){
        $Result_logon_account | where { $_.eventID -eq 4624}
        }


        
}
