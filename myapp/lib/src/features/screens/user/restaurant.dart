import 'package:flutter/material.dart';
import 'package:myapp/src/models/restaurant.dart';
import 'package:myapp/src/providers/restaurant_provider.dart';
import 'package:myapp/src/utils/theme/navbar.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurants"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Trigger a refresh of the restaurant data
              Provider.of<RestaurantProvider>(context, listen: false)
                  .fetchRestaurants();
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, restaurantProvider, child) {
          if (restaurantProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (restaurantProvider.error != null) {
            return Center(child: Text("Error: ${restaurantProvider.error}"));
          } else if (restaurantProvider.restaurants.isEmpty) {
            return Center(child: Text("No restaurants found"));
          } else {
            return ListView.builder(
              itemCount: restaurantProvider.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantProvider.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            child: Image.network(
              restaurant.imageUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.error, color: Colors.red),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  restaurant.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  restaurant.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
