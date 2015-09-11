$a = (Get-Host).UI.RawUI
$a.ForegroundColor = "Black"

Write-Host "Loading Personal Module" -foregroundcolor yellow
Import-Module Personal

Write-Host "Loading ssh-agent-utils Module" -foregroundcolor yellow
Import-Module ssh-agent-utils

Write-Host "Loading Agresso Framework Module" -foregroundcolor yellow
Import-Module Empiria.AgressoFramework

Write-Host "Setting Location to git folder" -ForegroundColor yellow
Set-Location "e:\projects"