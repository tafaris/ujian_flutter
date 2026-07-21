import 'package:flutter/material.dart';

import 'data/sample_programmes.dart';
import 'theme.dart';
import 'widgets/programme_card.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi eTT Mobile — titik masuk.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eTT Mobile',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light, // AppBar auto-navy, Card auto-bulat, dll.
      home: const HomeScreen(),
    );
  }
}

/// Skrin utama: senarai semua tawaran pengajian eTT.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('eTT Mobile · Program')),
      // ListView.builder = senarai boleh skrol, bina kad hanya bila kelihatan.
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: sampleProgrammes.length,
        itemBuilder: (context, index) {
          final programme = sampleProgrammes[index];
          return ProgrammeCard(programme: programme);
        },
      ),
    );
  }
}
