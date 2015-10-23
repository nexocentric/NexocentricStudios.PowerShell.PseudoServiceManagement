function Unregister-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		# [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
		[string]$Name
	)
	try
	{
		Write-Verbose -Message ("Checking for pseduo service [${Name}].")
		$scheduledTaskObject = Get-ScheduledTask -TaskName $Name

		Write-Verbose -Message ("Pseduo service [${Name}] found!")
		Unregister-ScheduledTask -TaskName $Name
		return $true
	}
	catch
	{
		Write-Verbose -Message ("No pseduo service by the name of [${Name}] exists.")
		return $false
	}
}