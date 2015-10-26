function Get-PseudoServiceInfo
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[parameter(Mandatory=$true,ValueFromPipeline=$true)]
		[ValidateNotNullOrEmpty()]
		[string[]]$PseudoServiceName
	)
	begin {}
	process
	{
		foreach ($pseudoService in $PseudoServiceName)
		{
			$pseudoServiceProperties = @{
				PseudoServiceName = $pseudoService;
				Description = "Not Applicable";
				Registrant = "Not Applicable";
				Registered = $false;
				Status = "Not Applicable";
			}
			
			if (Test-PseudoService -Name $pseudoService)
			{
				$selectedTask = Get-ScheduledTask -TaskName "${pseudoService}${pseudoServiceSuffix}"
				$pseudoServiceProperties.Description = $selectedTask.Description
				$pseudoServiceProperties.Registered = $true
				$pseudoServiceProperties.Registrant = $selectedTask.Author
				$pseudoServiceProperties.Status = if ($selectedTask.State -eq "Disabled") { "Stopped" } else { "Running" }
			}

			Write-Output -InputObject (New-Object -TypeName PSObject -Property $pseudoServiceProperties)
		}
	}
	end {}
}
