import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/src/utils/theme/navbar.dart';

// Dummy data for the slideshow
final List<Map<String, String>> dailyDeals = [
  {
    "image": "assets/images/burger.jpg",
    "description": "Double Cheeseburger Combo - Only \$7.99!",
    "cta": "Order Now"
  },
  {
    "image": "assets/images/pizza.jpg",
    "description": "Large Pepperoni Pizza - Only \$10.99!",
    "cta": "Learn More"
  },
  {
    "image": "assets/images/pexels-ash-122861-376464.jpg",
    "description": "Fresh Caesar Salad - Only \$5.99!",
    "cta": "Order Now"
  },
];

// Dummy data for food items
final List<Map<String, String>> foodItems = [
  {
    "image": "assets/images/soda pizza.jpg",
    "name": "Cheeseburger",
    "price": "\$5.99",
    "description": "Juicy beef patty with cheese"
  },
  {
    "image": "assets/images/pizza.jpg",
    "name": "Pepperoni Pizza",
    "price": "\$8.99",
    "description": "Large pizza with pepperoni"
  },
  {
    "image": "assets/images/pexels-ash-122861-376464.jpg",
    "name": "Caesar Salad",
    "price": "\$4.99",
    "description": "Fresh romaine lettuce with Caesar dressing"
  },
  // Add more items as needed
];

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
            // Hero Section
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: dailyDeals.map((deal) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(deal['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              deal['description']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle call to action button press
                            },
                            child: Text(deal['cta']!),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // Food Category Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final item = foodItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['price']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item['description']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
