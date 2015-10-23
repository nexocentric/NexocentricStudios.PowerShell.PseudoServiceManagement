function Register-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({(Test-PseudoService -Name $_) -eq $false})]
		[string]$Name,

		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		[ValidateScript({Test-Path -Path $_ -PathType Leaf})]
		[string]$ExecutableFile,

		[ValidateNotNullOrEmpty()]
		[string]$Description
	)

	Write-Verbose -Message ("Performing checks for proper credentials.")
	$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	# if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
	# {
	# 	Write-Error -Message ("You must run PowerShell as administrator to run this function.")
	# 	return $false
	# }

	$taskUser = $env:USERDOMAIN + "\" + $env:USERNAME


	Write-Verbose -Message ("Script confirmed at location: ${ExecutableFile}")

	$taskName = "${Name}"
	$taskAction = New-ScheduledTaskAction -Execute $ExecutableFile

	$creationDate = Get-Date
	
	$taskTrigger = New-ScheduledTaskTrigger -Once:$false -At $creationDate -RepetitionDuration ([TimeSpan]::MaxValue) -RepetitionInterval (New-TimeSpan -Minutes 5)

# (New-TimeSpan -Minutes 5)
	$taskSettings = New-ScheduledTaskSettingsSet -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1) -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -WakeToRun
	$taskSettings.ExecutionTimeLimit = "PT0S" #this disables the stop the task checkbox

	# $userPassword = Read-Host -Prompt ("Please enter the password for [${taskUser}]") -AsSecureString

	$taskPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

	$dom = $env:userdomain
	$usr = $env:username
	
	$creationDate = Get-Date
	$Description = "This task was created by the Register-PseudoService PowerShell cmdlet on [${creationDate}].`n`n${Description}"

	$scheduledTask = New-ScheduledTask -Action $taskAction -Principal $taskPrincipal -Trigger $taskTrigger -Settings $taskSettings
	$scheduledTask.Author = ([adsi]"WinNT://$dom/$usr,user").FullName
	$scheduledTask.Description = $Description
	$scheduledTask.Date = $creationDate

	Register-ScheduledTask -TaskName $taskName -InputObject $scheduledTask
}