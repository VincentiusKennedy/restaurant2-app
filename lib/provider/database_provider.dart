import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/database/db_helper.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';

class DatabaseProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DatabaseProvider({required this.dbHelper}) {
    _getFavorite();
  }

  ResultState _state = ResultState.isLoading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _favorite = [];
  List<RestaurantList> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await dbHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'No Favorite Restaurant.. Add Some !';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantList restaurantList) async {
    try {
      await dbHelper.addFavorite(restaurantList);
      _getFavorite();
    } catch (error) {
      _state = ResultState.error;
      _message = 'Error -> $error';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await dbHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await dbHelper.removeFavorite(id);
      _getFavorite();
    } catch (error) {
      _state = ResultState.error;
      _message = 'Failed To Delete Reataurant';
      notifyListeners();
    }
  }
}
