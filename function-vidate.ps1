# ----------------------------------------------------------------------
# Function: vidate - edit-filewithbackup
#
#           This function copies the existing file to old\<filename>_<date>
#           This function is autoloaded
# ----------------------------------------------------------------------
function edit-filewithbackup { 
<#
.SYNOPSIS
Copies the target file to an 'old' directory (creates the old directory if
there isn't one) and then edits it

.DESCRIPTION
The edit-filewithbackup function 'backs up' the target file to an 'old' directory. It creates the 'old' directory under the directory of the target file if it doesn't exist. The backup copy is suffixed with the date and time.

.PARAMETER FILE_TO_EDIT
The file you want to back up and edit, with the full filepath

.EXAMPLE
vidate g:\my_scripts\x.txt

.LINK
Online list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions

#>
  Param( [String] $FILE_TO_EDIT)

  write-debug "vidate-ing $FILE_TO_EDIT"
#
  # Work out what the 'old' folder would be
  $FS_FILE_TO_EDIT="Filesystem::$FILE_TO_EDIT"
  $OLD_FOLDER = $(gci $FS_FILE_TO_EDIT).directory
  $OLD_FOLDER = "Filesystem::$OLD_FOLDER\old"
  write-debug "Old folder is $OLD_FOLDER"

  # If 'old' folder doesn't exist, create it
  $OLD_FOLDER_EXISTS = test-path $OLD_FOLDER
  if ($OLD_FOLDER_EXISTS -eq $FALSE) 
  {
    mkdir $OLD_FOLDER
  }

  # get the date in YYYYMMDD format
  $DATE_SUFFIX = get-date -uformat "%Y%m%d"

  # get the filename without the folder
  $FILENAME = $(gci $FS_FILE_TO_EDIT).name
  write-debug "FILENAME is $FILENAME"

  # copy the existing file to the 'old' directory
  $OLD_FILE = $OLD_FOLDER + "\" + $FILENAME + "_" + $DATE_SUFFIX
  write-debug "OLD_FILE is $OLD_FILE"
  copy $FS_FILE_TO_EDIT $OLD_FILE

  # edit the file you first thought of (the out-null makes it wait)
  gvim "$FILE_TO_EDIT" | out-null

  # show the file edited, and its backup copies
  dir $FILE_TO_EDIT | select fullname, lastwritetime | ft -a 
  dir $OLD_FOLDER\$FILENAME* | select fullname, lastwritetime | ft -a
}
set-alias vidate edit-filewithbackup
set-alias vd edit-filewithbackup

# vim: set softtabstop=2 shiftwidth=2 expandtab 

