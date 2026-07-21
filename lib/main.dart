import 'package:flutter/material.dart';

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
      body: Center(
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
              const ProgrammeBanner(
                programme: Programme(
                  universityName: 'Universiti Al-Azhar',
                  fieldOfStudy: 'Perubatan (Medicine)',
                  flagEmoji: '🇲🇦',
                  category: EntryCategory.spm,
                ),
              ),
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
                  child: Icon(Icons.chevron_right, color: kNavy),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ===== Warna tema (ganti KptTheme dalam nota) =====
const kNavy = Color(0xFF1A2B5C);
const kGold = Color(0xFFD4A017);

// Kategori kemasukan eTT
enum EntryCategory { spm, stam, spmOrStam }

String categoryLabel(EntryCategory c) {
  switch (c) {
    case EntryCategory.spm:
      return 'SPM';
    case EntryCategory.stam:
      return 'STAM';
    case EntryCategory.spmOrStam:
      return 'SPM atau STAM';
  }
}

// Model data ringkas untuk satu tawaran pengajian
class Programme {
  const Programme({
    required this.universityName,
    required this.fieldOfStudy,
    required this.flagEmoji,
    required this.category,
  });

  final String universityName;
  final String fieldOfStudy;
  final String flagEmoji;
  final EntryCategory category;
}

// Widget kecil yang boleh diguna semula: pill kategori kemasukan
class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.category});

  final EntryCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: kGold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        categoryLabel(category),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: kNavy,
        ),
      ),
    );
  }
}

// Banner program: Stack (banner navy + bendera + teks + pill kategori)
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
            color: kNavy,
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
