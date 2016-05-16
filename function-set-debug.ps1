# ----------------------------------------------------------------------
# Function: aliasname - dbgon/off
#
#           This function just sets debug off (default) or on
# ----------------------------------------------------------------------
function set-debug { 
<#
.SYNOPSIS
Sets de bugger on or off

.DESCRIPTION
Changes debug mode between off (silentlycontinue) and on (continue). If no mode specified defaults to off
  
This function is autoloaded by .matt.ps1

.PARAMETER P_DEBUG_MODE
On or off

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
dboff - alias to turn it off

.EXAMPLE
dbon - guess what?

.EXAMPLE
db on - as above

.EXAMPLE
db - turns it off

#>

  [CmdletBinding()]
	Param( [String] $P_DEBUG_MODE = "OFF")

  set-alias dbg write-debug

  dbg "P_DEBUG_MODE $P_DEBUG_MODE"

  dbg " DEBUGPREFENCE is $DEBUGPREFERENCE"
  if ($P_DEBUG_MODE -eq "ON")
  {
    dbg "On DEBUGPREFENCE is $DEBUGPREFERENCE"
    $DEBUGPREFERENCE = "Continue"
    dbg "On DEBUGPREFENCE is $DEBUGPREFERENCE"
  }
  else
  {
    dbg "Off DEBUGPREFENCE is $DEBUGPREFERENCE"
    $DEBUGPREFERENCE = "SilentlyContinue"
    dbg "Off DEBUGPREFENCE is $DEBUGPREFERENCE"
  }
    $DEBUGPREFERENCE = "SilentlyContinue"
    dbg "DEBUGPREFENCE is $DEBUGPREFERENCE"

}
set-alias db set-debug
function dbon {
<#
.SYNOPSIS
    Sets debug on
#>
. set-debug on}
function dboff {
<#
.SYNOPSIS
    Sets debug off
#>
. set-debug off}
# Not setting an alias here for 'dbg' because I'm intending to use that 
# in the code

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


