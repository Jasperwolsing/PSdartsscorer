$versionURL = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt"
Invoke-WebRequest "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt" -OutFile C:\Temp\repository.version
$version = Get-Content C:\temp\repository.version

$installedversion = Get-Content C:\Scorebord\installed.version -ErrorAction SilentlyContinue
if(!$installedversion -and $installedversion -lt $version)
{
    $URLupdater = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/updater.ps1"
    $updaterlocation = "C:\Scorebord\updater.ps1" 
    $URL1 = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/Scorebord.ps1"
    $url1location = "C:\scorebord\scorebord.ps1"

    Invoke-WebRequest $URLupdater -OutFile $updaterlocation
    Invoke-WebRequest $URL1 -OutFile $url1location

    Echo $version > C:\Scorebord\installed.version
}



