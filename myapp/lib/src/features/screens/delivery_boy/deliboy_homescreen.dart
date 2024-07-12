import 'package:flutter/material.dart';
import 'package:myapp/src/utils/theme/navbar.dart';

class DeliBoyHome extends StatelessWidget {
  const DeliBoyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deliveries HomePage",
        ),
        leading: const Icon(Icons.line_style), // Use a specific icon
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section

            // Food Category Section
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
