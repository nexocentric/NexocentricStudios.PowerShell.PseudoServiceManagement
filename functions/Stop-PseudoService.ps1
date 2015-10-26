function Stop-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({((Test-PseudoService -Name $_) -eq $true) -and (Test-PseudoServiceRegistrantIsAdministrator)})]
		[string]$PseudoServiceName
	)
	
	Stop-ScheduledTask -TaskName "${PseudoServiceName}${pseudoServiceSuffix}" | Out-Null
	Disable-ScheduledTask -TaskName "${PseudoServiceName}${pseudoServiceSuffix}" | Out-Null

	Get-PseudoServiceInfo -PseudoServiceName $PseudoServiceName
}