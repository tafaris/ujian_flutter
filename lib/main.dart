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
                    top: 12,
                    right: 12,
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
