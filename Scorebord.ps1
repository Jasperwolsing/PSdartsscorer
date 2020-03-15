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

function set-count
{
    param
    (
        [int]$count
    )
    IF($WPFnumbercount.Content -eq 0)
    {
        $WPFnumbercount.Content = $count
    }
    Else
    {
        $WPFnumbercount.content = [string]$WPFnumbercount.Content + [string]$count
    }

}

Function run-possible-out
{
    IF($WPFStatusThuis.Visibility -like "Visible")
    {
        IF($WPFScoreThuis.Content -le 170)
        {
            $WPFInstructions.Content =  Possible-out -score $($WPFScoreThuis.Content)
        }
        Else
        {
            $WPFInstructions.Content =  "Thuis mag gooien"
        }
    }
    Else
    {
        IF($WPFscoreUit.Content -le 170)
        {
            $WPFInstructions.Content =  Possible-out -score $($WPFscoreUit.content)
        }
        Else
        {
            $WPFInstructions.Content =  "Uit mag gooien"
        }
    }
}

Function Set-score
{
    IF($WPFStatusThuis.Visibility -like "Visible")
    {
        IF(([int]$WPFScoreThuis.Content - [int]$WPFnumbercount.Content) -ge "0")
        {
            $WPFScoreThuis.Content = [int]$WPFScoreThuis.Content - [int]$WPFnumbercount.Content
            $WPFStatusUIT.Visibility = "Visible"
            $WPFStatusThuis.Visibility = "Hidden"
            $WPFInstructions.Content = "Uit mag werpen"
        }
        Else
        {
            $WPFInstructions.Content = "Deze score is niet mogelijk. Kan niet onder 0"
        }
    }
    else
    {
        IF(([int]$WPFScoreUIT.Content - [int]$WPFnumbercount.Content) -ge "0")
        {
            $WPFScoreUIT.Content = $WPFScoreUIT.Content - [int]$WPFnumbercount.Content
            $WPFStatusUIT.Visibility = "Hidden"
            $WPFStatusThuis.Visibility = "Visible"
            $WPFInstructions.Content = "Thuis mag werpen"
        }
        Else
        {
            $WPFInstructions.Content = "Deze score is niet mogelijk. Kan niet onder 0"
        }
    }

}

function calc-plus
{
    IF(!$WPFnumbercountcalc.content)
    {
        $WPFnumbercountcalc.content = $WPFnumbercount.Content
    }
    Else
    {
        $WPFnumbercountcalc.content= [int]$WPFnumbercountcalc.content + [int]$WPFnumbercount.Content
    }
    $WPFnumbercount.Content = "0"
}

function Calc-is
{
    $WPFnumbercount.Content = [int]$WPFnumbercountcalc.content + [int]$WPFnumbercount.Content
    $WPFnumbercountcalc.Content = ""
}

Function new-game
{
    $lastone = Get-Content C:\Scorebord\laststarter.txt
    IF($lastone -like "uit" -or !$lastone)
    {
        $WPFScoreThuis.Content = 501
        $WPFScoreUIT.content = 501
        $WPFStatusThuis.Visibility = "Visible"
        $WPFStatusUIT.Visibility = "Hidden"
        $WPFInstructions.Content = "Thuis mag beginnen aan de wedstrijd"
        Echo Thuis > C:\Scorebord\laststarter.txt
    }
    else
    {
        $WPFScoreThuis.Content = 501
        $WPFScoreUIT.content = 501
        $WPFStatusThuis.Visibility = "Hidden"
        $WPFStatusUIT.Visibility = "Visible"
        $WPFInstructions.Content = "Uit mag beginnen"
        Echo uit > C:\Scorebord\laststarter.txt
    }

}

