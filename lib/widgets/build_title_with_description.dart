import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildTitleWithDescription extends StatelessWidget {
  final String? _title, _description;
  const BuildTitleWithDescription({
    Key? key,
    required String? title,
    required String? description,
  })  : _title = title,
        _description = description,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _title!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(25),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
        Text(
          _description!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
      ],
    );
  }
}
