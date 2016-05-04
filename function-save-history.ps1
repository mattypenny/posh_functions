# ------------------------------
# save-history
# ------------------------------
function save-history { 
<#
.Synopsis
   Saves history to  \\$RepositoryServer\d$\dbawork\matt\history\history.txt

#>
    
  history -count 1000 | select EndExecutionTime, ExecutionStatus, CommandLine | fl | out-string -width 512  >> \\$RepositoryServer\d$\dbawork\matt\history\history.txt
}
set-alias shh save-history

