import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurant_list.dart';
import 'package:restaurant_app/data/models/restaurant_search.dart';

class ApiService {
  http.Client client;
  ApiService(this.client);
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Restaurant> getRestaurant() async {
    final response = await client.get(Uri.parse('${_baseUrl}list'));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<DetailResto> getDetailId(String id) async {
    final response = await client.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return DetailResto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<SearchRestaurant> getSearchQuery(String query) async {
    final response = await client.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load searched restaurant');
    }
  }
}
