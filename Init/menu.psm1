function Show-Menu
{
     param (
           [string]$Title = 'Menu-1'
     )
     #cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' Process."
     Write-Host "2: Press '2' Network."
     Write-Host "3: Press '3' Logon Event Logs."
     Write-Host "4: Press '4' Security Event Logs."
     Write-Host "q: Press 'q' to exit."

     Write-Host "=========================================="
 }

function Show-Menu2
{
    param (
           [string]$Title = 'Menu-2'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' for All Process "
     Write-Host "2: Press '2' List Process Tree."
     Write-Host "3: Press '3' For Running Processes with active network conections."
     Write-Host "4: Press '4' For Running Processes with Autoruns."
     Write-Host "5: Press '5' For Running Processes with Schedule tasks."
     Write-Host "5: Press '6' For Running Processes with Un Signed Images."
     Write-Host "B: Press 'B' to back."

     Write-Host "=========================================="
}

function Show-Menu3
{
    param (
           [string]$Title = 'Menu-3'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' for All Network Connection details."
     Write-Host "2: Press '2' For get all Active Network Connections."
     Write-Host "3: Press '3' For get Network Connection by IP address."
     Write-Host "4: Press '4' For get Network Connection by Connection State."
     Write-Host "5: Press '5' For get All Remote IPs."
     Write-Host "B: Press 'B' to back."

     Write-Host "=========================================="
    
}

function Show-Menu4
{
    param (
           [string]$Title = 'Menu-4'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' for All Logn events."
     Write-Host "2: Press '2' For get Special Privilege Logons."
     Write-Host "3: Press '3' For get Logon Failiures."
     Write-Host "4: Press '4' For get Successful Logons."
     Write-Host "5: Press '5' For get Logn events by Username."
     Write-Host "6: Press '6' For get Logn events by time."
     Write-Host "7: Press '7' For get Extended Details."
     Write-Host "B: Press 'B' to back."

     Write-Host "=========================================="
    
}

function Show-Menu5
{
    param (
           [string]$Title = 'Menu-5'
     )
     cls
     Write-Host "================ $Title ================"
     
     Write-Host "1: Press '1' for Export All Security logs."
     Write-Host "2: Press '2' For Filter Security Logs by eventID."
     Write-Host "3: Press '3' For Filter Security Logs by TimeGenerated."
     Write-Host "4: Press '4' For Filter Security Logs by Replacementstring."
     Write-Host "5: Press '5' For Filter Security Logs by Log Content."
     Write-Host "6: Press '6' For Extended Search."
     Write-Host "B: Press 'B' to back."

     Write-Host "=========================================="
    
}