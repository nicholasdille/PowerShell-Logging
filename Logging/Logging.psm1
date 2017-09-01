$script:LogPath  = ''
$script:LogLevel = 'Info'

Get-ChildItem -Path "$PSScriptRoot" -File -Recurse -Filter '*.ps1' | ForEach-Object {
    . $_.FullName
}