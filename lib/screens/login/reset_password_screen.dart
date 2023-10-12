import 'dart:async';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/validations.dart';
import 'package:aqua_meal/widgets/build_custom_back_button.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_text_field.dart';
import 'package:aqua_meal/widgets/build_login_signup_heading.dart';
import 'package:aqua_meal/widgets/build_wave_logo_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = "/ResetPassword";
  final String? _emailControllerText;

  const ResetPassword({
    Key? key,
    String? emailControllerText,
  })  : _emailControllerText = emailControllerText,
        super(key: key);

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
                  SizedBox(
                    height: SizeConfig.screenHeight -
                        getProportionateScreenHeight(175),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Column(
                        children: [
                          const HeaderText(
                            firstText: "Reset Password",
                            lastText:
                                "You will receive intructions for reset your password.",
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          ResetPasswordForm(
                              emailControllerText: _emailControllerText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              BuildCustomBackButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  final String? _emailControllerText;
  const ResetPasswordForm({
    Key? key,
    String? emailControllerText,
  })  : _emailControllerText = emailControllerText,
        super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  //focus nodes
  final FocusNode _emailfocusNode = FocusNode();
  final FocusNode _submitButtonfocusNode = FocusNode();

  final TextEditingController _emailController =
      TextEditingController(); //controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isClicked = false;
  bool _isShow = false;
  int _start = 30;

  @override
  void initState() {
    _emailController.text = widget._emailControllerText!;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState!.dispose();
    super.dispose();
  }

  resetPassword() async {
    GlobalMethods globalMethods = GlobalMethods();
    final FormState key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    if (isValidated) {
      GlobalMethods().showIconLoading(context: context);
      try {
        String? email = _emailController.text.trim();
        FirebaseAuth auth = FirebaseAuth.instance;
        setState(() {
          _isClicked = true;
        });

        await auth.sendPasswordResetEmail(email: email).then((value) {
          Navigator.of(context, rootNavigator: true).pop();
          startTimer();
          setState(() {
            _isShow = true;
          });
        });
      } on FirebaseException catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isClicked = false;
        });
        globalMethods.showErrorMessage(
          context: context,
          title: e.code,
          description: e.message,
          buttonText: "OK",
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        );
      } catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        globalMethods.showErrorMessage(
          context: context,
          title: "Unexpected Error",
          description: e.toString(),
          buttonText: "OK",
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        );
      }
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timerr = Timer.periodic(onsec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _isClicked = false;
          _isShow = false;
          _start = 30;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
            focusNode: _emailfocusNode,
            controller: _emailController,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_submitButtonfocusNode);
            },
            validator: (value) {
              return FieldValidations.isEmail(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomLargeButton(
            text: "Reset Email",
            focusNode: _submitButtonfocusNode,
            isDisable: _isClicked,
            onPressed: _isClicked
                ? () {}
                : () async {
                    await resetPassword();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Visibility(
            visible: _isShow,
            child: Column(
              children: [
                const Text(
                  "An instructions for resetting your password have been sent to your email address.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
              ],
            ),
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: "Reset password again in ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "00:$_start",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: " sec ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
