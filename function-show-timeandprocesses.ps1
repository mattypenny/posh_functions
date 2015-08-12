# ----------------------------------------------------------------------
# Function: tp - show time, then process info
# ----------------------------------------------------------------------

function show-timeandprocesses { 
Param ([String] $MyServer, [String] $MyProcessString)
get-date -format F 
get-process -ComputerName . $MyProcessString | select WorkingSet, Id, ProcessName | ft}
set-alias tp show-timeandprocesses

