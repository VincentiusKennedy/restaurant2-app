import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widgets/card_search_restaurant.dart';
import '../common/result_state.dart';
import '../data/api/api_service.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({super.key});

  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearchScreen> {
  TextEditingController controller = TextEditingController();
  String value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: ChangeNotifierProvider<RestaurantSearchProvider>(
        create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        child: Consumer<RestaurantSearchProvider>(
          builder: (context, state, _) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextField(
                        autofocus: true,
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Search Restaurant',
                          hintStyle: TextStyle(color: Colors.black26),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                        onChanged: (String query) {
                          if (query.isNotEmpty) {
                            setState(() {
                              value = query;
                            });
                            state.fetchSearchedRestaurant(value);
                          } else if (query.isEmpty) {
                            setState(() {
                              value = '';
                            });
                          }
                        },
                      ),
                    ),
                    (value.isEmpty)
                        ? const Center(
                            child: Text('Find Your Restaurant Here'),
                          )
                        : Consumer<RestaurantSearchProvider>(
                            builder: (context, state, _) {
                              if (state.state == ResultState.isLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state.state == ResultState.hasData) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state
                                      .restaurantSearch!.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurantList = state
                                        .restaurantSearch!.restaurants[index];
                                    return CardSearchRestaurant(
                                        restaurantList: restaurantList);
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
