<#
.SYNOPSIS
    Mendaftarkan perintah untuk dijalankan dengan Windows+R
.DESCRIPTION
    Membuat shortcut untuk membersihkan:
    - temp
    - %temp%
    - prefetch
    - recyclebin
.NOTES
    File Name: RegisterShortcuts.ps1
    Author: Your Name
    Version: 1.0
#>

# Pastikan script dijalankan sebagai administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    Write-Warning "Script ini membutuhkan hak administrator!"
    Start-Sleep 3
    Exit
}

# Lokasi script cleaner
$cleanerScriptPath = Join-Path $PSScriptRoot "CleanTemporaryFiles.ps1"

# Buat shortcut di Windows untuk berbagai perintah
function Register-Shortcut {
    param (
        [string]$commandName,
        [string]$action
    )
    
    $shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\$commandName.lnk"
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$cleanerScriptPath`" $action"
    $shortcut.Save()
    
    # Tambahkan ke registry untuk Run dialog
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\$commandName.exe"
    New-Item -Path $regPath -Force | Out-Null
    Set-ItemProperty -Path $regPath -Name "(Default)" -Value $shortcutPath -Force
}

# Daftarkan perintah-perintah
Register-Shortcut -commandName "temp" -action "1"
Register-Shortcut -commandName "%temp%" -action "1"
Register-Shortcut -commandName "prefetch" -action "1"
Register-Shortcut -commandName "recyclebin" -action "2"

Write-Host "Shortcut telah didaftarkan. Sekarang Anda bisa menggunakan Windows+R lalu ketik:"
Write-Host "- temp atau %temp% atau prefetch: untuk membersihkan file temporary"
Write-Host "- recyclebin: untuk membersihkan recycle bin"
Write-Host "Tekan Enter untuk keluar..."
Read-Host