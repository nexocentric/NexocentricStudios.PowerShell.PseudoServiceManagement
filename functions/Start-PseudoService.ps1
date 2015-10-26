function Start-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({((Test-PseudoService -Name $_) -eq $true) -and (Test-PseudoServiceRegistrantIsAdministrator)})]
		[string]$PseudoServiceName
	)

	Enable-ScheduledTask -TaskName "${PseudoServiceName}${pseudoServiceSuffix}" | Out-Null
	Start-ScheduledTask -TaskName "${PseudoServiceName}${pseudoServiceSuffix}" | Out-Null

	Get-PseudoServiceInfo -PseudoServiceName $PseudoServiceName
}