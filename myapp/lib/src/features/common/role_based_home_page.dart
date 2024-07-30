import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myapp/src/features/screens/auth/authstate.dart';
import 'package:myapp/src/features/screens/auth/login_view.dart';
import 'package:myapp/src/features/screens/delivery_boy/deliboy_homescreen.dart';

import 'package:myapp/src/features/screens/user/home.dart';
import 'package:provider/provider.dart';

class RoleBasedHomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return LoginView();
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future: _firestore.collection('users').doc(user.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.data != null && snapshot.data!.exists) {
                        String role = snapshot.data!['role'];
                        switch (role) {
                          case 'DeliveryBoy':
                            return DeliBoyHome();
                          case 'User':
                            return HomePage();
                          default:
                            return LoginView();
                        }
                      } else {
                        return Center(child: Text('No user data found.'));
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
