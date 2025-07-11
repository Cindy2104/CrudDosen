class Dosen {
  final int id;
  final String nama;
  final String nidn;
  final String prodi;

  Dosen({
    required this.id,
    required this.nama,
    required this.nidn,
    required this.prodi,
  });

  Map<String, dynamic> toJson() {
    return {
      'nip': nidn,
      'nama_lengkap': nama,
      'no_telepon': '08123456789',
      'email': '${nidn}@example.com',
      'alamat': prodi,
    };
  }

  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      id: json['no'] ?? 0,
      nama: json['nama_lengkap'] ?? '',
      nidn: json['nip'] ?? '',
      prodi: json['alamat'] ?? '',
    );
  }
}
