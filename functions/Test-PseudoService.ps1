function Test-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[string]$Name
	)
	Write-Verbose -Message ("Checking for pseduo service [${Name}].")
	$scheduledTaskObject = Get-ScheduledTask | Where-Object { $_.TaskName -eq $Name }

	if ($scheduledTaskObject -eq $null)
	{
		Write-Verbose -Message ("Pseduo service [${Name}] does not exist!") -ErrorAction Stop
		return $false
	}

	Write-Verbose -Message ("Pseduo service [${Name}] found!") -ErrorAction Stop
	return $true
}