<#
.SYNOPSIS
    Force Windows Defender Powershell script
	Mark Messink 27-15-2021

.DESCRIPTION
 
.INPUTS
  None

.OUTPUTS
  Log file: pslog_ForceDefenderUpdate.txt
  
.NOTES
  

.EXAMPLE
  .\ForceDefenderUpdate.ps1
#>

# Create Default Intune Log folder (is not exist)
$path = "C:\IntuneLogs"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

$logPath = "$path\pslog_ForceDefenderUpdate.txt"

#Start logging
Start-Transcript $logPath -Append -Force

	Write-Output "-------------------------------------------------------------------"
	Write-Output "----- Check Defender Versions"
	Get-MpComputerStatus | select *updated, *version
	Write-Output "-------------------------------------------------------------------"
	
	# AntivirusSignatureVersion 1.339.1400.0 = may 2021
	if((Get-MpComputerStatus).AntivirusSignatureVersion -le "1.339.1400.0"){
	Write-Output "----- Update Defender, AntivirusSignatureVersion is lower then 1.339.1400.0"
	Update-MpSignature
	Write-Output "-------------------------------------------------------------------"
	}
	Else {
	Write-Output "----- Defender not updated, version is 1.339.1400.0 or higher"
	} 
	
	Write-Output "----- Check New Defender Versions"
	Get-MpComputerStatus | select *updated, *version		
    Write-Output "-------------------------------------------------------------------"

#Stop Logging
Stop-Transcript
