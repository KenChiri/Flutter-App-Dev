import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPageTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        titleMedium: GoogleFonts.marmelad(
      color: Colors.black87,
    )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black87, // Light theme background
      selectedItemColor:
          Color.fromARGB(246, 237, 227, 142), // Light theme selected item color
      unselectedItemColor:
          Color.fromARGB(246, 238, 214, 0), // Light theme unselected color
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
        headlineMedium: GoogleFonts.marmelad(
      color: Color.fromARGB(246, 238, 214, 0),
    )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:
          Color.fromARGB(246, 238, 214, 0), // Light theme background
      selectedItemColor: Colors.black, // Light theme selected item color
      unselectedItemColor:
          Color.fromARGB(221, 27, 26, 26), // Light theme unselected color
    ),
  );
}
