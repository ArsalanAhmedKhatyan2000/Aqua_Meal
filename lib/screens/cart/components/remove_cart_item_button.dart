import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemoveCartItemButton extends StatelessWidget {
  final void Function()? _onTap;
  const RemoveCartItemButton({
    Key? key,
    required void Function()? onTap,
  })  : _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: getProportionateScreenWidth(35),
        width: getProportionateScreenWidth(35),
        decoration: BoxDecoration(
          color: context.isLightMode
              ? Theme.of(context).primaryColor
              : whiteColor.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(20)),
            bottomLeft: Radius.circular(getProportionateScreenWidth(20)),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: getProportionateScreenWidth(1),
            bottom: getProportionateScreenWidth(1),
          ),
          decoration: BoxDecoration(
            color:
                context.isLightMode ? whiteColor : Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(getProportionateScreenWidth(20)),
              bottomLeft: Radius.circular(getProportionateScreenWidth(20)),
            ),
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.cart_badge_minus,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
