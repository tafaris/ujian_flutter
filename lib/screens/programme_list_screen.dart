// lib/screens/programme_list_screen.dart
// Senarai ringkas semua tawaran (versi Hari 2 — tanpa carian/tapisan).
import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../widgets/programme_card.dart';

class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 7.2 — Tajuk guna gaya GLOBAL (bukan TextStyle sebaris).
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Semua Tawaran Pengajian',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            itemCount: sampleProgrammes.length,
            itemBuilder: (context, index) {
              final p = sampleProgrammes[index];
              return ProgrammeCard(programme: p);
            },
          ),
        ),
      ],
    );
  }
}
