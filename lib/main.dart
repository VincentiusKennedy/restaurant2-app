import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/database/db_helper.dart';
import 'package:restaurant_app/preferences/preferences_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/scheduling_restaurant_provider.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/restaurant_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'common/styles.dart';
import 'helper/background_service.dart';
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) =>
              RestaurantListProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            dbHelper: DbHelper(),
          ),
        ),
        ChangeNotifierProvider<SchedulingRestaurantProvider>(
          create: (_) => SchedulingRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: Colors.black,
                    secondary: secondaryColor,
                  ),
              scaffoldBackgroundColor: Color.fromARGB(255, 248, 247, 247),
              textTheme: myTextTheme,
              appBarTheme: const AppBarTheme(elevation: 0),
            ),
            builder: (context, child) {
              return Material(
                child: child,
              );
            },
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
