import 'dart:convert';

class CartItemModel {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final String? price;
  final String? duration;
  final String? thumbnail;
  final String? downloadUrl;
  final String? previewUrl;
  final String? author;

  CartItemModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.duration,
    this.thumbnail,
    this.downloadUrl,
    this.previewUrl,
    this.author,
  });

  factory CartItemModel.fromRawJson(String str) =>
      CartItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      duration: json["duration"],
      thumbnail: json["thumbnail"],
      downloadUrl: json["downloadUrl"],
      previewUrl: json["previewUrl"],
      author: json["author"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "duration": duration,
        "thumbnail": thumbnail,
        "downloadUrl": downloadUrl,
        "previewUrl": previewUrl,
        "author": author
      };
}
