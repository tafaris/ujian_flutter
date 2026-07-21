import 'package:flutter/material.dart';

import 'data/sample_programmes.dart';
import 'models/programme.dart';
import 'theme.dart';
import 'widgets/programme_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'eTT Mobile (MESIR)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Program disimpan: $_counter'),
              const SizedBox(height: 12),

              // ===== LATIHAN 1 — ProgrammeSummaryRow (dah dibetulkan Expanded) =====
              ProgrammeSummaryRow(programme: sampleProgrammes[6]),
              // ====================================================================
              const SizedBox(height: 12),

              // ===== 2.2 EXPANDED: teks pertama "menolak diri" + dipotong … =====
              Row(
                children: const [
                  Flexible(
                    child: Text(
                      'Universite Al Quaraouiyine',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis, // potong dengan …
                    ),
                  ),
                  Text(' — Fes, Maghribi', style: TextStyle(fontSize: 18)),
                ],
              ),

              const SizedBox(height: 12),

              // ===== 2.3 FLEXIBLE: teks pendek TAK meregang; ikon terus di sebelah =====
              Row(
                children: const [
                  Flexible(
                    child: Text(
                      'Universiti Al-Azhar',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
              // ==================================================================
              const SizedBox(height: 12),

              // ===== 3.1 STACK + POSITIONED: lapisan bertindan =====
              Stack(
                children: [
                  // Lapisan BAWAH: banner navy, isi penuh lebar Stack.
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2B5C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Lapisan ATAS: "pill" di sudut kanan-atas, 12px dari tepi.
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Perubatan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2B5C),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // =====================================================
              const SizedBox(height: 12),

              // ===== 3.2 ProgrammeBanner: gabungan Stack penuh =====
              ProgrammeBanner(programme: sampleProgrammes.first),
              // =====================================================
              const SizedBox(height: 12),

              // ===== 3.3 ALIGN: satu anak di dalam ruang lebih besar =====
              // Kotak selebar penuh, tinggi 40 -> ikon dilekat ke TENGAH-KANAN.
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.grey.shade200,
                child: const Align(
                  alignment: Alignment(-1.0, 1.0),
                  child: Icon(Icons.chevron_right, color: KptTheme.navy),
                ),
              ),
              // ===========================================================
              const SizedBox(height: 12),
              const Text(
                '🇪🇬  Universiti Al-Azhar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2B5C),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kaherah (Cairo), Mesir',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text('Bidang: Perubatan (Medicine)'),
              const SizedBox(height: 4),
              const Text('Anggaran yuran: RM23,000/tahun (ilustrasi)'),
              const SizedBox(height: 4),
              const Text(
                'Kuota (ilustrasi): 40 tempat · Pengambilan: September',
              ),
              const SizedBox(height: 12),
              const Icon(Icons.school, size: 32, color: Color(0xFF1A2B5C)),
            ],
          ),
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Banner program: Stack (banner navy + bendera + teks + pill kategori)
// CategoryPill & Programme kini datang dari fail starter (import di atas).
class ProgrammeBanner extends StatelessWidget {
  const ProgrammeBanner({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lapisan bawah: "gambar" destinasi (warna sebagai placeholder)
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: KptTheme.navy,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              programme.flagEmoji,
              style: const TextStyle(fontSize: 56),
            ),
          ),
        ),
        // Lapisan atas: universiti & bidang, dilabuhkan ke bawah kiri
        Positioned(
          left: 16,
          top: 14,
          child: Text(
            '${programme.universityName}\n${programme.fieldOfStudy}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        // Pill kategori kemasukan, ditindan di sudut kanan atas
        Positioned(
          top: 12,
          right: 12,
          child: CategoryPill(category: programme.category),
        ),
      ],
    );
  }
}

// ── LATIHAN 1 — Ringkasan program dengan Expanded (tiada overflow) ──
class ProgrammeSummaryRow extends StatelessWidget {
  const ProgrammeSummaryRow({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              programme.universityName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(' — ${programme.city}, ${programme.countryLabel}'),
        ],
      ),
    );
  }
}
