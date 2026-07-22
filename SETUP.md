# SETUP — Pindah projek ke PC baharu & sambung semula

Panduan ringkas untuk jalankan projek **eTT Mobile** di PC lain dan "recall"
Claude Code supaya sambung dari tempat kita berhenti (Hari 2 siap).

---

## 1. Pasang alatan di PC baharu (sekali sahaja)

- **Flutter SDK** — https://docs.flutter.dev/get-started/install/windows
- **Android Studio** + satu emulator (atau guna Chrome untuk web).
- Sahkan:
  ```powershell
  flutter doctor
  ```
  (Abaikan amaran "Visual Studio / Desktop C++" — itu hanya untuk app Windows
  desktop; emulator Android & Chrome tetap berfungsi.)

---

## 2. Salin 3 folder ini ke PC baharu

Kekalkan laluan yang **sama** kalau boleh (senangkan Claude sambung semula):

| Folder asal | Fungsi |
|---|---|
| `D:\Flutter\ujian_flutter` | projek app (kod + PROGRESS.md) |
| `D:\Flutter\kelas-flutter-5-hari` | nota & lab kelas *(atau clone semula — lihat #5)* |
| `C:\Users\MOHE\.claude` | memori + transkrip Claude Code |

> `.claude` disalin ke folder HOME user baharu, cth `C:\Users\<nama-baharu>\.claude`.

---

## 3. Jalankan app

Dari dalam folder projek:
```powershell
flutter pub get
flutter run
```
Pilih emulator Android **atau** Chrome bila diminta.

---

## 4. "Recall" Claude Code

Buka terminal **di dalam** `D:\Flutter\ujian_flutter`, kemudian:
```powershell
claude
```
Claude akan baca `MEMORY.md` + `PROGRESS.md` dan terus tahu kita di Hari 2 (siap).

Nak buka semula perbualan LAMA yang sama (kalau laluan/versi sepadan):
```powershell
claude --resume
```

Contoh ayat mula: **"baca PROGRESS.md, kita nak mula Hari 3"** atau
**"guide me through hari-2 lab.md Latihan 1"** untuk ulang latihan.

---

## 5. (Pilihan) Clone semula nota, bukan salin

Kalau tak nak salin folder nota, clone semula guna proxy ghfast:
```powershell
git clone https://ghfast.top/https://github.com/habibtalib/kelas-flutter-5-hari.git D:\Flutter\kelas-flutter-5-hari
```
Untuk dapat nota terkini bila-bila masa:
```powershell
git -C D:\Flutter\kelas-flutter-5-hari pull
```

---

## 6. Kalau `flutter run` gagal dengan ralat engine.realm

PC Windows dengan PowerShell 5.1 kadang beri:
`Set-Content : Stream was not readable ... Unable to determine engine version`.

Punca: bug dalam `<SDK>\bin\internal\update_engine_version.ps1` (baris tulis
`engine.realm` kosong). Betulkan baris `Set-Content ... -Value ""` kepada:
```powershell
[System.IO.File]::WriteAllText("$flutterRoot/bin/cache/engine.realm", "")
```
(atau pasang PowerShell 7). Minta Claude tolong kalau perlu.
