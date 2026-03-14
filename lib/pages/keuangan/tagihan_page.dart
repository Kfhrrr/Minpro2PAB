import 'package:flutter/material.dart';
import '../../models/penghuni.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TagihanPage extends StatefulWidget {
  final List<Penghuni> listPenghuni;
  final bool isDarkMode; // Tambahkan parameter mode

  const TagihanPage({
    super.key,
    required this.listPenghuni,
    required this.isDarkMode,
  });

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  final int iuranPerBulan = 150000;
  final supabase = Supabase.instance.client;

  int hitungTotalTunggakan(Penghuni penghuni) {
    final now = DateTime.now();
    int totalBulanSekarang = now.year * 12 + now.month;
    int totalBulanTerakhirBayar =
        penghuni.tahunTerakhirBayar * 12 + penghuni.bulanTerakhirBayar;
    int selisih = totalBulanSekarang - totalBulanTerakhirBayar;
    if (selisih < 0) selisih = 0;
    return selisih * iuranPerBulan;
  }

  String getStatus(int totalTunggakan) =>
      totalTunggakan == 0 ? "LUNAS" : "MENUNGGAK";

  Color statusColor(int totalTunggakan) =>
      totalTunggakan == 0 ? Colors.green : Colors.red;

  void updatePembayaran(Penghuni penghuni) {
    int selectedMonth = penghuni.bulanTerakhirBayar;
    int selectedYear = penghuni.tahunTerakhirBayar;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: widget.isDarkMode ? Colors.grey.shade800 : null,
          title: Text(
            "Update Pembayaran",
            style: TextStyle(color: widget.isDarkMode ? Colors.white : null),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: selectedMonth == 0 ? null : selectedMonth,
                decoration: InputDecoration(
                  labelText: "Pilih Bulan",
                  border: const OutlineInputBorder(),
                  filled: widget.isDarkMode,
                  fillColor: widget.isDarkMode ? Colors.grey.shade700 : null,
                  labelStyle: TextStyle(
                    color: widget.isDarkMode ? Colors.white70 : null,
                  ),
                ),
                items: List.generate(12, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text(
                      "Bulan ${index + 1}",
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white70
                            : Colors.black,
                      ),
                    ),
                  );
                }),
                onChanged: (value) => selectedMonth = value!,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: selectedYear,
                decoration: InputDecoration(
                  labelText: "Pilih Tahun",
                  border: const OutlineInputBorder(),
                  filled: widget.isDarkMode,
                  fillColor: widget.isDarkMode ? Colors.grey.shade700 : null,
                  labelStyle: TextStyle(
                    color: widget.isDarkMode ? Colors.white70 : null,
                  ),
                ),
                items: List.generate(6, (index) {
                  int year = 2024 + index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? Colors.white70
                            : Colors.black,
                      ),
                    ),
                  );
                }),
                onChanged: (value) => selectedYear = value!,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              onPressed: () async {
                try {
                  await supabase
                      .from('penghuni')
                      .update({
                        'bulanTerakhirBayar': selectedMonth,
                        'tahunTerakhirBayar': selectedYear,
                      })
                      .eq('id', penghuni.id);

                  setState(() {
                    penghuni.bulanTerakhirBayar = selectedMonth;
                    penghuni.tahunTerakhirBayar = selectedYear;
                  });

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Gagal update pembayaran: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTagihanCard(Penghuni penghuni) {
    final totalTunggakan = hitungTotalTunggakan(penghuni);
    final status = getStatus(totalTunggakan);

    return Card(
      color: widget.isDarkMode ? Colors.grey.shade800 : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.blueAccent.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.lightBlueAccent,
              child: Text(
                penghuni.nama.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    penghuni.nama,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Kamar: ${penghuni.kamar} | Terakhir Bayar: ${penghuni.bulanTerakhirBayar}/${penghuni.tahunTerakhirBayar}\nTunggakan: Rp $totalTunggakan",
                    style: TextStyle(
                      color: widget.isDarkMode
                          ? Colors.white70
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: statusColor(totalTunggakan),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.lightBlue),
                  onPressed: () => updatePembayaran(penghuni),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listPenghuni = widget.listPenghuni;

    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? Colors.grey.shade900
          : const Color(0xFFF1F6FB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 4,
          shadowColor: Colors.blueAccent.withOpacity(0.3),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: widget.isDarkMode
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
            "Keuangan Asrama",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
              letterSpacing: 0.5,
              color: Colors.white,
              shadows: const [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
      ),
      body: listPenghuni.isEmpty
          ? Center(
              child: Text(
                "Belum ada data penghuni",
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: listPenghuni.length,
              itemBuilder: (context, index) {
                final penghuni = listPenghuni[index];
                return _buildTagihanCard(penghuni);
              },
            ),
    );
  }
}
