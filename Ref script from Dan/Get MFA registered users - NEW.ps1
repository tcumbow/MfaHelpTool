Connect-MsolService

# $joeyD = Get-MsolUser -UserPrincipalName "gary.laverick@dart.biz" -ErrorAction Stop
# $joeyD | select -ExpandProperty StrongAuthenticationMethods


$groupMembers = Get-ADGroupMember -Identity "U AAD MFA Enabled"| Get-ADUser -Properties ExtensionAttribute9, mail, title, l, department | where { $_.ExtensionAttribute9.Length -gt 0 -and $_.mail -like "*@dart*" }

#$groupMembers = Get-ADUser -Filter { ExtensionAttribute9 -like "*" -and mail -like "*@dart*"} -properties title, l, department -SearchBase "OU=Users,OU=IT,OU=Mason,DC=dartcontainer,DC=com" | select -ExpandProperty UserPrincipalName | Sort-Object

#$groupMembers = Get-ADUser -Identity aa43075 -Properties ExtensionAttribute9, title, l, department | where { $_.ExtensionAttribute9.Length -gt 0 } | select -ExpandProperty UserPrincipalName

#$groupMembers = $groupMembers | select -first 50

$regUsers = @()
$nonRegUsers = @()

foreach ( $groupMember in ( $groupMembers | Sort UserPrincipalName ) ) {
    $user = Get-MsolUser -UserPrincipalName $groupMember.UserPrincipalName
   
    $StrongAuthenticationMethodsresult = $user.StrongAuthenticationMethods | Select-Object MethodType,IsDefault

    $object = [PSCustomObject]@{
       
        UserPrincipalName = $user.UserPrincipalName
        DisplayName = $user.DisplayName
        Location = $groupMember.l
        JobTitle = $groupMember.Title
        Department = $groupMember.Department
        Mail = $groupMember.Mail
        ObjectID = $user.Objectid
        AuthEmail = $user.StrongAuthenticationUserDetails.Email
        AuthPhoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
        PhoneDeviceName = $user.StrongAuthenticationPhoneAppDetails.DeviceName
        AuthAltPhone = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
        State = if($user.StrongAuthenticationRequirements.State -ne $null){ $user.StrongAuthenticationRequirements.State} else { "Disabled"}

        PhoneAppNotification = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppNotification"}) {$true} else {$false}
        PhoneAppNotificationIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppNotification"}).isDefault -eq "True") {$true} Else {$false}

        PhoneAppOTP = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppOTP"}) {$true} else {$false}
        PhoneAppOTPIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppOTPIsDefault"}).isDefault -eq "True") {$true} Else {$false}

        TwoWayVoiceMobile = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "TwoWayVoiceMobile"}) {$true} else {$false}
        TwoWayVoiceMobileIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "TwoWayVoiceMobileIsDefault"}).isDefault -eq "True") {$true} Else {$false}

        OneWaySMS = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "OneWaySMS"}) {$true} else {$false}
        OneWaySMSIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "OneWaySMSIsDefault"}).isDefault -eq "True") {$true} Else {$false}
    }

    $intMFAMethods = 0
    $intMFAMethods += if ($object.AuthEmail.Length -gt 0) { 1 } else { 0 }
    $intMFAMethods += if ($object.AuthPhoneNumber.Length -gt 0) { 1 } else { 0 }
    $intMFAMethods += if ($object.AuthAltPhone.Length -gt 0) { 1 } else { 0 }
    $intMFAMethods += if ($object.PhoneAppNotification) { 1 } else { 0 }
    $intMFAMethods += if ($object.PhoneAppOTP) { 1 } else { 0 }
    $intMFAMethods += if ($object.TwoWayVoiceMobile) { 1 } else { 0 }
    $intMFAMethods += if ($object.OneWaySMS) { 1 } else { 0 }

    #if ( $object.AuthEmail.Length -gt 0 -or $object.AuthPhoneNumber.Length -gt 0 -or $object.AuthAltPhone.Length -gt 0 -or $object.PhoneAppNotification -or $object.PhoneAppOTP -or $object.TwoWayVoiceMobile -or $object.OneWaySMS ) {
    if ( $intMFAMethods -ge 2 ) {
        Write-Host ("{0} is registered." -f $groupMember)
        $regUsers += $object
    } else {
        Write-Host ("{0} is NOT registered." -f $groupMember) -ForegroundColor Red
        $nonRegUsers += $object
    }
}

