# Disable applications for all users
# Created by Zachary Mangiaracina

Set-ExecutionPolicy "Bypass" -Force
# Regex pattern for SIDs
$PatternSID = 'S-1-5-21-\d+-\d+\-\d+\-\d+$'
 
# Get Username, SID, and location of ntuser.dat for all users
$ProfileList = gp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*' | Where-Object {$_.PSChildName -match $PatternSID} | 
    Select  @{name="SID";expression={$_.PSChildName}}, 
            @{name="UserHive";expression={"$($_.ProfileImagePath)\ntuser.dat"}}, 
            @{name="Username";expression={$_.ProfileImagePath -replace '^(.*[\\\/])', ''}}
 
# Get all user SIDs found in HKEY_USERS (ntuder.dat files that are loaded)
$LoadedHives = gci Registry::HKEY_USERS | ? {$_.PSChildname -match $PatternSID} | Select @{name="SID";expression={$_.PSChildName}}
 
# Get all users that are not currently logged
$UnloadedHives = Compare-Object $ProfileList.SID $LoadedHives.SID | Select @{name="SID";expression={$_.InputObject}}, UserHive, Username
 
# Loop through each profile on the machine
Foreach ($item in $ProfileList) {
    # Load User ntuser.dat if it's not already loaded
    IF ($item.SID -in $UnloadedHives.SID) {
        reg load HKU\$($Item.SID) $($Item.UserHive) | Out-Null
    }
    #####################################################################
    # This is where you can read/modify a users portion of the registry 
	New-Item -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies" -Name "Explorer"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Type "DWord" -Value "1"
	New-Item -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Type "String" -Value "mmc.exe"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "2" -Type "String" -Value "regedit.exe"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "3" -Type "String" -Value "Taskmgr.exe"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "4" -Type "String" -Value "powershell.exe"
	Set-ItemProperty -Path "registry::HKEY_USERS\$($Item.SID)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "5" -Type "String" -Value "powershell_ise.exe"
    #####################################################################
}
Restart-Computer -Force