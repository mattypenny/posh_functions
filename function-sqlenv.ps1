<#
.Synopsis
   Sets $ServerInstance and $ComputerName
.DESCRIPTION
   This function sets $ServerInstance and $ComputerName. It's an equivalent of .oraenv

   Todo: Could append \default if appropriate

.EXAMPLE
   . sqlenv

PS C:\Windows\system32> . sqlenv

instance_name     purpose                 monitor
-------------     -------                 -------
Serv01\prod01     Accounting production   Y      
Serv02\test01     Testing                 N
Serv03\default :  Widgets                 Y

ServerInstance = [serv03\default]: serv01\prod01
$Global:ComputerName: serv01
$Global:ServerInstance: serv01\prod01
   
#>
function set-SqlVariables
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        $ServerInstance = "$Global:ServerInstance"
    )

    Begin
    {
    }
    Process
    {
        write-verbose "`$Global:ServerInstance: $Global:ServerInstance"
 	smi
        write-verbose "Calling read-host"
	$NewServerInstance = read-host "ServerInstance = [$ServerInstance]"
        write-verbose "Called read-host"
        write-verbose "`$NewServerInstance: $NewServerInstance"
	if ($NewServerInstance) 
        { 
            write-verbose "In if..."
            $Global:ServerInstance = "$NewServerInstance" 
            write-verbose "`$Global:ServerInstance: $Global:ServerInstance"
        }
        write-verbose "`$Global:ServerInstance: $Global:ServerInstance"

        $Global:ComputerName = $Global:ServerInstance.split("\")[0]
        write-verbose "`$Global:ComputerName: $Global:ComputerName"
    
        write-output "`$Global:ComputerName: $Global:ComputerName"
        write-output "`$Global:ServerInstance: $Global:ServerInstance"
    }

    End
    {
    }
}
set-alias oraenv set-SqlVariables
set-alias sqlenv set-SqlVariables
