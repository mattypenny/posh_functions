# ----------------------------------------------------------------------
# Function: ssi - show all static OS info
#
#           Show lots of OS stuff
# ----------------------------------------------------------------------

function show-serverinfo { 
Param ( [String] $MyServer = "." )


get-wmiobject win32_ComputerSystem -computer $MyServer | ft
get-wmiobject win32_bios -computer $MyServer | ft
sos $MyServer | out-string | fl
sproc $MyServer | out-string | fl
ss $MyServer | ft 
sshare $MyServer | ft

}
set-alias ssi show-serverinfo
set-alias ssinfo show-serverinfo


