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
  Todo: use this select  @{E={$_.sequencenumber};L='No.'}, title, bitrate, ContributingArtists, Genre, Size, Comments | ft -a
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
         [string]$filetype = "mp3") 


  Process
  {

    # todo: seperate this bit out into get-SelectExpression
    $Csv = import-csv ExtendedFileProperties.dat

    $SelectExpression = "select "

    foreach ($Prop in $($Csv | ? Usedfor -like "*`~$filetype`~*" )) 
    {
      write-debug "$`Prop.CookedName:  $Prop.CookedName"
      $SelectExpression = $SelectExpression + $Prop.CookedName + ", "
    }

    $SelectExpression = $SelectExpression.substring(0, $SelectExpression.length - 2 )

    write-verbose "The Select `$Expression $SelectExpression"


    $Files = Get-ChildItem "$folder" -recurse 
  
    foreach( $file in $Files ) 
    {
  
      write-verbose "$MyInvocation.MyCommand.Name: Processing file $file"

      [string]$Expression = "Get-CookedExtendedFileProperties -folder `"$file`" | "
 
      
      $Expression = $Expression + $SelectExpression

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
