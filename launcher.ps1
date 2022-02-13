# Features needed
# Ask for directory (maybe open up Windows file manager to select game shortcut location)
# Then display all games in a list
# allow the user to select between different games in the list (maybe look at textbox options for other programs)
# display, keep running, maybe have list of all games (don't worry about scrolling, just didsplay them), then just go to game you want and select it with enter
# run the program, then close the launcher when done
# Install-Module Microsoft.PowerShell.ConsoleGuiTools 
# $module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
# Add-Type -Path (Join-Path $module Terminal.Gui.dll)
# [Terminal.Gui.Application]::Init()

Import-Module Microsoft.PowerShell.ConsoleGuiTools 
$module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
Add-Type -Path (Join-path $module Terminal.Gui.dll)
Add-Type -AssemblyName System.Windows.Forms

[Terminal.Gui.Application]::Init()
$Window = [Terminal.Gui.Window]::new()
$Window.Title = "Games Launcher"

$DirectoryFile = (Get-Content -Path .\directory.txt)

if ($DirectoryFile -eq "No")
{
    $browser = New-Object System.Windows.Forms.FolderBrowserDialog
    $null = $browser.ShowDialog()
    $path = $browser.SelectedPath
    $path | Out-File -FilePath .\directory.txt
}

# # $i = 1
$path = Get-Content -Path .\directory.txt
$shortcuts = Get-ChildItem -Path $path -Name -Attributes !Directory
Write-Output $shortcuts

# $Label = [Terminal.Gui.Label]::new()
# $Label.Text = "Welcome to the Powershell Games Launcher!`n" 
# $Label.Width = [Terminal.Gui.Dim]::Fill()
# $Label.Height = [Terminal.Gui.Dim]::Fill()
# $Window.Add($Label)

$i = 0

foreach ($game in $shortcuts) {
    $Button = [Terminal.Gui.Button]::new()
    $Button.Text = $game
    $Window.Add($Button)
    # Write-Output "$path\$game" | Out-F??ile -FilePath .\$game.txt 
    $Button.add_Clicked({
        # Out-File -FilePath .\test.txt 
        Out-File -FilePath .\$temp
        # Write-Output "$path\$game" | Out-File -FilePath .\test.txt 
        $temp = $Window.MostFocused.Text
        $temp = $temp | ConvertFrom-StringData
        # $temp = [system.String]::Join(" ", $temp) 
        Start-Process "$path\$temp"         
        # [Terminal.Gui.Application]::RequestStop()    
    })
    $Button.Y = $i
    $i += 1
}



# $ListView = [Terminal.Gui.ListView]::new()
# $ListView.SetSource(@($shortcuts))
# $ListView.Width = [Terminal.Gui.Dim]::Fill()
# $ListView.Height = [Terminal.Gui.Dim]::Fill()
# $ListView.add_Clicked({ $Label.Text = $ListView.SelectedItem })
# $Window.Add($ListView)

[Terminal.Gui.Application]::Top.Add($Window)
[Terminal.Gui.Application]::Run() 