import 'dart:convert';

SearchRestaurant searchRestaurantFromJson(String str) =>
    SearchRestaurant.fromJson(json.decode(str));

String searchRestaurantToJson(SearchRestaurant data) =>
    json.encode(data.toJson());

class SearchRestaurant {
  bool error;
  int founded;
  List<RestaurantSearch> restaurants;

  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantSearch>.from(
          json["restaurants"].map((x) => RestaurantSearch.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(
          restaurants.map((x) => x.toJson()),
        ),
      };
}

class RestaurantSearch {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
