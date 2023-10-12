import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/wave_clipper.dart';
import 'package:flutter/material.dart';

class WaveLogoHeader extends StatelessWidget {
  const WaveLogoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperBottom(),
      child: Container(
        height: getProportionateScreenHeight(140),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        decoration: BoxDecoration(
          color: context.isLightMode ? whiteColor : kLightCanvasColor,
        ),
        child: Image.asset(
          context.isLightMode ? lightThemeLogo! : darkThemeLogo!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
