Import-Module -Name Logging -Force

Describe 'Utility' {
    Context 'Get-CallerInvocationInfo' {
        It 'Returns the direct caller' {
            function Invoke-Something {
                Get-CallerInvocationInfo
            }
            (Invoke-Something).MyCommand.Name | Should Be 'Invoke-Something'
        }
        It 'Excludes logging functions' {
            function Write-Verbose {
                Get-CallerInvocationInfo -ExcludeLogging
            }
            function Invoke-Something {
                Write-Verbose
            }
            (Invoke-Something).MyCommand.Name | Should Be 'Invoke-Something'
        }
        It 'Returns second level caller' {
            function Invoke-InnerSomething {
                Get-CallerInvocationInfo -Index 2
            }
            function Invoke-OuterSomething {
                Invoke-InnerSomething
            }
            (Invoke-OuterSomething).MyCommand.Name | Should Be 'Invoke-OuterSomething'
        }
    }
}