import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class CircularNoImageWidget extends StatelessWidget {
  final IconData? _icon;
  const CircularNoImageWidget({
    Key? key,
    IconData? icon,
  })  : _icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(130),
      height: getProportionateScreenWidth(130),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Icon(
        _icon!,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        size: getProportionateScreenWidth(40),
      ),
    );
  }
}
