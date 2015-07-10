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
        [int]$count = 100
    )

    
    
    if ( $option -eq "recent" )
    {
       $uri = "https://api.pinboard.in/v1/posts/recent?count=$count"
    }
    else
    {
       $uri = "https://api.pinboard.in/v1/posts/$option"
    }
       
    write-verbose "Uri: $uri"
    
    $secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
    
    $cred = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
    
    [xml]$PinsAsXml = Invoke-RestMethod -Uri $uri -Method Post -Credential $cred 

    $PinsAsObject = $xml.posts.post
    
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

    write-debug "$pins"

    foreach ($tag in $tagList)
    {
        write-debug "$Tag"

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
       
        write-debug "$Href" 
        write-debug "$Description" 
        write-debug "$PinTag" 
       
        foreach ($tag in $tagList)
        {
            write-debug "$Tag"

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
$Posts = $xml.posts.post | ? tag -notlike "*powershell*" | ? tag -notlike "*sqlserver*" | ? tag -notlike "*gtd*"
$Posts | ft @{Expression = {"<a href=`"" + $_.href + "`">" + $_.description + "</a> " + $_.Extended }}
#>
