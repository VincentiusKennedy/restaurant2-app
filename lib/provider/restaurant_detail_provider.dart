import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

enum ResultState {
  isLoading,
  noData,
  hasData,
  error,
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailResto _detailResto;
  late ResultState _state;
  String _message = '';

  DetailResto get detailRestaurant => _detailResto;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.isLoading;
      notifyListeners();
      final detailResto = await apiService.getDetailId(id);
      if (detailResto.error) {
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResto = detailResto;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Connection";
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = error.toString();
    }
  }
}
