import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class NoAccountStrip extends StatelessWidget {
  final String? _firstText;
  final String? _lastText;
  final Function()? _onTap;
  const NoAccountStrip({
    Key? key,
    required String? firstText,
    required String? lastText,
    required Function()? onTap,
  })  : _firstText = firstText,
        _lastText = lastText,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _firstText!,
          style: TextStyle(
            color: context.isLightMode
                ? whiteColor.withOpacity(0.7)
                : whiteColor.withOpacity(0.5),
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
        GestureDetector(
          onTap: _onTap,
          child: Text(
            _lastText!,
            style: TextStyle(
              color: kLightCanvasColor,
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ],
    );
  }
}
