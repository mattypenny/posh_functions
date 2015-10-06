function get-childitemwithcommas { 
<#
.SYNOPSIS
  Does a dir, but outputs length with commas

.DESCRIPTION
  Longer description

.PARAMETER


.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("f")]$FileSpec = "$pwd"  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  dir $FileSpec | select @{Label="LastUpdated"; Expression = {"{0:dd/MM/yyyy HH:mm}" -f $_.lastwritetime } }, 
                         @{ Label="Size"; Expression ={"{0:N0}" -f $_.length}},
                         PSChildName,
                         PSDrive,
                         PSIsContainer,
                         PSParentPath,
                         PSPath,
                         PSProvider,
                         Attributes,
                         CreationTime,
                         CreationTimeUtc,
                         Directory,
                         DirectoryName,
                         Exists,
                         Extension,
                         FullName,
                         IsReadOnly,
                         LastAccessTime,
                         LastAccessTimeUtc,
                         LastWriteTime,
                         LastWriteTimeUtc,
                         Length,
                         Name,
                         BaseName,
                         VersionInfo,
                         mode

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias gciwc get-childitemwithcommas




function show-childitemwithcommas { 
<#
.SYNOPSIS
  Does a dir, but outputs length with commas and formats it

.DESCRIPTION
  Longer description

.PARAMETER


.EXAMPLE
  Example of how to use this cmdlet

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("f")]$FileSpec = "$pwd"  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  get-childitemwithcommas $FileSpec | select mode,
                                             lastupdated,
                                             size,
                                             name,
                                             fullname | ft -a
                                             
  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias sciwc show-childitemwithcommas 
set-alias dirt show-childitemwithcommas 


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>
