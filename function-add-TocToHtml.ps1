function add-TocToHtml { 
<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description

.PARAMETER folder
  Folder 

.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("i")]$InputFile = "c:\temp\post.html",
         [string][Alias ("o")]$OutputFile = "c:\temp\post_with_Toc.html") 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  $InputText = get-content $InputFile

  $OutputText = ""
  $TocText = ""
   
  foreach ($Line in $InputText) 
  {
    if ($Line -like "*h3*") 
    { 
      $Title = $Line.Split("<>")[2] 
      write-debug "`$Title: $Title"

      $Anchor = $Title.replace(" ", "")
      write-debug "`$Anchor: $Anchor"

      $OutputLine = "<h3 id=`"$Anchor`">$Title</h3><br>`n"
      write-debug "`$OutputLine: $OutputLine"

      $OutputText = $OutputText + $OutputLine
      
      $TocLine = "<a href=`"`#$Anchor`">$Title</a><br>`n"
      write-debug "`$TocLine: $TocLine"

      $TocText = $TocText + $TocLine
    } 
    else 
    {
      $OutputText = $OutputText + $Line
    }
  }

  $OutputText
  $TocText

  $TocText | out-file $OutputFile
  $OutputText | out-file -append $OutputFile

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias atth add-TocToHtml

atth


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


