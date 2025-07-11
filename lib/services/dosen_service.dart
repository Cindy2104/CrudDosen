import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dosen_model.dart';

class DosenService {
  final String baseUrl = 'http://192.168.100.15:8000/api/dosen'; // Ganti sesuai IP Laravel kamu

  Future<List<Dosen>> getAllDosen() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Dosen.fromJson(json)).toList();
      } else {
        print('Gagal: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<void> createDosen(Dosen dosen) async {
    final response = await http.post(Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dosen.toJson()),
    );

    if (response.statusCode != 201) {
      print('Gagal tambah: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal menambah data dosen');
    }
  }

  Future<void> updateDosen(int id, Dosen dosen) async {
    final response = await http.put(Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dosen.toJson()),
    );

    if (response.statusCode != 200) {
      print('Gagal update: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal mengupdate data dosen');
    }
  }

  Future<void> deleteDosen(int id) async {
  final response = await http.delete(
    Uri.parse('http://192.168.100.15:8000/api/dosen/$id'),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal menghapus data dosen');
  }
}
}
