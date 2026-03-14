import 'package:flutter/material.dart';
import '../../models/penghuni.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KamarPage extends StatefulWidget {
  final List<Penghuni> listPenghuni;
  final bool isDarkMode; // Tambahkan parameter mode

  const KamarPage({
    super.key,
    required this.listPenghuni,
    required this.isDarkMode,
  });

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  List<String> kamarList = [];
  final supabase = Supabase.instance.client;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKamar();
  }

  Future<void> _fetchKamar() async {
    setState(() => isLoading = true);
    try {
      final response = await supabase.from('kamar').select('nomor');
      final list = (response as List)
          .map((e) => e['nomor'].toString())
          .toList();
      setState(() {
        kamarList = list;
        isLoading = false;
      });
    } catch (e) {
      print('Gagal mengambil kamar: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal mengambil daftar kamar"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int _jumlahPenghuni(String kamar) =>
      widget.listPenghuni.where((p) => p.kamar == kamar).length;

  void _tambahKamar() async {
    String? newKamar = await showDialog<String>(
      context: context,
      builder: (context) {
        String input = "";
        return AlertDialog(
          backgroundColor: widget.isDarkMode ? Colors.grey.shade800 : null,
          title: Text(
            "Tambah Kamar",
            style: TextStyle(color: widget.isDarkMode ? Colors.white : null),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Masukkan nomor kamar",
              hintStyle: TextStyle(
                color: widget.isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            onChanged: (value) => input = value.toUpperCase(),
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (input.isNotEmpty) Navigator.pop(context, input);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );

    if (newKamar != null) {
      setState(() => isLoading = true);
      try {
        await supabase.from('kamar').insert({'nomor': newKamar});
        setState(() {
          kamarList.removeWhere((k) => k == newKamar);
          kamarList.add(newKamar);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kamar berhasil ditambahkan"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Gagal menambah kamar: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal menambah kamar: $e")));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void _hapusKamar(String kamar) async {
    final penghuniKamar = _jumlahPenghuni(kamar);
    if (penghuniKamar > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kamar $kamar masih berisi penghuni!")),
      );
      return;
    }

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: widget.isDarkMode ? Colors.grey.shade800 : null,
        title: Text(
          "Hapus Kamar",
          style: TextStyle(color: widget.isDarkMode ? Colors.white : null),
        ),
        content: Text(
          "Apakah yakin ingin menghapus kamar $kamar?",
          style: TextStyle(color: widget.isDarkMode ? Colors.white70 : null),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true);
    try {
      await supabase.from('kamar').delete().eq('nomor', kamar);
      setState(() {
        kamarList.remove(kamar);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kamar berhasil dihapus"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Gagal hapus kamar: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal hapus kamar: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildKamarCard(String kamar) {
    final penghuniKamar = _jumlahPenghuni(kamar);
    final sisa = 2 - penghuniKamar;
    final isFull = penghuniKamar >= 2;

    return Card(
      color: widget.isDarkMode ? Colors.grey.shade800 : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.blueAccent.withOpacity(0.2),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Icon(
          Icons.meeting_room,
          size: 32,
          color: widget.isDarkMode
              ? Colors.lightBlue.shade200
              : Colors.lightBlue,
        ),
        title: Text(
          "Kamar $kamar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "Terisi: $penghuniKamar/2\nSisa: $sisa",
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                isFull ? "Penuh" : "Tersedia",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: isFull ? Colors.red : Colors.green,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _hapusKamar(kamar),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                "Data Kamar",
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
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: kamarList.length,
                  itemBuilder: (context, index) {
                    final kamar = kamarList[index];
                    return _buildKamarCard(kamar);
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: _tambahKamar,
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.add),
            tooltip: "Tambah Kamar",
          ),
        ),
      ],
    );
  }
}
