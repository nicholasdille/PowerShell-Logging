function Start-LogSession {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path = "$PSScriptRoot\Log-$($Env:COMPUTERNAME).txt"
        ,
        [Parameter()]
        [ValidateSet('Info', 'Verbose', 'Debug')]
        [string]
        $Level = 'Info'
        ,
        [Parameter()]
        [switch]
        $ClearLog
    )

    Process {
        if ($ClearLog) {
            Remove-Item -Path $LogPath -Force
        }

        $script:LogPath  = $Path
        $script:LogLevel = $Level

        $now = Get-Date
        Write-Log '================================================================================'
        Write-Log ('[INFO   ] Starting log session on {0} at {1}-{2}-{3} {4}:{5}:{6} for {7}' -f $Env:COMPUTERNAME, $now.Year, $now.Month, $now.Day, $now.Hour, $now.Minute, $now.Second, $env:USERNAME)
    }
}