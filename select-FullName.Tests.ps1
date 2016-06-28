$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "select-FullName" {
    $PesterData = "c:\powershell\functions\PesterData"
    It "displays the fullname for a single specified file" {
        select-fullname $PesterData\existent-file.dat | Should Be "c:\powershell\functions\PesterData\existent-file.dat"
    }
<#
    It "displays the fullname for a multiple files" {
        $true | Should Be $false
    }
    It "generates an error if the file doesn't exist" {
        $true | Should Be $false
    }
#>
    It "displays the fullname if you pipe in output from get-childitem" {
        $true | Should Be $false
    }
    It "displays nothing if you pipe in nothing" {
        $true | Should Be $false
    }

}
