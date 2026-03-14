class Kamar {
  final String nomor;
  bool terisi;

  Kamar({required this.nomor, this.terisi = false});

  factory Kamar.fromMap(Map<String, dynamic> map) {
    return Kamar(nomor: map['nomor'], terisi: map['terisi'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {'nomor': nomor, 'terisi': terisi};
  }
}
