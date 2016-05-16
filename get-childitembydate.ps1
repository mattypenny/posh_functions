<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
   This function is autoloaded by .matt.ps1


.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-childitembydate
{
    [CmdletBinding()]
    
    Param
    (
        # Param1 help description
        $Filespec,

        # Param2 help description
        [int]
        $newer = 1000000,

        
        # Param2 help description
        [int]
        $older = 0
    )
    

    gci -recurse $Filespec | select lastwritetime, length, fullname | 
        where-object {
                        $_.Lastwritetime -ge (Get-Date).AddDays($newer * -1) -and 
                        $_.Lastwritetime -le (Get-Date).AddDays($older * -1)
                     }

}










