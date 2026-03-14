class Penghuni {
  final String id;
  final String nama;
  final String nim;
  final String noHp;
  String kamar;
  int bulanTerakhirBayar;
  int tahunTerakhirBayar;
  final String nik;
  final String universitas;

  Penghuni({
    required this.id,
    required this.nama,
    required this.nim,
    required this.noHp,
    required this.kamar,
    required this.bulanTerakhirBayar,
    required this.tahunTerakhirBayar,
    required this.nik,
    required this.universitas,
  });

  factory Penghuni.fromMap(Map<String, dynamic> map) {
    return Penghuni(
      id: map['id'] as String,
      nama: map['nama'] as String,
      nim: map['nim'] as String,
      noHp: map['noHp'] as String,
      kamar: map['kamar'] as String,
      bulanTerakhirBayar: map['bulanTerakhirBayar'] as int,
      tahunTerakhirBayar: map['tahunTerakhirBayar'] as int,
      nik: map['nik'] as String,
      universitas: map['universitas'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'noHp': noHp,
      'kamar': kamar,
      'bulanTerakhirBayar': bulanTerakhirBayar,
      'tahunTerakhirBayar': tahunTerakhirBayar,
      'nik': nik,
      'universitas': universitas,
    };
  }
}
