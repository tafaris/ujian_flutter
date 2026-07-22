// lib/screens/application_form_screen.dart
import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  void _submitDummy() {
    final application = Application(
      id: 'ETT-UJIAN-${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Ujian Sahaja',
      icNumber: '000000000000',
      email: 'ujian@contoh.my',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'Ujian',
      country: widget.programme.country,
      fieldOfStudy: widget.programme.fieldOfStudy,
      universityChoiceIds: [widget.programme.id],
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    Navigator.of(
      context,
    ).pop(application); // pulangkan objek ke skrin sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan')),
      body: Center(
        child: FilledButton(
          onPressed: _submitDummy,
          child: const Text('Hantar (Ujian)'),
        ),
      ),
    );
  }
}
