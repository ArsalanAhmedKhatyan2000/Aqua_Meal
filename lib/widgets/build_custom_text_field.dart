import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? _controller;
  final IconData? _prefixIcon;
  final FocusNode? _focusNode;
  final String? _hintText;
  final TextInputType? _textInputType;
  final String? Function(String?)? _validator;
  final void Function(String?)? _onFieldSubmitted;
  const CustomTextFormField({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    IconData? prefixIcon,
    String? hintText,
    TextInputType? textInputType,
    String? Function(String?)? validator,
    void Function(String?)? onFieldSubmitted,
  })  : _controller = controller,
        _focusNode = focusNode,
        _prefixIcon = prefixIcon,
        _hintText = hintText,
        _textInputType = textInputType,
        _validator = validator,
        _onFieldSubmitted = onFieldSubmitted,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dimmWhiteLightColor = kLightCanvasColor.withOpacity(0.7);
    Color dimmWhiteDarkColor = kLightCanvasColor.withOpacity(0.5);
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onFieldSubmitted: _onFieldSubmitted,
      validator: _validator,
      keyboardType: _textInputType,
      cursorColor: kLightCanvasColor,
      style: TextStyle(
          color: whiteColor, fontSize: getProportionateScreenWidth(15)),
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: TextStyle(
            color:
                context.isLightMode ? dimmWhiteLightColor : dimmWhiteDarkColor),
        prefixIcon: Icon(_prefixIcon, color: kLightCanvasColor),
        contentPadding: EdgeInsets.only(
          top: getProportionateScreenHeight(13),
          bottom: getProportionateScreenHeight(13),
          right: getProportionateScreenWidth(13),
        ),
        enabledBorder: loginSignupFieldsBorder(context),
        focusedBorder: loginSignupFieldsBorder(context),
        border: loginSignupFieldsBorder(context),
        errorBorder: coloredErrorOutlineInputBorder(),
        filled: true,
        fillColor: context.isLightMode
            ? whiteColor.withOpacity(0.35)
            : whiteColor.withOpacity(0.3),
      ),
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  final String? _hintText;
  final TextEditingController? _controller;
  final FocusNode? _focusNode;
  final String? Function(String?)? _validator;
  final void Function(String?)? _onFieldSubmitted;
  const PasswordTextFormField({
    Key? key,
    required String? hintText,
    required TextEditingController? controller,
    FocusNode? focusNode,
    void Function(String?)? onFieldSubmitted,
    String? Function(String?)? validator,
  })  : _hintText = hintText,
        _controller = controller,
        _focusNode = focusNode,
        _validator = validator,
        _onFieldSubmitted = onFieldSubmitted,
        super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obsecure = true;

  isPasswordVisibile() {
    setState(() {
      _obsecure = !_obsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color dimmWhiteLightColor = kLightCanvasColor.withOpacity(0.7);
    Color dimmWhiteDarkColor = kLightCanvasColor.withOpacity(0.5);
    return TextFormField(
      controller: widget._controller,
      focusNode: widget._focusNode,
      onFieldSubmitted: widget._onFieldSubmitted,
      obscureText: _obsecure,
      validator: widget._validator,
      keyboardType: TextInputType.text,
      cursorColor: kLightCanvasColor,
      style: TextStyle(
          color: whiteColor, fontSize: getProportionateScreenWidth(15)),
      decoration: InputDecoration(
        hintText: widget._hintText,
        hintStyle: TextStyle(
            color:
                context.isLightMode ? dimmWhiteLightColor : dimmWhiteDarkColor),
        prefixIcon: const Icon(Icons.lock_outline, color: kLightCanvasColor),
        suffixIcon: GestureDetector(
          onTap: isPasswordVisibile,
          child: _obsecure
              ? Icon(Icons.visibility_off,
                  color: context.isLightMode
                      ? kLightCanvasColor.withOpacity(0.8)
                      : dimmWhiteLightColor)
              : const Icon(Icons.visibility, color: whiteColor),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(13)),
        enabledBorder: loginSignupFieldsBorder(context),
        focusedBorder: loginSignupFieldsBorder(context),
        border: loginSignupFieldsBorder(context),
        errorBorder: coloredErrorOutlineInputBorder(),
        filled: true,
        fillColor: context.isLightMode
            ? whiteColor.withOpacity(0.35)
            : whiteColor.withOpacity(0.3),
      ),
    );
  }
}

OutlineInputBorder loginSignupFieldsBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(getProportionateScreenWidth(30))),
    borderSide: const BorderSide(
      color: kLightCanvasColor,
    ),
  );
}
