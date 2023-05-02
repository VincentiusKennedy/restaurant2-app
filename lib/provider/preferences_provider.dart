import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurant();
  }

  bool _isDailyRestaurant = false;
  bool get isDailyRestaurant => _isDailyRestaurant;

  void _getDailyRestaurant() async {
    _isDailyRestaurant = await preferencesHelper.isDailyRestaurant;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurant();
  }
}
