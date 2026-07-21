// lib/widgets/programme_intake_tile.dart
// Alternatif ringkas kepada ProgrammeCard: satu Card + ListTile.
import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';

class ProgrammeIntakeTile extends StatelessWidget {
  const ProgrammeIntakeTile({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.school_outlined, color: KptTheme.navy),
        title: Text(
          programme.universityName,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('${programme.fieldOfStudy} · ${programme.intakeMonth}'),
        trailing: Text(
          '${programme.quotaSeats} tempat',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
