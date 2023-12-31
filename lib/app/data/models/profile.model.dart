// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

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
        data: json["data"] == null
            ? []
            : List<Profile>.from(json["data"]!.map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Profile {
  final String? about;
  final String? country;
  final String? city;
  final String? id;
  final String? name;
  final String? userName;
  final String? email;
  final bool? isEmailVerified;
  final bool? userNameChanged;
  final String? password;
  final String? accountType;
  final String? accountStatus;
  final String? profilePic;
  final int? totalVideos;
  final List<String>? interest;
  final List<dynamic>? purchaseList;
  final List<dynamic>? creatorSubscriptionList;
  final int? favouriteItemCount;
  final int? wishlistItemCount;
  final int? cartItemCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Profile({
    this.about,
    this.country,
    this.city,
    this.id,
    this.name,
    this.userName,
    this.email,
    this.isEmailVerified,
    this.userNameChanged,
    this.password,
    this.accountType,
    this.accountStatus,
    this.profilePic,
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
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        about: json["about"],
        country: json["country"],
        city: json["city"],
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        email: json["email"],
        isEmailVerified: json["isEmailVerified"],
        userNameChanged: json["userNameChanged"],
        password: json["password"],
        accountType: json["accountType"],
        accountStatus: json["accountStatus"],
        profilePic: json["profilePic"],
        totalVideos: json["totalVideos"],
        interest: json["interest"] == null
            ? []
            : List<String>.from(json["interest"]!.map((x) => x)),
        purchaseList: json["purchaseList"] == null
            ? []
            : List<dynamic>.from(json["purchaseList"]!.map((x) => x)),
        creatorSubscriptionList: json["creatorSubscriptionList"] == null
            ? []
            : List<dynamic>.from(
                json["creatorSubscriptionList"]!.map((x) => x)),
        favouriteItemCount: json["favouriteItemCount"],
        wishlistItemCount: json["wishlistItemCount"],
        cartItemCount: json["cartItemCount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "country": country,
        "city": city,
        "_id": id,
        "name": name,
        "userName": userName,
        "email": email,
        "isEmailVerified": isEmailVerified,
        "userNameChanged" : userNameChanged,
        "password": password,
        "accountType": accountType,
        "accountStatus": accountStatus,
        "profilePic": profilePic,
        "totalVideos": totalVideos,
        "interest":
            interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
        "purchaseList": purchaseList == null
            ? []
            : List<dynamic>.from(purchaseList!.map((x) => x)),
        "creatorSubscriptionList": creatorSubscriptionList == null
            ? []
            : List<dynamic>.from(creatorSubscriptionList!.map((x) => x)),
        "favouriteItemCount": favouriteItemCount,
        "wishlistItemCount": wishlistItemCount,
        "cartItemCount": cartItemCount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
