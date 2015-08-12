<#
.Synopsis
   Generates a 'git add' command for everything that has been changed but not added
.DESCRIPTION
   Generates a 'git add' command for everything that has been changed but not added.

   There's probably a better way to do this within git itself, but I couldn't find it!

   Todo: implement swapping to a folder or folders and generating cd commands and got add commands
.EXAMPLE
   get-gitaddcommand

   git add .gitignore function-convertto-twiki.ps1 function-edit-powershellref.ps1 function-get-gitaddcommand.ps1

.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-GitAddCommand
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter(Position=0)]
        $FolderName = ".",

        [string]$Option = 0
    )

    
    Process
    {
        # Todo -  convert to building a string then write-outputting it
        # write-host -nonewline "git add" ; foreach ($F in $(get-gitstatus | select -expand working)) {write-host -nonewline " $F"}; write-host
    
        $GitAddString = "git add"
        foreach ($F in $(get-gitstatus | select -expand working)) 
        {
          $GitAddString = $GitAddString + " $F"
        }
        $GitAddString
        
    }
    
}