import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/authstate.dart';
import 'package:myapp/firebase_options.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;

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
                      return Column(
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
                          TextField(
                            controller: _email,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your email..',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 225, 139),
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 248, 244, 199)),
                            ),
                            style: TextStyle(
                                color: Color.fromARGB(255, 248, 244, 199)),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Password goes here",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 242, 225, 139),
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 248, 244, 199)),
                            ),
                            style: TextStyle(
                                color: Color.fromARGB(255, 248, 244, 199)),
                          ),
                          const SizedBox(height: 10.0),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                try {
                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  print(userCredential);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  } else if (e.code == 'invalid-email') {
                                    print('The email address is not valid.');
                                  } else {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                  }
                                } catch (e) {
                                  print('Registration failed with error: $e');
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
                        ],
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
