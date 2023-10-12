import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String? _firstText;
  final String? _lastText;
  const HeaderText({
    Key? key,
    String? firstText,
    String? lastText,
  })  : _firstText = firstText,
        _lastText = lastText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _firstText!,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: kLightCanvasColor,
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(30),
            ),
          ),
          Text(
            _lastText!,
            style: TextStyle(
              color: context.isLightMode
                  ? whiteColor.withOpacity(0.7)
                  : whiteColor.withOpacity(0.5),
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ],
      ),
    );
  }
}
