import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:myapp/src/features/authentication/screens/login_view.dart';
import 'package:myapp/src/features/authentication/screens/splash_screen.dart'; // Import the controller

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashScreenController _controller =
      SplashScreenController(); // Create an instance

  AnimationController?
      _controllerAnimation; // Animation controller for UI effects
  Animation<double>? _scaleAnimation; // Animation for text scaling

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controllerAnimation!);

    _controller.addListener(() {
      // Listen for changes from the controller
      if (_controller.isInitialized) {
        _controllerAnimation!.forward().then((_) {
          // Animate UI before navigation
          Future.delayed(const Duration(seconds: 1), () {
            // Simulate delay
            _controller.navigateToLogin(context);
          });
        });
      }
    });
    _controller.initialize(); // Start the initialization process
  }

  @override
  void dispose() {
    _controllerAnimation?.dispose();
    super.dispose();
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
            color: Colors.black.withOpacity(0.8),
          ),

          // Animated "Welcome to Insta Foods" text with bouncing effect
          Center(
            child: AnimatedBuilder(
              animation: _controllerAnimation!,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation!.value,
                child: Text(
                  'Welcome to Insta Foods',
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Optional loading spinner for visual feedback during animation
          Center(
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: const SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
