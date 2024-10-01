$cred = Get-Credential -Username $env:USERNAME
$cred.Password | ConvertFrom-SecureString | Set-Content -Path "C:\password.txt"
