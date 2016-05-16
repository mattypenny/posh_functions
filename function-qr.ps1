$QuickReferenceFolder = "c:\users\$($($Env:Username).trimend('2'))\Documents\QuickReference\"
# ----------------------------------------------------------------------
# Function: show-quickref
#
#           This function
# ----------------------------------------------------------------------
function show-quickref { 
<#
.SYNOPSIS
Does a grep on quickref files

.DESCRIPTION
 
This function is autoloaded by .matt.ps1 


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

  if ($Pattern -ne $null)
  {
    select-string -Pattern $Pattern -path $QuickReferenceFolder\*.md | select line | ft -wrap
  }
  else
  {
    gc $QuickReferenceFolder\*.md
  }


}
set-alias qr show-quickref

function set-LocationToQuickReference {
  cd $QuickReferenceFolder
}
set-alias cdqr set-LocationToQuickReference 

function edit-quickref 
<#
Edit the quick reference document
#>
{ 
  gvim "$QuickReferenceFolder\\unsorted.md" 
}
set-alias gqr edit-quickref
set-alias eqr edit-quickref
set-alias qrg edit-quickref

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


