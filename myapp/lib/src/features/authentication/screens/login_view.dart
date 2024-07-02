import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/views/home.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  //late is a variable that tesll flutter that althought a variable doesn't have value now it can be of use later

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //Stack will have children which are basically itlems stacked together
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
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: FutureBuilder(
                future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  return Column(
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
                      PhoneInputScreen(
                        action: AuthAction.signUp, // Or other action if needed
                        auth: FirebaseAuth.instance,
                      ),
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
                                color: Color.fromARGB(255, 242, 225, 139)),
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
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
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
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email, password: password);
                              final userCredential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );

                              print(userCredential);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "user-not-found") {
                                print("User not found");
                              } else if (e.code == "wrong-password") {
                                print("Wrong Password");
                              }
                            }
                          },
                          child: const Text('Login'),
                          style: TextButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: Color.fromARGB(255, 253, 190, 0),
                            foregroundColor: Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ], //Children
      ),
    );
  }
}
