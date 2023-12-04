// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

import 'product.model.dart';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  final List<CartItem>? cartItems;
  final String? cartId;

  CartItemModel({
    this.cartItems,
    this.cartId,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        cartItems: json["cartItems"] == null
            ? []
            : List<CartItem>.from(
                json["cartItems"]!.map((x) => CartItem.fromJson(x))),
        cartId: json["cartId"],
      );

  Map<String, dynamic> toJson() => {
        "cartItems": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "cartId": cartId,
      };
}

class CartItem {
  final String? productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final String? duration;
  final Author? author;

  CartItem({
    this.productId,
    this.title,
    this.price,
    this.thumbnail,
    this.duration,
    this.author,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
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