function clear-numbercount
{
    $WPFnumbercount.Content = 0
    $WPFnumbercountcalc.content = ""
}
#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="WpfApp1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp1"
        mc:Ignorable="d"
        Title="MainWindow" Height="1080" Width="1920" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" WindowState="Maximized" Topmost="True" WindowStyle="None">
    <Grid Background="Black">
        <Label x:Name="ScoreThuis" Content="501" HorizontalAlignment="Left" Height="117" Margin="87,210,0,0" VerticalAlignment="Top" Width="471" FontFamily="Impact" FontSize="100" Background="#00000000" Foreground="White" HorizontalContentAlignment="Center" />
        <Label x:Name="scoreUit" Content="501" HorizontalAlignment="Left" Height="117" Margin="1278,210,0,0" VerticalAlignment="Top" Width="471" FontFamily="Impact" FontSize="100" Background="#00000000" Foreground="#FF001FE0" HorizontalContentAlignment="Center" />
        <Label x:Name="LabelUIT" Content="UIT" HorizontalAlignment="Left" Height="117" Margin="1278,23,0,0" VerticalAlignment="Top" Width="471" FontFamily="Impact" FontSize="100" Background="#00000000" Foreground="#FF001FE0" HorizontalContentAlignment="Center" />
        <Label x:Name="LabelThuis" Content="THUIS" HorizontalAlignment="Left" Height="117" Margin="87,23,0,0" VerticalAlignment="Top" Width="471" FontFamily="Impact" FontSize="100" Background="#00000000" Foreground="White" HorizontalContentAlignment="Center" />
        <Button x:Name="knop0" Content="0" VerticalAlignment="Top" Height="93" Margin="886,984,886,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knopOK" Content="OK" VerticalAlignment="Top" Height="93" Margin="1038,984,734,0" Background="#FF323431" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knopClear" Content="Clear" VerticalAlignment="Top" Height="93" Margin="734,984,1038,0" Background="#FF323431" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop5" Content="5" VerticalAlignment="Top" Height="93" Margin="886,790,886,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop7" Content="7" VerticalAlignment="Top" Height="93" Margin="734,887,1038,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop9" Content="9" VerticalAlignment="Top" Height="93" Margin="1038,887,734,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop8" Content="8" VerticalAlignment="Top" Height="93" Margin="886,887,886,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop6" Content="6" VerticalAlignment="Top" Height="93" Margin="1038,790,734,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop4" Content="4" VerticalAlignment="Top" Height="93" Margin="734,790,1038,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop2" Content="2" VerticalAlignment="Top" Height="93" Margin="886,693,886,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop3" Content="3" VerticalAlignment="Top" Height="93" Margin="1038,693,734,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knop1" Content="1" VerticalAlignment="Top" Height="93" Margin="734,693,1038,0" Background="#FF535552" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Label x:Name="Instructions" Content="" HorizontalAlignment="Left" Margin="734,589,0,0" VerticalAlignment="Top" Width="452" Height="100" Background="#FF2B2727" Foreground="White" FontFamily="Impact" FontSize="32"/>
        <Label x:Name="numbercount" Content="0" HorizontalAlignment="Left" Margin="743,639,0,0" VerticalAlignment="Top" Width="434" Height="50" Background="#FF554646" HorizontalContentAlignment="Center" FontFamily="Impact" FontSize="36" Foreground="White"/>
        <Ellipse x:Name="StatusThuis" Fill="#FF41E810" HorizontalAlignment="Left" Height="56" Margin="285,149,0,0" Stroke="White" VerticalAlignment="Top" Width="60"/>
        <Ellipse x:Name="StatusUIT" Fill="#FF41E810" HorizontalAlignment="Left" Height="56" Margin="1485,149,0,0" Stroke="White" VerticalAlignment="Top" Width="60"/>
        <Image HorizontalAlignment="Left" Height="135" Margin="609,23,0,0" VerticalAlignment="Top" Width="756" Source="C:\Scorebord\ZPC-Logo.png"/>
        <Button x:Name="knopNew" Content="Nieuw" VerticalAlignment="Top" Height="93" Margin="1755,984,17,0" Background="#FF323431" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knopplus" Content="plus" VerticalAlignment="Top" Height="93" Margin="1190,790,582,0" Background="#FF323431" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Button x:Name="knopIS" Content="IS" VerticalAlignment="Top" Height="93" Margin="1190,888,582,0" Background="#FF323431" Foreground="White" FontFamily="Impact" FontSize="38"/>
        <Label x:Name="numbercountcalc" Content="" HorizontalAlignment="Left" Margin="1089,639,0,0" VerticalAlignment="Top" Width="88" Height="50" Background="#FF554646" HorizontalContentAlignment="Center" FontFamily="Impact" FontSize="36" Foreground="White"/>

    </Grid>
</Window>

"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================

$WPFknop0.add_Click({
    set-count -count 0
})

$WPFknop1.add_Click({
    set-count -count 1
})

$WPFknop2.add_Click({
    set-count -count 2
})

$WPFknop3.add_Click({
    set-count -count 3
})

$WPFknop4.add_Click({
    set-count -count 4
})

$WPFknop5.add_Click({
    set-count -count 5
})

$WPFknop6.add_Click({
    set-count -count 6
})

$WPFknop7.add_Click({
    set-count -count 7
})

$WPFknop8.add_Click({
    set-count -count 8
})

$WPFknop9.add_Click({
    set-count -count 9
})

# knoppen kopieren om ze allemaal te laten werken

$WPFknopOK.add_click({
    Set-score
    clear-numbercount
    run-possible-out
})

$WPFknopNew.add_Click({
    new-game
    clear-numbercount
})

$WPFknopClear.add_Click({
    clear-numbercount
})

$WPFknopPlus.Content = '+'
$WPFknopPlus.add_Click({
    calc-plus
})

$WPFknopIS.Content = '='
$WPFknopIS.add_Click({
    calc-is
})




new-game

#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan
$Form.ShowDialog() | out-null

