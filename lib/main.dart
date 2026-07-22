import 'package:flutter/material.dart';

import 'data/sample_programmes.dart';
import 'theme.dart';
import 'widgets/programme_card.dart';
import 'screens/home_screen.dart';
import 'screens/programme_detail_screen.dart';
import 'models/programme.dart';

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
      scrollBehavior: const AppScrollBehavior(), // <-- cuba tukar di kelas ni
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final programme = settings.arguments as Programme;
          return MaterialPageRoute(
            builder: (_) => ProgrammeDetailScreen(programme: programme),
          );
        }
        return null; // laluan tidak dikenali
      },
    );
  }
}

/// Kelakuan skrol seluruh app — cuba tukar 2 tempat di bawah untuk rasa beza.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  // KNOB 1 — kesan visual di hujung senarai:
  //   return child;                    -> TIADA (sesuai untuk bounce iOS)
  //   default (buang override ini)     -> STRETCH (Android 12+)
  //   GlowingOverscrollIndicator(...)  -> GLOW (Android lama)
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // tiada stretch/glow
  }

  // KNOB 2 — cara pergerakan skrol:
  //   BouncingScrollPhysics()  -> lantun gaya iOS
  //   ClampingScrollPhysics()  -> berhenti tegas gaya Android
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
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
