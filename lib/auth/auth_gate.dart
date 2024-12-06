import 'package:flutter/material.dart';
import 'package:stego_mart/pages/login.dart';
import 'package:stego_mart/pages/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // auth state changes:
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // build appopriate page based on auth state:
      builder: (context, snapshot) {
        // Loading:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // check valid session currently:
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          // not logged in, show login screen:
          return const ProfilePage();
        } else {
          // logged in, show main app:
          return const LoginPage();
        }
      },
    );
  }
}
