

# Execution starts in the Main function below
$ScriptMode=$args[0]
function Main
{
    if($ScriptMode -eq "UnitTest1") {return UnitTest1}
    elseif($ScriptMode -eq "UnitTest2") {return UnitTest2}
    else {return NormalMain}
}

function UnitTest1
{
    Write-Host "Blarg"
}
function UnitTest2
{

}

function NormalMain
{
    DefineGUI # creates several script-wide WinForms elements via code that's copy/pasted from POSHGUI
    CustomizeGUI # tweaks to the WinForms elements that weren't copy/pasted from POSHGUI
    $script:GuiMain.Show()
    PopGuiOnTop
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    Sleep -Milliseconds 300; [System.Windows.Forms.Application]::DoEvents()
    $script:GuiMain.Dispose()
}

function DefineGUI # This function contains only code copy/pasted from POSHGUI.com
{
    <# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    MfaHelpTool Main
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$script:GuiMain                  = New-Object system.Windows.Forms.Form
$script:GuiMain.ClientSize       = New-Object System.Drawing.Point(654,359)
$script:GuiMain.text             = "WindowTitle"
$script:GuiMain.TopMost          = $false

$script:LabelAnimation           = New-Object system.Windows.Forms.Label
$script:LabelAnimation.AutoSize  = $false
$script:LabelAnimation.width     = 636
$script:LabelAnimation.height    = 39
$script:LabelAnimation.location  = New-Object System.Drawing.Point(9,311)
$script:LabelAnimation.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',18)

$script:TextBoxUserId            = New-Object system.Windows.Forms.TextBox
$script:TextBoxUserId.multiline  = $false
$script:TextBoxUserId.width      = 144
$script:TextBoxUserId.height     = 20
$script:TextBoxUserId.location   = New-Object System.Drawing.Point(15,57)
$script:TextBoxUserId.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$script:GuiMain.controls.AddRange(@($script:LabelAnimation,$script:TextBoxUserId))

}

function CustomizeGUI
{
    $script:GuiMain.ControlBox = $false
    $script:GuiMain.FormBorderStyle = 'Fixed3D'
    $script:GuiMain.StartPosition = "CenterScreen"

    # This base64 string holds the bytes that make up the Dart cup icon
    $iconBase64      = 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAadEVYdFNvZnR3YXJlAFBhaW50Lk5FVCB2My41LjEwMPRyoQAAAjJJREFUOE+V0W1IE3EcB3DrRRREb3oT9SJ60wtfWCg9QSD4opQeQCmiFoNeNCRardIXQ8IecGWYBWJORbK51WymbGk+bNN5JattNxPW2O3Odnu+p+32v7vdbb7qQFLvVQRf+L35fuDH71dRUW38v6yPqqsfz9xzXHo6qTMuPLf5uyfg1nfQuSejx+8PndKZarVjR1Q2BdD2es52jFa1DVzuGWuxzLWYnRdf2/bd7tx15cGeJl1lc1eTwa4A4wHs5bTvjsWlt86/mvL1OuH2CejGoP16j1XzxmYY91i8EQWwQqjrV9yDpOAYjRBsMi9kCgLBiSQnJnNCJMvOwQkF0Bt/fAnGnKE4FM3+TNJRgl2lQIzmftMcQoIARncMwwqgfjQ/E4x70WwwkYtSIFMoMkKJKZYIIMbzgi9Kap4tKkBds2PEiXixzEoihzM8w5eAuMZJazKTwWcv3nB3SgEON37oNC8vYdkgzshr0LwEpDIQyxQv4Xmh3x4+ek151t2nh7RdX5fQLJygMArIPbldEMsEL2IMp+/7vrduWAG21RgbW2e+RTIBnEJlwInyPusgSgLVQ9f2mn4FkHNM/WnSh/tiJEoCmheBWGKL5QyQ/Kt0rebv17aC/fWmPkcIiqRD6Zx8JVaQGF6KUdx7N3rogmWjtgl2nBhQP3a/dYcXwimMKKRyPJJmZ4PxmwbPzpODG7VNIOdA/Yiq3dltW5n1JxaX06Zp5NYL6OB589aOAvw71cY/wbikwSqtN2EAAAAASUVORK5CYII='
    $iconBytes       = [Convert]::FromBase64String($iconBase64)
    $stream          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
    $stream.Write($iconBytes, 0, $iconBytes.Length);
    $script:GuiMain.Icon       = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

    
}

function PopGuiOnTop {
    # $Button1TGModal.Enabled = $false
    # $Button2TGModal.Enabled = $false
    # $Button3TGModal.Enabled = $false
    $script:GuiMain.TopMost = $true
    # $LastPopUp = GetUnixTimestamp
    # Start-Sleep -Milliseconds 300
    # [System.Windows.Forms.Application]::DoEvents()
    # Start-Sleep -Milliseconds 300
    # [System.Windows.Forms.Application]::DoEvents()
    # Start-Sleep -Milliseconds 300
    # [System.Windows.Forms.Application]::DoEvents()
    Start-Sleep -Milliseconds 300
    [System.Windows.Forms.Application]::DoEvents()
    Start-Sleep -Milliseconds 300
    [System.Windows.Forms.Application]::DoEvents()
    # $Button1TGModal.Enabled = $true
    # $Button2TGModal.Enabled = $true
    # $Button3TGModal.Enabled = $true
    $script:GuiMain.TopMost = $false
    [System.Windows.Forms.Application]::DoEvents()
}



return Main