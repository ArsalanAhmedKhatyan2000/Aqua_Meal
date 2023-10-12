import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/widgets/build_custom_back_button.dart';
import 'package:aqua_meal/widgets/build_title_with_description.dart';
import 'package:aqua_meal/widgets/build_wave_logo_header.dart';
import 'package:aqua_meal/widgets/social_media_icons_strip.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = "/AboutUs";
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const WaveLogoHeader(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BuildTitleWithDescription(
                        title: "About Product",
                        description:
                            "Aqua Meal is an E-Commerce mobile application that provides the platform for a sea food sellers to sell their products as well as for consumers of sea food to buy products through the app that will be deliver to their door step.",
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const BuildTitleWithDescription(
                        title: "Launched At",
                        description:
                            "The Aqua Meal was launched at jan 1, 2023. The current version is v1.0.0",
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const BuildTitleWithDescription(
                        title: "Developer",
                        description:
                            "The application is designed and developed by team TechBeast.",
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const BuildTitleWithDescription(
                        title: "Follow Us",
                        description:
                            "For latest update please follow us on our social media platforms.",
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      const SocialMediaIconsStrip(),
                    ],
                  ),
                ),
              ],
            ),
            BuildCustomBackButton(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
