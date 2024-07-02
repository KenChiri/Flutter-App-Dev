// splashscreen_controller.dart

import 'package:flutter/material.dart';
import 'package:myapp/src/features/authentication/screens/login_view.dart';
import 'package:myapp/src/features/authentication/screens/register_view.dart';

class SplashScreenController extends ChangeNotifier {
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    // Simulate some initialization logic (replace with your actual logic)
    await Future.delayed(const Duration(seconds: 2));
    _initialized = true;
    notifyListeners();
  }

  Future<void> navigateToLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterView()),
    );
  }
}
