import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/seller_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:aqua_meal/screens/product_details/build_product_image.dart';
import 'package:aqua_meal/widgets/add_to_wishlist_button.dart';
import 'package:aqua_meal/widgets/build_custom_back_button.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_price_lebel_with_unit.dart';
import 'package:aqua_meal/widgets/build_star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = "/ProductDetails";

  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1!.color!;
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);
    final sellerProvider = Provider.of<SellerProvider>(context);
    final getCurrSeller =
        sellerProvider.findSellerById(getCurrProduct.sellerID!);
    //Wishlist
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productId);
    //Cart
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrProduct.productID);
    final double? productRating = ratingCalculator(getCurrProduct.rating!);
    SizeConfig().init(context);

    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        extendBody: true,
        bottomSheet: Container(
          height: getProportionateScreenHeight(50),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(getProportionateScreenWidth(20)),
              topRight: Radius.circular(getProportionateScreenWidth(20)),
            ),
          ),
          child: Container(
            height: getProportionateScreenHeight(50),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getProportionateScreenWidth(20)),
                topRight: Radius.circular(getProportionateScreenWidth(20)),
              ),
            ),
            margin: EdgeInsets.only(
              top: getProportionateScreenWidth(1),
              right: getProportionateScreenWidth(1),
              left: getProportionateScreenWidth(1),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BuildPriceLebelWithUnit(
                  regularPrice: getCurrProduct.regularPrice,
                  discountedPrice: getCurrProduct.discountedPrice,
                  unit: getCurrProduct.unit,
                  smallTextFontSize: getProportionateScreenWidth(12),
                  largeTextFontSize: getProportionateScreenWidth(18),
                ),
                BuildSmallButton(
                  text: isInCart ? "In Cart" : "Add to Cart",
                  isDisable: (getCurrProduct.currentProductStatusValue == "0" ||
                          getCurrSeller.status == 0)
                      ? true
                      : false,
                  backgroundcolor: context.isLightMode
                      ? Theme.of(context).primaryColor
                      : whiteColor.withOpacity(0.7),
                  textColor:
                      context.isLightMode ? kDarkTextColor : klightTextColor,
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(130),
                  onPressed: isInCart
                      ? null
                      : () async {
                          final User? user = CRUD().getAuthInstance.currentUser;

                          if (user == null) {
                            GlobalMethods().showAlertMessage(
                              context: context,
                              title: "Not Login",
                              description: "No user found, Please login first",
                              rightButtonText: "Login",
                              onPressedRightButton: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                              leftButtonText: "Cancel",
                              onPressedLeftButton: () {
                                Navigator.pop(context);
                              },
                            );
                            return;
                          }
                          await GlobalMethods.addToCart(
                              productId: getCurrProduct.productID!,
                              quantity: 1,
                              context: context);
                          await cartProvider.fetchCart();
                        },
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  BuildProductImage(
                    productID: 2.toString(),
                    productImageUrl: getCurrProduct.productImageUrl,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrProduct.productName!,
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: getProportionateScreenWidth(20),
                                ),
                              ),
                            ),
                            AddRemoveToWishlist(
                              productID: getCurrProduct.productID!,
                              isInWishlist: isInWishlist,
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildStarRating(
                              ratingValue: productRating,
                            ),
                            Text(
                              getCurrProduct.currentProductStatusValue == "0"
                                  ? "Out of Stock"
                                  : "In Stock",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          getCurrProduct.productDescription!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: dimmTextColor,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category: ${getCurrProduct.category}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(15),
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  getCurrSeller.profileImage!)),
                          title: Text(
                            // "Arsalan Ahmed Khatyan",
                            getCurrSeller.name!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.8),
                              fontSize: getProportionateScreenWidth(15),
                            ),
                          ),
                          tileColor: Theme.of(context).cardColor,
                          shape: const StadiumBorder(),
                          minVerticalPadding: 0,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: getProportionateScreenWidth(5),
                          ),
                          dense: true,
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: context.isLightMode
                                        ? kLightPrimaryColor
                                        : whiteColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          getProportionateScreenWidth(20)),
                                      topLeft: Radius.circular(
                                          getProportionateScreenWidth(20)),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            getProportionateScreenWidth(20)),
                                        topLeft: Radius.circular(
                                            getProportionateScreenWidth(20)),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      top: getProportionateScreenHeight(1),
                                      right: getProportionateScreenHeight(1),
                                      left: getProportionateScreenHeight(1),
                                    ),
                                    padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(20),
                                      left: getProportionateScreenWidth(20),
                                      top: getProportionateScreenHeight(20),
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            getProportionateScreenHeight(20),
                                      ),
                                      child: Wrap(
                                        runSpacing:
                                            getProportionateScreenWidth(10),
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            getProportionateScreenWidth(
                                                                50)))),
                                                child: CircleAvatar(
                                                  radius:
                                                      getProportionateScreenWidth(
                                                          50),
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          getCurrSeller
                                                              .profileImage!),
                                                ),
                                              ),
                                              Text(
                                                getCurrSeller.name!,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          17),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BuildStarRating(
                                                    ratingValue: productProvider
                                                        .sellerRatingWRTproducts(
                                                            getCurrProduct
                                                                .sellerID!),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              Divider(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              TextWithLeadingIcon(
                                                text: getCurrSeller.email!,
                                                leadingIcon: Icons.email,
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              TextWithLeadingIcon(
                                                text:
                                                    getCurrSeller.phoneNumber!,
                                                leadingIcon: Icons.phone,
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              TextWithLeadingIcon(
                                                text: getCurrSeller.address!,
                                                leadingIcon:
                                                    Icons.location_on_outlined,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(70)),
                ],
              ),
            ),
            BuildCustomBackButton(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithLeadingIcon extends StatelessWidget {
  final String? _text;
  final IconData? _leadingIcon;
  const TextWithLeadingIcon({
    Key? key,
    required String? text,
    required IconData? leadingIcon,
  })  : _text = text,
        _leadingIcon = leadingIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(30),
          height: getProportionateScreenWidth(30),
          child: Icon(
            _leadingIcon,
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
            size: getProportionateScreenWidth(30),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Flexible(
          child: BuildlightText(text: _text!),
        ),
      ],
    );
  }
}

class BuildlightText extends StatelessWidget {
  final String? _text;
  const BuildlightText({
    Key? key,
    required String? text,
  })  : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text!,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        fontSize: getProportionateScreenWidth(15),
      ),
    );
  }
}
