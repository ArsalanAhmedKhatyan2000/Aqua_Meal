import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/screens/view%20all/view_all.dart';
import 'package:aqua_meal/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';

class HomeScreenSearchWidget extends StatelessWidget {
  const HomeScreenSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CustomPageRoute(
            direction: AxisDirection.right,
            child: const ViewAll(
              screenView: "allProducts",
              appBarTitle: "All Products",
              isFromHomeSearch: true,
            ),
          ),
        );
      },
      child: Container(
        height: getProportionateScreenHeight(45),
        width: SizeConfig.screenWidth,
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        padding: EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: getProportionateScreenWidth(13),
          right: getProportionateScreenWidth(13),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(getProportionateScreenWidth(60)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search Products",
              style: TextStyle(
                color: klightTextColor.withOpacity(0.5),
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: getProportionateScreenWidth(25),
            ),
          ],
        ),
      ),
    );
  }
}
