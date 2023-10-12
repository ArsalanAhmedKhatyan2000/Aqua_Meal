import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildCustomBackButton extends StatelessWidget {
  final void Function()? _onTap;
  const BuildCustomBackButton({
    Key? key,
    required void Function()? onTap,
  })  : _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child: Row(
        children: [
          GestureDetector(
            onTap: _onTap,
            child: Container(
              width: getProportionateScreenWidth(25),
              height: getProportionateScreenWidth(25),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: whiteColor,
                size: getProportionateScreenWidth(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
