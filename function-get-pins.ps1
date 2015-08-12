<#
.Synopsis
  Gets pins (i.e. saved URLs) from Pinboard
.DESCRIPTION
  Gets pins (i.e. saved URLs) from Pinboard

  Todo: option parameter
  Todo: tags parameter

.PARAMETER Username
  Pinboard user. If the $PinUser variable has been defined, this will be used as a default

.PARAMETER Password
  Pinboard password. If the $PinPass variable has been defined, this will be used as a default

.PARAMETER Option
  Not yet implemented
  The Pinboard API retrieval option. One of:
    get - one or more posts on a single day
    recent - most recent posts
    dates - a list of dates with the number of posts at each date
    all - all bookmarks in the user's account

.PARAMETER Tags
  Not yet implemented
  Pinboard tags - up to 3

.PARAMETER Count
  How many bookmarks to retrieve. Only used if the option is 'recent'

.PARAMETER TempFile
  File to retrieve the bookmarks into, then read them out of. Horrible kludge because I can't get reading directly into an XML variable to work.jjjjjjjjjjjjjjjjjj
  
.EXAMPLE
   
#>

function get-pins
{
  [CmdletBinding()]
  [OutputType([xml])]
  Param
  (
    
    [string]$username = "$PinUser",
    [string]$password = "$PinPass",
    [string]$option = "recent",
    [int]$count = 100,
    [string]$TempFile = "c:\temp\pins.xml"
  )
  write-verbose "Starting function get-pins"
  write-debug "Parameters: `$username $username `$password $password 
                           `$option $option `$count $count"
    
    
  if ( $option -eq "recent" )
  {
    $uri = "https://api.pinboard.in/v1/posts/recent?count=$count"
  }
  else
  {
    $uri = "https://api.pinboard.in/v1/posts/$option"
  }
       
  write-verbose "Getting bookmarks from Uri: $uri"
    
  $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
  $cred = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
    
  try
  {

    write-verbose "Running Invoke-RestMethod -Uri $uri -Credential $cred -timeout 300 -outfile $TempFile"

    Invoke-RestMethod -Uri $uri -Credential $cred -timeout 300 -outfile $TempFile
    write-debug $(dir $TempFile | select fullname, length, lastwritetime)

    
  }
  catch 
  {
    Write-output "It's all gone Pete Tong"
  }
  write-verbose "Reading $TempXmlFile into an xml object"
  [xml]$PinsAsXml = gc $TempFile

  write-verbose "Converting xml to Powershell object"
  $PinsAsObject = ""
  $PinsAsObject = $PinsAsXml.posts.post

  if ( $VerbosePreference -ne "SilentlyContinue" )
  {
    $NumberOfPins = $PinsAsObject | measure-object | select count
    [str]$NumberOfPinsString = $NumberOfPins.count
    write-verbose "Got this many bookmarks: $NumberOfPinsString"
  }

  return $PinsAsObject
}


<#
.Synopsis
   This retrieves recent pins as webpage, with specfied tags as headers
.DESCRIPTION
  This function outputs the last week's Pinboard tags as html. 

  It takes a list of Pinboard tags as a parameter. The Pins for each tag are listed nder an <h3> level header, then any remaining tags are listed under a heading of 'other'.

  The Pinboard username and password can be supplied as a parameter, or for convenience, these can be set up in the Shell variables $PinUser and $PinPass.

.EXAMPLE
  Example of how to use this cmdlet
.EXAMPLE
  Another example of how to use this cmdlet
#>
function Show-PinsAsWebPage
{
  [CmdletBinding()]
  Param
  (
    [string]$username = "$PinUser",
    [string]$password = "$PinPass",
    $tagList
  )

  $pins = get-pins -username $username -password $secpasswd
  convert-pinstowebpage $pins, $TagList

}

function Convert-PinsToWebPage
{
  [CmdletBinding()]
  Param
  (
    $pins,
    $taglist
  )

  write-verbose "$pins"

  foreach ($tag in $tagList)
  {
    write-verbose "$Tag"

    # Todo: Need to allow for one tag incorporating another e.g. 'sql' and 'sqlserver'
    [string]$TagString = $Tag
    write-output "<h3>$TagString</h3>"
    $PinsWithMatchingTag = $pins | ? tag -like "*$TagString*"

    foreach ($Pin in $PinsWithMAtchingTag)
    {
      $Href = $Pin.href
      $Description = $Pin.Description
      write-output "<a href=`"$href`">$Description</a>"
      write-output "<br>"
    }
  }

  write-output "<h3>Other</h3>"

  foreach ($pin in $pins)
  {

    $PinHasNoMatchingTags = $True

    $Href = $Pin.href
    $Description = $Pin.Description
    $Extended = $Pin.Extended
    $PinTag = $pin.tag 
       
    write-verbose "$Href" 
    write-verbose "$Description" 
    write-verbose "$PinTag" 
       
    write-debug "`$Extended: $Extended"
    $Extended = convert-PlainTextToSafeText $Extended
    write-debug "`$Extended: $Extended"

    foreach ($tag in $tagList)
    {
      write-verbose "$Tag"

      # Todo: Need to allow for one tag incorporating another e.g. sql and sqlserver
      [string]$TagString = $Tag
      
      if ( $PinTag -like "*$TagString*" )
      {
        $PinHasNoMatchingTags = $False
      }

    }

    if ( $PinHasNoMatchingTags -eq $True )
    {
      write-output "<a href=`"$href`">$Description</a>"
      if ( $Extended -ne "" )
      {
        write-output "- $Extended"
      }
      write-output "<br>"
    }

  }

}

<#
.Synopsis
   Convert text that has been saved to Pinboard to html-safe text
.DESCRIPTION
   Convert text that has been saved to Pinboard to html-safe text
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function convert-PlainTextToSafeText
{
    [CmdletBinding()]
    [OutputType([string])]
    Param
    (
        # Param1 help description
        [string]$PlainText,
        [string]$Option = 'html'
    )
    
    # replace greater than
    $SafeText = $PlainText.Replace("<", "&lt;")

    # replace less than
    $SafeText = $SafeText.Replace(">", "&gt;")

    return $SafeText
}

<#
$Posts = $xml.posts.post | ? tag -notlike "*powershell*" | ? tag -notlike "*sqlserver*" | ? tag -notlike "*gtd*"
$Posts | ft @{Expression = {"<a href=`"" + $_.href + "`">" + $_.description + "</a> " + $_.Extended }}
#>

# vim: set softtabstop=2 shiftwidth=2 expandtab 
