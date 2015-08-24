# ----------------------------------------------------------------------
# Function: aliasname - 
#
#           This function
# ----------------------------------------------------------------------
function get-cal { 
<#
.SYNOPSIS
Similar to the Unix Cal Command ( Get-Cal.ps1 ). Lightly tweaked version of a acript by 'xshell guest' 

.DESCRIPTION
Similar to the Unix Cal Command ( Get-Cal.ps1 ). This is a lightly tweaked version of a acript by someone with the handle 'xshell guest' that I found at http://www.vistax64.com/powershell/17834-unix-cal-command.html 

It gives you a nicely formatted calendar view of the month or year

.PARAMETER Year

.PARAMETER Month

.INPUTS
None. You cannot pipe objects to this function

.EXAMPLE
cal

    October 2013

Su Mo Tu We Th Fr Sa
       1  2  3  4  5
 6  7  8  9 10 11 12
13 14 15 16 17 18 19
20 21 22 23 24 25 26
27 28 29 30 31

.EXAMPLE
get-cal 2013 12

    December 2013

Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31
 
.EXAMPLE
cal -next

    November 2013

Su Mo Tu We Th Fr Sa
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30

.EXAMPLE
cal -previous

   September 2013

Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30


.LINK
Twiki list: http://www.vistax64.com/powershell/17834-unix-cal-command.html 


#>
  [CmdletBinding()]	

  Param(
    [Int]$Year=(Get-Date).Year,
    [Int]$Month=(Get-Date).Month,
    [Switch] $Next,
    [Switch] $Previous
  )


  $script:err=$false
  if ($Next)
  {
    $Month=((Get-Date).Month+1)
    if ($Month -eq 13)
    {
      $Year=(Get-Date).Year+1
      $Month=1
    }
  }
  if ($Previous)
  {
    $Month=((Get-Date).Month-1)
    if ($Month -eq 0)
    {
      $Year=(Get-Date).Year-1
      $Month=12;
    }
  }
  $Space=" "

  trap { Write-Host -f red "Exception occurred while parsing month/year parameters.";$script:err=$true;continue}

  write-debug "After trap statenebt"

  $StartDate=new-object System.DateTime $Year,$Month,1
  if ($script:err)
  {
    return;
  }
  write-debug "`$StartDate: $StartDate"

  $MonthLabel="$($StartDate.ToString('MMMM')) $($StartDate.Year)"
  write-debug "`$MonthLabel: $MonthLabel"

  $DOWLabel=[Enum]::GetValues([DayOfWeek]) | % { $_.ToString().SubString(0,2) }
  write-debug "`$DOWLabel: $DOWLabel"

  $AlignCenter=[Math]::Ceiling((20-$MonthLabel.Length)/2)
  write-debug "`$AlignCenter: $AlignCenter"

  "{0}{1}" -f ($Space * $AlignCenter),$MonthLabel
  write-debug "Written {0}{1} construct"

  Write-Host "$DOWLabel"
  write-debug "Written $DOWLabel"

  $NextDate=$StartDate
  write-debug "`$NextDate: $NextDate"

  $SpaceCount=(([int]$StartDate.DayOfWeek))*3
  write-debug "`$SpaceCount: $SpaceCount"

  Write-Host $($Space * $SpaceCount) -No

  While ($NextDate.Month -eq $StartDate.Month)
  {
    if ($NextDate.ToString("MMddyyyy") -eq $(get-date).ToString("MMddyyyy"))
    {
      Write-Host ("{0,2}" -f $NextDate.Day) -no -fore yellow
    }
    else
    {
      Write-Host ("{0,2}" -f $NextDate.Day) -no
    }
    Write-Host " " -No
    $NextDate=$NextDate.AddDays(1)
    if ($NextDate.DayOfWeek -eq [DayOfWeek]::Sunday)
    {
      Write-Host
    }

  }
  Write-Host

}
set-alias cal get-cal


<#
vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab
#>


