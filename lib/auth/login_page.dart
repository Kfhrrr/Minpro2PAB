import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password wajib diisi")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (res.user != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login berhasil")));
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login gagal: ${e.message}")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
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
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 4,
          shadowColor: Colors.blueAccent.withOpacity(0.3),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildTextField(
              label: "Email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(
              label: "Password",
              controller: passwordController,
              obscure: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: login,
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              ),
              child: const Text("Belum punya akun? Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