$regUsers.Count
$nonRegUsers.Count

$regUsers | Export-Csv c:\temp\MFAUsers.csv -NoTypeInformation
$nonRegUsers | Export-Csv c:\temp\MFAUsers-Not-Registered.csv -NoTypeInformation


#$regUsers | group { $_.PhoneAppNotification }

break


Connect-MsolService
$allUsers = Get-MsolUser -All:$true

$TotalItems = $allusers.count
$count=0
Write-Host "Total users in AzureAD: $TotalItems"

$outputVal = @()

$mfauserinfo =  ForEach ($user in $allusers ) {
        Write-Host "Processing $($User.UserPrincipalName) $count/$TotalItems"
        $StrongAuthenticationMethodsresult = $user.StrongAuthenticationMethods | Select-Object MethodType,IsDefault

        #$object = [ordered]@{
        $object = [PSCustomObject]@{
            UserPrincipalName = $user.UserPrincipalName
            ObjectID = $user.objectid
            DisplayName = $user.DisplayName
            AuthEmail = $user.StrongAuthenticationUserDetails.Email
            AuthPhoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
            PhoneDeviceName = $user.StrongAuthenticationPhoneAppDetails.DeviceName
            AuthAltPhone = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
            State = if($user.StrongAuthenticationRequirements.State -ne $null){ $user.StrongAuthenticationRequirements.State} else { "Disabled"}

            PhoneAppNotification = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppNotification"}) {$true} else {$false}
            PhoneAppNotificationIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppNotification"}).isDefault -eq "True") {$true} Else {$false}

            PhoneAppOTP = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppOTP"}) {$true} else {$false}
            PhoneAppOTPIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "PhoneAppOTPIsDefault"}).isDefault -eq "True") {$true} Else {$false}

            TwoWayVoiceMobile = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "TwoWayVoiceMobile"}) {$true} else {$false}
            TwoWayVoiceMobileIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "TwoWayVoiceMobileIsDefault"}).isDefault -eq "True") {$true} Else {$false}

            OneWaySMS = if ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "OneWaySMS"}) {$true} else {$false}
            OneWaySMSIsDefault = IF (  ($StrongAuthenticationMethodsresult | Where-Object {$_.MethodType -eq "OneWaySMSIsDefault"}).isDefault -eq "True") {$true} Else {$false}

        }

        $outputVal += $object
        $count++

}

      $outputVal | Out-GridView





      #Add all users in Search base OU to identity group
Get-ADUser -SearchBase ‘OU=Users,OU=DCSC,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=DFB,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=TUM,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=TWF,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=UNP,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=URB,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=WAX,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Get-ADUser -SearchBase ‘OU=Users,OU=ATL,DC=dartcontainer,DC=com’ -Filter "memberOf -recursivematch '$((Get-ADGroup -Identity "APPRole Office365 PRD KnowledgeWorkers").DistinguishedName )'" | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }






$groupMembers = Get-ADUser -Filter { ExtensionAttribute9 -like "*" -and mail -like "*@dart*"} -SearchBase "OU=Users,OU=IT,OU=Mason,DC=dartcontainer,DC=com" | select -ExpandProperty UserPrincipalName | ForEach-Object {Add-ADGroupMember -Identity ‘I.T. SSPR-1-549057710’ -Members $_ }
Add-AzureADGroupMember 