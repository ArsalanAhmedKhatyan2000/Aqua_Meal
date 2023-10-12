import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyScreen extends StatelessWidget {
  final IconData? _icon;
  final String? _title, _description, _svgImagePath;

  const EmptyScreen({
    Key? key,
    IconData? icon,
    required String? title,
    required String? description,
    String? svgImagePath,
  })  : _icon = icon,
        _title = title,
        _description = description,
        _svgImagePath = svgImagePath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_icon == null && _svgImagePath!.isNotEmpty)
            SvgPicture.asset(
              _svgImagePath!,
              color: context.isLightMode ? kLightPrimaryColor : whiteColor,
              fit: BoxFit.cover,
              width: getProportionateScreenWidth(80),
              height: getProportionateScreenWidth(80),
            )
          else
            Icon(
              _icon,
              color: context.isLightMode ? kLightPrimaryColor : whiteColor,
              size: getProportionateScreenWidth(80),
            ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            _title!,
            style: TextStyle(
              color: context.isLightMode ? kLightPrimaryColor : whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Text(
            _description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.isLightMode
                  ? kLightPrimaryColor.withOpacity(0.7)
                  : whiteColor.withOpacity(0.7),
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ],
      ),
    );
  }
}
