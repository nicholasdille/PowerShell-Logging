function Assert-Variable {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
        ,
        [Parameter()]
        [ValidateNotNull()]
        [scriptblock]
        $Scriptblock
    )

    if (-Not (Get-Variable -Name LogPath -ErrorAction SilentlyContinue)) {
        if (-Not $Scriptblock) {
            throw ('[{0}] Variable {1} not found. Aborting.' -f $MyInvocation.MyCommand, 'LogPath')

        } else {
            $Scriptblock.Invoke()
        }
    }
}