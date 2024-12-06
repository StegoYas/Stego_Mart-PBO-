import 'package:flutter/material.dart';
import 'package:stego_mart/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Supabasenya:
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFobnR5Z3dsZGN6bm16dGx0bHV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzOTY3MDgsImV4cCI6MjA0Njk3MjcwOH0.KQwzkk1Ew5HyRyDasE5Xuq7058GL7nIRC_SShEUP_Ig",
    url: "https://qhntygwldcznmztltluv.supabase.co",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
