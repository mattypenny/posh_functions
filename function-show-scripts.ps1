function get-scripts {

<#
.SYNOPSIS
  Show the ps1 scripts in the script folders
.DESCRIPTION
  Just a convenience for showing the scripts
  This function is autoloaded by .matt.ps1


.PARAMETER Folders
  This would nearly always be left to the default, which would be set in the $profile, or '.matt' initialization script

#>
Param( $Folders = $ScriptFolders )
  foreach ($SCRIPT_FOLDER in $FOLDERS) 
  {
    gci $SCRIPT_FOLDER | select Fullname, lastwritetime 
  }
}

set-alias show-scripts get-scripts

# vim: set softtabstop=2 shiftwidth=2 expandtab
