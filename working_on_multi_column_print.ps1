    $val=0; $Aliases = while ($val -ne 5) {$val++; New-Object -TypeName PSObject -property @{Name = "$val"; Definition ="Defined"}}
    $DesiredColumns = 3
    [int]$AliasesWritten = 0
 # $Aliases
    [int]$CountOfAliases = $($Aliases | measure-object).count
    
    write-debug "`$CountOfAliases: $CountOfAliases `$AliasesWritten: $AliasesWritten   $($AliasesWritten -le $CountOfAliases)"
       
    while ($AliasesWritten -le $CountOfAliases) 
    {
      write-debug "OuterWhile - `$AliasesWritten: $AliasesWritten"
      $AliasesWrittenInThisRow = 0

      while ($AliasesWrittenInThisRow -le $DesiredColumns)
      {
        write-debug "In A While - `$AliasesWritten: $AliasesWritten"
      
        [string]$Alias = $Aliases[$AliasesWritten].Name
        [string]$Definition = $Aliases[$AliasesWritten].Definition

        [int]$ThisAliasWidth = [math]::min($AliasWidth, $Alias.length) 
        [int]$ThisDefinitionWidth = [math]::min($DefinitionWidth, $Definition.length) 

        write-debug "`$Alias: $Alias `$ThisAliasWidth: $ThisAliasWidth "
        write-debug "`$Definition: $Definition `$ThisDefinitionWidth: $ThisDefinitionWidth"

        [string]$PrintString = "{0,-$AliasWidth} {1,-$DefinitionWidth}     " -f $Alias.Substring(0, $ThisAliasWidth), $Definition.Substring(0, $ThisDefinitionWidth)
  
        write-host -NoNewline $PrintString
    
        $AliasesWrittenInThisRow++

        $AliasesWritten++
      }
      


      $AliasesWritten = $AliasesWritten + $DesiredColumns

    }