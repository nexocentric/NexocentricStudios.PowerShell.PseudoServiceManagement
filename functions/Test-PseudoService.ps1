function Test-PseudoService
{
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[string]$Name
	)
	Write-Verbose -Message ("Checking for pseduo service [${Name}${pseduoServiceSuffix}].")
	$scheduledTaskObject = Get-ScheduledTask | Where-Object { $_.TaskName -eq "${Name}${pseduoServiceSuffix}" }

	if ($scheduledTaskObject -eq $null)
	{
		Write-Verbose -Message ("Pseduo service [${Name}${pseduoServiceSuffix}] does not exist!")
		return $false
	}

	Write-Verbose -Message ("Pseduo service [${Name}${pseduoServiceSuffix}] found!")
	return $true
}