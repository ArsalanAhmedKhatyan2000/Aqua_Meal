import 'package:flutter/cupertino.dart';

class OrdersModel with ChangeNotifier {
  final String? userID;
  final String? orderID;
  final DateTime? orderDate;
  final String? address;
  final int? paymentMethod;
  final int? status;
  final List<dynamic>? sellerIDs;
  OrdersModel({
    this.orderID,
    this.userID,
    this.orderDate,
    this.sellerIDs,
    this.address,
    this.paymentMethod,
    this.status,
  });

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderID: map["orderID"],
      sellerIDs: map["sellerIDs"],
      userID: map["buyerID"],
      orderDate: map["orderDate"].toDate(),
      address: map["address"],
      paymentMethod: map["paymentMethod"],
      status: map["status"],
    );
  }
}
