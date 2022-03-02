$services = @("W32Time", "Netlogon", "DNS", "TrkWks", "LanmanWorkstation", "IsmServ","ADWS","DFSR", "NtFrs","Kdc","NTDS", "LanmanServer","DFS")
foreach($service in $services){
	stop-service $service -force
	set-service $service -status stopped -StartupType disable
}