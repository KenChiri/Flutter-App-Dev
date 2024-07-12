import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> registerWithEmailAndPassword(String email, String password, String role) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    await _firestore.collection('users').doc(user!.uid).set({
      'email': email,
      'role': role,
    });
    return user;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
