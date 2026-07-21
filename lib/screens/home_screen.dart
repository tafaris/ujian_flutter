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

  static const _titles = ['Program', 'Permohonan Saya', 'Profil'];
  static const _screens = [
    ProgrammeListScreen(),
    MyApplicationsScreen(),
    ProfileScreen(),
  ];

  void _selectCountry(String? country) {
    // Hari 3 ke atas: hubung dengan provider untuk tapis sebenar.
    Navigator.of(context).pop(); // tutup Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
      drawer: _CountryDrawer(onSelect: _selectCountry),
      body: _screens[_index],
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
  const _CountryDrawer({required this.onSelect});
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
              onTap: () => onSelect(option.value),
            ),
        ],
      ),
    );
  }
}
