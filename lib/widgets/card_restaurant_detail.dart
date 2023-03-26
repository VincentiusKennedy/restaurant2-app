import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

class CardRestaurantDetail extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const CardRestaurantDetail({
    Key? key,
    required this.restaurantDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag:
                "https://restaurant-api.dicoding.dev/images/small/${restaurantDetail.pictureId}",
            child: Stack(
              children: [
                Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurantDetail.pictureId}"),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black),
                color: Colors.black26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Restoran:',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        restaurantDetail.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kota:',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        restaurantDetail.city,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deskripsi:',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        restaurantDetail.description,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.clip,
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Makanan: '),
                ),
                buildContainer(
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurantDetail.menus.foods.length,
                    itemBuilder: (ctx, index) => _buildCardMenu(
                        ctx, restaurantDetail.menus.foods[index].name),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Minuman: '),
                ),
                buildContainer(
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: restaurantDetail.menus.drinks.length,
                    itemBuilder: (ctx, index) => _buildCardMenu(
                        ctx, restaurantDetail.menus.drinks[index].name),
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

Widget buildContainer(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 238, 215, 238),
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    height: 150,
    width: double.infinity,
    child: child,
  );
}

Widget _buildCardMenu(BuildContext context, String menus) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menus,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
