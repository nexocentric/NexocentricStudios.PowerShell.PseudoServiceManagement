function Register-PSPseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		# [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
		[string]$Name,

		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({Test-Path -Path $_ -PathType Leaf})]
		[string]$PowerShellScript
	)

	Write-Verbose -Message ("Performing checks for proper credentials.")
	$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
	{
		Write-Error -Message ("You must run PowerShell as administrator to run this function.")
		return $false
	}

	$taskUser = $env:USERDOMAIN + "\" + $env:USERNAME


	Write-Verbose -Message ("Script confirmed at location: ${PowerShellScript}")

	$taskName = "$Name"
	$taskAction = New-ScheduledTaskAction -Execute $PowerShellScript
	
	$taskTrigger = New-ScheduledTaskTrigger -Daily -At 6AM
	$taskTrigger.RepetitionInterval = (New-TimeSpan -Minutes 5)
	$taskTrigger.RepetitionDuration = ([TimeSpan]::MaxValue)

	$taskSettings = New-ScheduledTaskSettingsSet -RestartCount 3 -StartWhenAvailable #-MultipleInstances ()

	# $userPassword = Read-Host -Prompt ("Please enter the password for [${taskUser}]") -AsSecureString

	$taskPrincipal = New-ScheduledTaskPrincipal -UserId "LOCALSERVICE" -LogonType ServiceAccount

	$scheduledTask = New-ScheduledTask -Action $taskAction -Principal $taskPrincipal -Trigger $taskTrigger -Settings $taskSettings

	Register-ScheduledTask -TaskName $taskName -InputObject $scheduledTask
}