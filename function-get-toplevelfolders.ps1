function get-toplevelfolders { 
<#
.SYNOPSIS
  Get servers top level folders

.DESCRIPTION
  Handy for looking to see where stuff is installed.

  This function is autoloaded by .matt.ps1
.PARAMETER


.EXAMPLE
  get-toplevelfolders server1

.EXAMPLE
  gtlf server1 | select fullname
#>
  [CmdletBinding()]
  Param( [string][Alias ("c")]$computername = "."  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  $Drives = Get-WMIObject Win32_LogicalDisk -filter "DriveType=3" -computer $ComputerName

  foreach ($D in $Drives)
  {
    [string]$Drive = $D.DeviceID
    $Drive = $Drive.replace(":", "$")
    dir \\$ComputerName\$Drive 
  }

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias gtlf get-toplevelfolders


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


