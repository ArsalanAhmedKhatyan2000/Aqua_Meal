import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_text_field.dart';
import 'package:flutter/material.dart';

customBottomModalSheet({
  required BuildContext context,
  required String? title,
  required TextEditingController? controller,
  required String? Function(String?)? validator,
  required void Function()? onSave,
  required void Function()? onCancel,
  required String? hintText,
  required IconData? prefixIcon,
  required TextInputType? inputType,
  bool? isPass = false,
  required GlobalKey<FormState>? formKey,
  double? hight = 220,
  String? Function(String?)? validatorSecondPass,
  TextEditingController? controllerSecondPass,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(20)),
            topLeft: Radius.circular(getProportionateScreenWidth(20)),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(getProportionateScreenWidth(20)),
              topLeft: Radius.circular(getProportionateScreenWidth(20)),
            ),
          ),
          margin: EdgeInsets.only(
            top: getProportionateScreenHeight(0.2),
            right: getProportionateScreenHeight(0.2),
            left: getProportionateScreenHeight(0.2),
          ),
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(20),
            left: getProportionateScreenWidth(20),
            top: getProportionateScreenHeight(20),
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(20),
            ),
            child: Wrap(
              runSpacing: getProportionateScreenWidth(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(16),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: isPass!
                      ? Column(
                          children: [
                            PasswordTextFormField(
                              hintText: hintText,
                              controller: controller,
                              validator: validator,
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            PasswordTextFormField(
                              hintText: "Enter your new password",
                              controller: controllerSecondPass,
                              validator: validatorSecondPass,
                            ),
                          ],
                        )
                      : CustomTextFormField(
                          hintText: hintText,
                          prefixIcon: prefixIcon,
                          textInputType: inputType,
                          controller: controller,
                          validator: validator,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BuildSmallButton(
                      text: "CANCEL",
                      onPressed: onCancel,
                    ),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    BuildSmallButton(
                      text: "SAVE",
                      onPressed: onSave,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
