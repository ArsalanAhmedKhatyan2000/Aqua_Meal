import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  final String? categoryID;
  final String? categoryName;
  final String? categoryImage;

  CategoryModel({
    this.categoryID,
    this.categoryName,
    this.categoryImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map, String productID) {
    return CategoryModel(
      categoryID: productID,
      categoryName: map["name"],
      categoryImage: map["image"],
    );
  }
}
