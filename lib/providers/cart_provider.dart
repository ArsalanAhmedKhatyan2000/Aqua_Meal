import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/models/cart.dart';
import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance
      .collection("users")
      .doc("WvamEGwHsbNkF3KImk2V")
      .collection("buyer");

  Future<void> fetchCart() async {
    final User? user = CRUD().getAuthInstance.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await userCollection.doc(user!.uid).get();
    if (!userDoc.exists) {
      return;
    }
    final leng = userDoc.get('cartList').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('cartList')[i]['productId'],
          () => CartModel(
                id: userDoc.get('cartList')[i]['cartId'],
                productId: userDoc.get('cartList')[i]['productId'],
                quantity: userDoc.get('cartList')[i]['quantity'],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );

    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = CRUD().getAuthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'cartList': FieldValue.arrayRemove([
        {'cartId': cartId, 'productId': productId, 'quantity': quantity}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnlineCart() async {
    final User? user = CRUD().getAuthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'cartList': [],
    });
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double totalPrice({required BuildContext context}) {
    double totalProductsPrice = 0.0;
    final productProvider = Provider.of<ProductsProvider>(context);
    _cartItems.forEach((key, value) {
      final ProductModel getCurrProduct =
          productProvider.findProdById(value.productId);
      totalProductsPrice += (getCurrProduct.discountedPrice!.isNotEmpty
              ? double.parse(getCurrProduct.discountedPrice!)
              : double.parse(getCurrProduct.regularPrice!)) *
          value.quantity;
    });
    return totalProductsPrice;
  }

  List<String> sellersIDListOfProducts({required BuildContext context}) {
    List<String> sellersIDListOfProducts = [];
    final productProvider = Provider.of<ProductsProvider>(context);
    _cartItems.forEach((key, value) {
      final ProductModel getCurrProduct =
          productProvider.findProdById(value.productId);
      if (sellersIDListOfProducts.contains(getCurrProduct.sellerID!) == false) {
        sellersIDListOfProducts.add(getCurrProduct.sellerID!);
      }
    });
    return sellersIDListOfProducts;
  }
}
