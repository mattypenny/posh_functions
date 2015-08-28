<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description

.PARAMETER


.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
function get-template { 
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 

  Begin
  {
  }

  Process
  {
  }

  End
  {
  }
}
}
set-alias aliasname get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


