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
function Get-MTPGitAddCommand
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter(Position=0)]
        $FolderName = ".",

        [string]$Option = "All"
    )

   $GitStatusOutput = get-MTPGetGitStatus 
 
   get-MTPGitUntrackedFilesCommands -GitStatusOutput $GitStatusOutput
   get-MTPGitModifiedFilesCommands -GitStatusOutput $GitStatusOutput
    
}
function get-MTPGitModifiedFilesCommands
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Position=0)]
        $GitStatusOutput
	)
    
    $ModifiedFiles = get-MTPGitModifiedFiles -GitStatusOutput $GitStatusOutput
	foreach ($F in $ModifiedFiles)
	{
		[string]$File = $F.Line
		$File = $File.trim()
		write-output "git add `"$File`""
	}

}


function get-MTPGitUntrackedFilesCommands
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Position=0)]
        $GitStatusOutput
	)
    
    $UntrackedFiles = get-MTPGitUntrackedFiles -GitStatusOutput $GitStatusOutput
	foreach ($F in $UntrackedFiles)
	{
		[string]$File = $F.Line
		$File = $File.trim()
		write-output "git add `"$File`""
	}

}

function get-MTPGitStatus
{
    [CmdletBinding()]

    $GitStatusOutput = git status | select-string '^'

    $GitStatusOutput = $GitStatusOutput |
							where-object Line -notlike "*~" |
                            where-object Line -notlike "*swp*" | 				
                            where-object Line -notlike "*swo" | 				
							where-object Line -notlike '(use "git add <file>..." to include in what will be committed)*'

	$GitStatusOutput
}

function get-MTPGitUntrackedFiles
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Position=0)]
        $GitStatusOutput,

        [string]$UntrackedFilesString = "Untracked files:"
    )
    $UntrackedFilesLine = $GitStatusOutput | ? line -Like "$UntrackedFilesString*" 

    [int]$UntrackedFilesLineNumber = $UntrackedFilesLine.LineNumber

    $Untracked = $GitStatusOutput | ? linenumber -gt $UntrackedFilesLineNumber


	$Untracked
}

function get-MTPGitModifiedFiles
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Position=0)]
        $GitStatusOutput,

        [string]$UntrackedFilesString = "Untracked files:"
    )
    $UntrackedFilesLine = $GitStatusOutput | ? line -Like "$UntrackedFilesString*" 

    [int]$UntrackedFilesLineNumber = $UntrackedFilesLine.LineNumber

    $Modified = $GitStatusOutput | 
    				? linenumber -lt $UntrackedFilesLineNumber |
    				? line -like "*modified:*" 

	

	$ModifiedFiles = @()	

	foreach ($F in $Modified)
	{
		[string]$Line = $F.Line
		write-host "$Line"
    
	    $ModifiedFiles += [PSCustomObject]@{Line = $Line.split(':')[1] }
    }

	$ModifiedFiles
}


set-alias ggac get-gitaddcommand
