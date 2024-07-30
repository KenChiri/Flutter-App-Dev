// cart_provider.dart

import 'package:flutter/material.dart';
import 'food_item.dart';

class CartProvider with ChangeNotifier {
  final List<FoodItem> _items = [];

  List<FoodItem> get items => _items;

  void addItem(FoodItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }
}
