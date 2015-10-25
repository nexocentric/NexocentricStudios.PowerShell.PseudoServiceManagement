function Stop-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({((Test-PseudoService -Name $_) -eq $true) -and (Test-PseudoServiceRegistrantIsAdministrator)})]
		[string]$Name
	)
	
	Write-Verbose -Message ("Stopping the listed PseudoServices")
}