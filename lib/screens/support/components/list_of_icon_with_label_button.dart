import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/screens/support/components/build_icon_with_label_button.dart';
import 'package:flutter/material.dart';

class ListOfIconWithLabelButton extends StatelessWidget {
  const ListOfIconWithLabelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildIconWithLabelButton(
            icon: Icons.phone_in_talk_rounded,
            label: "+92 341 2234864",
            onTap: () {
              GlobalMethods().launchURL(
                url: "tel:$phoneNumber",
                context: context,
              );
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          BuildIconWithLabelButton(
            icon: Icons.whatsapp_rounded,
            label: "+92 341 2234864",
            onTap: () {
              var whatsapp = whatsappNumber;
              GlobalMethods().launchURL(
                  url: "whatsapp://send?phone=$whatsapp", context: context);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          BuildIconWithLabelButton(
            icon: Icons.mail_outline_rounded,
            label: aquaMealEmail,
            onTap: () {
              GlobalMethods()
                  .launchURL(url: "mailto:$aquaMealEmail", context: context);
            },
          ),
        ],
      ),
    );
  }
}
