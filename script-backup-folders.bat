cd c:\powershell\functions
set PSModulePath=%PSModulePath%;c:\powershell\modules
echo %PSModulePath%
powershell.exe -Noninteractive -Noprofile -Command " & {  $OriginalDebugPreference = $Global:DebugPreference ; $Global:DebugPreference = \"Continue\" ; ./script-backup-folders.ps1 -verbose ; $Global:DebugPreference = $OriginalDebugPreference}
