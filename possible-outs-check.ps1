$PossibleOutList = Get-Content C:\Scorebord\possible-outs.csv | ConvertFrom-Csv -Delimiter ";"

Function Possible-out
{
    Param
    (
        [string]$score
    )
    $possibleout = $PossibleOutList | select Score, Display | where {$_.Score -eq $score}
    $possibleout.Display
}
