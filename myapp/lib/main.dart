import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/features/screens/admin/admin_home_screen.dart';
import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:myapp/src/features/controllers/navigation_bar_state.dart';
import 'package:myapp/src/features/screens/profile.dart';
import 'package:myapp/src/features/screens/restaurant_manager/rm_home.dart';

import 'package:myapp/src/features/screens/splash_screen.dart';

import 'package:myapp/src/utils/theme/theme.dart';
import 'package:myapp/src/features/screens/user/home.dart';
import 'package:myapp/src/features/screens/auth/login_view.dart';
import 'package:myapp/src/features/screens/auth/register_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        '/admin': (context) => AdminHomeScreen(),
        '/res_manager': (context) => RestaurantHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
