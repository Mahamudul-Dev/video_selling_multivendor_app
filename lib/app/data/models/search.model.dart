// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

import 'product.model.dart';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
    String? message;
    List<ProductModel>? result;

    SearchResultModel({
        this.message,
        this.result,
    });

    factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
        message: json["message"],
        result: json["result"] == null ? [] : List<ProductModel>.from(json["result"]!.map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}