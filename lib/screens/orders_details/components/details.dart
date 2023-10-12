import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/widgets/build_label_with_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({super.key, required String? orderID, required bool? isHistory})
      : _orderID = orderID,
        _isHistory = isHistory;
  final String? _orderID;
  final bool? _isHistory;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final orderModel = ordersProvider.getOrdersByOrderID(_orderID);
    final orderDetailsItems = orderDetailsProvider.getItemsByOrderID(_orderID);
    final double price = orderDetailsProvider.getTotalPriceByOrderID(_orderID);
    final double deliveryCharges =
        (orderModel.sellerIDs!.length * deliveryPrice);
    // const double tax = orderTax;
    const double discount = discountPercentage;
    final totalAmount = price + deliveryCharges;
    // + tax;

    return Container(
      // height: SizeConfig.screenHeight * 0.35,
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
              label: "Status",
              // value: orderModel.status == 0 ? "Pending" : "Delivered",
              value: _isHistory == false ? "Pending" : "Delivered",
            ),
            // BuildLabelWithValue(
            //   label: "Quantity",
            //   value: "${orderDetailsItems.length}",
            // ),
            SizedBox(height: getProportionateScreenHeight(5)),
            BuildLabelWithValue(
              label: "Price",
              value: "$price Rs",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            const BuildLabelWithValue(
              label: "Discount",
              value: "$discount %",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            BuildLabelWithValue(
              label: "Delivery Charges",
              value: "$deliveryCharges Rs",
            ),
            // SizedBox(height: getProportionateScreenHeight(5)),
            // const BuildLabelWithValue(
            //   label: "Tax",
            //   value: "$tax Rs",
            // ),
            const Divider(color: Colors.black),
            BuildLabelWithValue(
              label: "Total Amount",
              value: "$totalAmount Rs",
            ),
            const Divider(color: Colors.black),
            SizedBox(height: getProportionateScreenHeight(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: kLightPrimaryColor,
                  size: getProportionateScreenWidth(20),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    orderModel.address!,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      color: klightTextColor,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      orderModel.paymentMethod == 0
                          ? "Cash on Delivery"
                          : "Online Payment",
                      style: TextStyle(
                        color: klightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Order Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kLightPrimaryColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    TextSpan(
                      text: DateFormat("d-M-y")
                          .add_jm()
                          .format(orderModel.orderDate!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: klightTextColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
          ],
        ),
      ),
    );
  }
}
