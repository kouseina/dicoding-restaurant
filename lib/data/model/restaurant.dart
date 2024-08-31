// To parse this JSON data, do
//
//     final restaurant = restaurantFromMap(jsonString);

import 'dart:convert';

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)["restaurants"];
  return parsed.map((json) => Restaurant.fromMap(json)).toList();
}

Restaurant restaurantFromMap(String str) =>
    Restaurant.fromMap(json.decode(str));

String restaurantToMap(Restaurant data) => json.encode(data.toMap());

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;
  final Menus? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
    Menus? menus,
  }) =>
      Restaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
        menus: menus ?? this.menus,
      );

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: json["menus"] == null ? null : Menus.fromMap(json["menus"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus?.toMap(),
      };
}

class Menus {
  final List<Drink>? foods;
  final List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  Menus copyWith({
    List<Drink>? foods,
    List<Drink>? drinks,
  }) =>
      Menus(
        foods: foods ?? this.foods,
        drinks: drinks ?? this.drinks,
      );

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Drink>.from(json["foods"]!.map((x) => Drink.fromMap(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods!.map((x) => x.toMap())),
        "drinks": drinks == null
            ? []
            : List<dynamic>.from(drinks!.map((x) => x.toMap())),
      };
}

class Drink {
  final String? name;

  Drink({
    this.name,
  });

  Drink copyWith({
    String? name,
  }) =>
      Drink(
        name: name ?? this.name,
      );

  factory Drink.fromMap(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
