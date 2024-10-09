$FileUri = "https://ninite.com/chrome-winrar/ninite.exe"
$Destination = "C:/File.exe"

$bitsJobObj = Start-BitsTransfer $FileUri -Destination $Destination

switch ($bitsJobObj.JobState) {

    'Transferred' {
        Complete-BitsTransfer -BitsJob $bitsJobObj
        break
    }

    'Error' {
        throw 'Error downloading'
    }
}

$exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'

# Force 32-bit execution on 64-bit systems
$workingDir = if ([Environment]::Is64BitOperatingSystem) { "C:\Windows\SysWOW64" } else { $env:SystemRoot }

Start-Process -Wait -WorkingDirectory $workingDir -FilePath $Destination -ArgumentList $exeArgs

# Remove the file after installation
Remove-Item -Path $Destination -Force
