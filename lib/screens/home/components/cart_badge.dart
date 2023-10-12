import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/screens/cart/cart.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isUserNull =
        CRUD().getAuthInstance.currentUser == null ? true : false;
    return GestureDetector(
      onTap: () {
        if (isUserNull == true) {
          GlobalMethods().showAlertMessage(
            context: context,
            title: "Not Login",
            description: "No user found, Please login first",
            rightButtonText: "Login",
            onPressedRightButton: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Login.routeName);
            },
            leftButtonText: "Cancel",
            onPressedLeftButton: () {
              Navigator.pop(context);
            },
          );
          return;
        }
        Navigator.of(context, rootNavigator: true).pushNamed(Cart.routeName);
      },
      child: Container(
        width: getProportionateScreenWidth(40),
        alignment: Alignment.centerLeft,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Icon(
              CupertinoIcons.cart,
              size: getProportionateScreenWidth(25),
            ),
            Positioned(
              right: 0,
              top: getProportionateScreenWidth(5),
              child: Container(
                height: getProportionateScreenWidth(20),
                width: getProportionateScreenWidth(20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  cartProvider.getCartItems.length.toString(),
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
