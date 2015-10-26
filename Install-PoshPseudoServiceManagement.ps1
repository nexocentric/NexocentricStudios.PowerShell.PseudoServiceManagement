function Install-PoshPseudoServiceManagement
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param ()

	$powershellModulePaths = @($env:PSModulePath -split ';')

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

	Write-Verbose -Message ("${installationPath}")
	if (!(Test-Path $installationPath))
	{
		New-Item -ItemType Directory -Path ("${installationPath}") -Force
	}

	if ($PSCmdlet.ShouldProcess("thing", "place"))
	{
		Write-Verbose -Message ("Downloading archive")
		(New-Object Net.WebClient).DownloadFile(
			"https://github.com/nexocentric/posh-pseudo-service-management/archive/1.0.0.zip",
			"${installationPath}\PoshPseudoServiceManagement.zip" #full file path required!
		)
	}
	else {
		Write-Verbose -Message ("Simulating download!")
	}

	if ($PSCmdlet.ShouldProcess("thing", "place"))
	{
		$fullFileName = "${installationPath}\PoshPseudoServiceManagement.zip"
		Write-Verbose -Message ("Extracting archive!")
		$shell = New-Object -com shell.application
		$zip = $shell.NameSpace($fullFileName)
		foreach($item in $zip.items())
		{
			$shell.Namespace("${installationPath}").copyhere($item)
		}

		Remove-Item -Path $fullFileName
		Write-Host "You can now use these tools by running Import-Module -ListAvailable and enabling PsuedoService"
	}
	else {
		Write-Verbose -Message ("Simulating archive extraction!")
	}
}

Install-PoshPseudoServiceManagement -Verbose -Confirm