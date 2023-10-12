import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/screens/orders/components/orders_tile.dart';
import 'package:aqua_meal/widgets/build_empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    // final ordersList = ordersProvider.getOrdersList;
    final pendingOrdersList = ordersProvider.getPendingOrders(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: pendingOrdersList.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: pendingOrdersList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  SizedBox(height: getProportionateScreenHeight(10)),
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
              ),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: pendingOrdersList[index],
                child: const OrdersTile(isHistoryOrder: false),
              ),
            )
          : const EmptyScreen(
              svgImagePath: "assets/images/pending_orders.svg",
              title: "Oops! Empty Pending Orders",
              description:
                  "Sorry, there are no products in the pending orders.",
            ),
    );
  }
}
