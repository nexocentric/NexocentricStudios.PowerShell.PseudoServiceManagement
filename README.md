# Posh Pseudo Service Management

PowerShell functions for creating pseudo services. According to the steps outlined in this blog http://blog.start-transcript.com/2012/01/22/running-powershell-scripts-as-a-service-events-prologue/ .

However, unlike the blog all registration is done via PowerShell.

## Installation

(New-Object Net.WebClient).DownloadString("https://github.com/nexocentric/posh-pseudo-service-management/master/Install-PoshPseudoServiceManagement.ps1") | Invoke-Expression

