# ----------------------------------------------------------------------
# Function: sos - show os details. Runs get-wmiobject win32_operatingsystem
#
#           Show various os level details
#           Todo: comment-based help
#           Todo: input from pipeline
# ----------------------------------------------------------------------

function get-os 
{ 
  [CmdletBinding()]
  Param ( $ComputerNameList = ".")

  foreach ($ComputerName in $ComputerNameList)
  {
    get-wmiobject -class win32_operatingsystem -computer $ComputerName 
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
          Expression = { $_.caption.replace('Microsoft Windows ','Windows ').replace('Microsoft(R) Windows(R)','Windows ') } 
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
          Label="Version";
          Expression={$_.Version }; 
          Width = 12
        },
      @{
          Label="Install";
          Expression={$_.InstallDate.substring(6,2) + "/" + 
                      $_.InstallDate.substring(4,2) + "/" + 
                      $_.InstallDate.substring(0,4)};
          width=10},
      @{
          Label="Booted";
          Expression={ $_.LastBootUpTime.substring(6,2) + "/" + 
                       $_.LastBootUpTime.substring(4,2) + "/" + 
                       $_.LastBootUpTime.substring(0,4) + " " +
                       $_.LastBootUpTime.substring(8,2) + ":" +
                       $_.LastBootUpTime.substring(10,2)  }; 
          width=20}

}
set-alias sos show-os
set-alias gos get-os


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

# vim: set softtabstop=2 shiftwidth=2 expandtab
