# ----------------------------------------------------------------------
# Function: aliasname - 
#
#           This function
# ----------------------------------------------------------------------
function get-loggedonuser { 
<#
.SYNOPSIS
  Gets a list of users logged on to a specified server


.DESCRIPTION



.PARAMETER MyServer



.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE

.EXAMPLE
 

.LINK
Twiki list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions


#>
  [CmdletBinding()]	
	Param( [String] $Computername)


  $(Gwmi Win32_ComputerSystem -Comp $ComputerName).Username

}


function show-loggedonuser {
<#
.SYNOPSIS
  Gets a list of users logged on to a specified server. No formatting, yet.


  [CmdletBinding()]	
	Param( [String] $Computername)
  
  get-loggedonuser $ComputerName

}



<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


