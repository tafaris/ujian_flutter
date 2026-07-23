import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

/// Empat keadaan kitaran hayat sesuatu panggilan rangkaian.
enum LoadState { idle, loading, loaded, error }

class LabHari4Screen extends StatefulWidget {
  const LabHari4Screen({super.key});

  @override
  State<LabHari4Screen> createState() => _LabHari4ScreenState();
}

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];

  /// [tunjukSpinnerPenuh] = false semasa pull-to-refresh, supaya senarai kekal
  /// kelihatan (RefreshIndicator sudah ada spinner sendiri) dan tidak "berkelip"
  /// jadi skrin spinner penuh.
  Future<void> _load({bool tunjukSpinnerPenuh = true}) async {
    if (tunjukSpinnerPenuh) setState(() => _state = LoadState.loading);
    try {
      final data = await _service.fetchProgrammes();
      setState(() {
        _programmes = data;
        _state = LoadState.loaded;
      });
    } catch (_) {
      setState(() => _state = LoadState.error);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  /// Hantar satu permohonan contoh (POST) dan papar hasil dalam SnackBar.
  Future<void> _hantarContohPermohonan() async {
    final contoh = Application(
      id: 'LAB-${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Pelajar Contoh',
      icNumber: '000000-00-0000',
      email: 'pelajar@example.com',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'SPM 2025 — 8A',
      country: 'Egypt',
      fieldOfStudy: 'Perubatan (Medicine)',
      universityChoiceIds: const ['ETT-001'],
    );
    final berjaya = await _service.submitApplication(contoh);
    if (!mounted) return; // WAJIB: pengguna mungkin tinggalkan skrin semasa await
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          berjaya
              ? 'Permohonan contoh berjaya dihantar'
              : 'Gagal hantar permohonan contoh',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Hari 4 — Tawaran eTT (API)'),
        actions: [
          IconButton(
            onPressed: _hantarContohPermohonan,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('Gagal memuat data program.'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Cuba Lagi')),
            ],
          ),
        );
      case LoadState.loaded:
        // Latihan 6 — senarai sebenar + tarik-untuk-muat-semula.
        return RefreshIndicator(
          onRefresh: () => _load(tunjukSpinnerPenuh: false),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: _programmes.length,
            itemBuilder: (context, index) {
              final p = _programmes[index];
              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
