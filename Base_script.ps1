using module ".\init\Get_directory.psm1"

#using Get_directory.psm1 and menu.psm1


$first = $args[0]
$second = $args[1]
$third = $args[2]
$forth = $args[3] 

If ($first -eq ""){
Write-host "`n =============================== IFR Framework =============================" -fore Green
Write-host " ===========================================================================`n" -fore Green
Write-host " `r`n ========================= Please select a option ========================== `r`n" -fore Green 
Write-host "`t -Help(-H)             : Get-Help "
Write-host "`t -List_plugins(-L)     : List available plugins"
Write-host "`t -Select(-S)           : Select a plugin"
Write-host "`t -Clear(-C)            : Clear the cache"
Write-host "`t -Routing(-R)          : Start the routing framework"
Write-host " `r`n =========================================================================== `r`n" -fore Green
}

if ($first -eq "-help"){
        Write-host " `r`n ============================ Available Parameters ============================ `r`n" -fore Green 
        Write-host "`t -Help(-H)             : Get-Help "
        Write-host "`t -List_plugins(-L)     : List available plugins"
        Write-host "`t -Select(-S)           : Select a plugin"
        Write-host "`t -Clear(-C)            : Clear the cache"
        Write-host "`t -Routing(-R)          : Start the routing framework"
        Write-host " `r`n =============================================================================== `r`n" -fore Green

        " -------------------------------------------------------------------------------
            Developed by M.A. Dilanka Mallawaarachchi | IFR Version 1.0 
 -------------------------------------------------------------------------------`r`n"
      
        }
if ($first -eq "-List_plugins" -or $first -eq "-L"){
        Write-host " `r`n ============================ Available Plugins ============================ `r`n" -fore Green 
        print_plugin_list
        Write-host " `r`n =========================================================================== `r`n" -fore Green 
        }

if ($first -eq "-select" -or $first -eq "-S" -and $second -ne "" -and $third -ne "-help"){
        $plugin_details = get_plugin_list
        $plugin_name = $second
        $plugin_path = $plugin_details | where {$_.name -eq $plugin_name}
        $m = $plugin_path.fullname
        $m | %{. $_ }
        $command_get = $second + " " + $third + " " + $forth
        iex $command_get
        }

if ($third -eq "-help"){
        $plugin_details = get_plugin_list
        $plugin_name = $second
        $plugin_path = $plugin_details | where {$_.name -eq $plugin_name}
        $m = $plugin_path.fullname
        $m | %{. $_ }
        get-help $m -Detailed
        }
        
if ($first -eq "Clear" -or $first -eq "-C"){
        Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();
        Write-host "*Cache cleared*" -fore Green
        }

if ($first -eq "-r" -or $first -eq "-Routing"){
        .\FrameWork.ps1
        }
