import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'penghuni/penghuni_page.dart';
import 'keuangan/tagihan_page.dart';
import 'kamar/kamar_page.dart';
import '../models/penghuni.dart';
import '../models/tagihan.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final supabase = Supabase.instance.client;

  List<Penghuni> listPenghuni = [];
  List<Tagihan> listTagihan = [];
  bool isLoading = true;

  bool isDarkMode = false; // theme mode

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    try {
      final penghuniRes = await supabase
          .from('penghuni')
          .select()
          .order('nama', ascending: true);
      if (penghuniRes != null && penghuniRes is List) {
        listPenghuni = penghuniRes.map((e) => Penghuni.fromMap(e)).toList();
      }

      final tagihanRes = await supabase.from('tagihan').select();
      if (tagihanRes != null && tagihanRes is List) {
        listTagihan = tagihanRes.map((e) => Tagihan.fromMap(e)).toList();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal load data: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void onDataChanged() => fetchData();

  ThemeData _getThemeData() {
    return isDarkMode
        ? ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey.shade900,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade800,
              elevation: 4,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.grey.shade800,
              selectedItemColor: Colors.lightBlueAccent,
              unselectedItemColor: Colors.white70,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.lightBlueAccent,
            ),
          )
        : ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF1F6FB),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue.shade600,
              elevation: 4,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.lightBlue,
              unselectedItemColor: Colors.black54,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.lightBlue,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final theme = _getThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.lightBlue,
                      strokeWidth: 4,
                    ),
                  )
                : IndexedStack(
                    index: _currentIndex,
                    children: [
                      PenghuniPage(
                        listPenghuni: listPenghuni,
                        listTagihan: listTagihan,
                        onDataChanged: onDataChanged,
                        isDarkMode: isDarkMode, // kirim mode
                      ),
                      KamarPage(
                        listPenghuni: listPenghuni,
                        isDarkMode: isDarkMode, // kirim mode
                      ),
                      TagihanPage(
                        listPenghuni: listPenghuni,
                        isDarkMode: isDarkMode, // kirim mode
                      ),
                    ],
                  ),
            // toggle dark mode
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => setState(() => isDarkMode = !isDarkMode),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: isDarkMode
                        ? LinearGradient(
                            colors: [
                              Colors.grey.shade800,
                              Colors.grey.shade700,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Penghuni",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room),
              label: "Kamar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: "Keuangan",
            ),
          ],
        ),
      ),
    );
  }
}
