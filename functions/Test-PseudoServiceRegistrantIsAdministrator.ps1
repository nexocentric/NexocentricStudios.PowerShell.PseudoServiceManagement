function Test-PseudoServiceRegistrantIsAdministrator
{
	Write-Verbose -Message ("Performing checks for proper credentials.")
	If (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
	{
		Write-Error -Message "Pseudo service registration/unregistration requires your PowerShell session to be run as administrator."
		return $false
	}
	return $true
}