function get-template { 
<#
.SYNOPSIS
    One-line description
.DESCRIPTION
    Longer description
.PARAMETER

.EXAMPLE
    Example of how to use this cmdlet

.EXAMPLE
    Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    Param( [string][Alias ("f")]$folder = "$pwd"  ) 

    write-startfunction



    write-endfunction

}

set-alias temp get-template

<#
vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab
#>


