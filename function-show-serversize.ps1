# ----------------------------------------------------------------------
# Function: ss - Show server sizings - i.e. free and used diskspace
# ----------------------------------------------------------------------
function get-serversize { Param( [String] $ComputerName)

Get-WMIObject Win32_LogicalDisk -filter "DriveType=3" -computer $ComputerName | 
   Select SystemName, DeviceID, VolumeName,
          @{Name="size(GB)";Expression={"{0:N1}" -f($_.size/1gb)}},
          @{Name="freespace(GB)";Expression={"{0:N1}" -f($_.freespace/1gb)}} 
}

function ss { Param( [String] $ComputerName)
    get-serversize $ComputerName | ft
}
