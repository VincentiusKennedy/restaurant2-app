import 'dart:convert';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';
import '../main.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSeetingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSeetingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSeetingsAndroid,
      iOS: initializationSeetingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurants) async {
    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'Restaurant App';
    final random = Random();

    var androidPlatformChannelSpecificcs = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecificcs,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = '<b>Popular Restaurant Today</b>';
    var dataRestaurant = restaurants.restaurant;
    var randomNumber = random.nextInt(dataRestaurant.length);
    var nameRestaurant = dataRestaurant[randomNumber].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      nameRestaurant,
      platformChannelSpecifics,
      payload: json.encode(
        dataRestaurant[randomNumber].toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        var restaurants = data.restaurant[0];
        Navigation.intentWithData(route, restaurants);
      },
    );
  }
}

Future<void> postNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'default_notification_channel_id',
    'Default',
    importance: Importance.max,
    priority: Priority.max,
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(0, 'PROTO IKAN',
      'Anda telah mengaktifkan notifikasi', notificationDetails);
}

Future<void> permission() async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  late final Map<Permission, PermissionStatus> statusess;

  if (androidInfo.version.sdkInt <= 32) {
  } else {
    statusess = await [Permission.notification].request();
  }

  var allAccepted = true;
  statusess.forEach((permission, status) {
    if (status != PermissionStatus.granted) {
      allAccepted = false;
    }
  });

  if (allAccepted) {
    postNotification();
  }
}
