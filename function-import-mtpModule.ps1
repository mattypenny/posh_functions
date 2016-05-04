function import-mtpModule { 
<#
.SYNOPSIS
    Shows module last update time, removes it if its already loaded then imports it
.DESCRIPTION
    Shows module last update time, removes it if its already loaded then imports it
.PARAMETER ModuleName
    List of Modules to load
.EXAMPLE
    Example of how to use this cmdlet
#>
    [CmdletBinding()]
    Param( [string][Alias ("module")]$ListOfModules = "Bounce-PCs"  ) 

    Import-Module Logging
    Import-Module MtpLogging

    write-startfunction

    foreach ($ModuleString in $ListOfModules) {

        Write-Debug "`$moduleString: $ModuleString"

        foreach ($ModuleObject in $(get-module -ListAvailable $ModuleString)) {

            Write-Debug "`$moduleObject: $ModuleObject"

            [string]$Path = $ModuleObject.path
            $FileDetails = dir $Path | select Lastwritetime, fullName 

            [string]$LastWriteTime = $FileDetails.LastWriteTime
            [string]$Fullname = $FileDetails.Fullname

            write-hostlog "Loading $ModuleObject $LastWriteTime  $Fullname"

            remove-module $ModuleObject

            import-module $ModuleObject

        }

    }
         
    write-endfunction

}

set-alias temp get-template

<#
vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab
#>
