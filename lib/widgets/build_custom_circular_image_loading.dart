import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  State<LoadingIcon> createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: RotationTransition(
        turns: animation!,
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset(
          loadingFishImage!,
          color: context.isLightMode ? kLightPrimaryColor : whiteColor,
          semanticsLabel: "Loading Fish Icon",
          fit: BoxFit.cover,
          width: getProportionateScreenWidth(40),
          height: getProportionateScreenWidth(40),
        ),
      ),
    );
  }
}
