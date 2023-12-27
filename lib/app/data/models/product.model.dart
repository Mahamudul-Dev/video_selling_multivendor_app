
class ProductModel {
    String? id;
    String? title;
    String? description;
    double? price;
    String? category;
    List<String>? tags;
    String? duration;
    String? thumbnail;
    String? downloadUrl;
    String? previewUrl;
    String? videoStatus;
    List<dynamic>? videoStrike;
    int? totalSales;
    int? viewsCount;
    Author? author;
    double? ratings;
    List<Review>? reviews;
    int? v;

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
        price: json["price"]?.toDouble(),
        category: json["category"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        duration: json["duration"],
        thumbnail: json["thumbnail"],
        downloadUrl: json["downloadUrl"],
        previewUrl: json["previewUrl"],
        videoStatus: json["videoStatus"],
        videoStrike: json["videoStrike"] == null ? [] : List<dynamic>.from(json["videoStrike"]!.map((x) => x)),
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
        "videoStrike": videoStrike == null ? [] : List<dynamic>.from(videoStrike!.map((x) => x)),
        "totalSales": totalSales,
        "viewsCount": viewsCount,
        "author": author?.toJson(),
        "ratings": ratings,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "__v": v,
    };
}

class Author {
    String? authorId;
    String? name;
    String? country;
    String? city;
    int? totalVideos;
    String? profilePic;

    Author({
        this.authorId,
        this.name,
        this.country,
        this.city,
        this.totalVideos,
        this.profilePic,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["authorId"],
        name: json["name"],
        country: json["country"],
        city: json["city"],
        totalVideos: json["totalVideos"] ?? 0,
        profilePic: json["profilePic"],
    );

    Map<String, dynamic> toJson() => {
        "authorId": authorId,
        "name": name,
        "country": country,
        "city": city,
        "totalVideos": totalVideos,
        "profilePic": profilePic,
    };
}

class Review {
    String? user;
    int? rating;
    String? review;
    String? id;

    Review({
        this.user,
        this.rating,
        this.review,
        this.id,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        rating: json["rating"],
        review: json["review"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "rating": rating,
        "review": review,
        "_id": id,
    };
}
