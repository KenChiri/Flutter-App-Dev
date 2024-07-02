import 'package:flutter/material.dart';
import 'package:myapp/src/utils/theme/navbar.dart';

class UserProfile extends StatelessWidget {
  final String email;
  final String phoneNumber;

  UserProfile({
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Navigate to edit profile screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/profile_picture.jpg'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Work hard in silence. Let your success be the noise.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                  subtitle: Text(phoneNumber),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfile(
      email: 'miranda.west@example.com',
      phoneNumber: '+123456789',
    ),
  ));
}
