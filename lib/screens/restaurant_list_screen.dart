import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import '../widgets/card_restaurant_list.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
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
}
