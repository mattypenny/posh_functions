# ----------------------------------------------------------------------
# Function: sbackup - sqlserver backups
#
#           These functions show backups for the specified instance
#           This function is autoloaded
# ----------------------------------------------------------------------
function show-backups { Param( [String] $MyServer)
invoke-sqlcmd -ServerInstance $MyServer -query `
" select bs.database_name, 
         bs.backup_finish_date, 
         bmf.physical_device_name, 
         bs.compressed_backup_size    
  FROM [msdb].[dbo].[backupset] bs , [msdb].[dbo].backupmediafamily bmf
  where bs.backup_finish_date > GETDATE() - 2
  and   bmf.media_set_id = bs.media_set_id
  order by bs.backup_finish_date desc
"
}
set-alias sbackup show-backups
set-alias sback show-backups
set-alias sbackups show-backups

function show-backups2000 { Param( [String] $MyServer)
invoke-sqlcmd -ServerInstance $MyServer -query `
"  select bs.database_name, 
         bs.latest_backup, 
         bmf.physical_device_name 
  FROM  [msdb].[dbo].backupmediafamily bmf,
        msdb.dbo.backupset bs2,
        (select database_name,
                max(backup_finish_date) latest_backup
         from   [msdb].[dbo].[backupset] 
         group by database_name) bs,
        sysdatabases sd	
  where bs2.database_name = bs.database_name
  and   bs2.backup_finish_date = latest_backup
  and   bmf.media_set_id = bs2.media_set_id
  and   bs2.database_name = sd.name
  order by bs.database_name
" 

}
set-alias sbackup2000 show-backups2000
set-alias sback2000 show-backups2000
set-alias sbackups2000 show-backups2000


