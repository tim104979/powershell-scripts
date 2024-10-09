# Define the URLs of the installation files
$WinRarUrl = "https://www.win-rar.com/fileadmin/winrar-versions/winrar-x64-601.exe"
$ChromeUrl = "https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe"

# Define the destination paths for the files
$WinRarDestination = "C:\WinRAR.exe"
$ChromeDestination = "C:\Chrome.exe"

# Download the files using BITS
$WinRarJob = Start-BitsTransfer $WinRarUrl -Destination $WinRarDestination
$ChromeJob = Start-BitsTransfer $ChromeUrl -Destination $ChromeDestination

# Wait for the downloads to complete
while ($WinRarJob.JobState -eq "Transferring" -or $ChromeJob.JobState -eq "Transferring") {
    Start-Sleep -Milliseconds 100
}

# Check the job states
switch ($WinRarJob.JobState) {
    'Transferred' {
        # Complete the BITS transfer
        Complete-BitsTransfer -BitsJob $WinRarJob

        # Install WinRAR
        $WinRarArgs = '/S'
        $workingDir = if ([Environment]::Is64BitOperatingSystem) { "C:\Windows\SysWOW64" } else { $env:SystemRoot }
        Start-Process -Wait -WorkingDirectory $workingDir -FilePath $WinRarDestination -ArgumentList $WinRarArgs

        # Remove the file after installation
        Remove-Item -Path $WinRarDestination -Force
        break
    }

    'Error' {
        # Throw an error if the download fails
        throw 'Error downloading WinRAR'
    }
}

switch ($ChromeJob.JobState) {
    'Transferred' {
        # Complete the BITS transfer
        Complete-BitsTransfer -BitsJob $ChromeJob

        # Install Chrome
        $ChromeArgs = '/silent /install'
        $workingDir = if ([Environment]::Is64BitOperatingSystem) { "C:\Windows\SysWOW64" } else { $env:SystemRoot }
        Start-Process -Wait -WorkingDirectory $workingDir -FilePath $ChromeDestination -ArgumentList $ChromeArgs

        # Remove the file after installation
        Remove-Item -Path $ChromeDestination -Force
        break
    }

    'Error' {
        # Throw an error if the download fails
        throw 'Error downloading Chrome'
    }
}
