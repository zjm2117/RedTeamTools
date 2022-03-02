#************
#*** ICMP ***
#************
New-NetFirewallRule -Direction "Inbound" -Protocol "ICMPv4" -ICMPType 8 -Action "Block" -DisplayName "Disable inbound ICMP"
New-NetFirewallRule -Direction "Outbound" -Protocol "ICMPv4" -ICMPType 8 -Action "Block" -DisplayName "Disable outbound ICMP"

#***********
#*** DNS ***
#***********
New-NetFirewallRule -Direction "Inbound" -Protocol "UDP" -LocalPort 53 -Action "Block" -DisplayName "Disable inbound DNS"
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 53 -Action "Block" -DisplayName "Disable inbound DNS"

#************
#*** ADDS ***
#************

#*** Kerberos ***
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 88 -Action "Block" -DisplayName "Disable inbound Kerberos"
New-NetFirewallRule -Direction "Inbound" -Protocol "UDP" -LocalPort 88 -Action "Block" -DisplayName "Disable inbound Kerberos"

#*** LDAP ***
New-NetFirewallRule -Direction "Inbound" -Protocol "UDP" -LocalPort 389 -Action "Block" -DisplayName "Disable inbound LDAP"

#*** SMB ***
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 445 -Action "Block" -DisplayName "Disable inbound SMB"
New-NetFirewallRule -Direction "Inbound" -Protocol "UDP" -LocalPort 445 -Action "Block" -DisplayName "Disable inbound SMB"

#*** NetBIOS Name Service ***
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 137 -Action "Block" -DisplayName "Disable inbound NetBIOS Name Service"
New-NetFirewallRule -Direction "Inbound" -Protocol "UDP" -LocalPort 137 -Action "Block" -DisplayName "Disable inbound NetBIOS Name Service"

#***********
#*** SMB ***
#***********
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 445 -Action "Block" -DisplayName "Disable inbound SMB"
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 139 -Action "Block" -DisplayName "Disable inbound SMB"

#***********
#*** RDP ***
#***********
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 3389 -Action "Block" -DisplayName "Disable inbound RDP"
New-NetFirewallRule -Direction "Inbound" -Protocol "TCP" -LocalPort 53 -Action "Block" -DisplayName "Disable inbound RDP"