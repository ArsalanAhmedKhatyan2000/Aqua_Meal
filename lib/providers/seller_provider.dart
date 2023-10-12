import 'package:aqua_meal/models/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerProvider with ChangeNotifier {
  static List<SellerModel> _sellerList = [];

  List<SellerModel> get getSellers {
    return _sellerList;
  }

  Future<void> fetchSellers() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("sellers")
        .get()
        .then((QuerySnapshot productSnapshot) {
      _sellerList = [];
      for (var document in productSnapshot.docs) {
        _sellerList.insert(
          0,
          SellerModel(
            name: document.get("name"),
            email: document.get("email"),
            sellerID: document.get("userID"),
            profileImage: document.get("profileImage"),
            address: document.get("address"),
            phoneNumber: document.get("phoneNumber"),
            status: document.get("status"),
          ),
        );
      }
    });
    notifyListeners();
  }

  SellerModel findSellerById(String sellerId) {
    return _sellerList.firstWhere((element) => element.sellerID == sellerId);
  }
}
