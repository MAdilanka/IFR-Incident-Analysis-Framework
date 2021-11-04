class module {
    [int]$size
    [string]$pmodules
    [string]$filename
}

class aprocess {
    [string]$pname
    [int]$PID
    [string]$path
    [string]$username
    [string]$company
    #[string]$ProductVersion
    #[string]$Description
    [string]$StartTime

    [module[]]$modules = [module[]]::new(10000)

    aprocess(){   
    }

    [void] Addmodule([module]$mod ,[int]$slot ){
        $this.modules[$slot] = $mod
    }

}

$Result = @()
#$P = Get-Process -IncludeUserName | Select-Object -Property *
$P = Get-Process -IncludeUserName | Select Processname,ID,path,username,startTime,company

$P.ForEach({
    $process1 = [aprocess]::new()
    $process1.pname = $_.ProcessName      
    $process1.PID = $_.Id
    $process1.path = $_.Path
    $process1.username = $_.UserName
    $process1.company = $_.Company
    #$process1.Description = $_.Description
    $process1.StartTime = $_.StartTime
    #$process1.ProductVersion = $_.ProductVersion

    $Result += $process1

    })


function getmodules($PMOD){

$M = Get-Process -Id $PMOD -Module

$M.ForEach({
    $module1 = [module]::new()
    $module1.size = $_.Size
    $module1.pmodules = $_.ModuleName
    $module1.filename = $_.FileName

    $process1.Addmodule($module1,$_.Size)
    })

}


Function getprocess{
    param(
        [int]$procid,
        [string]$proname,
        [string]$propath,
        [string]$procusername,
        [string]$procompany,
        [string]$procstarttime,
        [Parameter(Mandatory = $false)][switch]$Allprocesses = $false,
        [Parameter(Mandatory = $false)][switch]$unsignedprocess = $false,
        [Parameter(Mandatory = $false)][switch]$Allpaths = $false
        )
        if ($procid){
        $Result | where { $_.PID -eq $procid}
        }
        if ($proname){
        $Result | where { $_.pname -match $proname}
        }
        if ($propath){
        $Result | where { $_.path -match $propath}
        }
        if ($procusername){
        $Result | where { $_.username -match $procusername}
        }
        if ($procstarttime){
        $Result | where { $_.StartTime -match $procstarttime}
        }
        if ($Allprocesses){
        $Result 
        }
        if ($unsignedprocess){
        $Result | where { $_.company -eq '' }
        }
        if ($Allpaths){
        $Result.path
        }
}


