import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .orderBy("rating", descending: false)
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      for (var document in productSnapshot.docs) {
        _productsList.insert(
          0,
          ProductModel(
            productID: document.id,
            productName: document.get("name"),
            regularPrice: document.get("regularPrice"),
            discountedPrice: document.get("discountedPrice"),
            productDescription: document.get("description"),
            productImageUrl: document.get("imageURL"),
            currentProductStatusValue: document.get("status"),
            createdDate: document.get("createdDate"),
            sellerID: document.get("sellerID"),
            category: document.get("category"),
            unit: document.get("unit"),
            rating: document.get("rating"),
          ),
        );
      }
    });
    notifyListeners();
  }

  Future<void> addAndUpdateRating(
      {required String? productID, required List<dynamic>? ratingList}) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productID)
        .update({
      "rating": ratingList,
    });
    fetchProducts();
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList
        .where((element) => element.discountedPrice!.isNotEmpty)
        .toList();
  }

  List<ProductModel> get getTopRatedProducts {
    List<ProductModel> ratedProductsList =
        _productsList.where((element) => element.rating!.isNotEmpty).toList();
    ratedProductsList.sort((b, a) =>
        ratingCalculator(a.rating!)!.compareTo(ratingCalculator(b.rating!)!));
    return ratedProductsList;
  }

  ProductModel findProdById(String productId) {
    return _productsList
        .firstWhere((element) => element.productID == productId);
  }

  double? sellerRatingWRTproducts(String sellerID) {
    List<ProductModel> sellerProducts =
        _productsList.where((element) => element.sellerID == sellerID).toList();
    double? sellerProductsRatingList = 0;
    int sellerProductsLength = 0;
    for (var sellerProducts in sellerProducts) {
      sellerProductsRatingList =
          ratingCalculator(sellerProducts.rating!)! + sellerProductsRatingList!;
      sellerProductsLength += 1;
    }
    double sellerRating = double.parse(
        (sellerProductsRatingList! / sellerProductsLength).toStringAsFixed(1));
    return sellerRating;
  }

  List<ProductModel> findProdByCategory(String productCateogry) {
    return _productsList
        .where((element) => element.category == productCateogry)
        .toList();
  }

  List<ProductModel> searchQuery(
      String searchText, List<ProductModel> productsList) {
    return productsList.where((element) {
      return element.productName!.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();
    // return searchList;
  }
}
