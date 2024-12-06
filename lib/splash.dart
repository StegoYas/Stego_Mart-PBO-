import 'package:flutter/material.dart';
import 'package:stego_mart/auth/auth_gate.dart';
import 'package:stego_mart/pages/login.dart';
import 'package:stego_mart/screens/home.dart';
import 'dart:async'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const AuthGate()), // Replace with your actual home page widget
      );
    });
  }

  // UI nya:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/Logo_Stegomart.png', width: 300, height: 300),
            SizedBox(height: 20),
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
