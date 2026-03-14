import 'package:flutter/material.dart';
import '../../models/penghuni.dart';
import '../../models/tagihan.dart';
import 'form_penghuni.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PenghuniPage extends StatefulWidget {
  final List<Penghuni> listPenghuni;
  final List<Tagihan> listTagihan;
  final VoidCallback? onDataChanged;
  final bool isDarkMode;

  const PenghuniPage({
    super.key,
    required this.listPenghuni,
    required this.listTagihan,
    this.onDataChanged,
    required this.isDarkMode,
  });

  @override
  State<PenghuniPage> createState() => _PenghuniPageState();
}

class _PenghuniPageState extends State<PenghuniPage> {
  final supabase = Supabase.instance.client;
  bool isProcessing = false;

  Future<void> editPenghuni(Penghuni penghuni) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPenghuniPage(
          listPenghuni: widget.listPenghuni,
          penghuni: penghuni,
          isDarkMode: widget.isDarkMode, // 🟢 kirim mode ke form
        ),
      ),
    );

    if (result != null) {
      setState(() => isProcessing = true);
      try {
        await supabase
            .from('penghuni')
            .update(result.toMap())
            .eq('id', result.id);

        setState(() {
          int index = widget.listPenghuni.indexWhere((p) => p.id == result.id);
          widget.listPenghuni[index] = result;
        });

        widget.onDataChanged?.call();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data penghuni berhasil diperbarui"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal update penghuni: $e"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => isProcessing = false);
      }
    }
  }

  Future<void> hapusPenghuni(Penghuni penghuni) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: widget.isDarkMode ? Colors.grey.shade800 : null,
        title: Text(
          "Konfirmasi Hapus",
          style: TextStyle(color: widget.isDarkMode ? Colors.white : null),
        ),
        content: Text(
          "Hapus penghuni ${penghuni.nama}?",
          style: TextStyle(color: widget.isDarkMode ? Colors.white70 : null),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(false), // ✅ pakai rootNavigator
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(true), // ✅ pakai rootNavigator
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isProcessing = true);
    try {
      await supabase.from('penghuni').delete().eq('id', penghuni.id);
      await supabase.from('tagihan').delete().eq('penghuniId', penghuni.id);

      setState(() {
        widget.listPenghuni.removeWhere((p) => p.id == penghuni.id);
        widget.listTagihan.removeWhere((t) => t.penghuniId == penghuni.id);
      });

      widget.onDataChanged?.call();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Penghuni ${penghuni.nama} berhasil dihapus"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal hapus penghuni: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  Widget _buildPenghuniCard(Penghuni p) {
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
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.lightBlueAccent,
          child: Text(
            p.nama.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          p.nama,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "NIM: ${p.nim}\nNIK: ${p.nik}\nKamar: ${p.kamar}\nKampus: ${p.universitas}",
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.lightBlue),
              onPressed: () => editPenghuni(p),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => hapusPenghuni(p),
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
                "Data Penghuni",
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
          body: widget.listPenghuni.isEmpty
              ? Center(
                  child: Text(
                    "Belum ada data",
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode
                          ? Colors.white70
                          : Colors.black54,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.listPenghuni.length,
                  itemBuilder: (context, index) {
                    return _buildPenghuniCard(widget.listPenghuni[index]);
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormPenghuniPage(
                    listPenghuni: widget.listPenghuni,
                    isDarkMode: widget.isDarkMode, // 🟢 kirim mode
                  ),
                ),
              );
              if (result != null) {
                setState(() => widget.listPenghuni.add(result));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Penghuni berhasil ditambahkan"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ),
        if (isProcessing)
          const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black54),
          ),
        if (isProcessing) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
