import 'package:flutter/material.dart';
import 'package:stego_mart/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // get auth service:
  final authService = AuthService();

  // text controllers:
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Tombol Sign Up Pressed:
  void signUp() async {
    // persiapan data:
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // chech Password tidak cocok:
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    // Mencoba sign up:
    try {
      await authService.signUpWithEmailAndPassword(email, password);

      // pop this register page:
      Navigator.pop(context);
    }

    // catch any error:
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: Failed to register! $e")));
      }
    }
  }

  // UI nya:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: const Text("Register Page")),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.login,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              const Text(
                'Orang Baru ya?, Daftar Disini Bro!...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Email textfield:
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Masukkan Email"),
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Password textfield:
              TextField(
                controller: _passwordController,
                decoration:
                    const InputDecoration(labelText: "Masukkan Password"),
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Confirm Password:
              TextField(
                controller: _confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: "Confirm Passsword"),
                obscureText: true, // password is hidden
              ),

              const SizedBox(height: 25),

              // Button:
              ElevatedButton(
                onPressed: signUp,
                child: const Text("Sign Up"),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
