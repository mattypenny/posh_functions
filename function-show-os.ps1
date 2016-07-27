
function get-os 
{ 
<#
.SYNOPSIS
  Get OS details for specified computer
.DESCRIPTION
This function is autoloaded by .matt.ps1

#>

  [CmdletBinding()]
  Param ( [Parameter(Position=1)]$ComputerNameList = ".")

  foreach ($ComputerName in $ComputerNameList)
  {
    get-wmiobject -class win32_operatingsystem -computer $ComputerName 
  }

}

function show-os {
<#
.SYNOPSIS
Get and format computer os details
.PARAMETER ComputerNameList
Either the server you're interested in or 'all' for a list of all of them

#>
  [CmdletBinding()]
  Param ( [Parameter(Position=1)]$ComputerNameList = "all")

  if ($ComputerNameList -eq "all")
  {
    $ComputerNameList = get-monitoredservers
    write-verbose "`$ComputerNameList: $ComputerNameList"
    $OsDetails = foreach ($C in $ComputerNameList)
    {
      [string]$ComputerName = $C.ComputerName

      get-os $ComputerName 
    }
  }
  else
  {
    $OsDetails = foreach ($ComputerName in $ComputerNameList)
    {
      get-os $ComputerName
    }
  }

  $OsDetails |
      ft @{
            Label="Server"; 
            Width = 12 ;
            Expression={$_.__Server}
          },
        @{
            Name="Versh"; 
            Width=42; 
            Expression = { $_.caption.replace('Microsoft Windows','Windows').replace('Microsoft(R) Windows(R)','Windows') } 
          },
        @{
            Label="SPMaj"; 
            Width = 5;
            Expression={$_.ServicePackMajorVersion}
          },
        @{
            Label="SPMin"; 
            Width = 5;
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


function Get-InstallDateAndLastBootTime { 
<#
.SYNOPSIS
  Gets install date and last boot time
#>

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
