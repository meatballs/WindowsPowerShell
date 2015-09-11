Function prompt {
	$user = [System.Security.Principal.WindowsIdentity]::GetCurrent()
	$num = (Get-History -count 1).id + 1
	
	write-host
	write-host "$(Get-Location)" -foregroundcolor DarkRed -NoNewline
    	write-host "$(Get-GitBranch)" -foregroundcolor blue
	write-host $num -foregroundcolor DarkGreen -nonewline
	return "-->"
}

Function Get-GitBranch {
    $branch = ""
    if (Test-Path .git) {
        git branch | foreach {
            if ($_ -match "^\*(.*)"){
                $branch = $matches[1]
            }
        }
    }
    return $branch
}

Function Get-RegistryValue {
	param (
		[string] $key,
		[string] $value
	)
	return (Get-ItemProperty $key $value).$value
}

Function ConvertFrom-Base64 {
	param (
		[string] $base64String
	)
	$bytes = [System.Convert]::FromBase64String($base64String)
	$decoded = [System.Text.Encoding]::UTF8.GetString($bytes)
	
	return $decoded
}

Function Get-DropboxDirectory {
	$dropboxInstallPath = Get-RegistryValue HKCU:\Software\Dropbox InstallPath
	$dropboxHostDbFile = $dropboxInstallPath.Substring(0, $dropboxInstallPath.LastIndexOf("\") + 1) + "host.db"
	$encodedDirectory = Get-Content $dropboxHostDbFile | Select-Object -last 1
	$dropboxDirectory = ConvertFrom-Base64 $encodedDirectory
	
	if (-not $dropboxDirectory.EndsWith("\"))
		{$dropboxDirectory = $dropboxDirectory + "\"}
	
	return $dropboxDirectory
}

Function ConvertFrom-DosPath {
	[CmdletBinding()]
	Param (
		[Parameter(
			Position = 1,
			Mandatory = $True, 
			ValueFromPipeline = $True,
			ParameterSetName = "Paths"
		)]
		[string] $dosPath
	)
	$posixDrive = "/cygdrive/" + (Split-Path -qualifier $dosPath).Substring(0, 1)
	$posixPath = (Split-Path -noqualifier $dosPath).Replace("\", "/")
	
	return $posixDrive + $posixPath
}

Function r2d2 {ssh root@r2d2.empiria.co.uk}
Function bouch {ssh root@149.255.98.115}

Export-ModuleMember -Function *

Write-Host "Personal Functions Loaded"