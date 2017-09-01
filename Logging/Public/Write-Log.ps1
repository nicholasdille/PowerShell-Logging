function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Message
    )

    Begin {
        if (-Not (Test-Path -Path "Variable:\LogPath")) {
            Microsoft.Powershell.Utility\Write-Error -Message 'Use Start-LogSession before calling Write-Log'
            throw
        }
    }

    Process {
        Foreach ($Line in $Message) {
            $Line | Out-File -FilePath $script:LogPath -Append
        }
    }
}

function Write-Host {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        Write-Log -Message "[INFO   ] $Message"
        Microsoft.Powershell.Utility\Write-Host $Message
    }
}

function Write-Output {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        Write-Log -Message "[INFO   ] $Message"

        Microsoft.Powershell.Utility\Write-Output $Message
    }
}
    
function Write-Debug {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        Write-Log -Message "[DEBUG  ] $Message"

        if (@('Debug') -contains $LogLevel) {
            Microsoft.Powershell.Utility\Write-Debug -Message $Message
        }
    }
}

function Write-Verbose {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        write-Log -Message "[VERBOSE] $Message"

        if (@('Verbose', 'Debug') -contains $LogLevel) {
            Microsoft.Powershell.Utility\Write-Verbose -Message $Message
        }
    }
}

function Write-Warning {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        write-Log -Message "[WARNING] $Message"
        Microsoft.Powershell.Utility\Write-Warning -Message $Message
    }
}

function Write-Error {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    Process {
        write-Log -Message "[ERROR  ] $Message"
        Microsoft.Powershell.Utility\Write-Error -Message $Message
    }
}