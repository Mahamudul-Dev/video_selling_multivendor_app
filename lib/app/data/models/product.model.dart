import 'dart:convert';

class ProductModel {
  final String? id;
  final String? title;
  final String? description;
  final String? price;
  final String? category;
  final List<String>? tags;
  final String? duration;
  final String? thumbnail;
  final String? downloadUrl;
  final String? previewUrl;
  final int? totalSales;
  final String? viewsCount;
  final String? author;
  final int? ratings;
  final List<Review>? reviews;
  final DateTime? uploadTimeStamp;
  final DateTime? updateTimeStamp;
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
    this.totalSales,
    this.viewsCount,
    this.author,
    this.ratings,
    this.reviews,
    this.uploadTimeStamp,
    this.updateTimeStamp,
    this.v,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        downloadUrl: json["downloadUrl"],
        previewUrl: json["previewUrl"],
        totalSales: json["totalSales"],
        viewsCount: json["viewsCount"],
        author: json["author"],
        ratings: json["ratings"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        uploadTimeStamp: json["uploadTimeStamp"] == null
            ? null
            : DateTime.parse(json["uploadTimeStamp"]),
        updateTimeStamp: json["updateTimeStamp"] == null
            ? null
            : DateTime.parse(json["updateTimeStamp"]),
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
        "totalSales": totalSales,
        "viewsCount": viewsCount,
        "author": author,
        "ratings": ratings,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "uploadTimeStamp":
            "${uploadTimeStamp!.year.toString().padLeft(4, '0')}-${uploadTimeStamp!.month.toString().padLeft(2, '0')}-${uploadTimeStamp!.day.toString().padLeft(2, '0')}",
        "updateTimeStamp":
            "${updateTimeStamp!.year.toString().padLeft(4, '0')}-${updateTimeStamp!.month.toString().padLeft(2, '0')}-${updateTimeStamp!.day.toString().padLeft(2, '0')}",
        "__v": v,
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

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
