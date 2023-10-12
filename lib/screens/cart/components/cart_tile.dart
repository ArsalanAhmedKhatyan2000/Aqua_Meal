import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/cart.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/screens/cart/components/remove_cart_item_button.dart';
import 'package:aqua_meal/screens/product_details/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CartTile extends StatefulWidget {
  final int? _quantity;
  const CartTile({
    Key? key,
    int? quantity,
  })  : _quantity = quantity,
        super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final TextEditingController _quantityController = TextEditingController();
  @override
  initState() {
    _quantityController.text = widget._quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProdById(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final String? productPrice = getCurrProduct.discountedPrice!.isNotEmpty
        ? getCurrProduct.discountedPrice
        : getCurrProduct.regularPrice;
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          height: getProportionateScreenHeight(80),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(20))),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          ProductDetails.routeName,
                          arguments: getCurrProduct.productID);
                    },
                    borderRadius: BorderRadius.all(
                        Radius.circular(getProportionateScreenWidth(20))),
                    child: SizedBox(
                      width: getProportionateScreenWidth(80),
                      height: getProportionateScreenHeight(80),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(getProportionateScreenWidth(20))),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            getCurrProduct.productImageUrl!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth -
                                    getProportionateScreenWidth(160),
                                child: Text(
                                  getCurrProduct.productName!.capitalize(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getProportionateScreenWidth(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (_quantityController.text == '1') {
                                        return;
                                      } else {
                                        cartProvider.reduceQuantityByOne(
                                            cartModel.productId);
                                        setState(() {
                                          _quantityController.text = (int.parse(
                                                      _quantityController
                                                          .text) -
                                                  1)
                                              .toString();
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          getProportionateScreenWidth(10)),
                                      bottomLeft: Radius.circular(
                                          getProportionateScreenWidth(10)),
                                    ),
                                    child: Container(
                                      width: getProportionateScreenWidth(30),
                                      height: getProportionateScreenHeight(30),
                                      decoration: BoxDecoration(
                                        color: context.isLightMode
                                            ? Theme.of(context).primaryColor
                                            : whiteColor.withOpacity(0.7),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              getProportionateScreenWidth(10)),
                                          bottomLeft: Radius.circular(
                                              getProportionateScreenWidth(10)),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: whiteColor,
                                        size: getProportionateScreenWidth(15),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: getProportionateScreenWidth(40),
                                    height: getProportionateScreenHeight(30),
                                    color: context.isLightMode
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.13)
                                        : whiteColor,
                                    child: Center(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: _quantityController,
                                        maxLength: 4,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(14),
                                          color: klightTextColor,
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[1-9]'),
                                          ),
                                        ],
                                        onChanged: (v) {
                                          setState(() {
                                            if (v.isEmpty) {
                                              _quantityController.text = '1';
                                            } else {
                                              return;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          isDense: true,
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 0,
                                            horizontal:
                                                getProportionateScreenWidth(2),
                                          ),
                                          border: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          counterText: "",
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cartProvider.increaseQuantityByOne(
                                          cartModel.productId);
                                      setState(() {
                                        _quantityController.text = (int.parse(
                                                    _quantityController.text) +
                                                1)
                                            .toString();
                                      });
                                    },
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          getProportionateScreenWidth(10)),
                                      bottomRight: Radius.circular(
                                          getProportionateScreenWidth(10)),
                                    ),
                                    child: Container(
                                      width: getProportionateScreenWidth(30),
                                      height: getProportionateScreenHeight(30),
                                      decoration: BoxDecoration(
                                        color: context.isLightMode
                                            ? Theme.of(context).primaryColor
                                            : whiteColor.withOpacity(0.7),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              getProportionateScreenWidth(10)),
                                          bottomRight: Radius.circular(
                                              getProportionateScreenWidth(10)),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: whiteColor,
                                        size: getProportionateScreenWidth(15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "${_quantityController.text} X ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: getProportionateScreenWidth(10),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$productPrice Rs",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: getProportionateScreenWidth(13),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " / ${getCurrProduct.unit!.toLowerCase()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: getProportionateScreenWidth(13),
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RemoveCartItemButton(
                    onTap: () async {
                      GlobalMethods().showAlertMessage(
                        context: context,
                        title: "Remove Item",
                        description:
                            "Are you sure, you want to remove your item from cart?",
                        rightButtonText: "OK",
                        onPressedRightButton: () async {
                          await cartProvider
                              .removeOneItem(
                            cartId: cartModel.id,
                            productId: cartModel.productId,
                            quantity: cartModel.quantity,
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        leftButtonText: "Cancel",
                        onPressedLeftButton: () {
                          Navigator.pop(context);
                        },
                      );
                    },
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
