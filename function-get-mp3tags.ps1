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

    $shellObject = New-Object -ComObject Shell.Application
  
  
    $Files = Get-ChildItem $folder -recurse 
  
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
  
        if ($name -ne "")
        {
          Add-Member -InputObject $RawFileProperties -MemberType NoteProperty -Name $name.replace(" ","") -value "$value"
          # write-debug "Adding Member -Name $name -value $value"
        }
      }

    return $RawFileProperties
  

    }
  
  }
  End
  {
  }
}
 

<#
.SYNOPSIS
   Short description

.DESCRIPTION

.EXAMPLE
   Get-CookedExtendedProperties -folder "D:\music\Desm*" -verbose

.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-CookedExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd" ) 

  Begin
  {
  }
  

  Process
  {

    # Todo: Need to remember/work out how to pass switches betwwen functions i.e. -verbose and -recurse

    $Expression = "`$CookedObject = [PSCustomObject]@{ "

    $Csv = import-csv ExtendedFileProperties.dat | ? Usedfor -like "*Mp3*"
    foreach ($r in $Csv ) 
    { 
      $Expression = $Expression + $r.CookedName + " = `$RawExtendedFileProperties.`"" + $r.RawName + "`"" + "`n"
      write-debug "`$Expression: $Expression"
    }

    $Expression = $Expression.substring(0, $Expression.length - 1 )
    $Expression = $Expression + "}"


    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "$MyInvocation.MyCommand.Name Processing file $file"
      $RawExtendedFileProperties = Get-RawExtendedFileProperties -folder $file
  
      write-debug "`$Expression: $Expression"
      invoke-expression $Expression

      $CookedObject
      
    } #EndForeach
  
  
  }
  End
  {
  }
}
 

 

 

# $X = Get-ExtendedFileProperties -folder "D:\music\Desm*" -verbose
# $X | select Size, Album


<#
.Synopsis
   Get extended properties depending on filetype
.DESCRIPTION
.EXAMPLE
   Get-SelectedExtendedFileProperties -folder "D:\music\*Take*"
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-SelectedExtendedFileProperties
            
{
  [CmdletBinding()]
  [Alias()]
  Param( [string]$folder = "$pwd",
         [string]$filetype = "default") 


  Process
  {

    $Csv = import-csv ExtendedFileProperties.dat

    $Files = Get-ChildItem $folder -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "$MyInvocation.MyCommand.Name: Processing file $file"

      [string]$Expression = "Get-CookedExtendedFileProperties -folder `"$file`" | "
 
      $Expression = $Expression + "select "

      foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) 
      {
        write-debug "$`Prop.CookedName:  $Prop.CookedName"
        $Expression = $Expression + $Prop.CookedName + ", "
      }

      $Expression = $Expression.substring(0, $Expression.length - 2 )

      write-debug "`$Expression $Expression"

      invoke-expression $Expression

    }

  }
      

<#
$Csv = import-csv ExtendedFileProperties.dat
$Csv | gm
$Csv | ? USedfor -like "*mp3*" | select PowershellName
$Csv | ? USedfor -like "*mp3*" | out-string
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = "PowershellName" + ","}
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = $_.PowershellName + ","}
$Csv | ? USedfor -like "*mp3*" | format-table @{Expression = {$_.PowershellName + ","}}
$String = $Csv | ? USedfor -like "*mp3*" | format-table @{Expression = {$_.PowershellName + ","}}
$String
#foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) {$X = $X + $Prop.PowershellName + ","}
[string]$X="select "
foreach ($Prop in $($Csv | ? Usedfor -like "*Mp3*" )) {$X = $X + $Prop.PowershellName + ","}
$X
$X = $X.substring(0, $X.length)
$X
$X = $X.substring(0, $X.length -1 )
$X
#>


  

  
  End
  {
  }
}
 


# vim: set softtabstop=2 shiftwidth=2 expandtab
