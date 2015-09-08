# ------------------------------
# show-functions
# ------------------------------
function get-functions {
<#
.SYNOPSIS
Show the functions in the repository folder
#>
$SHOW_FUNCTIONS_OBJECT = gci \\$RepositoryServer\d$\dbawork\matt\functions\*.ps1,$GhFunctions\*.ps1
$SHOW_FUNCTIONS_OBJECT
}
set-alias getf get-functions

function show-functions {
<#
.SYNOPSIS
Show the functions 
#>
get-functions | select lastwritetime, length, fullname | ft -a
}

set-alias sf show-functions

function get-functionsinmemory {
<#
.SYNOPSIS
Show the functions in memory and their synopsis
#>
  [CmdletBinding()]
  Param ([String] $FunctionPattern )

  write-verbose "In show-functionsinmemory: $FunctionPattern"

  $Synopses = foreach ($F in $(dir function:/* | ?  name -notlike "[A-Z]:")) {get-help $F | select name, synopsis}                                                          
  $Synopses | ? synopsis -like "[a-z][a-z]*" | select name, synopsis | sort -property name                                                      
  $Synopses | ? synopsis -notlike "[a-z][a-z]*" | select name, synopsis | sort -property name  

}
set-alias gfm  get-functionsinmemory  

function show-functionsinmemory { 
<#
.SYNOPSIS
  Get and format the functions in memory and their synopsis
#>

  [CmdletBinding()]
  Param ([String] $FunctionPattern )
  write-verbose "In show-functionsinmemory: $FunctionPattern"
  get-functionsinmemory $FunctionPattern | ft -a 
}
set-alias sf2  show-functionsinmemory  
set-alias sfm  show-functionsinmemory  
