# Define the URL of the executable file
$url = "https://ninite.com/chrome-winrar/ninite.exe"

# Define the path where the file will be saved
$filePath = "C:\File.exe"

# Download the file using the Invoke-WebRequest cmdlet
Invoke-WebRequest -Uri $url -OutFile $filePath

# Install the executable file using the Start-Process cmdlet
Start-Process -FilePath $filePath -ArgumentList "/silent" -Wait
