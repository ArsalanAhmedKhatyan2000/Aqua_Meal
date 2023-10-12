import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToWishlistButton extends StatelessWidget {
  final String? _productID;
  final bool? _isInWishlist;
  const AddToWishlistButton({
    Key? key,
    required String? productID,
    bool? isInWishlist = false,
  })  : _productID = productID,
        _isInWishlist = isInWishlist,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(_productID!);
    return GestureDetector(
      onTap: () async {
        try {
          final User? user = CRUD().getAuthInstance.currentUser;
          if (user == null) {
            GlobalMethods().showAlertMessage(
              context: context,
              title: "Not Login",
              description: "No user found, Please login first",
              rightButtonText: "Login",
              onPressedRightButton: () {
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
          if (_isInWishlist == false && _isInWishlist != null) {
            await GlobalMethods.addToWishlist(
                productId: _productID!, context: context);
          } else {
            await wishlistProvider.removeOneItem(
                wishlistId: wishlistProvider
                    .getWishlistItems[getCurrProduct.productID]!.id,
                productId: _productID!);
          }
          await wishlistProvider.fetchWishlist();
        } catch (error) {
          // GlobalMethods.errorDialog(subtitle: '$error', context: context);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Icon(
          _isInWishlist != null && _isInWishlist == true
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          size: getProportionateScreenWidth(25),
          color: _isInWishlist != null && _isInWishlist == true
              ? Colors.red
              : klightTextColor,
        ),
      ),
    );
  }
}

class AddRemoveToWishlist extends StatelessWidget {
  final String? _productID;
  final bool? _isInWishlist;
  const AddRemoveToWishlist({
    Key? key,
    required String? productID,
    bool? isInWishlist = false,
  })  : _productID = productID,
        _isInWishlist = isInWishlist,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(_productID!);
    return GestureDetector(
      onTap: () async {
        try {
          final User? user = CRUD().getAuthInstance.currentUser;
          if (user == null) {
            GlobalMethods().showAlertMessage(
              context: context,
              title: "Not Login",
              description: "No user found, Please login first",
              rightButtonText: "Login",
              onPressedRightButton: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              leftButtonText: "Cancel",
              onPressedLeftButton: () {
                Navigator.pop(context);
              },
            );
            return;
          }
          if (_isInWishlist == false && _isInWishlist != null) {
            await GlobalMethods.addToWishlist(
                productId: _productID!, context: context);
          } else {
            await wishlistProvider.removeOneItem(
                wishlistId: wishlistProvider
                    .getWishlistItems[getCurrProduct.productID]!.id,
                productId: _productID!);
          }
          await wishlistProvider.fetchWishlist();
        } catch (error) {
          // GlobalMethods.errorDialog(subtitle: '$error', context: context);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Icon(
          _isInWishlist == true
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          size: getProportionateScreenWidth(25),
          color: (context.isLightMode &&
                  _isInWishlist == true &&
                  _isInWishlist != null)
              ? Colors.red
              : (context.isLightMode &&
                      _isInWishlist == false &&
                      _isInWishlist != null)
                  ? klightTextColor
                  : (!context.isLightMode &&
                          _isInWishlist == true &&
                          _isInWishlist != null)
                      ? Colors.red
                      : kDarkTextColor,
        ),
      ),
    );
  }
}
