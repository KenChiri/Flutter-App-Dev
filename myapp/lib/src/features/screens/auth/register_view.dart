import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/common_widgets/anchor_text.dart';
import 'package:myapp/src/features/screens/auth/login_view.dart';
import 'package:myapp/src/features/screens/auth/model/user_model.dart';
import 'package:myapp/src/features/screens/delivery_boy/deliboy_homescreen.dart';
import 'package:myapp/src/features/screens/user/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController controller = TextEditingController();
  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  String? _selectedRole = 'User'; // Default role is User

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
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// This will display the error messages
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  // Other existing methods...

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular expression for email validation
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: FutureBuilder(
                  future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error initializing Firebase'));
                    } else {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Welcome to Insta Foods',
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Color.fromARGB(255, 229, 193, 64),
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
                                      color: Color.fromARGB(255, 242, 225, 139),
                                      width: 1.0),
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
                              validator: validateEmail,
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
                                      color: Color.fromARGB(255, 242, 225, 139),
                                      width: 1.0),
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
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              decoration: InputDecoration(
                                hintText: 'Tell us your role..',
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 242, 225, 139),
                                      width: 1.0),
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
                              dropdownColor: Colors.black54,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 244, 199)),
                              items: [
                                DropdownMenuItem(
                                    value: 'User', child: Text('User')),
                                DropdownMenuItem(
                                  value: 'DeliveryGuy',
                                  child: Text("Delivery Guy"),
                                )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a role';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Center(
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final email = _email.text;
                                    final password = _password.text;
                                    try {
                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );

                                      // Save the role in Firestore during registration
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userCredential.user!.uid)
                                          .set({
                                        'email': email,
                                        'role':
                                            _selectedRole, // Save selected role
                                        'userId': userCredential.user!.uid,
                                      });

                                      print(userCredential);
                                      // Redirect to login page after successful registration
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginView(),
                                        ),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        _showErrorMessage(
                                            'The password provided is too weak.');
                                      } else if (e.code ==
                                          'email-already-in-use') {
                                        _showErrorMessage(
                                            'An account already exists for that email.');
                                      }
                                    } catch (e) {
                                      _showErrorMessage(
                                          'An error occurred during registration.');
                                    }
                                  }
                                },
                                child: const Text('Sign Up'),
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

                                    // Save default role in Firestore during Google sign-in
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userCredential.user!.uid)
                                        .set({
                                      'email': userCredential.user!.email,
                                      'name': userCredential.user!
                                          .displayName, // Save name from Google
                                      'phone_no': userCredential
                                              .user!.phoneNumber ??
                                          '', // Save phone number from Google, if available
                                      'role': 'User', // Default role is User
                                      'userId': userCredential.user!.uid,
                                    });

                                    // Navigate to login after successful sign-u[]
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                    print(
                                        'Signed in user: ${userCredential.user?.displayName}');
                                  } catch (error) {
                                    // Handle errors
                                    print(
                                        'Error signing in with Google: $error');
                                    _showErrorMessage(
                                        'Error signing in with Google');
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adjust for desired roundness
                                ),
                                padding: const EdgeInsets.all(10.0),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnchorText(
                                text: "Have an account? Login",
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LoginView(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
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
