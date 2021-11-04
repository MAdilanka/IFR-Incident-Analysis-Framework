class signatureverify{
    [string]$status
    [string]$statusmessage
    [string]$path
    [string]$signaturetype
    [string]$Hash
}

Function Get_Signature($fpath){
$asig = Get-AuthenticodeSignature $fpath | Select-Object -Property *
$hash256 = Get-FileHash ($fpath)
$module = [signatureverify]::new()
$module.status = $asig.Status
$module.statusmessage = $asig.StatusMessage
$module.path = $asig.Path
$module.signaturetype = $asig.SignatureType
$module.Hash = $hash256

$module
}