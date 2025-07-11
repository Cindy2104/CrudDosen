import 'package:flutter/material.dart';
import '../models/dosen_model.dart';
import '../services/dosen_service.dart';
import 'tambah_dosen.dart';
import 'update_dosen.dart';

class ListDosenPage extends StatefulWidget {
  const ListDosenPage({super.key});

  @override
  State<ListDosenPage> createState() => _ListDosenPageState();
}

class _ListDosenPageState extends State<ListDosenPage> {
  late Future<List<Dosen>> futureDosen;

  @override
  void initState() {
    super.initState();
    futureDosen = DosenService().getAllDosen();
  }

  void _refreshData() {
    setState(() {
      futureDosen = DosenService().getAllDosen();
    });
  }

  void _deleteDosen(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus dosen ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );

    if (confirmed ?? false) {
      await DosenService().deleteDosen(id);
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Dosen"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Dosen>>(
        future: futureDosen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data dosen kosong."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final dosen = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(dosen.nama),
                    subtitle: Text("${dosen.nidn} - ${dosen.prodi}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdateDosenPage(dosen: dosen),
                              ),
                            );
                            _refreshData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteDosen(dosen.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahDosenPage()),
          );
          _refreshData();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
