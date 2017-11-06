<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-linksfromfile
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
       
        [Parameter(                   Position=0)]
        $XmlFile = "C:\Users\matt\Documents\working_repair_websites\salisburywiltshireandstonehenge.wordpress.2015-10-03.xml",

        [string]
        $WhiteList = "C:\Users\matt\Documents\data\links_whitelist.txt"

    )
         
         
    $WhiteListAs = gc $WhiteList

    # $WhiteListAs
    select-string  -pattern 'http' $XmlFile | select-string -notmatch $WhiteListAs 
   
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function format-Links
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
       
        [Parameter(                   Position=0)]
        $XmlFile = "C:\Users\matt\Documents\working_repair_websites\salisburywiltshireandstonehenge.wordpress.2015-10-03.xml",

        [string]
        $WhiteList = "C:\Users\matt\Documents\data\links_whitelist.txt",

        [string]
        $option = "plain",

        [string]
        $outputfile = "c:\temp\links.html",

        [int]
        $first = 20

    )
    
    $LinkLines = get-linksfromfile | select -First $first -property line 
     
    if ($Option -eq "plain")
    {
      write-verbose "Processing into Plain format"
      $LinkLines | ft @{e={$_.Line -replace "..*http","http" -replace """..*", "" -replace """", "" }}     
    }
    elseif ($Option -eq "html")
    {
      write-verbose "Processing into Html format"
      # $LinkLines | ft @{e={ $_.Line -replace "..*http","http" -replace """..*", "" -replace """", "" }}
      foreach ($Line in $LinkLines)
      {
        $L = $Line.Line
        write-debug "Raw line: $L"
        $L = $L -replace "..*http","http"
        write-debug "http on: $L"
        $L = $L + "x"
        $L = $L -replace """..*", ""
        write-debug "Removed after quote: $L"
        $L
      }
    }
    else
    { 
      Write-Verbose "Invalid option, numpty"
    }
}

$DebugPreference = "SilentlyContinue"
# format-links -option html -Verbose -first 400 | sort-object
# get-linksfromfile | select -First 10 -property line
# get-linksfromfile | select -First 10 -property line | ft @{e={$_.Line -replace "..*http","http" -replace """..*", "" -replace """", "" }}
format-links -option html -Verbose  -first 100000
