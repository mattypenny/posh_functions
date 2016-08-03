$Completion_TestName = {

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $DescribeLines = select-string "^Describe `"*`"*`{*" *.Tests.ps1 | sort-object -Property Line

    $PesterTests = foreach ($Line in $DescribeLines) 
    {
        $TestDescription = $Line.line -replace 'Describe',''  -replace '{','' -replace '"', ''

        $TestDescription = $TestDescription.trim()

        
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

 


if (-not $global:options) { $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}}

$global:options['CustomArgumentCompleters']['TestName'] = $Completion_TestName

$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}' 
