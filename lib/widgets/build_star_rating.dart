import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BuildStarRating extends StatelessWidget {
  final double? _ratingValue;
  final double? _starSize;
  final bool? _isRatingValueVisible;
  const BuildStarRating({
    Key? key,
    double? starSize = 20,
    required double? ratingValue,
    bool? isRatingValueVisible = true,
  })  : _ratingValue = ratingValue,
        _starSize = starSize,
        _isRatingValueVisible = isRatingValueVisible,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: _ratingValue!,
          minRating: 0,
          maxRating: 5,
          itemBuilder: ((context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              )),
          ignoreGestures: true,
          onRatingUpdate: (newRatingValue) {},
          updateOnDrag: false,
          allowHalfRating: true,
          glow: false,
          itemCount: 5,
          itemSize: getProportionateScreenWidth(_starSize!),
          textDirection: TextDirection.ltr,
        ),
        SizedBox(width: getProportionateScreenWidth(5)),
        Visibility(
          visible: _isRatingValueVisible!,
          child: Container(
            height: getProportionateScreenHeight(20),
            width: getProportionateScreenWidth(55),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getProportionateScreenWidth(10)))),
            child: Text(
              "$_ratingValue/5",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: getProportionateScreenWidth(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GiveStarRating extends StatefulWidget {
  final String? _productID;
  final double? _ratingValue;
  final double? _starSize;
  final bool? _isRatingValueVisible;
  final String? _orderDetailsID;
  const GiveStarRating({
    Key? key,
    double? starSize = 20,
    required double? ratingValue,
    bool? isRatingValueVisible = true,
    required String? productID,
    required String? orderDetailsID,
  })  : _ratingValue = ratingValue,
        _starSize = starSize,
        _isRatingValueVisible = isRatingValueVisible,
        _productID = productID,
        _orderDetailsID = orderDetailsID,
        super(key: key);

  @override
  State<GiveStarRating> createState() => _GiveStarRatingState();
}

class _GiveStarRatingState extends State<GiveStarRating> {
  @override
  void initState() {
    setState(() {
      rating = widget._ratingValue;
    });
    super.initState();
  }

  double? rating;
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final productModel = productsProvider.findProdById(widget._productID!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "How much you enjoying the product?",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: rating!,
              minRating: 1,
              maxRating: 5,
              itemBuilder: ((context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  )),
              onRatingUpdate: (newRatingValue) {
                setState(() {
                  rating = newRatingValue;
                });
              },
              updateOnDrag: true,
              allowHalfRating: true,
              glow: false,
              itemCount: 5,
              itemSize: getProportionateScreenWidth(widget._starSize!),
              textDirection: TextDirection.ltr,
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            Visibility(
              visible: widget._isRatingValueVisible!,
              child: Container(
                height: getProportionateScreenHeight(20),
                width: getProportionateScreenWidth(55),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(getProportionateScreenWidth(10)))),
                child: Text(
                  "$rating/5",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildSmallButton(
              text: "Cancel",
              backgroundcolor: Colors.green.withOpacity(0.7),
              height: 40,
              width: 100,
              fontSize: 15,
              onPressed: () {
                Navigator.of(context).pop();
                // final productRatingProvider =
                //     Provider.of<ProductRatingProvider>(context, listen: false);
                // await productRatingProvider.fetch();
              },
            ),
            BuildSmallButton(
              text: "Submit",
              backgroundcolor: Colors.red.withOpacity(0.7),
              height: 40,
              width: 100,
              fontSize: 15,
              onPressed: () async {
                List? ratingList = productModel.rating;
                ratingList!.add(rating.toString());
                productsProvider.addAndUpdateRating(
                  productID: widget._productID,
                  ratingList: ratingList,
                );
                await orderDetailsProvider
                    .updateOrderDetailsRatingStatus(widget._orderDetailsID)
                    .then((value) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
