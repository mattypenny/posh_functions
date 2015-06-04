<#
.Synopsis
Get files modified between specified dates [sh]   
.DESCRIPTION
This was either an example from some learning exercise or it was for some very specific purpose that I've forgotten.

It's a possible candidate for moving out of the 'automatically loaded' area

.EXAMPLE
get-childitembydate "*txt" 20 0
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
