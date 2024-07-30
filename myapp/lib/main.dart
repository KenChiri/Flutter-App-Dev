import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:myapp/src/features/controllers/navigation_bar_state.dart';
import 'package:myapp/src/features/screens/user/profile.dart';
import 'package:myapp/src/features/screens/user/splash_screen.dart';
import 'package:myapp/src/providers/restaurant_provider.dart';
import 'package:myapp/src/utils/theme/theme.dart';
import 'package:myapp/src/features/screens/user/home.dart';
import 'package:myapp/src/features/screens/auth/login_view.dart';
import 'package:myapp/src/features/screens/auth/register_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Add this import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    // Activate Debug Provider in debug mode
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  } else {
    // Use Play Integrity for production
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(
          create: (context) => AuthState(),
        ),
        ChangeNotifierProvider<NavigationBarState>(
          create: (context) => NavigationBarState(),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (context) => RestaurantProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthState>(context).currentUser;

    return MaterialApp(
      title: 'Food Delivery',
      theme: UserPageTheme.lightTheme,
      darkTheme: UserPageTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/home': (context) => HomePage(),
        '/profile': (context) => UserProfile(
              email: user?.email ?? "",
              phoneNumber: user?.phoneNumber ?? "",
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
