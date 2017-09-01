function Get-ScriptPath {
    [CmdletBinding()]
    [OutputType([string])]
    param()

    Process {
        $Invocation = Get-Variable -Name MyInvocation -Scope 1 | Select-Object -ExpandProperty Value

        if ($Invocation.PSScriptRoot) {
            $Invocation.PSScriptRoot

        } elseif ($Invocation.MyCommand.Path) {
            Split-Path -Path $Invocation.MyCommand.Path

        } else {
            Split-Path -Path $Invocation.InvocationName -Parent
        }
    }
}