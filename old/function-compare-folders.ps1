<#
.Synopsis
   See if each file in folder 1 exists in folder 2
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Compare-Folders
{
    [CmdletBinding()]
    
    Param
    (
        $Folder1 = "D:\onedrive\salisburyandstonehenge.net\content\on-this-day",

        $Folder2 = "D:\hugo\sites\example.com\content\on-this-day",

        [switch]$ShowDifferencesOnly = $True
    )

    $FileComparison = @()
    foreach ($file in $(gci $folder1 | where {!$_.PSIsContainer}))
    {
        [string]$Filename = $file.name

        if (test-path $Folder2/$Filename)
        {
            $File2 = gci $Folder2/$Filename
        }
        else
        {
            $file2 = ""
        }
        
        
        $FileComparison += [PSCustomObject]@{  Filename1 = $file.name
                                LastWriteTime1 = $file.lastwritetime
                                Length1 = $file.length
                                Filename2 = $file2.name
                                LastWriteTime2 = $file2.lastwritetime
                                Length2 = $file2.length
                                GvimCommand = "gvim $folder1\$Filename $folder2\$Filename"
                            }
    }                      
    $FileComparison | select lastwritetime1, length1, lastwritetime2, length2, filename1, filename2, gvimcommand
}
# compare-folders c:\temp c:\temp