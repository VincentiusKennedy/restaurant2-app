import 'package:flutter/material.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/screens/restaurant_detail_screen.dart';
import 'package:restaurant_app/screens/restaurant_favorite_screen.dart';
import 'package:restaurant_app/screens/restaurant_list_screen.dart';
import 'package:restaurant_app/screens/restaurant_search_screen.dart';
import 'package:restaurant_app/screens/restaurant_setting_screen.dart';

import '../data/models/restaurant_detail.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantListScreen(),
    const RestaurantFavoriteScreen(),
    const RestaurantSettingScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavBarTapped,
      ),
    );
  }
}
