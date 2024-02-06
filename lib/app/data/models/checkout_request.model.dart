import 'dart:convert';

CheckoutRequestModel checkoutRequestModelFromJson(String str) => CheckoutRequestModel.fromJson(json.decode(str));

String checkoutRequestModelToJson(CheckoutRequestModel data) => json.encode(data.toJson());

class CheckoutRequestModel {
  final List<String>? productIds;

  CheckoutRequestModel({
    this.productIds,
  });

  factory CheckoutRequestModel.fromJson(Map<String, dynamic> json) => CheckoutRequestModel(
    productIds: json["productIds"] == null ? [] : List<String>.from(json["productIds"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "productIds": productIds == null ? [] : List<String>.from(productIds!.map((x) => x)),
  };
}
