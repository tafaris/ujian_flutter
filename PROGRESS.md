# eTT Mobile — Progress Kelas Flutter 5 Hari

Projek latihan untuk kelas **kelas-flutter-5-hari** (nota di repo GitHub
`habibtalib/kelas-flutter-5-hari`, guna proxy ghfast untuk pull).

## Status: HARI 2 SIAP ✅ (Latihan 1–7 selesai)

Semua latihan Hari 2 (Layout, Senarai Dinamik & Styling) telah disiapkan.
`flutter analyze` bersih (No issues found).

| Latihan | Tajuk | Konsep utama | Fail berkaitan |
|---|---|---|---|
| 1 | Row/Expanded overflow | jalur kuning-hitam, `Expanded` + `ellipsis` | `widgets/programme_card.dart` |
| 2 | Stack + Positioned | banner bertindan | `widgets/programme_banner.dart` |
| 3 | Skrin senarai boleh skrol | collection-`for` | (dulu `layout_playground` — dah dibuang) |
| 4 | Widget AI + semak | Card + ListTile, checklist review | `widgets/programme_intake_tile.dart` |
| 5 | HomeScreen | BottomNavigationBar + Drawer + `setState` | `screens/home_screen.dart` |
| 6 | ListView.builder vs GridView | senarai malas (lazy), grid | `screens/programme_grid_screen.dart` |
| 7 | ThemeData styling | `textTheme`, `Theme.of(context)` | `theme.dart` |
| bonus | ScrollBehavior | bounce/stretch/glow overscroll | `main.dart` (`AppScrollBehavior`) |

## Struktur projek
```
lib/
├── main.dart                      ← app entry + AppScrollBehavior (scroll feel)
├── theme.dart                     ← KptTheme (navy/gold) + textTheme
├── models/programme.dart          ← model Programme + enum
├── data/sample_programmes.dart    ← 8 tawaran contoh
├── widgets/
│   ├── programme_card.dart        ← kad senarai (+ CategoryPill) — DIGUNA (tab Program)
│   ├── programme_banner.dart      ← banner Stack (Latihan 2) — "atas rak"
│   └── programme_intake_tile.dart ← Card+ListTile (Latihan 4) — "atas rak"
└── screens/
    ├── home_screen.dart           ← shell: 3 tab + Drawer
    ├── programme_list_screen.dart ← tab Program (senarai kad + tajuk titleLarge)
    ├── programme_grid_screen.dart ← grid (Latihan 6) — "atas rak"
    ├── my_applications_screen.dart← placeholder (Hari 3)
    └── profile_screen.dart        ← placeholder (Hari 3)
```
"Atas rak" = widget siap tapi belum dipaparkan dalam app sekarang.

## Cara jalankan
```
flutter pub get
flutter run   # pilih emulator Android atau Chrome
```

## Nota penting
- Tema navy = `KptTheme.navy` (`0xFF1A2B5C`), gold = `0xFFD4A017` (fail `theme.dart`).
- `EntryCategory` = `spm`, `stam`, `both` (label: "SPM atau STAM").
- Pakej `intl` TIDAK diperlukan — RM diformat guna `_formatRm()` dalam `programme_card.dart`.
- Untuk pull nota terkini: `git -C <path>\kelas-flutter-5-hari pull` (remote guna proxy ghfast).

## Seterusnya: HARI 3
`_selectCountry` dalam `home_screen.dart` dan skrin placeholder (My Applications,
Profile) akan dihidupkan Hari 3 (guna `provider` untuk carian/tapisan negara).
