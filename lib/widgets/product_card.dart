import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/seller_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/widgets/product_image.dart';
import 'package:aqua_meal/widgets/sales_flag.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:aqua_meal/screens/product_details/product_details.dart';
import 'package:aqua_meal/widgets/add_to_wishlist_button.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_price_lebel_with_unit.dart';
import 'package:aqua_meal/widgets/build_star_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(productModel.productID);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.productID);
    final sellerProvider = Provider.of<SellerProvider>(context);
    final getCurrSeller = sellerProvider.findSellerById(productModel.sellerID!);
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(getProportionateScreenWidth(10)))),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
              Radius.circular(getProportionateScreenWidth(10))),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
                ProductDetails.routeName,
                arguments: productModel.productID);
          },
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProductTileImage(
                    imageURL: productModel.productImageUrl,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(8),
                      vertical: getProportionateScreenHeight(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.productName!.capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenWidth(15),
                          ),
                        ),
                        BuildStarRating(
                          ratingValue: ratingCalculator(productModel.rating!),
                          starSize: 15,
                          isRatingValueVisible: false,
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        BuildPriceLebelWithUnit(
                          regularPrice: productModel.regularPrice,
                          discountedPrice: productModel.discountedPrice,
                          unit: productModel.unit!.toLowerCase(),
                          smallTextFontSize: 12,
                          largeTextFontSize: 15,
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        BuildSmallButton(
                          text: isInCart ? "In Cart" : "Add to Cart",
                          isDisable:
                              (productModel.currentProductStatusValue == "0" ||
                                      getCurrSeller.status == 0)
                                  ? true
                                  : false,
                          onPressed: (isInCart)
                              ? null
                              : () async {
                                  final User? user =
                                      CRUD().getAuthInstance.currentUser;

                                  if (user == null) {
                                    GlobalMethods().showAlertMessage(
                                      context: context,
                                      title: "Not Login",
                                      description:
                                          "No user found, Please login first",
                                      rightButtonText: "Login",
                                      onPressedRightButton: () {
                                        Navigator.pop(context);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(Login.routeName);
                                      },
                                      leftButtonText: "Cancel",
                                      onPressedLeftButton: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    return;
                                  }
                                  await GlobalMethods.addToCart(
                                      productId: productModel.productID!,
                                      quantity: 1,
                                      context: context);
                                  await cartProvider.fetchCart();
                                },
                          backgroundcolor: context.isLightMode
                              ? Theme.of(context).primaryColor
                              : whiteColor.withOpacity(0.7),
                          textColor: context.isLightMode
                              ? kDarkTextColor
                              : klightTextColor,
                          height: getProportionateScreenHeight(30),
                          width: getProportionateScreenWidth(150),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible:
                        productModel.discountedPrice!.isEmpty ? false : true,
                    child: SalesFlag(
                      salePercent: salesCalculator(
                        regularPrice: productModel.regularPrice,
                        discountedPrice: productModel.discountedPrice,
                      ),
                    ),
                  ),
                  AddToWishlistButton(
                    productID: productModel.productID!,
                    isInWishlist: isInWishlist,
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

double? ratingCalculator(List ratingList) {
  double ratingValue = 0;
  int count = 0;
  if (ratingList.isNotEmpty) {
    for (String? value in ratingList) {
      ratingValue = ratingValue + double.parse(value!);
      count += 1;
    }
    ratingValue = ratingValue / count;
    int decimalValue =
        int.parse((ratingValue - ratingValue.truncate()).toString()[2]);
    double value = 0;
    switch (decimalValue) {
      case 1:
        value = 0.0;
        break;
      case 2:
        value = 0.0;
        break;
      case 3:
        value = 0.0;
        break;
      case 4:
        value = 0.5;
        break;
      case 5:
        value = 0.5;
        break;
      case 6:
        value = 0.5;
        break;
      case 7:
        value = 0.5;
        break;
      case 8:
        value = 0.5;
        break;
      case 9:
        value = 1;
        break;
      default:
        value = 0.0;
        break;
    }

    return (ratingValue.truncate() + value);
  } else {
    return 0;
  }
}

String salesCalculator({String? regularPrice, String? discountedPrice}) {
  double result = 0;
  if (discountedPrice!.isNotEmpty) {
    result = 100 -
        ((double.parse(discountedPrice) / double.parse(regularPrice!)) * 100);
    return (result.ceil()).toString();
  } else {
    return result.toString();
  }
}
