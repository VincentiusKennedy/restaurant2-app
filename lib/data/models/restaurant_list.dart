import "dart:convert";

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  bool error;
  String message;
  int count;
  List<RestaurantList> restaurant;

  Restaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurant,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurant: List<RestaurantList>.from(
            json["restaurants"].map((x) => RestaurantList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurant.map((e) => e.toJson())),
      };
}

class RestaurantList {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
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
