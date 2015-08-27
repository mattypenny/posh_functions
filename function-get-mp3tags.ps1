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
function Get-ExtendedFileProperties
            
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
  
  
    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "Processing file $file"
  
      $directoryObject = $shellObject.NameSpace( $file.Directory.FullName )
  
      $fileObject = $directoryObject.ParseName( $file.Name )
      $RawFileProperties = New-Object PSObject
  
      for( $index = 0 ; $index -lt 1000; ++$index ) 
      {
  
        $name = $directoryObject.GetDetailsOf( $directoryObject.Items, $index )
  
        $value = $directoryObject.GetDetailsOf( $fileObject, $index )
  
        if ($name -ne "")
        {
          Add-Member -InputObject $RawFileProperties -MemberType NoteProperty -Name $name.replace(" ","") -value "$value"
          write-debug "Adding Member -Name $name -value $value"

          # todo: Check for unknown attributes (wull also check for atypical mp3 attributes). Logging both to some sort of error log
          #
          # if not in array
          # then
          #   write to errorlog file
          #
        }
      }

    return $RawFileProperties
  
    }
  
  }
  End
  {
  }
}
 

# todo: function to just extract the mp3 stuff
#
 

$X = Get-Rawmp3tags -folder "D:\music\Desm*" -verbose
$X | select Size, Album
# vim: set softtabstop=2 shiftwidth=2 expandtab
