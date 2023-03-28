import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant_list.dart';

class RestaurantFavoriteScreen extends StatelessWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite Restaurant'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, _) {
          if (value.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: value.favorite.length,
              itemBuilder: (context, index) {
                return CardRestaurantList(
                    restaurantList: value.favorite[index]);
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(
                  value.message,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
