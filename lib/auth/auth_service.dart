import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in pake Email & Password:
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign Up pake Email & Password:
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign out:
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get User Email:
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

}
