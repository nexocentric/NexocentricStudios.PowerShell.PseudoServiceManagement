Install-PoshPseudoServiceManagement
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param ()

	$powershellModulePaths = @($env:PSModulePath -split ';')

	foreach ($path in $powershellModulePaths)
	{
		Write-Verbose -Message ($path)
	}
}

Install-PoshPseudoServiceManagement -Verbose