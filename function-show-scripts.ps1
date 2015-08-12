# ------------------------------
# show-scripts
# ------------------------------
function show-scripts {

<#
.SYNOPSIS
Show the ps1 scripts in the script folders
.DESCRIPTION

The alias is: 

.PARAMETER 
#>
$SCRIPT_FOLDERS = ""
foreach ($SCRIPT_FOLDER in $SCRIPT_FOLDERS) 
{
    gci $SCRIPT_FOLDER | select Fullname, lastwritetime | ft -autosize
}
}

