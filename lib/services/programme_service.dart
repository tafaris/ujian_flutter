import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';

/// Lapisan servis: satu-satunya tempat yang tahu *dari mana* data Programme
/// datang (REST API). Skrin cuma panggil `fetchProgrammes()` — ia tidak perlu
/// tahu tentang http, JSON, atau fallback.
class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Endpoint sebenar — repo GitHub anda sendiri (2A), dihos melalui proxy gh-proxy.
  static const String _endpoint =
      'https://gh-proxy.com/https://raw.githubusercontent.com/tafaris/my-ett-mock/refs/heads/main/programmes.json';

  /// Ambil senarai tawaran daripada API. Tidak pernah `throw` — sebarang
  /// kegagalan (tiada internet / timeout / status bukan-200 / JSON rosak)
  /// jatuh balik ke data tempatan supaya app tidak crash.
  /// Ambil senarai tawaran daripada API. Tidak pernah `throw` — sebarang
  /// kegagalan (tiada internet / timeout / status bukan-200 / JSON rosak)
  /// jatuh balik ke data tempatan supaya app tidak crash.
  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      // Pelayan jawab, tapi bukan OK (cth. 404/500) → guna data tempatan.
      return _fallback();
    } catch (_) {
      // Rangkaian gagal sepenuhnya / timeout / JSON rosak → guna data tempatan.
      return _fallback();
    }
  }

  /// Data tempatan + kelewatan kecil supaya spinner "loading" sempat kelihatan.
  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  /// Asas URL untuk POST. Berasingan daripada [_endpoint] kerana GET & POST
  /// boleh guna laluan berbeza. Untuk json-server (2B): 'http://10.0.2.2:3001'
  /// (emulator). Raw URL GitHub (2A) hanya melayan GET — POST akan gagal.
  static const String _baseUrl = 'http://10.0.2.2:3001';

  /// Hantar satu permohonan (POST). Pulangkan true jika 200/201, false untuk
  /// kod lain ATAU sebarang ralat — tidak pernah `throw` ke pemanggil.
  Future<bool> submitApplication(Application application) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/applications'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(application.toJson()),
          )
          .timeout(const Duration(seconds: 8));
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  void dispose() => _client.close();
}
