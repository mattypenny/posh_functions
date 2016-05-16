function get-topprocesses { 
<#
.SYNOPSIS
  Gets top windows processes on specified server

.DESCRIPTION
  Longer description

  This function is autoloaded by .matt.ps1
.PARAMETER ComputerName
  
.PARAMETER NumberOfProcesses


.EXAMPLE
  top server1

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("c")]$ComputerName = "$ComputerName",
         [string][Alias ("option")]$SortOrder = "P",
         [int][Alias("Top")]$NumberOfProcesses = 11  
         ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  write-debug "`$ComputerName: $ComputerName"
  write-debug "`$SortOrder: $SortOrder"
  write-debug "`$NumberOfProcesses: $NumberOfProcesses"

  $AllProcesses = gwmi Win32_PerfFormattedData_PerfProc_Process -ComputerName $ComputerName | 
    select PSComputerName, idprocess, name, PercentPrivilegedTime,PercentProcessorTime, PercentUserTime, IODataBytesPersec, workingset 

  switch ( $SortOrder )
  {
    "P" { $SortedProcesses = $AllProcesses |  Sort-Object -Property PercentUserTime -desc  }
    "V" { $SortedProcesses = $AllProcesses |  Sort-Object -Property PercentPrivilegedTime -desc  }
    "U" { $SortedProcesses = $AllProcesses |  Sort-Object -Property PercentUserTime -desc  }
    "IO" { $SortedProcesses = $AllProcesses |  Sort-Object -Property IODataBytesPersec -desc  }
    "w" { $SortedProcesses = $AllProcesses |  Sort-Object -Property workingset -desc  }
    "M" { $SortedProcesses = $AllProcesses |  Sort-Object -Property workingset -desc  }
  }

  $SortedProcesses | sort-object -property IODataBytesPersec, workingset -desc | select-object -first $NumberOfProcesses



  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias gtp get-topprocesses

function show-topprocesses { 
<#
.SYNOPSIS
  Shows top windows processes on specified server

.DESCRIPTION
  Longer description

.PARAMETER ComputerName
  
.PARAMETER NumberOfProcesses


.EXAMPLE
  top server1

.EXAMPLE
  Another example of how to use this cmdlet
#>
  [CmdletBinding()]
  Param( [string][Alias ("c")]$ComputerName = "$ComputerName",
         [string][Alias ("option")]$SortOrder = "P",
         [int][Alias("Top")]$NumberOfProcesses = 11  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  get-topprocesses $ComputerName $SortOrder $NumberOfProcesses | ft -a

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias stp show-topprocesses
set-alias top show-topprocesses


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


