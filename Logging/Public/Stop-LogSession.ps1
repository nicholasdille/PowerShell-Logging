function Stop-LogSession {
    [CmdletBinding()]
    param()

    Process {
        $now = Get-Date
        Write-Log ('[INFO   ] Ending log session at {0}-{1}-{2} {3}:{4}:{5}' -f $now.Year, $now.Month, $now.Day, $now.Hour, $now.Minute, $now.Second)
    }
}