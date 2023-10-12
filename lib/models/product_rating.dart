import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductRatingModel with ChangeNotifier {
  final String? productID;
  final String? userID;
  final List<String>? rating;

  ProductRatingModel({
    this.productID,
    this.userID,
    this.rating,
  });
}

class ProductRatingProvider with ChangeNotifier {
  static List<ProductRatingModel> _productsRatingList = [];

  List<ProductRatingModel> get getProductsRatingList => _productsRatingList;

  fetch() async {
    await FirebaseFirestore.instance.collection("products").get().then(
      (QuerySnapshot<Map<String, dynamic>> snapshot) {
        _productsRatingList = [];
        for (var document in snapshot.docs) {
          final ratingListLength = document.get("rating").length;
          for (int i = 0; i < ratingListLength; i++) {
            _productsRatingList.insert(
              0,
              ProductRatingModel(
                productID: document.id,
                rating: document.get("rating")[i]["rating"],
                userID: document.get("rating")[i]["userID"],
              ),
            );
          }
        }
      },
    );
    notifyListeners();
  }

  List<ProductRatingModel> ratingListByProductID(String? productID) {
    return _productsRatingList
        .where((element) => element.productID == productID)
        .toList();
  }
}
