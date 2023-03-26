import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurants List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RestaurantSearchScreen()),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('SEARCH'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: const RestaurantListScreen(),
    );
  }
}
