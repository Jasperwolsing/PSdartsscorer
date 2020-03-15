$Trigger2= New-ScheduledTaskTrigger -AtStartup
$Trigger2.Delay = 'PT1M'
$trigger = @(
    $(New-ScheduledTaskTrigger -AtStartup),
    $($Trigger2)
)
$User= "NT AUTHORITY\SYSTEM"
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\Scorebord\updater.ps1"
Register-ScheduledTask -TaskName "Scorebord updater" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force
