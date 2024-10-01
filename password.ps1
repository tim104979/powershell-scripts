# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users in the domain
$users = Get-ADUser -Filter *

# Create an empty array to store the user passwords
$passwords = @()

# Loop through each user and get their password
foreach ($user in $users) {
  # Get the user's password
  $password = (Get-ADUser $user -Properties *).Password

  # Add the user's password to the array
  $passwords += [PSCustomObject]@{
    Username = $user.Name
    Password = $password
  }
}

# Export the user passwords to a file on the C drive
$passwords | Export-Csv -Path "C:\passwords.csv" -NoTypeInformation
