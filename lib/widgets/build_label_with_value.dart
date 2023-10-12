import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildLabelWithValue extends StatelessWidget {
  final String? _value, _label;
  const BuildLabelWithValue({
    Key? key,
    String? value,
    String? label,
  })  : _value = value,
        _label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _label!,
          style: TextStyle(
            color: klightTextColor,
            fontWeight: FontWeight.w700,
            fontSize: getProportionateScreenWidth(13),
          ),
        ),
        Text(
          _value!,
          style: TextStyle(
            color: klightTextColor,
            fontWeight: FontWeight.w700,
            fontSize: getProportionateScreenWidth(13),
          ),
        ),
      ],
    );
  }
}
