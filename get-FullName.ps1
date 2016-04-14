function get-fullname { 
<#
.SYNOPSIS
    Accepts item input from the commandline and outputs lastwritetime and fullname
.DESCRIPTION
    Just a handy select function 
.PARAMETER From the pipe line
    
.EXAMPLE
    Example of how to use this cmdlet

.EXAMPLE
    Another example of how to use this cmdlet
#>
#    [CmdletBinding()]
 

    write-startfunction

    foreach($file in $input)

    { 
        $file | select fullname, lastwritetime
    }
    write-endfunction

}

set-alias gfn get-fullname



function get-childitemfullname {
<#
.SYNOPSIS
    Accepts item input from the commandline and outputs lastwritetime and fullname
.DESCRIPTION
    Just a handy select function 
.PARAMETER From the pipe line
    
.EXAMPLE
    Example of how to use this cmdlet

.EXAMPLE
    Another example of how to use this cmdlet
#>
   [CmdletBinding()]
    Param ($Gci_filespec = ".") 

    write-startfunction

    Get-ChildItem $Gci_filespec | get-fullname
    write-endfunction

}

set-alias dirfn get-childitemfullname


<#
vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab
#>
