function get-ContentFromLastFile {
<#
.SYNOPSIS
    Show content of last file for filespec
.DESCRIPTION
    Longer description
    This function is autoloaded by .matt.ps1


.PARAMETER
    Filespec e.g. c:\temp\*.log
.EXAMPLE
    get-contentfromlastfile c:\temp\*.log

#>
    [CmdletBinding()]
    Param( [string]$FileSpecification = "C:\temp\*.log" ) 

    write-startfunction

    $LatestFile = Get-ChildItem $FileSpecification | sort-object -property lastwritetime | select -last 1
    

    get-content $LatestFile

    write-endfunction

}

set-alias gcflf get-ContentFromLastFile

function edit-ContentFromLastFile {
<#
.SYNOPSIS
    Edit content of last file for filespec
.DESCRIPTION
    This function is autoloaded by .matt.ps1


.PARAMETER
    Filespec e.g. c:\temp\*.log
.EXAMPLE
    get-contentfromlastfile c:\temp\*.log

#>
    [CmdletBinding()]
    Param( [string]$FileSpecification = "C:\temp\*.log" ) 

    write-startfunction

    $LatestFile = Get-ChildItem $FileSpecification | sort-object -property lastwritetime | select -last 1
    

    gvim $LatestFile

    write-endfunction

}





