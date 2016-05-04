# ----------------------------------------------------------------------
# Function: sql - Run a query against a specified database
# ----------------------------------------------------------------------

function run-sql { Param ( [String] $ServerInstance, [String] $Query ,
  [String][Alias ("d", "db", "dbname", "DatabaseName")] $Database = "master",
  [String][Alias ("f")] $File = "No_file_supplied")

write-debug $Query
if ("$Query" -like "ss*")
{
    $Query = "p:\\powershell\\sql\\$Query.sql"
    invoke-sqlcmd -ServerInstance $ServerInstance -inputfile $Query -Connectiontimeout 3 -Database $Database
}
elseif ("$File" -ne "No_file_supplied")
{
    invoke-sqlcmd -ServerInstance $ServerInstance -inputfile "$GhSql\\$File" -Connectiontimeout 3 -Database $Database
}
else
{
 
    invoke-sqlcmd -ServerInstance $ServerInstance -query $Query -Connectiontimeout 3 -Database $Database
}

}
set-alias sql run-sql


function run-SqlSelect 
{ 
  [CmdletBinding()]
  Param ( $ServerInstance, 
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

      foreach ($ServerInstance in $ServerInstance)
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


