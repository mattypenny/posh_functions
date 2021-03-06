﻿$Completion_TestName = {

    <#
        Based on http://www.powershellmagazine.com/2012/11/29/using-custom-argument-completers-in-powershell-3-0/
    #>

    # not sure what the last two parameters are here, tbh
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    <#
        Identifying any lines which begin with 'Describe {' are Pester describe lines
    #>
    $DescribeLines = select-string "^Describe `"*`"*`{*" *.Tests.ps1 | sort-object -Property Line

    $PesterTests = foreach ($Line in $DescribeLines) 
    {
        $TestDescription = $Line.line -replace 'Describe',''  -replace '{','' -replace '"', ''

        $TestDescription = $TestDescription.trim()

        # if the test name includes a space then it needs to show up in the tab completion in quotes
        if ($TestDescription -match ' ')
        {
            # $TestDescription = "'" + $TestDescription + "'"
            $TestDescription = "'$TestDescription'"
        }
        
        
        New-Object -TypeName pscustomobject -Property @{TestName = $TestDescription}

    } 
    
    ForEach ($Test in $PesterTests)
    {

        New-Object System.Management.Automation.CompletionResult $Test.TestName

    }

}

 

# these lines copied from the t'internet - don't entirely understand them yet!
if (-not $global:options) { $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}}

$global:options['CustomArgumentCompleters']['TestName'] = $Completion_TestName

$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}' 

 