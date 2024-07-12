import 'package:flutter/material.dart';
import 'package:myapp/src/features/controllers/navigation_bar_state.dart';
import 'package:myapp/src/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationBarState = Provider.of<NavigationBarState>(context);
    final brightness = MediaQuery.of(context).platformBrightness;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Color.fromARGB(246, 238, 214, 0),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: const Color.fromARGB(255, 8, 8, 8),
              textTheme: Theme.of(context).textTheme.copyWith(
                    bodyMedium: const TextStyle(
                        color: Colors
                            .white), // Ensure high contrast with background
                  ),
            ),
            child: Theme(
              data: brightness == Brightness.light
                  ? UserPageTheme.lightTheme
                  : UserPageTheme.darkTheme,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: navigationBarState.currentIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.food_bank),
                    label: 'Restaurants',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Account',
                  ),
                ],
                onTap: (index) {
                  navigationBarState.setCurrentIndex(index);
                  switch (index) {
                    case 0:
                      navigationBarState.navigateToHomePage(context);
                      break;
                    case 1:
                      // Add navigation logic for Restaurants

                      break;
                    case 2:
                      // Add navigation logic for Orders
                      break;
                    case 3:
                      navigationBarState.navigateToProfilePage(context);
                      break;
                    // Add more cases if needed
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
