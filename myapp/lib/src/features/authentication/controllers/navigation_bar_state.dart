// navigation_bar_state.dart

import 'package:flutter/material.dart';
import 'package:myapp/src/features/authentication/screens/profile.dart';
import 'package:myapp/views/home.dart';

class NavigationBarState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Add methods for handling navigation based on index (optional)
  void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void navigateToProfilePage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfile(
                  email: '',
                  phoneNumber: '',
                )));
  }
}
