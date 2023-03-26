import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import 'package:restaurant_app/screens/restaurant_detail_screen.dart';

class CardRestaurantList extends StatelessWidget {
  final RestaurantList restaurantList;

  const CardRestaurantList({
    Key? key,
    required this.restaurantList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RestaurantDetailScreen(restaurantId: restaurantList.id);
              }));
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Hero(
                    tag:
                        "https://restaurant-api.dicoding.dev/images/small/${restaurantList.pictureId}",
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurantList.pictureId}"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        restaurantList.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                          ),
                          Text(restaurantList.city)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                          ),
                          Text(restaurantList.rating.toString())
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
