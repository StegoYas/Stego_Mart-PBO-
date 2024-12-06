import 'package:flutter/material.dart';
import 'package:stego_mart/auth/auth_service.dart';
import 'package:stego_mart/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // get auth service:
  final authService = AuthService();

  // text controllers:
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Tombol Login Pressed:
  void login() async {
    // persiapan data:
    final email = _emailController.text;
    final password = _passwordController.text;

    // Mencoba login:
    try {
      await authService.signInWithEmailAndPassword(email, password);
    }

    // catch any error:
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  // UI nya:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: const Text("Login Page")),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              const Text(
                'Welcome back!, Login Disini Bro!...',
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

              const SizedBox(height: 25),

              // Button:
              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),

              const SizedBox(height: 50),

              // Don't have an account? Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 2), // This should be a separate child
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
