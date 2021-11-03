$c = Get-CimInstance -ClassName Win32_ComputerSystem
$c | Format-List

class computer_system{
    [string]$Domain
    [string]$Manufacturer
    [string]$Model
    [string]$Name
    [string]$PrimaryOwner
    [string]$TotalphysicalMemory
}


function get_computerinfo {
    $info = Get-CimInstance -ClassName Win32_ComputerSystem

    $computerinfo = [computer_system]::new()
    $computerinfo.Domain = $info.Domain
    $computerinfo.Manufacturer = $info.Manufacturer
    $computerinfo.Model = $info.Model
    $computerinfo.name = $info.Name
    $computerinfo.PrimaryOwner = $info.PrimaryOwnerName
    $computerinfo.TotalphysicalMemory =$info.TotalphysicalMemory

    $computerinfo

}
