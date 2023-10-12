import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class ViewAllWithLabelStrip extends StatelessWidget {
  final String? _label;
  final void Function()? _onTapViewAll;
  const ViewAllWithLabelStrip({
    Key? key,
    String? label,
    void Function()? onTapViewAll,
  })  : _label = label,
        _onTapViewAll = onTapViewAll,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _label!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          GestureDetector(
            onTap: _onTapViewAll,
            child: Container(
              height: getProportionateScreenHeight(30),
              width: getProportionateScreenWidth(70),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenWidth(30)))),
              child: InkWell(
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: getProportionateScreenWidth(13),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
