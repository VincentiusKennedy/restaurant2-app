import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';
import '../common/result_state.dart';
import '../widgets/card_restaurant_list.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  Widget _buildList() {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService(Client())),
      child: Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.restaurantList.restaurant.length,
              itemBuilder: (context, index) {
                var restaurant = state.restaurantList.restaurant[index];
                return CardRestaurantList(restaurantList: restaurant);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('FATAL ERROR'));
          }
        },
      ),
    );
  }

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
      body: _buildList(),
    );
  }
}
