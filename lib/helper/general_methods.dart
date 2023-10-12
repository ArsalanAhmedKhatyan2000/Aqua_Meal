import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_circular_image_loading.dart';
import 'package:aqua_meal/widgets/build_star_rating.dart';
import 'package:aqua_meal/widgets/custom_page_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension LightMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isLightMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.light;
  }
}

navigatePush({BuildContext? context, Widget? widget}) {
  Navigator.of(context!, rootNavigator: true).push(CustomPageRoute(
    child: widget!,
    direction: AxisDirection.right,
  ));
}

class GlobalMethods {
  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = CRUD().getAuthInstance.currentUser;
    final userID = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc("WvamEGwHsbNkF3KImk2V")
          .collection("buyer")
          .doc(userID)
          .update({
        'cartList': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
    } catch (error) {
      GlobalMethods().showErrorMessage(
        context: context,
        buttonText: "OK",
        description: "",
        onPressed: () {},
        title: "",
      );
    }
  }

  static Future<void> addToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = CRUD().getAuthInstance.currentUser;
    final userID = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc("WvamEGwHsbNkF3KImk2V")
          .collection("buyer")
          .doc(userID)
          .update({
        'wishlist': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
    } catch (error) {
      GlobalMethods().showErrorMessage(
        context: context,
        buttonText: "OK",
        description: "",
        onPressed: () {},
        title: "",
      );
    }
  }

  showSnackbar({
    BuildContext? context,
    String? message,
  }) {
    return ScaffoldMessenger.of(context!)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
          width: SizeConfig.screenWidth,
          dismissDirection: DismissDirection.down,
        ),
      );
  }

  Future<dynamic> showErrorMessage({
    BuildContext? context,
    String? title,
    String? description,
    String? buttonText,
    void Function()? onPressed,
  }) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.red),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              description!,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            elevation: 0,
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: [
              BuildSmallButton(
                text: buttonText,
                onPressed: onPressed,
                width: 70,
                height: 40,
                backgroundcolor: Theme.of(context).primaryColor,
              ),
            ],
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(24)),
          );
        });
  }

  Future<dynamic> showAlertMessage({
    BuildContext? context,
    String? title,
    String? description,
    String? leftButtonText,
    void Function()? onPressedLeftButton,
    String? rightButtonText,
    void Function()? onPressedRightButton,
  }) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.red),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              description!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            actions: [
              BuildSmallButton(
                text: leftButtonText!,
                backgroundcolor: Colors.green.withOpacity(0.7),
                onPressed: onPressedLeftButton,
              ),
              BuildSmallButton(
                text: rightButtonText!,
                backgroundcolor: Colors.red.withOpacity(0.7),
                onPressed: onPressedRightButton,
              ),
            ],
            elevation: 0,
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actionsPadding:
                EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(24)),
          );
        });
  }

  showIconLoading({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: LoadingIcon(),
      ),
    );
  }

  launchURL({required String? url, required BuildContext context}) async {
    try {
      Uri uri = Uri.parse(url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw "Error occured, trying to launch.";
      }
    } catch (e) {
      GlobalMethods().showErrorMessage(
        context: context,
        title: "Unexpected Error",
        description: e.toString(),
        buttonText: "OK",
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }
}

class RatingDialog extends StatelessWidget {
  final double? _rating;
  final Widget _child;
  final String? _productID;
  final int? _orderStatus;
  final bool? _isRated;
  final String? _orderDetailsID;
  const RatingDialog({
    super.key,
    required Widget child,
    required double? rating,
    required String? productID,
    int? orderStatus,
    bool? isRated,
    String? orderDetailsID,
  })  : _child = child,
        _rating = rating,
        _productID = productID,
        _orderStatus = orderStatus,
        _isRated = isRated,
        _orderDetailsID = orderDetailsID;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      onTap: (_orderStatus == 1 && _isRated == false)
          ? () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          "Rate the product",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    content: GiveStarRating(
                      ratingValue: _rating,
                      productID: _productID,
                      isRatingValueVisible: true,
                      orderDetailsID: _orderDetailsID,
                      starSize: 25,
                    ),
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
                  );
                },
              );
            }
          : () {},
      child: _child,
    );
  }
}
