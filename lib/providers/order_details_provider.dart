import 'package:aqua_meal/models/order_details.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailsProvider with ChangeNotifier {
  List<OrderDetailsModel> _orderDetailsList = [];
  List<OrderDetailsModel> get getOrderDetailsList => _orderDetailsList;

  Future<void> fetchOrdersDetails() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc("3I5gqAREx3MaA4C89QvT")
        .collection("orderDetails")
        .where("buyerID", isEqualTo: Users.getUserId)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orderDetailsList = [];
      for (var document in ordersSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _orderDetailsList.insert(
          0,
          OrderDetailsModel.fromMap(dataMap, document.id),
        );
      }
    });
    notifyListeners();
  }

  Future<void> updateOrderDetailsRatingStatus(String? orderDetailsID) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc("3I5gqAREx3MaA4C89QvT")
        .collection("orderDetails")
        .doc(orderDetailsID)
        .update({
      "isRated": true,
    });
    fetchOrdersDetails();
    notifyListeners();
  }

  List<OrderDetailsModel> getItemsByOrderID(String? orderID) {
    return _orderDetailsList
        .where((element) => element.orderID == orderID)
        .toList();
  }

  // List<OrderDetailsModel> getItemsBySellerAndOrderID({
  //   String? sellerID,
  //   String? orderID,
  // }) {
  //   return _orderDetailsList
  //       .where((element) => element.orderID == orderID)
  //       .toList()
  //       .where((element) => element.sellerID == sellerID)
  //       .toList();
  // }

  double getTotalPriceByOrderID(String? orderID) {
    double total = 0;
    getItemsByOrderID(orderID).forEach((element) {
      total = total + (double.parse(element.price!) * element.quantity!);
    });
    return total;
  }

  void clearLocalOrderDetails() {
    _orderDetailsList.clear();
    notifyListeners();
  }
}
