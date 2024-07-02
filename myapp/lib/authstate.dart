import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthView { RegisterView, LoginView, HomePage }

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthView _currentView = AuthView.RegisterView;

  AuthView get currentView => _currentView;

  User? _currentUser;

  User? get currentUser => _currentUser;

  void goToLogin() {
    _currentView = AuthView.LoginView;
    notifyListeners();
  }

  void goToHome() {
    if (_currentUser != null) {
      _currentView = AuthView.HomePage;
      notifyListeners();
    } else {
      // Handle case where user is not logged in (e.g., show a message)
    }
  }

  // Firebase Authentication methods
  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = credential.user;
      notifyListeners();
    } catch (error) {
      // Handle registration errors
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = credential.user;
      notifyListeners();
    } catch (error) {
      // Handle login errors
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    _currentUser = null;
    _currentView = AuthView.RegisterView; // Reset view
    notifyListeners();
  }

  // Optional: Listen to user state changes (consider implementing later)
  // StreamSubscription<User?>? _userSubscription;

  // ... (implement listen to user state changes logic if needed)
}
