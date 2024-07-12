import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:myapp/src/features/controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashScreenController _controller =
      SplashScreenController(); // Create an instance

  late AnimationController _controllerAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controllerAnimation,
      curve: Curves.elasticOut,
    ));

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
  void dispose() {
    _controllerAnimation.dispose();
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
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),

          // Centered animated text
          Center(
            child: AnimatedBuilder(
              animation: _controllerAnimation,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
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
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
              controller: _controllerAnimation,
            ),
          ),
        ],
      ),
    );
  }
}
