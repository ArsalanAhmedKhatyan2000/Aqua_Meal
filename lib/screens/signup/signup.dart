import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:aqua_meal/screens/signup/components/form.dart';
import 'package:aqua_meal/widgets/build_custom_back_button.dart';
import 'package:aqua_meal/widgets/build_have_an_account_strip.dart';
import 'package:aqua_meal/widgets/build_login_signup_heading.dart';
import 'package:aqua_meal/widgets/build_wave_logo_header.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  static const String routeName = "/Signup";
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const WaveLogoHeader(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeaderText(
                          firstText: "Sign up",
                          lastText: "Please sign up to register",
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        const SignupForm(),
                        SizedBox(height: getProportionateScreenHeight(29)),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getProportionateScreenHeight(10)),
                          child: NoAccountStrip(
                            firstText: "Already have an account? ",
                            lastText: "Sign in",
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacementNamed(Login.routeName);
                            },
                          ),
                        ),
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
