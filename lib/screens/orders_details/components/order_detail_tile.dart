import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/order_details.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/seller_provider.dart';
import 'package:aqua_meal/widgets/build_star_rating.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersDetailsModel = Provider.of<OrderDetailsModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct =
        productsProvider.findProdById(ordersDetailsModel.productID!);
    final sellerProvider = Provider.of<SellerProvider>(context);
    final sellerModel =
        sellerProvider.findSellerById(ordersDetailsModel.sellerID!);
    final double? productRating = ratingCalculator(getCurrProduct.rating!);

    final orderModel =
        ordersProvider.getOrdersByOrderID(ordersDetailsModel.orderID);
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: RatingDialog(
        productID: getCurrProduct.productID,
        rating: productRating,
        orderStatus: orderModel.status!,
        isRated: ordersDetailsModel.isRated,
        orderDetailsID: ordersDetailsModel.orderDetailsID,
        // borderRadius:
        //     BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(20))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenWidth(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getCurrProduct.productName!.capitalize(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      BuildStarRating(
                        ratingValue: ratingCalculator(getCurrProduct.rating!),
                        starSize: 10,
                        isRatingValueVisible: false,
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Quantity: ",
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
                                text: "${ordersDetailsModel.quantity}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: getProportionateScreenWidth(10),
                                ),
                              ),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${ordersDetailsModel.price} Rs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: getProportionateScreenWidth(12),
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
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Divider(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Total Price: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${double.parse(ordersDetailsModel.price!) * ordersDetailsModel.quantity!} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              ),
                              TextSpan(
                                text: "Rs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(3),
                          horizontal: getProportionateScreenWidth(3),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(getProportionateScreenWidth(5))),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: getProportionateScreenHeight(10),
                              minRadius: getProportionateScreenHeight(10),
                              backgroundImage: CachedNetworkImageProvider(
                                sellerModel.profileImage!,
                              ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(3)),
                            Text(
                              sellerModel.name!.capitalize(),
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: getProportionateScreenWidth(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
