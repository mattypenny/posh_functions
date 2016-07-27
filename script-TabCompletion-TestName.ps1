$Completion_TestName = {

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $searcher = select-string "^Describe `"*`"*`{*" *.Tests.ps1

    $searcher | ForEach-Object {

        New-Object -TypeName pscustomobject -Property @{ 
            TestName = $_.line -replace 'Describe',''  -replace '{','' 
        }

    } | Sort-Object TestName | ForEach-Object {

        New-Object System.Management.Automation.CompletionResult $_.TestName

    }

}

 

 

if (-not $global:options) { $global:options = @{CustomArgumentCompleters = @{};NativeArgumentCompleters = @{}}}

 

$global:options['CustomArgumentCompleters']['TestName'] = $Completion_TestName

$function:tabexpansion2 = $function:tabexpansion2 -replace 'End\r\n{','End { if ($null -ne $options) { $options += $global:options} else {$options = $global:options}' 