import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String? productID;
  final String? sellerID;
  final String? productName;
  final String? regularPrice;
  final String? discountedPrice;
  final String? productDescription;
  final String? productImageUrl;
  final String? currentProductStatusValue;
  final String? category;
  final String? unit;
  final String? createdDate;
  final List? rating;

  ProductModel({
    this.productID,
    this.sellerID,
    this.productName,
    this.regularPrice,
    this.discountedPrice,
    this.productDescription,
    this.productImageUrl,
    this.currentProductStatusValue,
    this.createdDate,
    this.category,
    this.unit,
    this.rating,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String productID) {
    return ProductModel(
      productID: productID,
      productName: map["name"],
      regularPrice: map["regularPrice"],
      discountedPrice: map["discountedPrice"],
      productDescription: map["description"],
      productImageUrl: map["imageURL"],
      currentProductStatusValue: map["status"],
      createdDate: map["createdDate"],
      sellerID: map["sellerID"],
      category: map["category"],
      unit: map["unit"],
      rating: map["rating"],
    );
  }
}
