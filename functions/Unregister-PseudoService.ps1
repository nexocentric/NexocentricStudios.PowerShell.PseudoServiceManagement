function Unregister-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({((Test-PseudoService -Name $_) -eq $true) -and (Test-PseudoServiceRegistrantIsAdministrator)})]
		[string]$PseudoServiceName
	)
	try
	{
		Unregister-ScheduledTask -TaskName "${PseudoServiceName}${pseudoServiceSuffix}"
		return $true
	}
	catch
	{
		Write-Verbose -Message ("The pseduo service by the name of [${PseudoServiceName}${pseudoServiceSuffix}] has dissapeared or been removed by another resource. It does not exist anymore.")
		return $false
	}
}