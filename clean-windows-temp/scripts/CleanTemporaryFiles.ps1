<#
.SYNOPSIS
    Membersihkan berbagai file temporary di Windows
.DESCRIPTION
    Script ini membersihkan:
    - Folder Temp
    - Folder %Temp%
    - Prefetch
    - Recycle Bin
.NOTES
    File Name: CleanTemporaryFiles.ps1
    Author: Your Name
    Version: 1.0
#>

function Clean-TempFolders {
    Write-Host "Membersihkan folder Temp..."
    Remove-Item -Path "$env:SystemRoot\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Membersihkan folder %Temp%..."
    Remove-Item -Path "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Membersihkan Prefetch..."
    Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Selesai membersihkan folder temporary."
}

function Clean-RecycleBin {
    Write-Host "Membersihkan Recycle Bin..."
    $shell = New-Object -ComObject Shell.Application
    $shell.NameSpace(0x0a).Items() | ForEach-Object { 
        Remove-Item $_.Path -Force -Recurse -ErrorAction SilentlyContinue 
    }
    Write-Host "Recycle Bin telah dibersihkan."
}

# Menu utama
function Show-Menu {
    Clear-Host
    Write-Host "===================================="
    Write-Host " Windows Temporary Files Cleaner v1.0"
    Write-Host "===================================="
    Write-Host "1. Bersihkan Temp, %Temp%, dan Prefetch"
    Write-Host "2. Bersihkan Recycle Bin"
    Write-Host "3. Bersihkan Semua"
    Write-Host "4. Keluar"
    Write-Host "===================================="
}

# Proses menu
do {
    Show-Menu
    $selection = Read-Host "Pilih opsi (1-4)"
    
    switch ($selection) {
        '1' {
            Clean-TempFolders
        }
        '2' {
            Clean-RecycleBin
        }
        '3' {
            Clean-TempFolders
            Clean-RecycleBin
        }
    }
    
    if ($selection -ne '4') {
        Pause
    }
} until ($selection -eq '4')