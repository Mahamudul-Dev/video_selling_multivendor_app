// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    final String? id;
    final String? title;
    final String? description;
    final double? price;
    final String? category;
    final List<String>? tags;
    final String? duration;
    final String? thumbnail;
    final String? downloadUrl;
    final String? previewUrl;
    final String? videoStatus;
    final int? videoStrike;
    final int? totalSales;
    final String? viewsCount;
    final Author? author;
    final double? ratings;
    final List<Review>? reviews;
    final int? v;

    ProductModel({
        this.id,
        this.title,
        this.description,
        this.price,
        this.category,
        this.tags,
        this.duration,
        this.thumbnail,
        this.downloadUrl,
        this.previewUrl,
        this.videoStatus,
        this.videoStrike,
        this.totalSales,
        this.viewsCount,
        this.author,
        this.ratings,
        this.reviews,
        this.v,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        category: json["category"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        downloadUrl: json["downloadUrl"],
        previewUrl: json["previewUrl"],
        videoStatus: json["videoStatus"],
        videoStrike: json["videoStrike"],
        totalSales: json["totalSales"],
        viewsCount: json["viewsCount"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        ratings: json["ratings"].toDouble(),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "category": category,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "duration": duration,
        "thumbnail": thumbnail,
        "downloadUrl": downloadUrl,
        "previewUrl": previewUrl,
        "videoStatus": videoStatus,
        "videoStrike": videoStrike,
        "totalSales": totalSales,
        "viewsCount": viewsCount,
        "author": author?.toJson(),
        "ratings": ratings,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "__v": v,
    };
}

class Author {
    final String? id;
    final String? name;
    final String? country;
    final String? city;
    final int? totalVideos;
    final String? profilePic;

    Author({
      this.id,
        this.name,
        this.country,
        this.city,
        this.totalVideos,
        this.profilePic,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
      id: json["_id"],
        name: json["name"],
        country: json["country"],
        city: json["city"],
        totalVideos: json["totalVideos"],
        profilePic: json["profilePic"],
    );

    Map<String, dynamic> toJson() => {
      "_id": id,
        "name": name,
        "country": country,
        "city": city,
        "totalVideos": totalVideos,
        "profilePic": profilePic,
    };
}

class Review {
    final String? text;
    final int? rating;
    final String? reviewer;

    Review({
        this.text,
        this.rating,
        this.reviewer,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        text: json["text"],
        rating: json["rating"],
        reviewer: json["reviewer"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "rating": rating,
        "reviewer": reviewer,
    };
}
