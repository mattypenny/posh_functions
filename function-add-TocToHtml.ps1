function add-TocToHtml { 
<#
.SYNOPSIS
  Reads in an html page, writes out an html page with a table of contents

.DESCRIPTION

  Todo list

  Todo: parameterize what headings are toc-ed
  Todo: make it work with headings other than <h3>
  Todo: indent the toc depending on the heading level
  Todo: create the toc with a specified font size
  Todo: add-in a go back to the top link before each heading, optionally
  Done: add in an offset parameter for lines you want to keep at the top
  Todo: some error-handling would be both nice and novel
  Todo: ignore a previously created TOC

.PARAMETER InputFile
  File containing the html to which you want to add a TOC

.PARAMETER OutputFile
  File to which to write the TOC-ed html
  Enter the word 'Screen' to have it output to the screen, or pipeline

.PARAMETER Offset
  Number of lines at the top of the html to leave 'as they are' before the TOC insert

.PARAMETER TextToInsertIntoTocLink
  This is a string that will be injected into each html link which makes up the TOC. 
  
  The script will then ignore these lines if and when it ever rebuilds the TOC for the same webpage.

  I wouldn't anticipate that I would often use anything other than the default of 'ThisIsATocLine'

.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("i")]$InputFile = "c:\temp\post.html",
         [string][Alias ("o")]$OutputFile = "c:\temp\post_with_Toc.html",
         [int][Alias ("off")]$Offset = 4,
         [string]$TextToInsertIntoTocLink = "ThisIsATocLine"
) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  write-debug "`$InputFile: $InputFile"
  write-debug "`$OutputFile: $OutputFile"
  write-debug "`$Offset: $Offset"

  # first step 
  # first read file, but throw away old TOC`dd
  $AllText = select-string -notmatch  "$TextToInsertIntoTocLink" $InputFile
 
  # Save the text that comes before the TOC into $OffSetText
  $OffSetLines = $AllText[0..$Offset]
  [string]$OffSetText = ""
  foreach ($LineObject in $OffSetLines) 
  {
    [string]$Line = $LineObject.line
    $OffsetText = $OffsetText + $Line + "<br>" 
  }

  # Save the text that comes after the TOC into $InputText
  $LineCount = $AllText | measure-object
  # $AfterOffset = $LineCount.count - $Offset
  $InputText = $AllText[$Offset..$LineCount.count]



  $OutputText = ""
  $TocText = ""
   
  foreach ($LineObject in $InputText) 
  {
    $Line = $LineObject.line
    if ($Line -like "*h3*") 
    { 
      $Title = $Line.Split("<>")[2] 
      write-debug "`$Title: $Title"

      $Anchor = $Title.replace(" ", "")
      write-debug "`$Anchor: $Anchor"

      $OutputLine = "`n`n<h3 id=`"$Anchor`">$Title</h3><br>`n"
      write-debug "`$OutputLine: $OutputLine"

      $OutputText = $OutputText + $OutputLine
      
      $TocLine = "<a $TextToInsertIntoTocLink href=`"`#$Anchor`">$Title</a><br>`n"
      write-debug "`$TocLine: $TocLine"

      $TocText = $TocText + $TocLine
    } 
    else 
    {
      if ($Line -ne "")
      {
        $OutputText = $OutputText + $Line + "<br>`n"
      }
    }
  }

  if ($OutputFile -ne "Screen")
  {
    $OffsetText | out-file $OutputFile
    $TocText | out-file -append $OutputFile
    $OutputText | out-file -append $OutputFile
  }
  else
  {
    $OffSetText
    $TocText
    $OutputText
  }

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias atth add-TocToHtml

atth


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


