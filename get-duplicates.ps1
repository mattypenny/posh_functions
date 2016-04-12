<pre>
function get-duplicates
{
  
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='What folder(s) would you like to target?')]
    [string[]]$folders,

    [string]$check_method = 'S'
  )



  function validate-folder
  {
    param ($p_folder)

    write-verbose "Validating folder $p_folder"

    # if not valid folder...
    if ($(test-path $p_folder) -eq $TRUE)
    {
      write-verbose "Folder $p_folder is hunky-dory"
    }
    else
    {
      write-host "$p_folder isn't valid"
    }


  }

  function get-filelist
  {
    parameter ($p_folders)

    write-verbose "Validating folder $p_folders"

  }


  # Validate each folder
  foreach ($folder in $folders)
  {
    validate-folder $folder
    $FILE_LIST += gci -recurse $folder
  }


  foreach ($FILE in $FILE_LIST)
  {
    $SORT_KEY = $FILE.fullname
    $SORT_KEY.toupper()

  }
  # sort the list as specified by the parameter
  $SORTED_FILE_LIST = $FILE_LIST | sort-object -property length

  foreach ($FILE in $SORTED_FILE_LIST)
  {
    # For each file, check whether it's key is the same as the previous key

    if ($LAST.length -eq $FILE.length )
    {
      $LAST
    }
    $LAST = $FILE
  }

}

</pre>
