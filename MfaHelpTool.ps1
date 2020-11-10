

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
    DefineGUI #creates several script-wide WinForms elements
    $script:GuiMain.Show()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    Sleep 1; [System.Windows.Forms.Application]::DoEvents()
    
}

function DefineGUI
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




return Main