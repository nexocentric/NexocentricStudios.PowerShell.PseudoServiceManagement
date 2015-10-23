function Unregister-PseudoService
{
	[CmdletBinding(SupportsShouldProcess=$true)]
	param (
		[ValidateNotNullOrEmpty()]
		[parameter(Mandatory=$true)]
		# [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
		[string]$Name
	)

	Unregister-ScheduledTask -TaskName $Name
}