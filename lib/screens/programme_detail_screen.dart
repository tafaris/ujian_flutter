// lib/screens/programme_detail_screen.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';

class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: Center(child: Text('${programme.city}, ${programme.countryLabel}')),
    );
  }
}
