import 'package:firebase_auth/firebase_auth.dart';
final FirebaseAuthServices authServices = FirebaseAuthServices();


class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

// forgetrpass wrod
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }


  Future logout() async {
    await _auth.signOut();
  }
}

