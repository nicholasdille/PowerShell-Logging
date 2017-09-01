function Get-CallerInvocationInfo {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]
        $Index = 1
        ,
        [switch]
        $ExcludeLogging
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $LoggingCmdlets = @('Write-Verbose', 'Write-Debug', 'Write-Error', 'Write-Warning', 'Write-Host', 'Write-Output', 'Write-Log', 'Write-Information')
    )

    Process {
        $Stack = Get-PSCallStack

        if ($ExcludeLogging) {
            while ($LoggingCmdlets -contains $Stack[$Index].InvocationInfo.MyCommand.Name) {
                ++$Index
            }
        }

        $Stack[$Index].InvocationInfo
    }
}