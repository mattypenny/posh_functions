function get-instanceinformation { 
<#
.SYNOPSIS
  Gets information about the instance and the server it lives on

.DESCRIPTION
  Developed to provide information for a third party, but possibly useful otherwise

.PARAMETER ServerInstance
  Instance name

.EXAMPLE
  Example of how to use this cmdlet

#>
  [CmdletBinding()]
  Param( [string][Alias ("Instance")]$ComputerName = "Ronnie"  ) 

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function beg: $([string]$MyInvocation.Line) "

  write-debug "get-wmiobject win32_ComputerSystem"
  $ComputerSystem = get-wmiobject win32_ComputerSystem -computer $ComputerName
  
  write-debug "get-wmiobject win32_Bios"
  $Bios = get-wmiobject win32_bios -computer $ComputerName 

  write-debug "get-wmiobject win32_operatingsystem"
  $OperatingSystem = get-wmiobject -class win32_operatingsystem -computer $ComputerName
  
  write-debug "get-wmiobject win32_logicaldisk"
  $LogicalDisk = Get-WMIObject Win32_LogicalDisk -filter "DriveType=3" -computer $ComputerName
  
  write-debug "aggregating dosk info"
  $TotalAvailableStorage = 0
  $Disks = ""
  foreach ($Disk in $LogicalDisk) 
  { 
    $TotalAvailableStorage = $TotalAvailableStorage + $disk.Size
    $Disks = $Disks  + $Disk.Name + " "
  }
  write-debug "`$TotalAvailableStorage $TotalAvailableStorage"

  write-debug "getting server level sql info"
  $ServerLevelSqlInformation = dir Sqlserver:\sql\$ComputerName\
  
  write-debug "get-wmiobject aggregating databases"
  $DatabaseList = ""
  foreach ($Database in $ServerLevelSqlInformation | select-object -ExpandProperty Databases) 
  { 
    $DatabaseList = $DatabaseList  + $Database.Name + " "
  }
  
  [PSCustomObject]@{
    ComputerName = $ComputerSystem.Name
    Make = $ComputerSystem.Manufacturer
    Model = $ComputerSystem.Model
    SMBIOSBIOSVersion = $Bios.SMBIOSBIOSVersion
    TotalAvailableStorage = $TotalAvailableStorage
    Disks = $Disks
    InstallDate = $OperatingSystem.InstallDate.substring(0,8)
    Caption = $OperatingSystem.Caption      # Windows description
    WindowsVersion = $OperatingSystem.Version
    SQLVersion = $ServerLevelSqlInformation.Version
    ProductLevel = $ServerLevelSqlInformation.ProductLevel  # SQL patch level
    Edition = $ServerLevelSqlInformation.Edition   #  SQL edition
    Collation = $ServerLevelSqlInformation.Collation
    LoginMode = $ServerLevelSqlInformation.LoginMode
    Databases = $DatabaseList
   }#EndPSCustomObject

  write-debug "$(get-date -format 'hh:mm:ss.ffff') Function end: $([string]$MyInvocation.Line) "

}

set-alias gii get-instanceinformation

if ($RunFunctionAfterLoading -eq $True)
{
  # get-instanceinformation
}

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


