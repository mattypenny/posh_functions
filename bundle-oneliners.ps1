# ----------------------------------------------------------------------
# These functions are too titchy to have their own separate ps1 file
#
# Some are glorified aliases
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

function gvim 
<#
.SYNOPSIS
Edits file and returns control to Poswershell command line
#>
{ [CmdletBinding()]
  param ($FileNames) 

  
  foreach ($F in $FileNames)
  {
    & "C:\Program Files (x86)\vim\vim74\gvim.exe" $F
    write-verbose "Edited $(dir $F | select fullname, lastwritetime, length | ft -a)"
  }

}
<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>
