import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildCustomTile extends StatelessWidget {
  final IconData? _leadingIcon, _trailingIcon;
  final String? _title, _subTitle;
  final void Function()? _onTap;
  final bool? _isEditable;
  final bool? _isEmail;
  final bool? _isEmailVerified;
  final void Function()? _emailVerificationOnTap;
  const BuildCustomTile({
    Key? key,
    required IconData? leadingIcon,
    required IconData? trailingIcon,
    required String? title,
    String? subTitle = "",
    bool? isEditable = true,
    bool? isEmail = false,
    bool? isEmailVerified = false,
    required void Function()? onTap,
    void Function()? emailVerificationOnTap,
  })  : _leadingIcon = leadingIcon,
        _trailingIcon = trailingIcon,
        _title = title,
        _subTitle = subTitle,
        _onTap = onTap,
        _isEditable = isEditable,
        _isEmail = isEmail,
        _isEmailVerified = isEmailVerified,
        _emailVerificationOnTap = emailVerificationOnTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    return InkWell(
      onTap: _onTap,
      child: Container(
        height: getProportionateScreenHeight(60),
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.2),
            border: Border(
                top: BorderSide(
              color: context.isLightMode ? Colors.white : kDarkConvasColor!,
              width: 1,
            ))),
        child: Row(
          children: [
            Icon(
              _leadingIcon,
              color: dimmTextColor,
              size: getProportionateScreenWidth(22),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            SizedBox(
              width: getProportionateScreenWidth(250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _title!,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      Visibility(
                        visible: _isEmail!,
                        child: InkWell(
                          onTap: _isEmailVerified!
                              ? () {}
                              : _emailVerificationOnTap,
                          child: Text(
                            _isEmailVerified! ? "verified" : "not verified",
                            style: TextStyle(
                              color:
                                  _isEmailVerified! ? Colors.green : Colors.red,
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.w700,
                              decoration: _isEmailVerified!
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _subTitle!.isNotEmpty ? true : false,
                    child: Text(
                      _subTitle!,
                      maxLines: 1,
                      softWrap: true,
                      textWidthBasis: TextWidthBasis.parent,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: dimmTextColor,
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Visibility(
              visible: _isEditable!,
              child: Icon(
                _trailingIcon,
                color: context.isLightMode
                    ? Theme.of(context).primaryColor
                    : kDarkTextColor,
                size: getProportionateScreenWidth(22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
