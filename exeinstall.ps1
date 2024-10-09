# Define the URL of the Ninite executable file
$FileUri = "https://ninite.com/chrome-winrar/ninite.exe"

# Define the destination path for the file
$Destination = "C:\Ninite.exe"

# Download the file using BITS
$bitsJobObj = Start-BitsTransfer $FileUri -Destination $Destination

# Wait for the download to complete
while ($bitsJobObj.JobState -eq "Transferring") {
    Start-Sleep -Milliseconds 100
}

# Check the job state
switch ($bitsJobObj.JobState) {

    'Transferred' {
        # Complete the BITS transfer
        Complete-BitsTransfer -BitsJob $bitsJobObj

        # Define the arguments for the Ninite installer
        $exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'

        # Force 32-bit execution on 64-bit systems
        $workingDir = if ([Environment]::Is64BitOperatingSystem) { "C:\Windows\SysWOW64" } else { $env:SystemRoot }

        # Run the Ninite installer
        Start-Process -Wait -WorkingDirectory $workingDir -FilePath $Destination -ArgumentList $exeArgs

        # Remove the file after installation
        Remove-Item -Path $Destination -Force
        break
    }

    'Error' {
        # Throw an error if the download fails
        throw 'Error downloading'
    }
}
