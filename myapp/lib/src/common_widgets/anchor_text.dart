import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnchorText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AnchorText({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
//This is a custom widget I have created to help me handle anchors
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: const Color.fromARGB(255, 243, 240, 33),
          decoration: TextDecoration.underline,
          fontFamily: GoogleFonts.marmelad().fontFamily,
        ),
      ),
    );
  }
}
