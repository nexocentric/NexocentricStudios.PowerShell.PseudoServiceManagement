function Get-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[string]$Filter
	)

	$registeredPseudoServices = (Get-ScheduledTask | Select-Object -ExpandProperty TaskName)
	foreach ($pseudoServiceName in $registeredPseudoServices)
	{
		if (!($pseudoServiceName -like "${Filter}${pseudoServiceSuffix}"))
		{
			continue
		}
		Write-Output -InputObject ($pseudoServiceName -replace "${pseudoServiceSuffix}$","")
	}
}