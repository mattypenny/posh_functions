# ----------------------------------------------------------------------
# These functions are too titchy to have their own separate ps1 file
#
# Some are glorified aliases
#
# This will be autoloaded by .matt.ps1
# ----------------------------------------------------------------------

function dirod {
<#
.SYNOPSIS
Does an equivalent of ls -ltr or dir /od
#>
Param ($DirName = "." ); dir $DirName | sort-object -property lastwritetime} 

function lsltr {
<#
.SYNOPSIS
Does an equivalent of ls -ltr or dir /od
#>
Param ($DirName = "." ); dir $DirName | sort-object -property lastwritetime}

function wcl {
<#
.SYNOPSIS
Does an equivalent of wc 0k
#>
Param ($FileName = "$PROFILE" ); gc $Filename | measure-object -line}


function dirwo 
<#
.SYNOPSIS
Edits file and returns control to Poswershell command line
#>
{ [CmdletBinding()]
  param ($FileNames) 

  . c:\powershell\load_site_specific_variables.ps1
  
  dir $DataPatchFolder\* | sort-object -property lastwritetime | select -last 15 -property lastwritetime, fullname

}


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>

