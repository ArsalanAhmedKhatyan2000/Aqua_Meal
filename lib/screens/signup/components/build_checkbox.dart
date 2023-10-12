import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/screens/signup/terms_condition.dart';
import 'package:flutter/material.dart';

class TermsConditionCheckBox extends StatefulWidget {
  final bool? _isCheckedTermsAndCondition;
  final void Function(bool?)? _onChange;
  const TermsConditionCheckBox({
    Key? key,
    required bool? isCheckedTermsAndCondition,
    required void Function(bool?)? onChange,
  })  : _isCheckedTermsAndCondition = isCheckedTermsAndCondition,
        _onChange = onChange,
        super(key: key);

  @override
  State<TermsConditionCheckBox> createState() => _TermsConditionCheckBoxState();
}

class _TermsConditionCheckBoxState extends State<TermsConditionCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget._isCheckedTermsAndCondition,
          onChanged: widget._onChange,
          checkColor: Theme.of(context).primaryColor,
          activeColor: kLightCanvasColor,
          focusColor: kLightCanvasColor,
          side: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "I've read and understood Aqua Meals",
              softWrap: true,
              style: TextStyle(
                color: kLightCanvasColor,
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(TermsAndCondition.routeName);
              },
              child: Text(
                "Terms & Conditions",
                softWrap: true,
                style: TextStyle(
                  color: kLightCanvasColor,
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
