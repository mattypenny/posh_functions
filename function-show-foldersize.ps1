function show-foldersize { 
<#
.SYNOPSIS
Recursively gets size of folders (but doesn't accumulate) [SH]


.DESCRIPTION
Lightly modified from http://technet.microsoft.com/en-us/library/ff730945.aspx



.PARAMETER BaseDirectory



.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE

.EXAMPLE
 



#>
  [CmdletBinding()]	
	Param( [String] $BaseDirectory)

  $startFolder = $BaseDirectory

  $colItems = (Get-ChildItem $startFolder | 
                 Measure-Object -property length -sum)

  "$startFolder -- " + "{0:N2}" -f ($colItems.sum / 1MB) + " MB"

  $colItems = (Get-ChildItem $startFolder -recurse | 
                 Where-Object {$_.PSIsContainer -eq $True} | Sort-Object)

  foreach ($i in $colItems)
  {
    $subFolderItems = (Get-ChildItem $i.FullName | 
                         Measure-Object -property length -sum)

    $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1MB) + " MB"
  }


}
set-alias du show-foldersize


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


