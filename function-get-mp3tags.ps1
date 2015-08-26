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
function Get-Mp3Tags
                      
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
            write-verbose "$CurrentlyKnownTags
          }
    

    }
    Process
    {

      $shellObject = New-Object -ComObject Shell.Application
    
      # Find all mp3 files under the given directory
    
      $mp3Files = Get-ChildItem $folder -recurse 
    
      foreach( $file in $mp3Files ) 
      {
    
        # Get a shell object to retrieve file metadata.
    
        $directoryObject = $shellObject.NameSpace( $file.Directory.FullName )
    
        $fileObject = $directoryObject.ParseName( $file.Name )
    
        for( $index = 0 ; $index -lt 1000; ++$index ) 
        {
    
          $name = $directoryObject.GetDetailsOf( $directoryObject.Items, $index )
    
          $value = $directoryObject.GetDetailsOf( $fileObject, $index )
    
          $RawMP3Info = New-Object PSObject
          Add-Member -InputObject $object -MemberType NoteProperty -Name $name -value $value

        }
    
      }
    
    
    }
    End
    {
    }
}
 

 

Get-mp3tags -folder "D:\music" -verbose
# vim: set softtabstop=2 shiftwidth=2 expandtab
