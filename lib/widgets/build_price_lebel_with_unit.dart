import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildPriceLebelWithUnit extends StatelessWidget {
  final String? _regularPrice;
  final String? _discountedPrice;
  final String? _unit;
  final double? _smallTextFontSize;
  final double? _largeTextFontSize;
  const BuildPriceLebelWithUnit({
    Key? key,
    String? regularPrice,
    String? discountedPrice,
    String? unit,
    double? smallTextFontSize,
    double? largeTextFontSize,
  })  : _regularPrice = regularPrice,
        _discountedPrice = discountedPrice,
        _unit = unit,
        _smallTextFontSize = smallTextFontSize,
        _largeTextFontSize = largeTextFontSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1!.color!;
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    return _discountedPrice!.isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _regularPrice!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  color: dimmTextColor,
                  fontSize: getProportionateScreenWidth(_smallTextFontSize!),
                ),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "${_discountedPrice!} Rs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize:
                          getProportionateScreenWidth(_largeTextFontSize!),
                    ),
                  ),
                  TextSpan(
                    text: " / ${_unit!}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      fontSize:
                          getProportionateScreenWidth(_largeTextFontSize!),
                    ),
                  ),
                ]),
              ),
            ],
          )
        : RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "${_regularPrice!} Rs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: getProportionateScreenWidth(_largeTextFontSize!),
                ),
              ),
              TextSpan(
                text: " / ${_unit!}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: getProportionateScreenWidth(_largeTextFontSize!),
                ),
              ),
            ]),
          );
  }
}
