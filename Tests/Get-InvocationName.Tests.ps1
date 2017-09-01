﻿Import-Module -Name Logging -Force

Describe 'Utility' {
    Context 'Get-InvocationName' {
        It 'Works for functions' {
            function Invoke-Something {
                Get-InvocationName -InvocationInfo $MyInvocation
            }
            Invoke-Something | Should Be 'Invoke-Something'
        }
        It 'Works for scripts' {
            @(
                ('. "{0}"' -f "$here\..\Support\$sut")
                'Get-InvocationName -InvocationInfo $MyInvocation'
            ) | Set-Content -Path TestDrive:\Invoke-Something.ps1
            & TestDrive:\Invoke-Something.ps1 | Should Be 'Invoke-Something.ps1'
        }
        It 'Works for scriptblock' {
            Invoke-Command -ScriptBlock {
                Get-InvocationName -InvocationInfo $MyInvocation
            } | Should Be 'ScriptBlock'
        }
        It 'Works for dot sourcing' {
            @(
                ('. "{0}"' -f "$here\..\Support\$sut")
                'Get-InvocationName'
            ) | Set-Content -Path TestDrive:\Invoke-Something.ps1
            $Path = Get-Item -Path TestDrive:\Invoke-Something.ps1 | Select-Object -ExpandProperty FullName
            ('. "{0}"' -f $Path) | Set-Content -Path TestDrive:\Caller.ps1
            & TestDrive:\Caller.ps1 | Should Be 'Invoke-Something.ps1'
        }
    }
}