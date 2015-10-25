function Test-PseudoService
{
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[string]$Name
	)
	Write-Verbose -Message ("Checking for pseduo service [${Name}${pseudoServiceSuffix}].")
	$scheduledTaskObject = Get-ScheduledTask | Where-Object { $_.TaskName -eq "${Name}${pseudoServiceSuffix}" }

	if ($scheduledTaskObject -eq $null)
	{
		Write-Verbose -Message ("Pseduo service [${Name}${pseudoServiceSuffix}] does not exist!")
		return $false
	}

	Write-Verbose -Message ("Pseduo service [${Name}${pseudoServiceSuffix}] found!")
	return $true
}