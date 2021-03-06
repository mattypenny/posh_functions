function get-nonstandardservices {
<#
.SYNOPSIS
  Gets a list of services deemed as non-standard or 'distinctive'
.DESCRIPTION
  This function is autoloaded by .matt.ps1
.PARAMETER ComputerNameList
  List of Computers, or just one  
#>
  [CmdletBinding()]

  Param ($ComputerNameList = ".")

  write-debug "In show-nonstandardservices"

  $ArrayOfNonStandardServices = import-csv c:\local\StandardServices.csv | select name

  foreach ($ComputerName in $ComputerNameList)
  {
    get-wmiobject win32_service -computername $ComputerName | 
        where { $ArrayOfNonStandardServices.name -notcontains $_.name } 
  }

}

function show-nonstandardservices {
<#
.SYNOPSIS
  Gets and format a list of services deemed as non-standard or 'distinctive', with options for properties shown
.PARAMETER ComputerNameList
  List of Computers, or just one  
.PARAMETER Option 
  Default, Def, 0 - shows server, names, state, auto/manual 
  Alternative, Alt, 1 - shows server, name, login, auto/manual
  Starttime, Process, Start, 2 - shows server, names, state, auto/manual, startup time
#>
  Param ([Parameter(Position=1)]$ComputerNameList = ".",
         $option = 'default')
  
  if ($option -in 'default','def','0')
  {
    get-nonstandardservices $ComputerNameList | 
      select __server, name, DisplayName,state, startmode | 
      sort -uniq __server, state, name | ft -a
  }
  elseif ($option -in 'alternative','alt','1')
  {
    get-nonstandardservices $ComputerNameList | 
      select __server, name, startname, startmode | 
      sort -uniq __server, state, name | ft -a
  }
  elseif ($option -in 'starttime', 'process', 'start', 2)
  {
    
    $ServicesToOutput = foreach ($ComputerName in $ComputerNameList)
    {    
      $Services = get-nonstandardservices $ComputerName

      foreach ($Service in $Services)
      {
        $ProcessId = $Service.ProcessId

        $Process = Get-WmiObject -Class Win32_Process -ComputerName $ComputerName -Filter "ProcessID='$ProcessId'" 


        # todo: could add in memory usage etc
        $Service | Add-Member -MemberType NoteProperty -Name StartTime -Value $($Service.ConvertToDateTime($Process.CreationDate))
 
        $Service 
      }
    }

    $ServicesToOutput | 
      select __server, name, DisplayName,state, startmode, starttime | 
      sort -uniq __server, state, name | ft -a
  }

}

set-alias sserv show-nonstandardservices
set-alias gserv get-nonstandardservices

