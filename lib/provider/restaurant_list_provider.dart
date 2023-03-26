import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import '../data/api/api_service.dart';

enum ResultState {
  isLoading,
  noData,
  hasData,
  error,
}

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late ResultState _state;
  late Restaurant _restaurant;
  String _message = '';

  ResultState get state => _state;
  Restaurant get restaurantList => _restaurant;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.isLoading;
      notifyListeners();
      final resto = await apiService.getRestaurant();
      if (resto.restaurant.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = resto;
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
