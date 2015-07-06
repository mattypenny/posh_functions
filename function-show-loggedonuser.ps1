# ----------------------------------------------------------------------
# Function: aliasname - 
#
#           This function
# ----------------------------------------------------------------------
function get-loggedonuser { 
<#
.SYNOPSIS


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
  [CmdletBinding()]	
	Param( [String] $Computername)
  
  get-loggedonuser $ComputerName

}



<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


