<#
.Synopsis
   Short description
.DESCRIPTION
   This code is based on Shaun Cassells Get-Mp3FilesLessThan which I found at:
   http://myitforum.com/myitforumwp/2012/07/24/music-library-cleaning-with-powershell-identifying-old-mp3-files-with-low-bitrates/
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-RawExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 


  Process
  {
    write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "
    write-debug "`$folder: $folder"
    $shellObject = New-Object -ComObject Shell.Application
  
  
    $Files = Get-ChildItem "$folder" -recurse 
  
    write-verbose "Got files $($Files | measure-object).count"
    foreach( $file in $Files ) 
    {
  
      write-verbose "Get-RawExtendedFileProperties: Processing file $file"
  
      $directoryObject = $shellObject.NameSpace( $file.Directory.FullName )
  
      $fileObject = $directoryObject.ParseName( $file.Name )
      $RawFileProperties = New-Object PSObject
  
      for( $index = 0 ; $index -lt 1000; ++$index ) 
      {
  
        $name = $directoryObject.GetDetailsOf( $directoryObject.Items, $index )
  
        $value = $directoryObject.GetDetailsOf( $fileObject, $index )
  
        # For some reason it *seems* both 141 and 142 are 'status'
        if ($name -ne "" -and $index -ne 142)
        {
          Add-Member -InputObject $RawFileProperties -MemberType NoteProperty -Name $name.replace(" ","") -value "$value"
          write-verbose "Adding Member -Name $name -value $value. Index is $index"
        }
      }

    return $RawFileProperties
    write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "
  

    }
  
  }
  End
  {
  }
}
 

<#
.SYNOPSIS
   Get file attributes as a Powershell-friendly object

.DESCRIPTION

.EXAMPLE
   Get-CookedExtendedFileProperties -folder "D:\music\Desm*" -verbose

.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-CookedExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd",
         [string]$filetype = "mp3") 

  Begin
  {
  }
  

  Process
  {
    write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "
    

    # Todo: Need to remember/work out how to pass switches betwwen functions i.e. -verbose and -recurse

    $Expression = "`$CookedObject = [PSCustomObject]@{ "

    $Csv = import-csv ExtendedFileProperties.dat | ? Usedfor -like "*`~$filetype`~*" 
    foreach ($r in $Csv ) 
    { 
      $Expression = $Expression + $r.CookedName + " = `$RawExtendedFileProperties.`"" + $r.RawName + "`"" + "`n"
    }

    $Expression = $Expression.substring(0, $Expression.length - 1 )
    $Expression = $Expression + "}"

    # write-debug "`$Expression: $Expression"

    $Files = Get-ChildItem "$folder" -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-debug "Foreach loop: `$file $file"
      write-verbose "Processing $file"
      $RawExtendedFileProperties = Get-RawExtendedFileProperties -folder $file
  
      invoke-expression $Expression

      $CookedObject
      
    } 
  
    write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "
    
     
  }
  End
  {
  }
}
 

 

 


<#
.Synopsis
   Get extended properties depending on filetype

.DESCRIPTION
  Todo: use this select  
.EXAMPLE
   Get-SelectedExtendedFileProperties -folder "D:\music\*Take*"
.EXAMPLE
   Another example of how to use this cmdlet
#>
function show-Mp3Properties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "d:\music",
         [string]$filetype = "mp3",
         [Alias ("o") $object) 


  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "
  Get-CookedExtendedFileProperties -folder "$folder" | select @{E={$_.sequencenumber};L='No.'}, title, bitrate, ContributingArtists, Genre, Size, Comments | ft -a
  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "
   
}
 


# vim: set softtabstop=2 shiftwidth=2 expandtab
