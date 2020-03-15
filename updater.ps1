$versionURL = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt"
Invoke-WebRequest "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt" -OutFile C:\Temp\repository.version
$version = Get-Content C:\temp\repository.version

$installedversion = Get-Content C:\Scorebord\installed.version -ErrorAction SilentlyContinue
if(!$installedversion -and $installedversion -lt $version)
{
    $URLupdater = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/updater.ps1"
    $updaterlocation = "C:\Scorebord\updater.ps1" 
    Invoke-WebRequest $URLupdater -OutFile $updaterlocation

    $URL1 = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/Scorebord.ps1"
    $url1location = "C:\scorebord\scorebord.ps1"   
    Invoke-WebRequest $URL1 -OutFile $url1location

    $URL2 = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/possible-outs.csv"
    $url2location = "C:\scorebord\possible-outs.csv"   
    Invoke-WebRequest $URL2 -OutFile $url2location

    $URL3 = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/possible-outs-check.ps1"
    $url3location = "C:\scorebord\Possible-outs-check.ps1"   
    Invoke-WebRequest $URL3 -OutFile $url3location


    Echo $version > C:\Scorebord\installed.version
}



