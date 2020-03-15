$versionURL = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt"
Invoke-WebRequest "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/currentversion.txt" -OutFile C:\Temp\repository.version
$version = Get-Content C:\temp\repository.version

$installedversion = Get-Content C:\Scorebord\installed.version -ErrorAction SilentlyContinue
if(!$installedversion -and $installedversion -lt $version)
{
    $URLupdater = 

}


$URL1 = "https://raw.githubusercontent.com/Jasperwolsing/PSdartsscorer/master/Scorebord.ps1"


Echo $version > C:\Scorebord\installed.version

