import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;
  String? _error;

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  RestaurantProvider() {
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();

      _restaurants = snapshot.docs.map((doc) {
        return Restaurant.fromFirestore(doc);
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      print('Error fetching restaurants: $e');
    }
  }
}