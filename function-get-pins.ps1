<#
.Synopsis
   Gets pins (i.e. saved URLs) from Pinboard
.DESCRIPTION
   Gets pins (i.e. saved URLs) from Pinboard

   Todo: option parameter
   Todo: tags parameter

.PARAMETER Username
   Pinboard user
.PARAMETER Password
   Pinboard password
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
        [string]$password = "$PinPass"
    )

    
    
    $uri = "https://api.pinboard.in/v1/posts/recent?count=100"
    
    $secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
    
    $cred = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)
    
    [xml]$xml = Invoke-RestMethod -Uri $uri -Method Post -Credential $cred 

<#
$xml.posts.post
#>
    $xml
}


<#
.Synopsis
   This retrieves recent pins as a header-ed webpage, with the header being specified tags
.DESCRIPTION
   Long description
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

        # Todo: Need to allow for one tag incorporating another e.g. sql and sqlserver
        [string]$TagString = $Tag
        write-output "<h3>$TagString</h3>"
        $PinsWithMatchingTag = $pins.posts.post | ? tag -like "*$TagString*"

	foreach ($Pin in $PinsWithMAtchingTag)
        {
                $Href = $Pin.href
                $Description = $Pin.Description
		write-output "<a href=`"$href`">$Description</a>"
        }
    }

    write-output "<h3>Other</h3>"

    foreach ($pin in $pins.posts.post)
    {

        $PinHasNoMatchingTags = $True

        $Href = $Pin.href
        $Description = $Pin.Description
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
        
        }

    }

}


<#
$Posts = $xml.posts.post | ? tag -notlike "*powershell*" | ? tag -notlike "*sqlserver*" | ? tag -notlike "*gtd*"
$Posts | ft @{Expression = {"<a href=`"" + $_.href + "`">" + $_.description + "</a> " + $_.Extended }}
#>
