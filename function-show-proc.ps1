# ----------------------------------------------------------------------
# Function: sproc - show processor details. Runs get-wmiobject 
#           win32_processor
# ----------------------------------------------------------------------
function show-proc { 
Param ( [String] $MyServer = ".")

Get-WmiObject win32_processor -computer $MyServer | select caption, name, datawidth, addresswidth, numberofcores, numberoflogicalprocessors, role, socketdesignation, LoadPercentage

}
set-alias sproc show-proc

