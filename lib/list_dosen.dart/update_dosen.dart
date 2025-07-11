import 'package:flutter/material.dart';
import '../models/dosen_model.dart';
import '../services/dosen_service.dart';

class UpdateDosenPage extends StatefulWidget {
  final Dosen dosen;

  const UpdateDosenPage({super.key, required this.dosen});

  @override
  State<UpdateDosenPage> createState() => _UpdateDosenPageState();
}

class _UpdateDosenPageState extends State<UpdateDosenPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController nidnController;
  late TextEditingController prodiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.dosen.nama);
    nidnController = TextEditingController(text: widget.dosen.nidn);
    prodiController = TextEditingController(text: widget.dosen.prodi);
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final updatedDosen = Dosen(
        id: widget.dosen.id,
        nama: namaController.text,
        nidn: nidnController.text,
        prodi: prodiController.text,
      );

      await DosenService().updateDosen(widget.dosen.id, updatedDosen);

      Navigator.pop(context); // kembali ke list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Dosen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: nidnController,
                decoration: const InputDecoration(labelText: "NIDN"),
                validator: (value) => value!.isEmpty ? 'NIDN tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: prodiController,
                decoration: const InputDecoration(labelText: "Prodi"),
                validator: (value) => value!.isEmpty ? 'Prodi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
