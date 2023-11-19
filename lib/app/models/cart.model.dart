// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  final List<CartItemModel>? cartItems;
  final String? cartId;

  CartModel({
    this.cartItems,
    this.cartId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartItems: json["cartItems"] == null
            ? []
            : List<CartItemModel>.from(
                json["cartItems"]!.map((x) => CartItemModel.fromJson(x))),
        cartId: json["cartId"],
      );

  Map<String, dynamic> toJson() => {
        "cartItems": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "cartId": cartId,
      };
}

class CartItemModel {
  final String? productId;
  final String? title;
  final String? price;
  final String? thumbnail;
  final String? duration;
  final Author? author;

  CartItemModel({
    this.productId,
    this.title,
    this.price,
    this.thumbnail,
    this.duration,
    this.author,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
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

class Author {
  final String? name;
  final String? profilePic;
  final String? country;
  final String? city;

  Author({
    this.name,
    this.profilePic,
    this.country,
    this.city,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        profilePic: json["profilePic"],
        country: json["country"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePic": profilePic,
        "country": country,
        "city": city,
      };
}
