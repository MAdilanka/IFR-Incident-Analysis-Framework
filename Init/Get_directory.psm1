$current_location = Get-Location

if($current_location -match 'IFR2$')
{
$PSScriptRoot = $current_location
#write-host "PSScriptRoot = $current_location `n" -fore Green
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

$directory = $PSScriptRoot

function print_plugin_list{

[string]$plugin_directory = Join-Path -Path $directory -ChildPath 'plugin'

Get-ChildItem -Path $plugin_directory|
        ForEach-Object {
            $folder_name = $_.Name
            $folder_full_name = $_.FullName
            write-host  $folder_name -fore Green

            Get-ChildItem -Path $folder_full_name -Filter '*.ps1' |
            ForEach-Object {
                $pn = $_.Name -replace ".ps1",""
                write-host "`t $pn"
                         }
                        }
}

function get_plugin_list{
$Resulplugins = @()

class plugindetails {
    [string]$name
    [string]$fullname
    [string]$directoryname

}

[string]$plugin_directory = Join-Path -Path $directory -ChildPath 'plugin'

Get-ChildItem -Path $plugin_directory|
        ForEach-Object {
            $folder_name = $_.Name
            $folder_full_name = $_.FullName

            Get-ChildItem -Path $folder_full_name -Filter '*.ps1' |
            ForEach-Object {
                $pdetails = [plugindetails]::new()
                $pdetails.name = $_.Name -replace ".ps1",""
                $pdetails.fullname = $_.FullName
                
                $Resulplugins += $pdetails         
                            }
               
                        }
$Resulplugins
}
