// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'dart:convert';

import 'product.model.dart';

FavouriteModel favouriteModelFromJson(String str) =>
    FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  final List<FavouriteItem>? favouriteItems;
  final String? favouriteId;

  FavouriteModel({
    this.favouriteItems,
    this.favouriteId,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        favouriteItems: json["favouriteItems"] == null
            ? []
            : List<FavouriteItem>.from(
                json["favouriteItems"]!.map((x) => FavouriteItem.fromJson(x))),
        favouriteId: json["favouriteId"],
      );

  Map<String, dynamic> toJson() => {
        "favouriteItems": favouriteItems == null
            ? []
            : List<dynamic>.from(favouriteItems!.map((x) => x.toJson())),
        "favouriteId": favouriteId,
      };
}

class FavouriteItem {
  final String? productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final String? duration;
  final Author? author;

  FavouriteItem({
    this.productId,
    this.title,
    this.price,
    this.thumbnail,
    this.duration,
    this.author,
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> json) => FavouriteItem(
        productId: json["productId"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        thumbnail: json["thumbnail"],
        duration: json["duration"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "price": price,
        "thumbnail": thumbnail,
        "duration": duration,
        "author": author?.toJson(),
      };
}
