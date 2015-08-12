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


function edit-powershellref { 
    gvim "\\$RepositoryServer\d$\dbawork\matt\quickref.txt"
}
set-alias qref edit-powershellref
set-alias pref edit-powershellref
set-alias qrg edit-powershellref
set-alias qrv edit-powershellref
