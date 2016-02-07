
function  convert-wpPostToHugo{ 
<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description

.PARAMETER WordpressXML
  The wordpress content imported into an xml variable

.PARAMETER PostString
  The wordpress content imported into an xml variable

.EXAMPLE
  Example of how to use this cmdlet

#>
  [CmdletBinding()]
  Param( [string][Alias ("xml")]$WordpressXML = "$wp_xml",
         [string][Alias ("string")]$PostString = "ramone" ,
         [string][Alias ("f")]$ContentFolder = "c:\temp"
) 


  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  $MatchingWordPressPosts = get-wpPostMetaData -WordPressXml $WordPressXML -PostString $Poststring

  foreach ($WordPressPost in $MatchingWordPressPosts)
  { 
  
    [String]$HugoFileName = get-wpHugoFileName -WordPressPost $WordPressPost -ContentFolder $contentFolder
    write-debug "`$HugoFileName: $HugoFileName"

    [String]$HugoFrontMatter = get-wpHugoFrontMatterAsString -WordPressPost $WordPressPost
    write-debug "`$HugoFrontMatter: $HugoFrontMatter"

    [String]$HugoContent = get-wpPostContentAsString -WordPressPost $WordPressPost

    if ($ConvertFootnotes)
    {
      $HugoContent = convert-WordpressFootnotesToInternalLinks -Content $HugoContent
    }

    if ($ConvertWordpressTableToMarkdownTable)
    {
      $HugoContent = convert-WordpressWordpressTableToMarkdownTable -Content $HugoContent
    }

    if ($FlagLink)
    {
      $Links = get-wpLinks $HugoContent
    }

    # Todo: process for file already exists
    # Todo: process for file not writeable


    write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

  }

}
set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


function get-wpPostMetadata { 
<#
.SYNOPSIS
  Get Metadata

.DESCRIPTION


.PARAMETER WordpressXML
  The wordpress content imported into an xml variable

.PARAMETER PostString
  The wordpress content imported into an xml variable

.EXAMPLE
  Example of how to use this cmdlet

get-WordpressPostMetadata -poststring moberly | where-object post_type -eq 'post' 

title          : Moberly Road, Salisbury
link           : http://salisburyandstonehenge.net/streetnames/moberly-road-salisbury
pubDate        : Sat, 01 Aug 2009 20:27:56 +0000
creator        : creator
guid           : guid
description    : 
encoded        : {content:encoded, excerpt:encoded}
post_id        : 1149
post_date      : 2009-08-01 20:27:56
post_date_gmt  : 2009-08-01 20:27:56
comment_status : open
ping_status    : open
post_name      : moberly-road-salisbury
status         : publish
post_parent    : 0
menu_order     : 0
post_type      : post
post_password  : 
is_sticky      : 0
category       : {category, category, category, category...}
postmeta       : {wp:postmeta, wp:postmeta, wp:postmeta, wp:postmeta...}
comment        : {wp:comment, wp:comment, wp:comment, wp:comment...}

#>
  [CmdletBinding()]
  Param( [string][Alias ("xml")]$WordpressXML = "$wp_xml",
         [string][Alias ("string")]$PostString = "ramone"         ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

<#
select-xml -xml $wp_xml -xpath "//channel/item" | 
  select -expandproperty node | 
  where post_type -ne "attachment" |
  where title -like "*January*" | 
  select -ExpandProperty encoded | fl
#>

# [xml]$wp_xml = get-content wp_exp.xml
$Nodes = select-xml -xml $wp_xml -xpath "//channel/item" | select -expandproperty node | where-object title -like "*$PostString*"

foreach ($Node in $Nodes)
{
  $attachmenturl  = $Node.attachment_url
  $commentstatus  = $Node.comment_status
  $creator        = $Node.creator       
  $description    = $Node.description   
  $encoded        = $Node.encoded       
  $guid           = $Node.guid          
  $issticky       = $Node.is_sticky     
  $link           = $Node.link          
  $menuorder      = $Node.menu_order    
  $pingstatus     = $Node.ping_status   
  $postmeta       = $Node.postmeta      
  $postdate       = $Node.post_date     
  $postdategmt    = $Node.post_date_gmt 
  $postid         = $Node.post_id       
  $postname       = $Node.post_name     
  $postparent     = $Node.post_parent   
  $postpassword   = $Node.post_password 
  $posttype       = $Node.post_type     
  $pubDate        = $Node.pubDate       
  $status         = $Node.status        
  $title          = $Node.title   

  <# I Need to work out how much of the above stuff I can retain and how much of it I can put in the front matter. 
  It would be great to be able to keep it 'for a rainy day'

  The other big-ish puzzle is whether there's any chance of maintaining the same URLs for all the content.

  Or, alternatively, creating re-directs for everything. I'm not sure given that I haven't got _loads_ of backlinks that that's 
  worth worrying about tbh. Although quite a lot from twitter etc
  #>
  
  $node

}




  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


function get-wpHugoFileName { 
<#
.SYNOPSIS
  One-line description

.DESCRIPTION
  Longer description
  Todo: Could think about putting the category name in here?

.PARAMETER WordpressPostAsXml
  One wordpress post as xml

.PARAMETER ContentFolder
  Folder where the markdown-ed posts are going to go

.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [xml][Alias ("x")]$WordpressPostAsXml    
         [string][Alias ("f")]$ContentFolder = "c:\temp" )

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "
  
  [string]$postname       = $Node.post_name     
  write-debug "`$postname: $postname"

  [string]$FileName = $ContentFolder + '\' + $postname
  write-debug "`$Filename: $Filename"

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>



function get-wpHugoFrontMatterAsString { 
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
  Param( [xml][Alias ("x")]$WordpressPostAsXml   ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>



function get-wpPostContentAsString { 
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
  Param( [xml][Alias ("x")]$WordpressPostAsXml   ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>



function convert-WordpressFootnotesToInternalLinks { 
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
  Param( [string][Alias ("f")]$PostAsString = "$pwd"  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>




function convert-WordpressWordpressTableToMarkdownTable  { 
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
  Param( [string][Alias ("f")]$MarkdownPost = ""  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>




function get-wpLinks { 
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
  Param( [string][Alias ("h")]$HugoContent = ""  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "




  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias temp get-template


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>




<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab ignorecase
#>


