# ----------------------------------------------------------------------
# Function: qref - edit-powershellref
#
#           This function gvims the powershell quick reference txt file
# ----------------------------------------------------------------------
function edit-powershellref { 
<#
.SYNOPSIS
This function gvims the powershell quick reference txt file[sh]

.DESCRIPTION


.PARAMETER FILE_TO_EDIT


.INPUTS

.LINK
Online list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions

#>

    gvim quickref.txt

}
set-alias qref edit-powershellref
set-alias pref edit-powershellref
set-alias qrg edit-powershellref
set-alias qrv edit-powershellref


