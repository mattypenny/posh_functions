function get-serversize { 
<#
.SYNOPSIS
Gets drive sizings
.DESCRIPTION
This function is autoloaded by .matt.ps1


#>
  [CmdletBinding()]

  Param( $ComputerName)

  foreach  ($C in $ComputerName)
  {
	Get-WMIObject Win32_LogicalDisk -filter "DriveType=3" -computer $C
  }
}
set-alias gs get-serversize

function show-serversize { 
<#
.SYNOPSIS
Gets drive sizings and formats them
#>
[CmdletBinding()]

Param(     $ComputerName,
           [String] $Option = "0")

  
	  if ($option -in 'default','def','0')
  {
    get-serversize $ComputerName |  
      Select SystemName, 
             DeviceID, 
             @{Name="%used";Expression={"{0:N1}" -f((($_.size - $_.freespace)/$_.size) * 100)}},
             VolumeName,
             @{Name="size(GB)";Expression={"{0:N1}" -f($_.size/1gb)}},
             @{Name="used(GB)";Expression={"{0:N1}" -f(($_.size - $_.freespace)/1gb)}}, 
             @{Name="freespace(GB)";Expression={"{0:N1}" -f($_.freespace/1gb)}} | ft -a
  }
  elseif ($option -in 'used','1')
  {
    get-serversize $ComputerName |  
      Select SystemName, 
             DeviceID, 
             @{Name="used(GB)";Expression={"{0:N1}" -f(($_.size - $_.freespace)/1gb)}},
             @{Name="size(GB)";Expression={"{0:N1}" -f($_.size/1gb)}} | ft -a
  
  }
}
set-alias ss show-serversize
# vim: set softtabstop=2 shiftwidth=2 expandtab 
