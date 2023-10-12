import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/cart.dart';
import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_label_with_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    bool isCartEmpty = cartItemsList.isEmpty ? true : false;
    final productProvider = Provider.of<ProductsProvider>(context);
    List<String> sellersIDListOfProducts = [];
    double totalProductsPrice = 0.0;
    //
    cartProvider.getCartItems.forEach((key, value) {
      final ProductModel getCurrProduct =
          productProvider.findProdById(value.productId);
      totalProductsPrice += (getCurrProduct.discountedPrice!.isNotEmpty
              ? double.parse(getCurrProduct.discountedPrice!)
              : double.parse(getCurrProduct.regularPrice!)) *
          value.quantity;
      if (sellersIDListOfProducts.contains(getCurrProduct.sellerID!) == false) {
        sellersIDListOfProducts.add(getCurrProduct.sellerID!);
      }
    });
    //
    double tax = cartProvider.getCartItems.isNotEmpty ? orderTax : 0;
    double discount = discountPercentage;
    double deliveryCharges =
        deliveryPrice * sellersIDListOfProducts.length.toDouble();
    double grossTotal = totalProductsPrice + tax + discount + deliveryCharges;
    return Visibility(
      visible: cartItemsList.isEmpty ? false : true,
      child: Container(
        height: SizeConfig.screenHeight * 0.35,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(30)),
            topLeft: Radius.circular(getProportionateScreenWidth(30)),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: getProportionateScreenWidth(1),
            left: getProportionateScreenWidth(1),
            right: getProportionateScreenWidth(1),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(getProportionateScreenWidth(30)),
              topLeft: Radius.circular(getProportionateScreenWidth(30)),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BuildLabelWithValue(
                label: "Quantity",
                value: "${cartProvider.getCartItems.length}",
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              BuildLabelWithValue(
                label: "Price",
                value: "$totalProductsPrice Rs",
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              BuildLabelWithValue(
                label: "Discount",
                value: "$discount %",
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              BuildLabelWithValue(
                label: "Delivery Charges",
                value: "$deliveryCharges Rs",
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              BuildLabelWithValue(
                label: "Tax",
                value: "$tax Rs",
              ),
              const Divider(color: Colors.black),
              BuildLabelWithValue(
                label: "Total Amount",
                value: "$grossTotal Rs",
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              CustomLargeButton(
                text: "Check Out",
                isDisable: isCartEmpty,
                buttonColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  GlobalMethods().showIconLoading(context: context);
                  String orderID =
                      DateTime.now().microsecondsSinceEpoch.toString();

                  DocumentReference collectionRef = FirebaseFirestore.instance
                      .collection("orders")
                      .doc("3I5gqAREx3MaA4C89QvT");

                  await collectionRef.collection("orders").add({
                    "orderID": orderID,
                    "orderDate": DateTime.now(),
                    "sellerIDs": sellersIDListOfProducts,
                    "buyerID": Users.getUserId,
                    "address": Users.getAddress,
                    "paymentMethod": 0, //0 indicates cash on delivery
                    "status": 0,
                  });
                  for (CartModel cartItem in cartItemsList) {
                    final getCurrProduct =
                        productProvider.findProdById(cartItem.productId);
                    final String? productPrice =
                        getCurrProduct.discountedPrice!.isNotEmpty
                            ? getCurrProduct.discountedPrice
                            : getCurrProduct.regularPrice;
                    await collectionRef.collection("orderDetails").add({
                      "orderID": orderID,
                      "price": productPrice,
                      "quantity": cartItem.quantity,
                      "sellerID": getCurrProduct.sellerID,
                      "productID": cartItem.productId,
                      "status": "0",
                      "isRated": false,
                      "buyerID": Users.getUserId,
                    });
                  }
                  await cartProvider.clearOnlineCart();
                  cartProvider.clearLocalCart();
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: SizedBox(
                        height: getProportionateScreenHeight(70),
                        width: getProportionateScreenWidth(70),
                        child: SvgPicture.asset(
                          "assets/images/tick.svg",
                          fit: BoxFit.fitHeight,
                          color: Colors.green,
                        ),
                      ),
                      content: Column(
                        children: [
                          Text(
                            "Congratulations!",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: getProportionateScreenWidth(20),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Text(
                            "Order placed successfully, please check your order details at orders feature.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        BuildSmallButton(
                          text: "Ok",
                          backgroundcolor: Colors.green.withOpacity(0.7),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      elevation: 0,
                      scrollable: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      actionsPadding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(10)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10),
                          horizontal: getProportionateScreenWidth(24)),
                    ),
                  );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/images/cash_on_delivery.svg",
                    color: kLightPrimaryColor,
                    fit: BoxFit.cover,
                    width: getProportionateScreenWidth(20),
                    height: getProportionateScreenHeight(20),
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      color: klightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
