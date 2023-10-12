import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/screens/login/components/form.dart';
import 'package:aqua_meal/screens/signup/signup.dart';
import 'package:aqua_meal/widgets/build_custom_back_button.dart';
import 'package:aqua_meal/widgets/build_have_an_account_strip.dart';
import 'package:aqua_meal/widgets/build_login_signup_heading.dart';
import 'package:aqua_meal/widgets/build_wave_logo_header.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String routeName = "/signin";
  const Login({Key? key}) : super(key: key);

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
                  Container(
                    height: SizeConfig.screenHeight -
                        getProportionateScreenHeight(175),
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeaderText(
                          firstText: "Welcome back!",
                          lastText: "Please sign in to continue",
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        const SigninForm(),
                        const Spacer(),
                        NoAccountStrip(
                          firstText: "Don't have an account? ",
                          lastText: "Sign up",
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(Signup.routeName);
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
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
      ),
    );
  }
}
