import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/main_page.dart';
import 'auth/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load file .env
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final supabase = Supabase.instance.client;
  User? _user;

  @override
  void initState() {
    super.initState();

    // cek user saat app pertama dibuka
    _user = supabase.auth.currentUser;

    // listener login / logout
    supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;

      setState(() {
        _user = session?.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi Asrama",
      theme: ThemeData(
        primaryColor: const Color(0xFF42A5F5),
        scaffoldBackgroundColor: const Color(0xFFF1F6FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: AuthGate(user: _user),
    );
  }
}

class AuthGate extends StatelessWidget {
  final User? user;

  const AuthGate({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const LoginPage();
    } else {
      return const MainPage();
    }
  }
}
