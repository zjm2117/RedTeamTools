Import-Module ActiveDirectory

$domain = "mangiaracina.net"

Function Get-AllADUsers([string]$domain){
	$splitDomain = $domain.split(".")
	$distinguishedName = "dc=" + $splitDomain[0] + ",dc=" + $splitDomain[1]
	Get-ADUser -Filter * -SearchBase $distinguishedName
}

Function Set-AdminAll([object[]]$users){
	Foreach($user in $users){
		if ($user.distinguishedName -eq "CN=zach2,CN=Users,DC=mangiaracina,DC=net"){
			write-output $user.distinguishedName
			Add-ADGroupMember -Identity "Enterprise Admins" -Members $user.distinguishedName
			Add-ADGroupMember -Identity "Domain Admins" -Members $user.distinguishedName
			Add-ADGroupMember -Identity "Schema Admins" -Members $user.distinguishedName
		}
	}
}

Get-AllADusers $domain | Set-AdminAll