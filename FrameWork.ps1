using module ".\init\menu.psm1"

$current_location = Get-Location
if($current_location -match 'IFR2$')
{
$directory = $current_location
#write-host "$directory = $current_location `n" -fore Green
write-host "Starting Framework.........." -fore Green
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

$Clases_directory    = Join-Path -Path $directory -ChildPath 'classes\'
$Plugins_directory    = Join-Path -Path $directory -ChildPath 'plugin\'
$Process_Plugins_directory = Join-Path -Path $Plugins_directory -ChildPath 'process\'
$Network_Plugins_directory = Join-Path -Path $Plugins_directory -ChildPath 'Network\'
$EventLogs_Plugins_directory = Join-Path -Path $Plugins_directory -ChildPath 'Event Logs\'
$Memory_Plugins_directory = Join-Path -Path $Plugins_directory -ChildPath 'Memory\'
$outputfiles = Join-Path -Path $directory -ChildPath 'outputs\'

$get_process = Join-Path -Path $Process_Plugins_directory -ChildPath 'get_process_details.ps1'
$getproc_tree = Join-Path -Path $Process_Plugins_directory -ChildPath 'get_process_tree.ps1'
$getnet_connections = Join-Path -Path $Network_Plugins_directory -ChildPath 'getnet_connections.ps1'


function Import_modules
{
    [string]$CacheFilepath    = Join-Path -Path $directory -ChildPath 'cache\module_cachefile.txt'
    [string]$module_directory    = Join-Path -Path $directory -ChildPath 'classes\'
    

    Get-ChildItem -Path $module_directory -Recurse -Filter '*.psm1' |
        ForEach-Object {
            $class_fullname = $_.FullName

            if ($class_fullname -notmatch "get_eventLogs_security")
            {
            $modulepath += $class_fullname 
            $modulepath += "`r`n" 

            import-module $class_fullname
            $class_fullname
            }
        }

        $modulepath > $CacheFilepath
}

#Import_modules

function Import-plugins

{
    write-host "Importing plugins.........." -fore Green
    [string]$plugin_CacheFilepath    = Join-Path -Path $directory -ChildPath 'cache\plugin_cachefile.txt'
    [string]$plugin_directory = Join-Path -Path $directory -ChildPath 'plugin\'

    Get-ChildItem -Path $plugin_directory -Recurse -Filter '*.ps1' |
            ForEach-Object {
                $plugin_fullname = $_.FullName

                $pluginpath += $plugin_fullname
                $pluginpath += "`r`n" 

                #import-module $plugin_fullname
                $plugin_fullname

            }

            $pluginpath > $plugin_CacheFilepath

}

Import-plugins
#Get-ChildItem "C:\Users\dilankaM\Desktop\sample framework\IFR2\plugin\*\*.ps1" | %{. $_ }
Get-ChildItem "$Plugins_directory\*\*.ps1" -Exclude get_process.ps1,GetEventlogs_Security.ps1 | %{. $_ }
write-host "===== Successfully imported plugins and Modules ======" -fore Green


#clear-host  
Write-Host "" 
Write-Host "---------------------------------------------------------------------------------------------------" -for cyan 
Write-Host "------------------------------------------------Welcome To IFT-------------------------------------" -for cyan 
Write-Host "-----------------------------------------Incident Response Framework-------------------------------" -for cyan
Write-Host "---------------------------------------------------------------------------------------------------" -for cyan 
Write-Host "" 
Write-Host " Press Enter to continue."

do
{
     "`n"
     Show-Menu
     $input = Read-Host -Prompt "Please select scope"
     Switch ($input)
     {
           '1' {
                'You chose option #1 for Processes'
                do
                {
                 "`n"
                 Show-Menu2
                 $input1 = Read-Host -Prompt "`n Please select a option "
                 "`n"
                 Switch ($input1)
                    { 
                        '1' {
                            get-process
                            Write-Host "`n Select PID to get more details1 or press 0 to back Menu 2 `n"
                            
                            do{
                            [int]$P = Read-host "PID "
                            Get_process_details -ID $P
                            pause 
                            }
                            until ($P -eq '0')

                      } '2' {
                            Get_Process_Tree
                            pause

                      } '3' {
                            Get_process_details -with_AC
                            pause

                      } '4' {
                            Get_process_details -with_AR
                            pause

                      } '5' {
                            Get_process_details -with_ST
                            pause

                      } '6' {
                            Get_process_details -with_UI
                            pause
                            
                      } 'q' {
                           return
                      } '0' {
                           break
                      }
                    }
                 pause
                 }
                 until ($input1 -eq 'b')


           } '2' {
                'You chose option #2 for Networks'
                do
                {
                 "`n"
                 Show-Menu3
                 $input2 = Read-Host -Prompt "`n Please select a option "
                 "`n"
                 Switch ($input2)
                 { 
                        '1' {
                            #Write-Host "You have selected 1 in menu 3"
                            Getnet_connections -AllConnections
                            
                            
                            Write-Host "Select PID to get more details or press 0 to back Menu 3 `n"
                            do 
                            {
                            [int]$PN = Read-host "PID"
                            getnet_connections -ID $PN
                            pause 
                            }
                            until ($PN -eq '0')

                      } '2' {
                            #Write-Host "You have selected 2 in menu 3"
                            getnet_connections -ActiveConnections
                            pause

                      } '3' {
                            Write-Host "Enter IP address to get more details or press 0 to back Menu 3 `n"
                            
                            do 
                            {
                            $IP = Read-host "IP Addreess "
                            getnet_connections -IP $IP
                            pause 
                            }
                            until ($IP -eq '0')


                      } '4' {
                            
                            Write-Host "Enter Connection State. (Available state: Established,Listen) `n  or press 0 to back Menu 1 `n"
                            
                            do 
                            {
                            $status = Read-host "State "
                            getnet_connections -state $status
                            pause 
                            }
                            until ($status -eq '0')

                      } '5' {

                            getnet_connections -Allremoteaddresses
                            pause
                            
                      } 'q' {
                           return
                      } '0' {
                           break
                      }
                      }
                    pause

                }
                until ($input2 -eq 'b')

           } '3' {
                'You chose option #3 for Logon events'
                do
                {
                 "`n"
                 Show-Menu4
                 $input3 = Read-Host -Prompt "`n Please select a option "
                 "`n"
                 Switch ($input3)
                 { 
                        '1' {
                            #Write-Host "You have selected 1 in menu 3"
                            getevent_logon -All
                            pause

                      } '2' {
                            #Write-Host "You have selected 2 in menu 3"
                            getevent_logon -Special_privilage_logon
                            pause

                      } '3' {
                            getevent_logon -Successful_logon
                            pause
                      
                      } '4' {
                            getevent_logon -logon_Failiures
                            pause

                      } '5' {
                            
                            Write-Host "Enter Username or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $uname = Read-host "Username "
                            getevent_logon -accountname $uname
                            pause 
                            }

                            until ($uname -eq '0')

                     } '6' {
                            
                            Write-Host "`n Enter Time or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $time = Read-host "Time "
                            getevent_logon -time $time
                            pause 
                            }
                            until ($time -eq '0')

                      } '7' {

                           getevent_logon -Extended_details
                            
                      } 'q' {
                           return
                      } '0' {
                           break
                      }
                      }
                    pause

                    }

                 until ($input3 -eq 'b')
          
           } '4' {
                'You chose option #4 for Security Logs'
                do
                {
                 "`n"
                 Show-Menu5
                 $input4 = Read-Host -Prompt "`n Please select a option "
                 "`n"
                 Switch ($input4)
                 { 
                        '1' {
                            #Write-Host "You have selected 1 in menu 3"
                            GetEventlogs_Security -Export_details
                            pause

                      } '2' {
                            #Write-Host "You have selected 2 in menu 3"
                            Write-Host "Enter eventID to get more details or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $eventID = Read-host "Event ID "
                            GetEventlogs_Security -eventID $eventID
                            pause

                            }
                            until ($eventID -eq '0')
                            

                      } '3' {
                            "`n"
                             Write-Host "Enter Time to get more details or press 0 to back Menu 4 `n"
                             Write-Host "MM/DD/YYYY HH:MM:SS"
                             "`n"
                            
                            do 
                            {
                            "`n"
                            $time = Read-host "Time "
                            if ($time.Length -gt 5){
                            "`n"
                            
                            GetEventlogs_Security -timegenerated $time
                            pause
                            }
                            else{
                            "`n"
                            Write-Host " Wrong time format"
                            "`n"
                            }
                            }
                            until ($time -eq '0')


                      } '4' {
                            
                            Write-Host "Enter ReplacementStrings to get more details or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $ReplacementStrings = Read-host "ReplacementString "
                            GetEventlogs_Security -replacementstring $ReplacementStrings
                            pause

                            }
                            until ($ReplacementStrings -eq '0')

                      } '5' {

                            Write-Host "Enter Strings to in message content or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $content = Read-host "Content "
                            GetEventlogs_Security -content $content
                            pause

                            }
                            until ($content -eq '0')

                       } '6' {

                            Write-Host "Enter eventID and Strings for advanced search or press 0 to back Menu 4 `n"
                            
                            do 
                            {
                            $eventID = Read-host "eventID "
                            $content = Read-host "Content "
                            GetEventlogs_Security_Extended $eventID $content
                            pause

                            }
                            until ($eventID -eq '0')
                            
                      } 'q' {
                           return
                      } '0' {
                           break
                      }
                      }
                    pause

                }
                until ($input4 -eq 'b')

    
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'b')