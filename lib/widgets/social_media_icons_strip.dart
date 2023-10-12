import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/widgets/build_social_svg_icon_button.dart';
import 'package:flutter/material.dart';

class SocialMediaIconsStrip extends StatelessWidget {
  const SocialMediaIconsStrip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialSvgIconButton(
          iconPath: "assets/images/facebook_icon.svg",
          onTap: () {
            GlobalMethods().launchURL(
              url: facebookPageURL,
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        SocialSvgIconButton(
          iconPath: "assets/images/twitter_icon.svg",
          onTap: () {
            GlobalMethods().launchURL(
              url: twitterAccountURL,
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        SocialSvgIconButton(
          iconPath: "assets/images/insta_icon.svg",
          onTap: () {
            GlobalMethods().launchURL(
              url: instagramAccountURL,
              context: context,
            );
          },
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        SocialSvgIconButton(
          iconPath: "assets/images/youtube_icon.svg",
          onTap: () {
            GlobalMethods().launchURL(
              url: youtubeChannelURL,
              context: context,
            );
          },
        ),
      ],
    );
  }
}
