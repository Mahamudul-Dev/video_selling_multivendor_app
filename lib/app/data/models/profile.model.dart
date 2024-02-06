// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:video_selling_multivendor_app/app/data/models/product.model.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String? status;
  final String? message;
  final List<Profile>? data;

  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Profile>.from(json["data"]!.map((x) => Profile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Profile {
  final String? id;
  final String? name;
  final String? userName;
  final bool? userNameChanged;
  final String? email;
  final bool? isEmailVerified;
  final String? password;
  final String? accountType;
  final String? accountStatus;
  final String? profilePic;
  final String? about;
  final String? country;
  final String? city;
  final int? totalVideos;
  final List<String>? interest;
  final List<PurchaseList>? purchaseList;
  final List<dynamic>? creatorSubscriptionList;
  final int? favouriteItemCount;
  final int? wishlistItemCount;
  final int? cartItemCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? cartItemId;
  final String? favouriteItemId;

  Profile({
    this.id,
    this.name,
    this.userName,
    this.userNameChanged,
    this.email,
    this.isEmailVerified,
    this.password,
    this.accountType,
    this.accountStatus,
    this.profilePic,
    this.about,
    this.country,
    this.city,
    this.totalVideos,
    this.interest,
    this.purchaseList,
    this.creatorSubscriptionList,
    this.favouriteItemCount,
    this.wishlistItemCount,
    this.cartItemCount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.cartItemId,
    this.favouriteItemId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    name: json["name"],
    userName: json["userName"],
    userNameChanged: json["userNameChanged"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    password: json["password"],
    accountType: json["accountType"],
    accountStatus: json["accountStatus"],
    profilePic: json["profilePic"],
    about: json["about"],
    country: json["country"],
    city: json["city"],
    totalVideos: json["totalVideos"],
    interest: json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x)),
    purchaseList: json["purchaseList"] == null ? [] : List<PurchaseList>.from(json["purchaseList"]!.map((x) => PurchaseList.fromJson(x))),
    creatorSubscriptionList: json["creatorSubscriptionList"] == null ? [] : List<dynamic>.from(json["creatorSubscriptionList"]!.map((x) => x)),
    favouriteItemCount: json["favouriteItemCount"],
    wishlistItemCount: json["wishlistItemCount"],
    cartItemCount: json["cartItemCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    cartItemId: json["cartItemId"],
    favouriteItemId: json["favouriteItemId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "userName": userName,
    "userNameChanged": userNameChanged,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "password": password,
    "accountType": accountType,
    "accountStatus": accountStatus,
    "profilePic": profilePic,
    "about": about,
    "country": country,
    "city": city,
    "totalVideos": totalVideos,
    "interest": interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
    "purchaseList": purchaseList == null ? [] : List<dynamic>.from(purchaseList!.map((x) => x.toJson())),
    "creatorSubscriptionList": creatorSubscriptionList == null ? [] : List<dynamic>.from(creatorSubscriptionList!.map((x) => x)),
    "favouriteItemCount": favouriteItemCount,
    "wishlistItemCount": wishlistItemCount,
    "cartItemCount": cartItemCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "cartItemId": cartItemId,
    "favouriteItemId": favouriteItemId,
  };
}

class PurchaseList {
  final String? productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final String? duration;
  final int? totalSales;
  final Author? author;

  PurchaseList({
    this.productId,
    this.title,
    this.price,
    this.thumbnail,
    this.duration,
    this.totalSales,
    this.author,
  });

  factory PurchaseList.fromJson(Map<String, dynamic> json) => PurchaseList(
    productId: json["productId"],
    title: json["title"],
    price: json["price"].toDouble(),
    thumbnail: json["thumbnail"],
    duration: json["duration"],
    totalSales: json["totalSales"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "title": title,
    "price": price,
    "thumbnail": thumbnail,
    "duration": duration,
    "totalSales": totalSales,
    "author": author?.toJson(),
  };
}