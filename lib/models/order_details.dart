import 'package:flutter/cupertino.dart';

class OrderDetailsModel with ChangeNotifier {
  final String? orderID,
      orderDetailsID,
      price,
      productID,
      sellerID,
      status,
      userID;
  final int? quantity;
  final bool? isRated;

  OrderDetailsModel({
    this.orderID,
    this.price,
    this.productID,
    this.quantity,
    this.sellerID,
    this.status,
    this.userID,
    this.isRated,
    this.orderDetailsID,
  });

  factory OrderDetailsModel.fromMap(
    Map<String, dynamic> map,
    String? orderDetailsID,
  ) {
    return OrderDetailsModel(
      orderDetailsID: orderDetailsID,
      orderID: map["orderID"],
      productID: map["productID"],
      sellerID: map["sellerID"],
      quantity: map["quantity"],
      price: map["price"],
      status: map["status"],
      userID: map["buyerID"],
      isRated: map["isRated"],
    );
  }
}
