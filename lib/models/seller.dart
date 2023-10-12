import 'package:flutter/material.dart';

class SellerModel with ChangeNotifier {
  final String? sellerID;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? profileImage;
  final int? status;

  SellerModel({
    this.sellerID,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.profileImage,
    this.status,
  });

  factory SellerModel.fromMap(Map<String, dynamic> map, String productID) {
    return SellerModel(
      sellerID: productID,
      name: map["name"],
      email: map["email"],
      // sellerID: map["userID"],
      profileImage: map["profileImage"],
      address: map["address"],
      phoneNumber: map["phoneNumber"],

      status: map['status'],
    );
  }
}
