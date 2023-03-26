import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_search.dart';

enum ResultState {
  isLoading,
  noData,
  hasData,
  error,
}

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  void autoIncrement() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchSearchedRestaurant(search);
    });
  }

  RestaurantSearchProvider({required this.apiService}) {
    fetchSearchedRestaurant(search);
  }

  SearchRestaurant? _searchRestaurant;
  ResultState? _state;
  String _message = '';
  String _search = '';

  SearchRestaurant? get restaurantSearch => _searchRestaurant;
  ResultState? get state => _state;
  String get message => _message;
  String get search => _search;

  Future<dynamic> fetchSearchedRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = ResultState.isLoading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getSearchQuery(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Can\'t find restaurant';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _searchRestaurant = restaurant;
        }
      } else {
        return _message = 'NULL';
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Connection";
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $error';
    }
  }
}
