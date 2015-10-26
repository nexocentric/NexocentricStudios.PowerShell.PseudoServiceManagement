$pseudoServiceSuffix = "PseudoService"

$moduleDirectory = Split-Path -Path $MyInvocation.MyCommand.Path

"${moduleDirectory}\functions\*.ps1" | Resolve-Path | Where-Object { -not ($_.ProviderPath -like "*.tests.*") } | ForEach-Object { . $_.ProviderPath }

Export-ModuleMember Get-PseudoService
Export-ModuleMember Get-PseudoServiceInfo
Export-ModuleMember Register-PseudoService
Export-ModuleMember Start-PseudoService
Export-ModuleMember Stop-PseudoService
Export-ModuleMember Test-PseudoService
Export-ModuleMember Unregister-PseudoService