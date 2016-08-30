get-MTPEventLog { 
<#
.SYNOPSIS
Displays the eventlog a bit more prettier than get-eventlog does out of the box

.DESCRIPTION

As above
This function is autoloaded by .matt.ps1

.PARAMETER ComputerName
Specify the remote server. If null tells you about wherever you are running
.PARAMETER StartTime
StartTime in HH24:MI format
.PARAMETER Minutes
Display these number of minutes after the start time
.PARAMETER NoSecurity
Exclude security logs if true
.PARAMETER DaysAgo
Go back this number of days. Defaults to 0, so today
.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
gel  -starttime 08:00 -NoSecurity  -Minutes 15 -computername server1 -daysago 0

   Index Time          EntryType   Source                 InstanceID Message
 1858476 Aug 30 08:13  Information Chume Capture Export            0 Service started successfully.
 1858475 Aug 30 08:12  Information Chume Capture Export            0 Service stopped successfully.
 1858474 Aug 30 08:12  Error       Userenv                3221226557 The Group Policy client-side extension Internet Explorer Zonemapping failed to execute. Please look for any errors reported earlier by that extension.
get-eventlog : No matches found
At C:\powershell\functions\function-get-mtpeventlog.ps1:60 char:9
+         get-eventlog -computername $ComputerName -logname $L.Log -before $EndTim ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (:) [Get-EventLog], ArgumentException
    + FullyQualifiedErrorId : GetEventLogNoEntriesFound,Microsoft.PowerShell.Commands.GetEventLogCommand
 
get-eventlog : No matches found
At C:\powershell\functions\function-get-mtpeventlog.ps1:60 char:9
+         get-eventlog -computername $ComputerName -logname $L.Log -before $EndTim ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (:) [Get-EventLog], ArgumentException
    + FullyQualifiedErrorId : GetEventLogNoEntriesFound,Microsoft.PowerShell.Commands.GetEventLogCommand 

#>
[CmdletBinding()]
Param( [String] $ComputerName = ".",
       [DateTime] $StartTime = "09:00",
       [int] $Minutes = 5,
       [int] $DaysAgo = 0,
       [switch] $NoSecurity = $False)

    write-verbose "`$StartTime: <$StartTime>"
    write-verbose "`$Minutes: <$Minutes>"
    write-verbose "`$DaysAgo: <$DaysAgo>"

    $StartTime = $StartTime.adddays(-$DaysAgo)
    write-verbose "`$StartTime: <$StartTime>"
    
    $EndTime = $StartTime.addminutes( $Minutes)
    write-verbose "`$EndTime: <$EndTime>"

    if ($NoSecurity)
    {
        $Logname = get-eventlog -list -ComputerName $ComputerName | where log -ne 'Security'
    }
    else
    {
        $Logname = get-eventlog -ComputerName $ComputerName  -list 
    }

    write-verbose "getting logs from <$ComputerName> from <$StartTime> to <$EndTime> with NoSecurity:$NoSecurity"

    foreach ($L in $LogName)
    {
        [string]$Log = $L.log
        write-verbose "getting logs from $Log"
        get-eventlog -computername $ComputerName -logname $L.Log -before $EndTime -After $StartTime
    }


}

    
set-alias gel get-MTPeventlog

