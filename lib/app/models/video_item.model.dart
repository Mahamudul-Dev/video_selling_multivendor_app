import 'dart:convert';

class VideoItemModel {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final List<String>? tags;
  final String? price;
  final String? duration;
  final String? thumbnail;
  final String? downloadUrl;
  final String? previewUrl;
  final int? totalSale;
  final String? viewsCount;
  final DateTime? uploadTimestamp;
  final DateTime? updateTimestamp;
  final Author? author;
  final Ratings? ratings;
  final List<Author>? reviews;

  VideoItemModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.tags,
    this.price,
    this.duration,
    this.thumbnail,
    this.downloadUrl,
    this.previewUrl,
    this.totalSale,
    this.viewsCount,
    this.uploadTimestamp,
    this.updateTimestamp,
    this.author,
    this.ratings,
    this.reviews,
  });

  factory VideoItemModel.fromRawJson(String str) =>
      VideoItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoItemModel.fromJson(Map<String, dynamic> json) => VideoItemModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        price: json["price"],
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        downloadUrl: json["downloadUrl"],
        previewUrl: json["previewUrl"],
        totalSale: json["totalSale"],
        viewsCount: json["viewsCount"],
        uploadTimestamp: json["uploadTimestamp"] == null
            ? null
            : DateTime.parse(json["uploadTimestamp"]),
        updateTimestamp: json["updateTimestamp"] == null
            ? null
            : DateTime.parse(json["updateTimestamp"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        reviews: json["reviews"] == null
            ? []
            : List<Author>.from(
                json["reviews"]!.map((x) => Author.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "category": category,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "price": price,
        "duration": duration,
        "thumbnail": thumbnail,
        "downloadUrl": downloadUrl,
        "previewUrl": previewUrl,
        "totalSale": totalSale,
        "viewsCount": viewsCount,
        "uploadTimestamp": uploadTimestamp?.toIso8601String(),
        "updateTimestamp": updateTimestamp?.toIso8601String(),
        "author": author?.toJson(),
        "ratings": ratings?.toJson(),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Author {
  final String? id;
  final String? name;
  final String? userName;
  final String? profilePhoto;
  final String? country;
  final String? city;
  final String? totalVideos;
  final String? reviewText;
  final int? rating;

  Author({
    this.id,
    this.name,
    this.userName,
    this.profilePhoto,
    this.country,
    this.city,
    this.totalVideos,
    this.reviewText,
    this.rating,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        profilePhoto: json["profilePhoto"],
        country: json["country"],
        city: json["city"],
        totalVideos: json["totalVideos"],
        reviewText: json["reviewText"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "profilePhoto": profilePhoto,
        "country": country,
        "city": city,
        "totalVideos": totalVideos,
        "reviewText": reviewText,
        "rating": rating,
      };
}

class Ratings {
  final int? fiveStarCount;
  final int? fourStarCount;
  final int? threeStarCount;
  final int? twoStarCount;
  final int? oneStarCount;

  Ratings({
    this.fiveStarCount,
    this.fourStarCount,
    this.threeStarCount,
    this.twoStarCount,
    this.oneStarCount,
  });

  factory Ratings.fromRawJson(String str) => Ratings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        fiveStarCount: json["fiveStarCount"],
        fourStarCount: json["fourStarCount"],
        threeStarCount: json["threeStarCount"],
        twoStarCount: json["twoStarCount"],
        oneStarCount: json["oneStarCount"],
      );

  Map<String, dynamic> toJson() => {
        "fiveStarCount": fiveStarCount,
        "fourStarCount": fourStarCount,
        "threeStarCount": threeStarCount,
        "twoStarCount": twoStarCount,
        "oneStarCount": oneStarCount,
      };
}
