<#
.Synopsis
    A Plugin of IR Framework for Get Process related details.
 
.DESCRIPTION
    The function can be used in retriving Process related data for incident analysis.
    Included :-
        Name
        Caption
        AccountID
        SID
        Domain
 
.EXAMPLE
    get_useraccounts -local
    
    Filter local user accounts.
 
.EXAMPLE
    get_useraccounts -Domain

    Filter Domain user accounts
 
.EXAMPLE
    get_useraccounts -withAdmin_Privillages

    Filter user accounts with admin privillages.
 
.EXAMPLE
    get_useraccounts -All

    Filter All details of user accounts

.EXAMPLE
    get_useraccounts -Export_details

    Export all details to CSV
       
#>

using module "..\..\.\classes\configurations\Get_LoggedonUsers.psm1"
using module "..\..\.\classes\configurations\Get_useraccounts.psm1"
using module "..\..\.\classes\configurations\Get_Computerinfo.psm1"


$compname = get_computerinfo
$useraccounts = get_Uaccounts

$current_location = Get-Location
if($current_location -match 'IFR2$')
{
$U_directory = $current_location
}

else{
write-host "please change the directry to */IFR2" -fore red
exit
}

[string]$user_Accountdetails_path    = Join-Path -Path $U_directory -ChildPath 'output\Get_userAccount_details.csv'

function get_useraccounts{
param(
        [Parameter(Mandatory = $false)][switch]$local =$false,
        [Parameter(Mandatory = $false)][switch]$Domain =$false,
        [Parameter(Mandatory = $false)][switch]$All = $false,
        [Parameter(Mandatory = $false)][switch]$withadmin_privillages = $false,
        [Parameter(Mandatory = $false)][switch]$loggedOn = $false,
        [Parameter(Mandatory = $false)][switch]$Export_details = $false
        )
        if ($local){
        $useraccounts | where { $_.domain -eq $compname.name}
        }
        if ($domain){
        $useraccounts | where { $_.domain -ne $compname.name}
        }
        if ($withadmin_privillages){
        net localgroup administrators
        }
        if ($loggedOn){
        get_loggedonuser
        }
        if ($All){
        $useraccounts
        }
        if ($Export_details){
        $useraccounts | Export-Csv -path $user_Accountdetails_path
        Write-Host "User account details exported to $user_Accountdetails_path " -fore Green
        }
 
 }

