function prompt { 
<#
.SYNOPSIS
Sets the prompt

.DESCRIPTION
Sets the prompt to a default of the Git Shell prompt, without the folder name and with a dollar rather than a chevron

Todo: show the time
Todo: show the time of the last command

.PARAMETER Folder
Not yet implemented. Show the folder name in the prompt


.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE

.EXAMPLE
 

.LINK
Twiki list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions


#>
  [CmdletBinding()]	
	Param( [String] $Folder)

  $realLASTEXITCODE = $LASTEXITCODE

  # Reset color, which can be messed up by Enable-GitColors
  $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

  $FolderName = [System.IO.Path]::GetFileName($pwd.ProviderPath)

  Write-Host($FolderName) -nonewline


  try
  {
    Write-VcsStatus
  }
  catch
  {
    get-date 
  }
  $global:LASTEXITCODE = $realLASTEXITCODE
  return " $ "

}
set-alias aliasname template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


