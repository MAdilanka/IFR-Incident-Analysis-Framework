class local_user_accounts{
    [string]$name
    [string]$caption
    [string]$accounttype
    [string]$SID
    [string]$domain
}


function get_Uaccounts{

$userAccocunt = get-ciminstance win32_useraccount
$ResultAccount = @()

$userAccocunt.ForEach({
    $accountinfo = [local_user_accounts]::new()
    $accountinfo.Name = $_.Name
    $accountinfo.caption = $_.Caption
    $accountinfo.accounttype = $_.AccountType
    $accountinfo.SID = $_.SID
    $accountinfo.domain =$_.Domain
    
    $ResultAccount += $accountinfo

})

$ResultAccount

}