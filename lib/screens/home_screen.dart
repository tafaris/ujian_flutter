// lib/screens/home_screen.dart
// Skrin utama kekal: 3 tab (Program / Permohonan / Profil) + Drawer negara.
import 'package:flutter/material.dart';

import '../theme.dart';
import 'my_applications_screen.dart';
import 'profile_screen.dart';
import 'programme_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tab yang sedang aktif (0 = Program). Bila berubah -> UI dibina semula.
  int _index = 0;

  /// Negara dipilih dalam Drawer. null = semua negara.
  String? _countryFilter;

  static const _titles = ['Program', 'Permohonan Saya', 'Profil'];

  /// Label BM untuk negara yang sedang ditapis (null jika semua).
  String? get _filterLabel => switch (_countryFilter) {
    'Egypt' => 'Mesir',
    'Morocco' => 'Maghribi',
    _ => null,
  };

  void _selectCountry(String? country) {
    setState(() => _countryFilter = country); // inilah kuncinya
    Navigator.of(context).pop(); // tutup Drawer
  }

  @override
  Widget build(BuildContext context) {
    // Dibina dalam build() supaya _countryFilter terkini sampai ke anak.
    final screens = [
      ProgrammeListScreen(countryFilter: _countryFilter),
      const MyApplicationsScreen(),
      const ProfileScreen(),
    ];

    // Tunjuk negara yang ditapis pada tajuk, contoh: "Program · Mesir".
    final title = _index == 0 && _filterLabel != null
        ? '${_titles[_index]} · $_filterLabel'
        : _titles[_index];

    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · $title')),
      drawer: _CountryDrawer(
        selected: _countryFilter,
        onSelect: _selectCountry,
      ),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: KptTheme.navy,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Program',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Permohonan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Satu pilihan negara dalam Drawer.
class _CountryOption {
  const _CountryOption(this.value, this.label, this.flag);
  final String? value;
  final String label;
  final String flag;
}

// Drawer senarai negara (header navy + 3 pilihan).
class _CountryDrawer extends StatelessWidget {
  const _CountryDrawer({required this.selected, required this.onSelect});

  final String? selected;
  final void Function(String?) onSelect;

  static const _options = [
    _CountryOption(null, 'Semua Negara', '🌍'),
    _CountryOption('Egypt', 'Mesir', '🇪🇬'),
    _CountryOption('Morocco', 'Maghribi', '🇲🇦'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: KptTheme.navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'eTT Mobile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Program pengajian Timur Tengah',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          for (final option in _options)
            ListTile(
              leading: Text(option.flag, style: const TextStyle(fontSize: 22)),
              title: Text(option.label),
              selected: option.value == selected,
              selectedColor: KptTheme.navy,
              onTap: () => onSelect(option.value),
            ),
          // Latihan 6 — pintu masuk demo kitaran hayat
          const Divider(),
          ListTile(
            leading: const Icon(Icons.science_outlined, color: KptTheme.navy),
            title: const Text('Demo Kitaran Hayat'),
            subtitle: const Text('Lihat log initState / build / dispose'),
            onTap: () {
              Navigator.of(context).pop(); // tutup Drawer dahulu
              Navigator.of(context).pushNamed('/lifecycle');
            },
          ),
        ],
      ),
    );
  }
}
