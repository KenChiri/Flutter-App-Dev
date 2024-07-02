import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/authstate.dart';
import 'package:myapp/src/features/authentication/controllers/navigation_bar_state.dart';
import 'package:myapp/src/features/authentication/screens/profile.dart';
import 'package:myapp/src/features/authentication/screens/splash_screen.dart';
import 'package:myapp/src/utils/theme/theme.dart';
import 'package:myapp/views/home.dart';
import 'package:myapp/src/features/authentication/screens/login_view.dart';
import 'package:myapp/src/features/authentication/screens/register_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(
          create: (context) => AuthState(),
        ),
        ChangeNotifierProvider<NavigationBarState>(
          create: (context) => NavigationBarState(),
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
      initialRoute: '/home',
      routes: {
        '/': (context) => SplashScreen(),
        '/register': (context) => RegisterView(),
        '/login': (context) => LoginView(),
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
