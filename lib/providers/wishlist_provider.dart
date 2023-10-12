import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/models/wishlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  // void addRemoveProductToWishlist({required String productId}) {
  //   if (_wishlistItems.containsKey(productId)) {
  //     removeOneItem(productId);
  //   } else {
  //     _wishlistItems.putIfAbsent(
  //         productId,
  //         () => WishlistModel(
  //             id: DateTime.now().toString(), productId: productId));
  //   }
  //   notifyListeners();
  // }

  final userCollection = FirebaseFirestore.instance
      .collection("users")
      .doc("WvamEGwHsbNkF3KImk2V")
      .collection("buyer");

  Future<void> fetchWishlist() async {
    final User? user = CRUD().getAuthInstance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (!userDoc.exists) {
      return;
    }
    final leng = userDoc.get('wishlist').length;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('wishlist')[i]['productId'],
          () => WishlistModel(
                id: userDoc.get('wishlist')[i]['wishlistId'],
                productId: userDoc.get('wishlist')[i]['productId'],
              ));
    }
    notifyListeners();
  }

  Future<void> removeOneItem({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = CRUD().getAuthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'wishlist': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistId,
          'productId': productId,
        }
      ])
    });
    _wishlistItems.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }

  Future<void> clearOnlineWishlist() async {
    final User? user = CRUD().getAuthInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'wishlist': [],
    });
    _wishlistItems.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
