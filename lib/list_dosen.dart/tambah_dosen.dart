import 'package:flutter/material.dart';
import '../models/dosen_model.dart';
import '../services/dosen_service.dart';

class TambahDosenPage extends StatefulWidget {
  const TambahDosenPage({super.key});

  @override
  State<TambahDosenPage> createState() => _TambahDosenPageState();
}

class _TambahDosenPageState extends State<TambahDosenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nidnController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final newDosen = Dosen(
        id: 0,
        nama: namaController.text,
        nidn: nidnController.text,
        prodi: prodiController.text,
      );

      try {
        print('Submitting new dosen: ${newDosen.nama}, ${newDosen.nidn}, ${newDosen.prodi}');
        await DosenService().createDosen(newDosen);
        print('Dosen added successfully');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dosen berhasil ditambahkan')),
          );
          // Clear form fields after successful submission
          namaController.clear();
          nidnController.clear();
          prodiController.clear();
          Navigator.pop(context); // kembali ke halaman sebelumnya
        }
      } catch (e) {
        print('Error adding dosen: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan data: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Dosen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: nidnController,
                decoration: const InputDecoration(labelText: "NIM"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'NIP tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: prodiController,
                decoration: const InputDecoration(labelText: "Prodi"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Prodi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
