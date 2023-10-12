import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/preferences.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/validations.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/login/components/build_reset_password.dart';
import 'package:aqua_meal/screens/login/reset_password_screen.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  //focus nodes
  final FocusNode _emailfocusNode = FocusNode();
  final FocusNode _passwordfocusNode = FocusNode();
  final FocusNode _submitButtonfocusNode = FocusNode();
  //Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailfocusNode.dispose();
    _passwordfocusNode.dispose();
    _submitButtonfocusNode.dispose();
    super.dispose();
  }

  void signInUser(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    final FormState key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (isValidated == true) {
      GlobalMethods().showIconLoading(context: context);
      try {
        await CRUD()
            .signInUser(email: email, password: password)
            .then((value) async {
          CRUD().fetchUserCredentials(userID: value.user!.uid);
          await cartProvider.fetchCart();
          await wishlistProvider.fetchWishlist();
          await ordersProvider.fetchOrders();
          await orderDetailsProvider.fetchOrdersDetails();
          await SharedPreferencesHelper()
              .setAuthToken(value.user!.uid)
              .then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
          });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              FocusScope.of(context).requestFocus(_submitButtonfocusNode);
            },
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          ResetPasswordStrip(
            onTap: () {
              navigatePush(
                  context: context,
                  widget: ResetPassword(
                    emailControllerText: _emailController.text == ""
                        ? ""
                        : _emailController.text,
                  ));
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomLargeButton(
            text: "Sign in",
            focusNode: _submitButtonfocusNode,
            isDisable: false,
            onPressed: () {
              signInUser(context);
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
