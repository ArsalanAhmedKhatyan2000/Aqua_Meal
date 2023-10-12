import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/validations.dart';
import 'package:aqua_meal/screens/signup/components/build_checkbox.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isCheckedTermsAndCondition = false;
  //Controllers nodes
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //focus nodes
  final FocusNode _namefocusNode = FocusNode();
  final FocusNode _emailfocusNode = FocusNode();
  final FocusNode _passwordfocusNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  final FocusNode _phoneNumberNode = FocusNode();
  final FocusNode _addressfocusNode = FocusNode();
  final FocusNode _submitButtonfocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  void isCheckedTermsAndCondition() {
    setState(() {
      _isCheckedTermsAndCondition = !_isCheckedTermsAndCondition;
    });
  }

  @override
  void dispose() {
    _namefocusNode.dispose();
    _emailfocusNode.dispose();
    _passwordfocusNode.dispose();
    _confirmPasswordNode.dispose();
    _phoneNumberNode.dispose();
    _addressfocusNode.dispose();
    _submitButtonfocusNode.dispose();
    super.dispose();
  }

  void createUser(BuildContext context) async {
    final FormState key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);

    DateTime? userCreatedDate = DateTime.now();
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String address = _addressController.text.trim();

    if (isValidated == true) {
      if (_isCheckedTermsAndCondition == true) {
        if (password == confirmPassword) {
          GlobalMethods().showIconLoading(context: context);
          try {
            await CRUD()
                .createUserWithUploadData(
                    name: name,
                    email: email,
                    address: address,
                    confirmPassword: confirmPassword,
                    phoneNumber: phoneNumber,
                    userCreatedDate: userCreatedDate)
                .then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } on FirebaseException catch (e) {
            Navigator.pop(context);
            GlobalMethods().showErrorMessage(
              context: context,
              title: e.code,
              description: e.message,
              buttonText: "OK",
              onPressed: () {
                Navigator.pop(context);
              },
            );
          } catch (e) {
            Navigator.pop(context);
            GlobalMethods().showErrorMessage(
              context: context,
              title: "Unexpected Error",
              description: e.toString(),
              buttonText: "OK",
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }
        } else {
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Invalid Password",
            description:
                "Confirm password is not matched with the password, please provide the same password in both fields to proceed.",
            buttonText: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }
      } else {
        GlobalMethods().showErrorMessage(
          context: context,
          title: "Unchecked Terms and Conditions.",
          description:
              "Terms and Conditions checkbox is unchecked yet. please click on the terms and condition checkbox.",
          buttonText: "OK",
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Enter your name",
            prefixIcon: Icons.person_outline,
            textInputType: TextInputType.name,
            controller: _nameController,
            focusNode: _namefocusNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_emailfocusNode);
            },
            validator: (value) {
              return FieldValidations.isName(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
            controller: _emailController,
            focusNode: _emailfocusNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_passwordfocusNode);
            },
            validator: (value) {
              return FieldValidations.isEmail(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          PasswordTextFormField(
            hintText: "Enter your password",
            controller: _passwordController,
            focusNode: _passwordfocusNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_confirmPasswordNode);
            },
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          PasswordTextFormField(
            hintText: "Confirm your password",
            controller: _confirmPasswordController,
            focusNode: _confirmPasswordNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_phoneNumberNode);
            },
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(
            hintText: "Enter your number",
            prefixIcon: Icons.phone_outlined,
            textInputType: TextInputType.number,
            controller: _phoneNumberController,
            focusNode: _phoneNumberNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_addressfocusNode);
            },
            validator: (value) {
              return FieldValidations.isPhoneNumber(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(
            hintText: "Enter your address",
            prefixIcon: Icons.location_on_outlined,
            textInputType: TextInputType.text,
            controller: _addressController,
            focusNode: _addressfocusNode,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(_submitButtonfocusNode);
            },
            validator: (value) {
              return FieldValidations.isAddress(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
          TermsConditionCheckBox(
            isCheckedTermsAndCondition: _isCheckedTermsAndCondition,
            onChange: (value) {
              isCheckedTermsAndCondition();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomLargeButton(
            text: "Sign up",
            focusNode: _submitButtonfocusNode,
            isDisable: false,
            onPressed: () async {
              createUser(context);
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
