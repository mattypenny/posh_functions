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
function Get-RaWMp3Tags
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 

  Begin
  {
    $CurrentlyKnownTags =
      "Name",
      "Size",
      "Item type",
      "Date modified",
      "Date created",
      "Date accessed",
      "Attributes",
      "Availability",
      "Perceived type",
      "Owner",
      "Kind",
      "Contributing artists",
      "Album",
      "Year",
      "Genre",
      "Rating",
      "Authors",
      "Title",
      "Comments",
      "#",
      "Length",
      "Bit rate",
      "Protected",
      "Total size",
      "Computer",
      "File extension",
      "Filename",
      "Space free",
      "Shared",
      "Folder name",
      "Folder path",
      "Folder",
      "Path",
      "Type",
      "Link status",
      "Space used",
      "Sharing status"

    write-verbose "$CurrentlyKnownTags $CurrentlyKnownTags"
  }
  

  Process
  {

    $shellObject = New-Object -ComObject Shell.Application
  
  
    $mp3Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $mp3Files ) 
    {
  
      write-verbose "Processing file $file"
  
      $directoryObject = $shellObject.NameSpace( $file.Directory.FullName )
  
      $fileObject = $directoryObject.ParseName( $file.Name )
      $RawMP3Info = New-Object PSObject
  
      for( $index = 0 ; $index -lt 1000; ++$index ) 
      {
  
        $name = $directoryObject.GetDetailsOf( $directoryObject.Items, $index )
  
        $value = $directoryObject.GetDetailsOf( $fileObject, $index )
  
        if ($name -ne "")
        {
          Add-Member -InputObject $RawMP3Info -MemberType NoteProperty -Name $name -value "$value"
          write-debug "Adding Member -Name $name -value $value"
        }
      }

    return $RawMP3Info
  
    }
  
  }
  End
  {
  }
}
 

 

$X = Get-Rawmp3tags -folder "D:\music\Desm*" -verbose
$X | select Size, Album
# vim: set softtabstop=2 shiftwidth=2 expandtab
