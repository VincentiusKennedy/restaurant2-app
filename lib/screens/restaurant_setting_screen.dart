import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

import '../provider/scheduling_restaurant_provider.dart';

class RestaurantSettingScreen extends StatelessWidget {
  const RestaurantSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Scheduling Restaurant'),
                  trailing: Consumer<SchedulingRestaurantProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isDailyRestaurant,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyRestaurant(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
