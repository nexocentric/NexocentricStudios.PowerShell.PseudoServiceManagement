$moduleDirectory = Split-Path -Path $MyInvocation.MyCommand.Path

"${moduleDirectory}\functions\*.ps1" | Resolve-Path | Where-Object { -not ($_.ProviderPath -like "*.tests.*") } | ForEach-Object { . $_.ProviderPath }

Export-ModuleMember Register-PseudoService
Export-ModuleMember Unregister-PseudoService