// lib/models/restaurant.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String name;
  final String description;
  final String imageUrl;
  final String location;


  Restaurant({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
  });

  // Optionally, you can add a factory constructor to create a Restaurant from a Firestore document
  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Restaurant(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      location: data['location'] ?? '',
    );
  }
}
