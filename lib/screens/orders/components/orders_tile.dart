import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/orders.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/screens/orders_details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersTile extends StatelessWidget {
  final bool? _isHistoryOrder;
  const OrdersTile({Key? key, bool? isHistoryOrder = false})
      : _isHistoryOrder = isHistoryOrder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final orderDetailsItems =
        orderDetailsProvider.getItemsByOrderID(ordersModel.orderID!);
    double totalPrice =
        orderDetailsProvider.getTotalPriceByOrderID(ordersModel.orderID!);
    double grossTotal =
        totalPrice + (ordersModel.sellerIDs!.length * deliveryPrice);
    // + orderTax;
    Color textColor = context.isLightMode
        ? Theme.of(context).textTheme.bodyText1!.color!
        : whiteColor.withOpacity(0.7);
    Color greenColor =
        context.isLightMode ? Colors.green : Colors.green.withOpacity(0.7);

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            OrdersDetails.routeName,
            arguments: [ordersModel.orderID, _isHistoryOrder],
          );
        },
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          height: getProportionateScreenHeight(80),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(20))),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Order ID: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                            fontSize: getProportionateScreenWidth(12),
                          ),
                        ),
                        TextSpan(
                          text: ordersModel.orderID,
                          style: TextStyle(
                            color: textColor,
                            fontSize: getProportionateScreenWidth(12),
                          ),
                        ),
                      ]),
                    ),
                    Text(
                      "$grossTotal Rs",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color:
                            _isHistoryOrder == false ? Colors.red : greenColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "No. of Products: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    TextSpan(
                      text: orderDetailsItems.length.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/images/cash_on_delivery.svg",
                              color: greenColor,
                              fit: BoxFit.cover,
                              width: getProportionateScreenWidth(15),
                              height: getProportionateScreenHeight(15),
                            ),
                            SizedBox(width: getProportionateScreenWidth(5)),
                            Text(
                              ordersModel.paymentMethod == 0
                                  ? "Cash on Delivery"
                                  : "Online Payment",
                              style: TextStyle(
                                color: greenColor,
                                fontSize: getProportionateScreenWidth(12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              _isHistoryOrder == false
                                  ? Icons.access_time_outlined
                                  : Icons.check_circle_rounded,
                              color: _isHistoryOrder == false
                                  ? Colors.red
                                  : greenColor,
                              size: getProportionateScreenWidth(15),
                            ),
                            SizedBox(width: getProportionateScreenWidth(5)),
                            Text(
                              DateFormat("d-M-y")
                                  .add_jm()
                                  .format(ordersModel.orderDate!),
                              style: TextStyle(
                                color: textColor,
                                fontSize: getProportionateScreenWidth(12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
