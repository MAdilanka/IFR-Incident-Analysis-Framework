class slog {
    [string]$eventID
    [string]$timegenerated
    [string]$message_brief
    [string]$message
    [string]$data
    [string]$entrytype
    [string]$replacementstring
    
    #[string]$username

}

$PL = Get-EventLog -LogName 'Security' | Select-Object -Property *

$Result_securitylogs = @()

$PL.ForEach({
    $slog = [slog]::new()
    $slog.eventID = $_.EventID
    $slog.message = $_.Message
    #$slog.username = $_.Username
    $slog.timegenerated = $_.TimeGenerated
    $slog.replacementstring = $_.ReplacementStrings
    $slog.entrytype = $_.EntryType

    $smessage = $slog.message
    $CharArray3 = $smessage.Split(".")
    $briefmessage = $CharArray3[0]
    $slog.message_brief = $briefmessage
  
    $Result_securitylogs += $slog

    })

Function get_seclogs{
    param(
        [int]$eventID,
        [string]$timegenerated,
        [string]$content,
        [string]$replacementstring,
        [string]$eventID_with_content,
        [Parameter(Mandatory = $false)][switch]$All = $false
        )
        if ($eventID){
        $Result_securitylogs | where { $_.eventID -eq $eventID} 

        #| Select-Object eventID,timegenerated,message_brief

        }
        if ($timegenerated){
        $Result_securitylogs  | where { $_.timegenerated -match $timegenerated}
        }
        if ($replacementstring){
        $Result_securitylogs  | where { $_.replacementstring -match $replacementstring}
        }
        if ($content){
        $Result_securitylogs  | where { $_.message -match $content}
        }
        if ($All){
        $Result_securitylogs
        }
        
}

#$Result_securitylogs | Where-Object {($_.eventID -eq '5156') -and ($_.message -match '142.250.182.206')}

Function get_seclogs_extended{
    param(
        [Parameter(Mandatory=$true)] [int32] $eventID1,
        [Parameter(Mandatory=$true)] [string] $content1
        )
        $Result_securitylogs | Where-Object {($_.eventID -eq $eventID1) -and ($_.message -match $content1)}  
}
