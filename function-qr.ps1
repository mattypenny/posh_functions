$QuickReferenceFolder = "c:\users\$($($Env:Username).trimend('2'))\Documents\QuickReference\"

function get-LineFromQuickReferenceFiles { 
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
	Param( [String] $Pattern,
         [String] $FilePattern)

  if ($Pattern -ne $null)
  {
    select-string -Pattern $Pattern -path $QuickReferenceFolder\*$FilePattern*.md 
  }
  else
  {
    gc $QuickReferenceFolder\*.md
  }


}

function show-quickref { 
<#
.SYNOPSIS
Does a grep on quickref files
.DESCRIPTION
This function is autoloaded by .matt.ps1 
.PARAMETER $Pattern
What to grep for. e.g. insert
.PARAMETER $FilePattern
File to grep in. e.g. power
.EXAMPLE
qr jobs

Line
----
$JOB = dir Sqlserver:\sql\$Computername\default\Jobserver\jobs | where-object {$_.name -like '*big-job*'}
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | select name, lastrundate, nextrundate, currentrunstatus, lastrunoutcome | ft
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | ft @{Label ="Jobbie" ; Expression={$_.name} ; Width = 42 }, @{Label="Last run" ;


#>
  [CmdletBinding()]	

	Param([Parameter(Mandatory=$False,Position=1)] [String] $Pattern,
        [Parameter(Mandatory=$False,Position=2)][Alias ("f","file")] [String] $FilePattern)

get-LineFromQuickReferenceFiles -pattern $Pattern -filepattern $FilePattern | select line | ft -wrap

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
  [CmdletBinding()]	

	Param( [Parameter(Mandatory=$False,Position=2)][Alias ("f","file")] [String] $FilePattern)

  if ($FilePattern)
  {
    gvim "$QuickReferenceFolder\\*$FilePattern*.md" 
  }
  else
  {
    gvim "$QuickReferenceFolder\\unsorted.md" 
  }
}
set-alias gqr edit-quickref
set-alias eqr edit-quickref
set-alias qrg edit-quickref

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


