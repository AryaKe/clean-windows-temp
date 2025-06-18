# Windows Temporary Files Cleaner

Proyek ini menyediakan solusi otomatis untuk membersihkan file-file temporary di Windows melalui shortcut yang dapat diakses via Windows + R.

## Fitur Utama

- Membersihkan folder system Temp (`C:\Windows\Temp`)
- Membersihkan folder user Temp (`%TEMP%`)
- Membersihkan file Prefetch (`C:\Windows\Prefetch`)
- Mengosongkan Recycle Bin
- Akses cepat via Windows + R dengan perintah:
  - `temp`
  - `%temp%`
  - `prefetch`
  - `recyclebin`

## Struktur Proyek

```
clean-windows-temp/
├── .vscode/
│   ├── tasks.json
│   └── launch.json
├── scripts/
│   ├── CleanTemporaryFiles.ps1    # Script utama pembersihan
│   └── RegisterShortcuts.ps1     # Script pendaftaran shortcut
└── README.md
```

## Cara Menggunakan

### Instalasi

1. Clone atau download proyek ini
2. Buka folder proyek di VS Code
3. Jalankan script pendaftaran sebagai Administrator:

```powershell
cd scripts
Set-ExecutionPolicy Bypass -Scope Process -Force
.\RegisterShortcuts.ps1
```

### Penggunaan

Setelah terinstall, cukup tekan `Windows + R` dan ketik salah satu perintah:

- `temp` - Membersihkan C:\Windows\Temp
- `%temp%` - Membersihkan folder temporary user
- `prefetch` - Membersihkan file prefetch
- `recyclebin` - Mengosongkan Recycle Bin

## Cara Menghapus Shortcut

Jika ingin menghapus semua shortcut yang telah dibuat:

### 1. Hapus dari Registry

Jalankan perintah berikut di PowerShell **sebagai Administrator**:

```powershell
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\temp.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\%temp%.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\prefetch.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\recyclebin.exe" -ErrorAction SilentlyContinue
```

### 2. Hapus File Shortcut

Hapus file shortcut dari Start Menu Programs:

```powershell
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\temp.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\%temp%.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\prefetch.lnk" -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\recyclebin.lnk" -ErrorAction SilentlyContinue
```

### 3. Verifikasi

Tekan `Windows + R` dan coba ketik perintah-perintah yang sudah dihapus. Jika muncul pesan "Windows cannot find...", artinya shortcut telah berhasil dihapus.

## Catatan Penting

1. Script membutuhkan hak Administrator untuk membersihkan beberapa folder sistem
2. File yang dihapus tidak dapat dikembalikan
3. Untuk keamanan, backup registry sebelum melakukan perubahan

## Lisensi

Proyek ini dilisensikan di bawah MIT License.
