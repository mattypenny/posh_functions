function select-FullName {

  Param ( 
    [Parameter(Mandatory=$False,ValueFromPipeLine=$true, Position=1)][String]$filename = "."
  )

  foreach ($i in $input)
  { 
    $I | select fullname
  }
<#
    if ($input)
    {
      foreach ($i in $input)
      { 
        $filename = $i
      
        $ChildItem = get-childitem $filename 

        [string]$FullName = $ChildItem.FullName

        return $FullName
    }
    else
    {
        $ChildItem = get-childitem $filename 

        [string]$FullName = $ChildItem.FullName

        return $FullName


    }
  }
#>

}
