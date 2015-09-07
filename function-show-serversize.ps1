# ----------------------------------------------------------------------
# Function: ss - Show server sizings - i.e. free and used diskspace
# ----------------------------------------------------------------------
function get-serversize { Param( [String] $ComputerName)

Get-WMIObject Win32_LogicalDisk -filter "DriveType=3" -computer $ComputerName 
}
set-alias gs get-serversize

function show-serversize { Param( [String] $ComputerName)
    get-serversize $ComputerName |  
      Select SystemName, 
             DeviceID, 
             VolumeName,
             @{Name="size(GB)";Expression={"{0:N1}" -f($_.size/1gb)}},
             @{Name="freespace(GB)";Expression={"{0:N1}" -f($_.freespace/1gb)}}, 
             @{Name="used(GB)";Expression={"{0:N1}" -f(($_.size - $_.freespace)/1gb)}},
             @{Name="%used";Expression={"{0:N1}" -f((($_.size - $_.freespace)/$_.size) * 100)}} | ft -a
}
set-alias ss show-serversize
