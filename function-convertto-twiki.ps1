function convertto-twiki { 
<#
.SYNOPSIS
Reformats an object inna twiki-style

.DESCRIPTION
Pushes the object through convertto-html then does a bunch of search and replaces



.PARAMETER InputObject



.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE

.EXAMPLE
 

.LINK
Twiki list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions


#>
  [CmdletBinding()]	
	Param( $InputObject)
  write-verbose "Running convertto-twiki"

  [string]$TwikiString = ""

  $OutputObject = $InputObject | ConvertTo-Html
  foreach ($OutputObjectLine in $OutputObject) 
  {

    [string]$Line = $OutputObjectLine
    write-verbose "`$Line $Line"
    $Line = $Line.replace("`n", "")
    $Line = $Line.replace("<td>", " | ")
    $Line = $Line.replace("</td>", "")
    $Line = $Line.replace("<tr>", "")
    $Line = $Line.replace("</tr>", " |`n")
    $Line = $Line.replace("^ ", "")
    $Line = $Line.replace("$", " |")
    $Line = $Line.replace("", "")
    $TwikiString = $TwikiString + $Line
    
# write-output -nonewline "$Line |"
  }

  $TwikiString
}
set-alias aliasname template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


