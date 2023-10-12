import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSvgIconButton extends StatelessWidget {
  final Function()? _onTap;
  final String? _iconPath;
  const SocialSvgIconButton({
    Key? key,
    required Function()? onTap,
    required String? iconPath,
  })  : _onTap = onTap,
        _iconPath = iconPath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      borderRadius:
          BorderRadius.all(Radius.circular(getProportionateScreenWidth(100))),
      child: SvgPicture.asset(
        _iconPath!,
        color: Colors.white,
        fit: BoxFit.cover,
        width: getProportionateScreenWidth(40),
        height: getProportionateScreenWidth(40),
      ),
    );
  }
}
