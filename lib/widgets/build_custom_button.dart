import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildSmallButton extends StatelessWidget {
  final void Function()? _onPressed;
  final String? _text;
  final Color? _backgroundcolor;
  final Color? _textColor;
  final double? _width, _hight;
  final bool? _isDisable;
  final double? _fontSize;
  const BuildSmallButton({
    Key? key,
    required void Function()? onPressed,
    required String? text,
    Color? backgroundcolor,
    Color? textColor,
    double? width = 100,
    double? height = 40,
    bool? isDisable = false,
    double? fontSize = 15,
  })  : _onPressed = onPressed,
        _text = text,
        _backgroundcolor = backgroundcolor,
        _textColor = textColor,
        _width = width,
        _hight = height,
        _isDisable = isDisable,
        _fontSize = fontSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(_width!),
      height: getProportionateScreenHeight(_hight!),
      child: ElevatedButton(
        onPressed: _isDisable == true ? () {} : _onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
              (_isDisable == true && _backgroundcolor == null)
                  ? Colors.white.withOpacity(0.3)
                  : (_isDisable == true && _backgroundcolor != null)
                      ? _backgroundcolor!.withOpacity(0.3)
                      : (_isDisable == false && _backgroundcolor == null)
                          ? Colors.white.withOpacity(0.3)
                          : (_isDisable == false && _backgroundcolor != null)
                              ? _backgroundcolor
                              : whiteColor.withOpacity(0.3)
              // _backgroundcolor ?? whiteColor.withOpacity(0.3),
              ),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
        child: Text(
          _text!,
          style: TextStyle(
            color: _textColor ?? Colors.white,
            fontSize: getProportionateScreenWidth(_fontSize!),
          ),
        ),
      ),
    );
  }
}

class CustomLargeButton extends StatelessWidget {
  final String? _text;
  final void Function()? _onPressed;
  final bool _isDisable;
  final Color? _buttonColor;
  final FocusNode? _focusNode;
  final double? _width, _height;
  const CustomLargeButton({
    Key? key,
    required String? text,
    required void Function()? onPressed,
    FocusNode? focusNode,
    bool isDisable = false,
    Color? buttonColor,
    double? width,
    double? height = 50,
  })  : _text = text,
        _onPressed = onPressed,
        _focusNode = focusNode,
        _isDisable = isDisable,
        _buttonColor = buttonColor,
        _width = width,
        _height = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width ?? SizeConfig.screenWidth,
      height: getProportionateScreenHeight(_height!),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: _isDisable ? null : _onPressed,
        focusNode: _focusNode,
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(
              (_isDisable == true && _buttonColor == null)
                  ? Colors.white.withOpacity(0.3)
                  : (_isDisable == true && _buttonColor != null)
                      ? _buttonColor!.withOpacity(0.6)
                      : _buttonColor ?? whiteColor.withOpacity(0.5)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(30))),
              side: BorderSide(
                color: _isDisable ? whiteColor.withOpacity(0.3) : whiteColor,
              ))),
        ),
        child: Center(
          child: Text(
            _text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _isDisable ? Colors.white.withOpacity(0.3) : whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
        ),
      ),
    );
  }
}
