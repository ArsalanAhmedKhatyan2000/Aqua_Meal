import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildIconWithLabelButton extends StatelessWidget {
  final IconData? _icon;
  final String? _label;
  final void Function()? _onTap;
  const BuildIconWithLabelButton({
    Key? key,
    required IconData? icon,
    required String? label,
    required void Function()? onTap,
  })  : _label = label,
        _icon = icon,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: SizedBox(
        width: SizeConfig.screenWidth - getProportionateScreenWidth(40),
        height: getProportionateScreenHeight(40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenWidth(40),
              child: Icon(
                _icon,
                color: Colors.white,
                size: getProportionateScreenWidth(40),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Flexible(
              child: Text(
                _label!,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.8),
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
