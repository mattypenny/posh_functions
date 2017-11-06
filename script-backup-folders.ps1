<#

.SYNOPSIS

    One-line description

.DESCRIPTION

    Longer description

.PARAMETER

 

.EXAMPLE

    Example of how to use this cmdlet

 

.EXAMPLE

    Another example of how to use this cmdlet

#>

#    [CmdletBinding()]

    Param( [string]$source = "c:\powershell",
           [string]$BackupFolder = "d:\onedrive\backups" )

 

    start-transcript $BackupFolder\script-backup-folders.log

    $Month = get-date -format %M
    $Day = get-date -format %d

    $MonthlyBackup = "$BackupFolder\$Month"
    $DailyBackup = "$BackupFolder\$Day"

 

    if ($(test-path $MonthlyBackup) -eq $False)
    {
        mkdir $MonthlyBackup
    }

    if ($(test-path $DailyBackup) -eq $False)
    {
        mkdir $DailyBackup
    }

 

    copy-item -force -recurse $Source $DailyBackup -verbose -exclude "*~"
    copy-item -force -recurse $Source $MonthlyBackup -verbose -exclude "*~"

    stop-transcript

 

<#

vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab

#>

 
