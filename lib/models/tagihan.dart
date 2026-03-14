class Tagihan {
  final String id;
  final String penghuniId;
  final String namaPenghuni;
  final int bulan;
  final int nominal;
  bool isLunas;

  Tagihan({
    required this.id,
    required this.penghuniId,
    required this.namaPenghuni,
    required this.bulan,
    required this.nominal,
    this.isLunas = false,
  });

  factory Tagihan.fromMap(Map<String, dynamic> map) {
    return Tagihan(
      id: map['id'].toString(),
      penghuniId: map['penghuniId'].toString(),
      namaPenghuni: map['namaPenghuni'] ?? '',
      bulan: map['bulan'] ?? 0,
      nominal: map['nominal'] ?? 0,
      isLunas: map['isLunas'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'penghuniId': penghuniId,
      'namaPenghuni': namaPenghuni,
      'bulan': bulan,
      'nominal': nominal,
      'isLunas': isLunas,
    };
  }
}
