function Install-PoshPseudoServiceManagement
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param ()

	$powershellModulePaths = @($env:PSModulePath -split ';')

	$installationDirectory = "PoshPseudoServiceManagement"
	$installationPath = ""
	foreach ($path in $powershellModulePaths)
	{
		if ($path -match ":\\Users")
		{
			Write-Verbose -Message ("The user has a path for modules this machine at [${path}].")
			$installationPath = $path
			break;
		}

		Write-Verbose -Message ("Selecting [${path}] as the general location for scripts.")
		$installationPath = $path
	}

	if ([System.string]::IsNullOrEmpty($installationPath))
	{
		Write-Verbose -Message ("An installation directory for the module could not be found.")
		return $false
	}

	Write-Verbose -Message ("${installationPath}\${installationDirectory}")
	New-Item -ItemType Directory -Path ("${installationPath}\${installationDirectory}") -Force

	if ($PSCmdlet.ShouldProcess("thing", "place"))
	{
		Write-Verbose -Message ("Simulate download")
		# (New-Object Net.WebClient).DownloadFile(
		# 	"https://github.com/nexocentric/posh-pseudo-service-management/archive/1.0.0.zip",
		# 	"${installationPath}\${installationDirectory}\posh-pseudo-service-management-1.0.0.zip" #full file path required!
		# )
	}
	else {
		Write-Verbose -Message ("Download!")
	}
}

Install-PoshPseudoServiceManagement -Verbose -Confirm -WhatIf