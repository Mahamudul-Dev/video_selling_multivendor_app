import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final Profile? profile;
  final String? token;

  ProfileModel({
    this.profile,
    this.token,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
        "token": token,
      };
}

class Profile {
  final String? name;
  final String? email;
  final String? password;
  final String? profilePic;
  final int? totalVideos;
  final List<String>? interest;
  final String? acountType;
  final List<String>? purchaseList;
  final List<String>? creatorSubscriptionList;
  final int? favouriteItemCount;
  final int? wishlistItemCount;
  final int? cartItemCount;
  final String? id;

  Profile({
    this.name,
    this.email,
    this.password,
    this.profilePic,
    this.totalVideos,
    this.interest,
    this.acountType,
    this.purchaseList,
    this.creatorSubscriptionList,
    this.favouriteItemCount,
    this.wishlistItemCount,
    this.cartItemCount,
    this.id,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        totalVideos: json["totalVideos"],
        interest: json["interest"] == null
            ? []
            : List<String>.from(json["interest"]!.map((x) => x)),
        acountType: json["acountType"],
        purchaseList: json["purchaseList"] == null
            ? []
            : List<String>.from(json["purchaseList"]!.map((x) => x)),
        creatorSubscriptionList: json["creatorSubscriptionList"] == null
            ? []
            : List<String>.from(json["creatorSubscriptionList"]!.map((x) => x)),
        favouriteItemCount: json["favouriteItemCount"],
        wishlistItemCount: json["wishlistItemCount"],
        cartItemCount: json["cartItemCount"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "totalVideos": totalVideos,
        "interest":
            interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
        "acountType": acountType,
        "purchaseList": purchaseList == null
            ? []
            : List<dynamic>.from(purchaseList!.map((x) => x)),
        "creatorSubscriptionList": creatorSubscriptionList == null
            ? []
            : List<dynamic>.from(creatorSubscriptionList!.map((x) => x)),
        "favouriteItemCount": favouriteItemCount,
        "wishlistItemCount": wishlistItemCount,
        "cartItemCount": cartItemCount,
        "_id": id,
      };
}
