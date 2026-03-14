import 'package:flutter/material.dart';
import '../../models/penghuni.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormPenghuniPage extends StatefulWidget {
  final List<Penghuni> listPenghuni;
  final Penghuni? penghuni;
  final bool isDarkMode; // 🟢 parameter dark mode

  const FormPenghuniPage({
    super.key,
    required this.listPenghuni,
    this.penghuni,
    required this.isDarkMode,
  });

  @override
  State<FormPenghuniPage> createState() => _FormPenghuniPageState();
}

class _FormPenghuniPageState extends State<FormPenghuniPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final nikController = TextEditingController();
  final noHpController = TextEditingController();
  final universitasController = TextEditingController();

  String? selectedKamar;
  List<String> daftarKamar = [];

  @override
  void initState() {
    super.initState();
    if (widget.penghuni != null) {
      namaController.text = widget.penghuni!.nama;
      nimController.text = widget.penghuni!.nim;
      nikController.text = widget.penghuni!.nik;
      noHpController.text = widget.penghuni!.noHp;
      universitasController.text = widget.penghuni!.universitas;
      selectedKamar = widget.penghuni!.kamar;
    }
    fetchDaftarKamar();
  }

  Future<void> fetchDaftarKamar() async {
    try {
      final res = await supabase.from('kamar').select('nomor');
      setState(() {
        daftarKamar = (res as List).map((e) => e['nomor'].toString()).toList();
      });
    } catch (e) {
      print('Gagal ambil kamar: $e');
    }
  }

  int jumlahPenghuni(String kamar) =>
      widget.listPenghuni.where((p) => p.kamar == kamar).length;

  void simpan() {
    if (!_formKey.currentState!.validate() || selectedKamar == null) return;

    if (jumlahPenghuni(selectedKamar!) >= 2 &&
        widget.penghuni?.kamar != selectedKamar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kamar sudah penuh"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final p = Penghuni(
      id: widget.penghuni?.id ?? DateTime.now().toString(),
      nama: namaController.text,
      nim: nimController.text,
      nik: nikController.text,
      noHp: noHpController.text,
      universitas: universitasController.text,
      kamar: selectedKamar!,
      bulanTerakhirBayar:
          widget.penghuni?.bulanTerakhirBayar ?? DateTime.now().month,
      tahunTerakhirBayar:
          widget.penghuni?.tahunTerakhirBayar ?? DateTime.now().year,
    );

    Navigator.pop(context, p);
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final isDark = widget.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        validator: (v) => v == null || v.isEmpty ? "Wajib diisi" : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          filled: true,
          fillColor: isDark ? Colors.grey.shade800 : Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.penghuni != null;
    final isDark = widget.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xFFF1F6FB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 4,
          shadowColor: Colors.blueAccent.withOpacity(0.3),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? LinearGradient(
                      colors: [Colors.grey.shade800, Colors.grey.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            isEditing ? "Edit Penghuni" : "Tambah Penghuni",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(label: "Nama", controller: namaController),
              _buildTextField(label: "NIM", controller: nimController),
              _buildTextField(label: "NIK", controller: nikController),
              _buildTextField(
                label: "No HP",
                controller: noHpController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: "Kampus",
                controller: universitasController,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedKamar,
                decoration: InputDecoration(
                  labelText: "Kamar",
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                items: daftarKamar.map((k) {
                  final sisa = 2 - jumlahPenghuni(k);
                  return DropdownMenuItem(
                    value: k,
                    child: Text(
                      "$k (Sisa: $sisa)",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedKamar = v),
                validator: (v) => v == null ? "Pilih kamar" : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.lightBlueAccent
                        : Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: simpan,
                  child: Text(
                    isEditing ? "Simpan Perubahan" : "Tambah Penghuni",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
