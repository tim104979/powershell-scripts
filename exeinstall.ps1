$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor = "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

 winget install -e --id RARLab.WinRAR

 winget install -e --id VMware.WorkstationPro

 winget install -e --id Microsoft.VisualStudioCode

 winget install -e --id PuTTY.PuTTY

 winget install -e --id WinSCP.WinSCP

 winget install -e --id Discord.Discord

 winget install -e --id Microsoft.OfficeDeploymentTool

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -Force
