function get-sqlsessions { 
<#
.SYNOPSIS
  Gets sql sessions

.DESCRIPTION
  sql sessions
  This function is autoloaded by .matt.ps1

.PARAMETER $ServerInstance
  Can be a single server or a list of server

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
  get-sqlsessions sql01


.LINK
  https://github.com/mattypenny/posh_functions

#>
  [CmdletBinding()]	
	Param( $ServerInstance,
	       $Distinct = "Distinct")

  if ($Distinct -ne "Distinct")
  {
    $Distinct = ""
  }

  $Query = "select " + $Distinct + " host_name from sys.dm_exec_sessions" 

  foreach ($S in $ServerInstance)
  {

    invoke-sqlcmd -ServerInstance $S -Query $Query
  }
}


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>
