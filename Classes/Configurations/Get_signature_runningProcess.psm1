using module "..\..\.\classes\configurations\Get_Signature_Status.psm1"
using module "..\..\.\classes\Process\process.psm1"

class signature_db{
    [string]$path
    [string]$status
}

$result_signatureDB = @()

$proclist1 = getprocess -Allpaths | Sort-Object -Unique

Foreach ($f in $proclist1){
if ($f -ne ''){
      $proclist_2 = [signature_db]::new()
      
      $proclist_2.path = $f
      [string]$procpath10 = $proclist_2.path
      $procpath1 = $procpath10
      $verification = Get_Signature_Status "$procpath1"
      $proclist_2.status = $verification

      $result_signatureDB += $proclist_2
    }

else{
 #write-host "Invalied"
}
}


function check_signature($file_path){
$result_signatureDB | where { $_.path -eq $file_path}
}
