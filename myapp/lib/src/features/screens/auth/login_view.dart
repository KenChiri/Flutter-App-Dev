import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/common_widgets/anchor_text.dart';
import 'package:myapp/src/features/screens/admin/admin_home_screen.dart';
import 'package:myapp/src/features/screens/auth/register_view.dart';
import 'package:myapp/src/features/screens/delivery_boy/deliboy_homescreen.dart';
import 'package:myapp/src/features/screens/restaurant_manager/rm_home.dart';
import 'package:myapp/src/features/screens/user/home.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _email.text;
      final password = _password.text;
      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _navigateBasedOnRole(userCredential.user);
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == "user-not-found") {
            _errorMessage = "User not found";
          } else if (e.code == "wrong-password") {
            _errorMessage = "Wrong password";
          } else {
            _errorMessage = "An error occurred. Please try again.";
          }
        });
        _showErrorMessage(_errorMessage);
      }
    }
  }

  Future<void> _navigateBasedOnRole(User? user) async {
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final role = userDoc['role'];

      if (role == 'Admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
        );
      } else if (role == 'DeliveryBoy') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DeliBoyHome()),
        );
      } else if (role == 'RestaurantManager') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RestaurantHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                    'assets/images/123102_original_3389x4519.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.multiply),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: FutureBuilder(
                  future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'Welcome Back to Insta Foods',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: GoogleFonts.marmelad().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 229, 193, 64),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            TextFormField(
                              controller: _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter your email..',
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 242, 225, 139)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15.0),
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 248, 244, 199)),
                              ),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 244, 199)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _password,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "Password goes here",
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15.0),
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 248, 244, 199)),
                              ),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 244, 199)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnchorText(
                                text: "Create a new account",
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterView(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: _login,
                                child: const Text('Login'),
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(200, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 253, 190, 0),
                                  foregroundColor: Color.fromARGB(255, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Center(
                              child: SignInButton(
                                Buttons.Google,
                                onPressed: () async {
                                  try {
                                    final userCredential =
                                        await signInWithGoogle();
                                    await _navigateBasedOnRole(
                                        userCredential.user);
                                  } catch (error) {
                                    print(
                                        'Error signing in with Google: $error');
                                    _showErrorMessage(
                                        'Error signing in with Google');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
