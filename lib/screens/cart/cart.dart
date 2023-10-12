import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/screens/cart/components/cart_tile.dart';
import 'package:aqua_meal/screens/cart/components/checkout_section.dart';
import 'package:aqua_meal/widgets/build_empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static const String routeName = "/Cart";
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Cart (${cartItemsList.length.toString()})",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods().showAlertMessage(
                  context: context,
                  title: "Empty your cart?",
                  description: "Are you sure, you want to clear your cart?",
                  rightButtonText: "OK",
                  onPressedRightButton: () async {
                    await cartProvider.clearOnlineCart().then((value) {
                      cartProvider.clearLocalCart();
                      Navigator.pop(context);
                    });
                  },
                  leftButtonText: "Cancel",
                  onPressedLeftButton: () {
                    Navigator.pop(context);
                  },
                );
              },
              icon: const Icon(Icons.delete),
            )
          ],
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
                  child: cartItemsList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cartItemsList.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                              height: getProportionateScreenHeight(10)),
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10),
                          ),
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                                  value: cartItemsList[index],
                                  child: CartTile(
                                    quantity: cartItemsList[index].quantity,
                                  )),
                        )
                      : const EmptyScreen(
                          svgImagePath: "assets/images/empty_cart.svg",
                          title: "Oops! Empty Cart",
                          description:
                              "Sorry, there are no products in the Cart.",
                        ),
                ),
              ),
              const CheckoutSection(),
            ],
          ),
        ),
      ),
    );
  }
}
