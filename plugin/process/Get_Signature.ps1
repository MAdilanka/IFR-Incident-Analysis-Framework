<#
.Synopsis
    A Plugin of IR Framework for validate file signatures.
 
.DESCRIPTION
    The function can be used in validating digital signatures for incident analysis.
 
.EXAMPLE
    Get_signature C:\program files\google chrome
    
    Get signature details of "google chrome" by file path
#>

#using module "..\..\.\classes\configurations\Get_signature.psm1"

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
$module.Hash = $hash256.Hash

$module
}