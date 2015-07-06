# ----------------------------------------------------------------------
# Function: sos - show os details. Runs get-wmiobject win32_operatingsystem
#
#           Show various os level details
# ----------------------------------------------------------------------

function get-os { 
[CmdletBinding()]
Param ( $ComputerNameList = ".")

foreach ($ComputerName in $ComputerNameList)
{
  get-wmiobject -class win32_operatingsystem -computer $ComputerName | 
      select __Server, 
             caption, 
             Manufacturer, 
             InstallDate, 
             LastBootUpTime, 
             Version,
             ServicePackMajorVersion, 
             ServicePackMinorVersion
}


}
function show-os {
[CmdletBinding()]
Param ( $ComputerNameList = ".")

get-os $ComputerNameList | 
  ft @{
        Label="Server"; 
        Width = 12 ;
        Expression={$_.__Server}
      },
     @{
        Name="Versh"; 
        Width=30; 
        Expression = { $_.caption.replace('Microsoft Windows ','') } 
      },
     @{
        Label="SPMajor"; 
        Width = 7;
        Expression={$_.ServicePackMajorVersion}
      },
     @{
        Label="SPMinor"; 
        Width = 7;
        Expression={$_.ServicePackMinorVersion}
      },
     @{
        l="Version";
        e={$_.Version }; 
        Width = 12
      },
     @{
        l="Install";
        e={$_.InstallDate.substring(6,2) + "/" + 
           $_.InstallDate.substring(4,2) + "/" + 
           $_.InstallDate.substring(0,4)};
        width=10},
     @{
        Label="Booted";
        e={ $_.LastBootUpTime.substring(6,2) + "/" + 
            $_.LastBootUpTime.substring(4,2) + "/" + 
            $_.LastBootUpTime.substring(0,4) + " " +
            $_.LastBootUpTime.substring(8,2) + ":" +
            $_.LastBootUpTime.substring(10,2)  }; 
        width=20}

}
set-alias sos show-os
set-alias gos get-os
# Using this for the sql one
# set-alias suptime show-os


function soss { 
[CmdletBinding()]
Param ( [String] $ComputerName = ".")

$COMPUTER_DETAILS = get-wmiobject -class win32_operatingsystem -computer $ComputerName 

$SHORT_DETAILS = 
   New-Object PSObject -Property @{
              Server         = $COMPUTER_DETAILS.__SERVER
              Installed      = $COMPUTER_DETAILS.InstallDate.substring(0,8)
              LastBoot       = $COMPUTER_DETAILS.LastBootUpTime.substring(0,12)
}

$SHORT_DETAILS
}

