# ----------------------------------------------------------------------
# Function: show-quickref
#
#           This function
# ----------------------------------------------------------------------
function show-quickref { 
<#
.SYNOPSIS
Does a grep on \\$RepositoryServer\d$\dbawork\matt\quickref.txt 

.DESCRIPTION



.PARAMETER $Pattern
What to grep for. e.g. databases

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
qr jobs

Line
----
$JOB = dir Sqlserver:\sql\$Computername\default\Jobserver\jobs | where-object {$_.name -like '*big-job*'}
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | select name, lastrundate, nextrundate, currentrunstatus, lastrunoutcome | ft
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | ft @{Label ="Jobbie" ; Expression={$_.name} ; Width = 42 }, @{Label="Last run" ;
Expression = {"{0:dd/MM/yy HH:mm}" -f $_.lastrundate} ; width=14},  @{Label="Now"; Expression = {$_.currentrunstatus} ; Width = 5},
lastrunoutcome
UPDATE known_jobs SET monitor = 'N' ,monitor_comment = 'Someguff' WHERE job_name = 'Backup_all_databases.Subplan_1'
$X= dir Sqlserver:\sql\$Computername\Jobserver\Jobs
$X | select parent, name | ft @{  Expression = {"insert into known_jobs (monitor, monitor_comments,  instance_name, job_name) values ('N',
'Someguff', '" + $_.Parent + "','" + $_.name + "')"}} | out-string -width 200
dir Sqlserver:\sql\$Computername\default\Jobserver\Jobs | select name, lastrundate, nextrundate, currentrunstatus, lastrunoutcome | ft

.LINK
Twiki list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions


#>
  [CmdletBinding()]	
	Param( [String] $Pattern)
  $QUICKREF = "\\$RepositoryServer\d$\dbawork\matt\quickref.txt"

  if ($Pattern -ne $null)
  {
    select-string -Pattern $Pattern -path $QUICKREF | select line | ft -wrap
  }
  else
  {
    gc $QUICKREF
  }


}
set-alias qr show-quickref

function edit-quickref 
<#
Edit the quick reference document
#>
{ gvim "\\$RepositoryServer\d$\dbawork\matt\quickref.txt" }
set-alias gqr edit-quickref
set-alias eqr edit-quickref

<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


