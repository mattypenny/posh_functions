# ----------------------------------------------------------------------
# Function: aliasname - gel - show-eventlog
#
#           This function just formats the eventlog nicely
# ----------------------------------------------------------------------
function show-eventlog { 
<#
.SYNOPSIS
Displays the eventlog a bit more prettier than get-eventlog does out of the box

.DESCRIPTION

As above
.PARAMETER P_server
Specify the remote server. If null tells you about wherever you are 
running
.PARAMETER P_Eventtype
What sort of events
.PARAMETER P_Howmany
How many to display

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
 

.LINK
Online list: http://ourwiki/twiki501/bin/view/Main/DBA/PowershellFunctions


#>
[CmdletBinding()]
Param( [String] $P_Server = ".",
       [String] $P_Eventtypes = "None_specified",
       [String] $P_Howmany = "10")


function get-eventlog2 {
	
    Param( [String] $P_Server = ".",
           [String] $P_Eventtypes = "None_specified",
           [String] $P_Howmany = "10")

    if ($P_EventTypes -eq "None_specified")
    {
        $P_Eventtype=@{}
        $V_EventTypes = "Application", "System", "Security"
    }
    else
    {
        $V_Eventtypes = $P_Eventtypes
    }

    foreach ($V_Eventtype in $V_Eventtypes)
    {
        write-verbose "Getting events for $P_server, $v_eventtype, $p_howmany"
        $GELS = get-eventlog -computername $P_Server `
                     -logname $V_Eventtype `
                     -newest $P_Howmany  
        foreach ($GEL in $GELS)
        {
        	# write-debug $GEL.message
		#format-table @{Label = "S"; Expression = {$V_Eventtype.Substring(0,1)}; width=1 }, 
		#@{Label="Date"; Expression={$_.timewritten};Format="F"}, source, message

                # $GM = $gel.message 
                # write-verbose "Event $GM"
        
        	$Gel_Object = New-Object PSObject -Property @{            
                                 Date       = $GEL.timewritten
                                 Source     = $GEL.Source
                                 Message    =  $GEL.MESSAGE}
        	$Gel_Object
        
    	} 

     }

}

$GO = get-eventlog2 $P_SERVER $P_Eventtypes $P_Howmany 
$GO | select date, message | ft -a

		#format-table @{Label = "S"; Expression = {$V_Eventtype.Substring(0,1)}; width=1 }, 
		#@{Label="Date"; Expression={$_.timewritten};Format="F"}, source, message
}
set-alias gel show-eventlog

