import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future deleteUser() async {
    User? user = await _auth.currentUser;
    user?.delete();
  }
}
