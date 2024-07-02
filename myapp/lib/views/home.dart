import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myapp/src/utils/theme/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Menu",
        ),
        leading: const Icon(Icons.line_style), // Use a specific icon
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add your dashboard tiles here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                children: List.generate(
                  10,
                  (index) => Card(
                    child: Center(
                      child: Text(
                        'Tile ${index + 1}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
