# ----------------------------------------------------------------------
# Function: sqlping - Connect to specified sqlserver and show version
# This function is autoloaded
# ----------------------------------------------------------------------

function sqlping { 
[System.ComponentModel.Description("Connects and selects version details")]
Param ( [String] $MyServer )

invoke-sqlcmd -ServerInstance $MyServer -Query @"
                      SELECT SERVERPROPERTY('productversion') as Version, 
                      SERVERPROPERTY ('productlevel') as Patch, 
                      SERVERPROPERTY ('edition') as Edition,
                      login_time as sql_booted
               FROM master.dbo.sysprocesses
               where spid = 1
"@ 
}
set-alias sping sqlping

function test-allsqlconnections {
Param ($ServerInstances = $ServerInstances)

$OUTPUT = @()

$Query = "SELECT @@servername as ServerInstance,
                 SERVERPROPERTY('productversion') as Version, 
                 SERVERPROPERTY ('productlevel') as Patch, 
                 SERVERPROPERTY ('edition') as Edition,
                 login_time as sql_booted
          FROM   master.dbo.sysprocesses
          where  spid = 1"  

foreach ($I in $ServerInstances)
{

    $DatabaseDetails = New-Object PSObject
    
    try
    {
        $ErrorActionPreference = "SilentlyContinue"
        $DatabaseDetails = invoke-sqlcmd -ServerInstance $I -Query $Query
        $ErrorActionPreference = "Continue"
        write-verbose "Tried $I.instance_name"
    }
    catch
    {
        $DatabaseDetails | Add-Member -type NoteProperty -name ServerInstance -value $I.instance_name
        $DatabaseDetails | Add-Member -type NoteProperty -name Version -value "Can't connect"
        $DatabaseDetails | Add-Member -type NoteProperty -name Patch -value "---"
        $DatabaseDetails | Add-Member -type NoteProperty -name Edition -value "-----------------------------------------------"
        $DatabaseDetails | Add-Member -type NoteProperty -name Sql_booted -value "-------------------"
        write-verbose "Caught $I.instance_name"
    }
    $output += $DatabaseDetails
}
$OUTPUT
}
set-alias gping test-allsqlconnections 
set-alias tping test-allsqlconnections 


function show-allsqlconnections
{
    Param ($ServerInstances = $ServerInstances)
    test-allsqlconnections -ServerInstances $ServerInstances | ft -a
}



set-alias spingall show-allsqlconnections



