// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

import 'product.model.dart';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  final List<WishlistItem>? wishlistItems;
  final String? wishlistId;

  WishlistModel({
    this.wishlistItems,
    this.wishlistId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        wishlistItems: json["wishlistItems"] == null
            ? []
            : List<WishlistItem>.from(
                json["wishlistItems"]!.map((x) => WishlistItem.fromJson(x))),
        wishlistId: json["wishlistId"],
      );

  Map<String, dynamic> toJson() => {
        "wishlistItems": wishlistItems == null
            ? []
            : List<dynamic>.from(wishlistItems!.map((x) => x.toJson())),
        "wishlistId": wishlistId,
      };
}

class WishlistItem {
  final String? productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final String? duration;
  final Author? author;

  WishlistItem({
    this.productId,
    this.title,
    this.price,
    this.thumbnail,
    this.duration,
    this.author,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        productId: json["productId"],
        title: json["title"],
        price: json["price"],
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
