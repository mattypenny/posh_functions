# ------------------------------
# show-history
# ------------------------------


<#
.Synopsis
   Gets the history
.DESCRIPTION
   Gets history - 1000
   searches for specified string
.EXAMPLE
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-historymatchingstring
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        $Pattern = "*",
        $Tail = 5000
    )
 
    write-verbose $Pattern
    Get-History -count $Tail | Where-Object {$_.CommandLine -like "*$Pattern*"}


}
  
function hh
{
    [CmdletBinding()]
    Param ($Pattern = "*",
           $Tail = 50)
    if ($Pattern -eq "*")
    {
        get-historymatchingstring -tail $Tail | select Commandline
    }
    else
    {
        get-historymatchingstring -Pattern $Pattern | select Commandline
    }

}
