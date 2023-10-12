import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildSearchField extends StatelessWidget {
  final void Function(String)? _onChanged;
  final TextEditingController? _controller;
  final FocusNode? _focusNode;
  final void Function()? _iconOnTap;
  final String? _hintText;
  const BuildSearchField({
    Key? key,
    void Function(String)? onChanged,
    TextEditingController? controller,
    void Function()? iconOnTap,
    String? hintText = "Search Products",
    FocusNode? focusNode,
  })  : _onChanged = onChanged,
        _controller = controller,
        _iconOnTap = iconOnTap,
        _focusNode = focusNode,
        _hintText = hintText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
        child: TextFormField(
          controller: _controller!,
          focusNode: _focusNode,
          onChanged: _onChanged,
          style: TextStyle(
              color: klightTextColor,
              fontSize: getProportionateScreenWidth(15)),
          decoration: InputDecoration(
            hintText: _hintText,
            filled: true,
            fillColor: whiteColor,
            isDense: true,
            hintStyle: TextStyle(
              color: klightTextColor.withOpacity(0.5),
              fontSize: getProportionateScreenWidth(15),
            ),
            enabledBorder: searchBoxOutlinedBorder(),
            focusedBorder: searchBoxOutlinedBorder(),
            border: searchBoxOutlinedBorder(),
            errorBorder: searchBoxOutlinedErrorBorder(),
            contentPadding: EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: getProportionateScreenWidth(13),
              right: 0,
            ),
            constraints: BoxConstraints(
              maxHeight: getProportionateScreenHeight(45),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: _focusNode!.hasFocus
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              iconSize: getProportionateScreenWidth(25),
              onPressed: _iconOnTap,
              padding: const EdgeInsets.all(0),
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder searchBoxOutlinedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(getProportionateScreenWidth(60)),
      ),
    );
  }

  OutlineInputBorder searchBoxOutlinedErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(
        Radius.circular(getProportionateScreenWidth(60)),
      ),
    );
  }
}
