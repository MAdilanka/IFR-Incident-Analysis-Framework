class signature_status{
    [string]$S_status
}

Function Get_Signature_Status($fpath){
$asig = Get-AuthenticodeSignature $fpath | Select status
$module = [signature_status]::new()
$module.S_status = $asig.Status
$module.S_status
}