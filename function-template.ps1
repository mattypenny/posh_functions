function get-template { 
<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description

.PARAMETER folder
  Folder 

.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("f")]$folder = "$pwd"  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


