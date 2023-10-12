import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class SalesFlag extends StatelessWidget {
  final String? _salePercent;
  const SalesFlag({
    Key? key,
    String? salePercent,
  })  : _salePercent = salePercent,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(50),
      width: getProportionateScreenWidth(27),
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getProportionateScreenWidth(10)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$_salePercent%",
            style: TextStyle(
              color: whiteColor,
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
          Text(
            "Off",
            style: TextStyle(
              color: whiteColor,
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ],
      ),
    );
  }
}
