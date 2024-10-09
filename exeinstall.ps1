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

Start-Process -Wait $Destination -ArgumentList $exeArgs
