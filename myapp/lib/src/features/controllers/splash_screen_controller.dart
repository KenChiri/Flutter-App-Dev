import 'package:flutter/material.dart';
import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:provider/provider.dart'; // Import provider package

class SplashScreenController extends ChangeNotifier {
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    // Simulate some initialization logic (replace with your actual logic)
    await Future.delayed(const Duration(seconds: 2));
    _initialized = true;
    notifyListeners();
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    final authState = Provider.of<AuthState>(context, listen: false);

    if (authState.currentUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
