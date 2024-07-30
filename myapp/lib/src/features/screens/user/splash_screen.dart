import 'package:flutter/material.dart';
import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:myapp/src/features/controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController _controller = SplashScreenController();

  @override
  void initState() {
    super.initState();
    final authState = Provider.of<AuthState>(context, listen: false);

    _controller.addListener(() {
      if (_controller.isInitialized) {
        Future.delayed(const Duration(seconds: 1), () {
          _controller.navigateToNextScreen(context);
        });
      }
    });
    _controller.initialize(); // Start the initialization process
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with opacity
          Image.asset(
            'assets/images/123102_original_3389x4519.jpg', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),

          // Centered app name (without animation)
          Center(
            child: Text(
              'Welcome to Insta Foods',
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
