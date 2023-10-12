import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/screens/orders_details/components/details.dart';
import 'package:aqua_meal/screens/orders_details/components/order_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersDetails extends StatelessWidget {
  static const String routeName = "/OrdersDetails";
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final orderID = arguments[0] as String;
    final isHistory = arguments[1] as bool;
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final orderDetailsItems = orderDetailsProvider.getItemsByOrderID(orderID);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details (${orderDetailsItems.length})",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        bottomOpacity: 0,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: orderDetailsItems.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: getProportionateScreenHeight(10)),
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                  ),
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: orderDetailsItems[index],
                    child: const OrderDetailsTile(),
                  ),
                ),
              ),
            ),
            Details(orderID: orderID, isHistory: isHistory),
          ],
        ),
      ),
    );
  }
}
