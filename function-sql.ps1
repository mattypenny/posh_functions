# ----------------------------------------------------------------------
# Function: sql - Run a query against a specified database
# ----------------------------------------------------------------------

function run-sql { Param ( [String] $MyServer, [String] $Query )

write-debug $Query
if ("$Query" -like "ss*")
{
    $Query = "p:\\powershell\\sql\\$Query.sql"
    invoke-sqlcmd -ServerInstance $MyServer -inputfile $Query -Connectiontimeout 3
}
else
{
 
    invoke-sqlcmd -ServerInstance $MyServer -query $Query -Connectiontimeout 3
}

}
set-alias sql run-sql


function run-SqlSelect 
{ 
  [CmdletBinding()]
  Param ( $MyServer, 
          [String] $QueryFile = "c:\temp\poshsql\select.sql" )

  write-debug $QueryFile

  write-verbose "Validating file is safe"

  if (test-path $QueryFile)
  {
    if (select-string -pattern update,delete c:\temp\poshsql\select.sql) 
    {
      write-host "found something other than a select"
    }
    else 
    {
      $Query = gc $QueryFile
      write-debug "Running $Query"

      foreach ($ServerInstance in $MyServer)
      {
        invoke-sqlcmd -ServerInstance $ServerInstance -inputfile $QueryFile -Connectiontimeout 3
      }
    }
  }
  else
  {
    write-host "couldnt find the file $QueryFile"
  }
}
set-alias sqls run-sqlselect
# set-alias ssql run-sqlselect

function edit-SqlSelect {gvim c:\temp\poshsql\select.sql}
set-alias esql edit-SqlSelect


