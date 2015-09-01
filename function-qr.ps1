# ----------------------------------------------------------------------
# Function: show-quickref
#
#           This function
# ----------------------------------------------------------------------
function show-quickref { 
<#
.SYNOPSIS
Does a grep on \\ronnie\c$\users\matt\Documents\WindowsPowershell\quickref.txt 

.DESCRIPTION



.PARAMETER $Pattern
What to grep for. e.g. databases

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
qr jobs

Line
----
$JOB = dir Sqlserver:\sql\$Computername\default\Jobserver\jobs | where-object {$_.name -like '*big-job*'}
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | select name, lastrundate, nextrundate, currentrunstatus, lastrunoutcome | ft
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | ft @{Label ="Jobbie" ; Expression={$_.name} ; Width = 42 }, @{Label="Last run" ;


#>
  [CmdletBinding()]	
	Param( [String] $Pattern)
  $QUICKREF = "$BaseDir\quickref.txt"

  if ($Pattern -ne $null)
  {
    select-string -Pattern $Pattern -path $QUICKREF | select line | ft -wrap
  }
  else
  {
    gc $QUICKREF
  }


}
set-alias qr show-quickref

function edit-quickref 
<#
Edit the quick reference document
#>
{ gvim "$BaseDir\\quickref.txt" }
set-alias gqr edit-quickref
set-alias eqr edit-quickref

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


