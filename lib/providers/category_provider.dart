import 'package:aqua_meal/models/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  static List<CategoryModel> _categoryList = [];

  List<CategoryModel> get getCategories {
    return _categoryList;
  }

  Future<void> fetchCategories() async {
    await FirebaseFirestore.instance
        .collection('category')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _categoryList = [];
      for (var document in productSnapshot.docs) {
        _categoryList.insert(
          0,
          CategoryModel(
            categoryID: document.id,
            categoryName: document.get('name'),
            categoryImage: document.get('image'),
          ),
        );
      }
    });
    notifyListeners();
  }

  CategoryModel findCategoryById(String categoryId) {
    return _categoryList
        .firstWhere((element) => element.categoryID == categoryId);
  }

  List<CategoryModel> searchQuery(
      String searchText, List<CategoryModel> catList) {
    return catList.where((element) {
      return element.categoryName!.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();
  }
}
