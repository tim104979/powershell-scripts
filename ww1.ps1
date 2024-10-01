$username = $env:USERNAME
$computer = $env:COMPUTERNAME
$pwd = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer).UserName
$pwd | ConvertFrom-SecureString | Set-Content -Path "C:/password.txt"
