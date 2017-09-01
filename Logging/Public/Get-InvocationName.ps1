function Get-InvocationName {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.InvocationInfo]
        $InvocationInfo = (Get-CallerInvocationInfo)
    )

    Begin {
        # Command type to name mapping:
        # Function       --> Invoke-Something
        # Externalscript --> Invoke-Something.ps1
        # Script         --> $null
        $TestedCommandTypes = @('Function', 'ExternalScript', 'Script')
        if ($TestedCommandTypes -notcontains $InvocationInfo.MyCommand.CommandType) {
            if ($InvocationInfo.MyCommand.Name) {
                Write-Warning ('[{0}] Unknown command type <{1}> for specified invocation info. Command name is populated.' -f $MyInvocation.MyCommand.Name, $InvocationInfo.MyCommand.Name)
            
            } else {
                throw ('[{0}] Unknown command type <{1}> for specified invocation info. Unable to determine command name. Aborting.' -f $MyInvocation.MyCommand.Name, $InvocationInfo.MyCommand.CommandType)
            }
        }

        $InvocationName = $InvocationInfo.MyCommand.Name
    }

    Process {
        if (-not $InvocationName -and $InvocationInfo.MyCommand.CommandType -eq 'Script') {
            $InvocationName = 'ScriptBlock'
        }

        if (-not $InvocationName) {
            throw ('[{0}] Unable to determine invocation name' -f $MyInvocation.MyCommand.Name)
        }

        $InvocationName
    }
}