import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthView {
  RegisterView,
  LoginView,

  DeliveryBoyHome,

  UserHome
}

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthView _currentView = AuthView.RegisterView;

  AuthView get currentView => _currentView;

  User? _currentUser;

  User? get currentUser => _currentUser;

  String? _userRole;

  String? get userRole => _userRole;

  String? _userName;
  String? _userPhoneNo;

  String? get userName => _userName;
  String? get userPhoneNo => _userPhoneNo;

  AuthState() {
    // Initialize the current user and set the initial view
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      await _fetchUserDetails();
      _setInitialView();
    } else {
      _currentView = AuthView.LoginView;
    }
    notifyListeners();
  }

  Future<void> _fetchUserDetails() async {
    if (_currentUser != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(_currentUser!.uid).get();
        if (userDoc.exists) {
          _userRole = userDoc['role'];
          _userName = userDoc['name'];
          _userPhoneNo = userDoc['phone_no'];
        } else {
          _userRole = null;
          _userName = null;
          _userPhoneNo = null;
        }
      } catch (e) {
        // Handle Firestore errors
      }
    }
  }

  void _setInitialView() {
    if (_userRole != null) {
      switch (_userRole) {
        case 'DeliveryBoy':
          _currentView = AuthView.DeliveryBoyHome;
          break;

        case 'User':
          _currentView = AuthView.UserHome;
          break;
        default:
          _currentView = AuthView.LoginView;
          break;
      }
    } else {
      _currentView = AuthView.LoginView;
    }
  }

  void goToLogin() {
    _currentView = AuthView.LoginView;
    notifyListeners();
  }

  void goToHome() {
    if (_currentUser != null) {
      _setInitialView();
      notifyListeners();
    } else {
      // Handle case where user is not logged in (e.g., show a message)
    }
  }

  // Firebase Authentication methods
  Future<void> registerUser(
      String email, String password, String name, String phoneNo) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = credential.user;
      // Save the additional fields and role in Firestore during registration
      await _firestore.collection('users').doc(_currentUser!.uid).set({
        'email': email,
        'name': name,
        'phone_no': phoneNo,
        'role': 'User', // Default role can be set here
        'userId': _currentUser!.uid,
      });
      await _fetchUserDetails();
      _setInitialView();
      notifyListeners();
    } catch (error) {
      // Handle registration errors
      print("Error during registration: $error");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = credential.user;
      await _fetchUserDetails();
      _setInitialView();
      notifyListeners();
    } catch (error) {
      // Handle login errors
      print("Error during login: $error");
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    _currentUser = null;
    _userRole = null;
    _currentView = AuthView.LoginView;
    notifyListeners();
  }
}
