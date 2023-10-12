import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/preferences.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/category_provider.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/seller_provider.dart';
import 'package:aqua_meal/providers/terms_and_condition_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splashRoute";
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _nextScreenNavigator();
    super.initState();
  }

  _nextScreenNavigator() async {
    final String? token = await SharedPreferencesHelper().getAuthToken();
    await Future.delayed(const Duration(microseconds: 1), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final ordersProvider =
          Provider.of<OrdersProvider>(context, listen: false);
      final orderDetailsProvider =
          Provider.of<OrderDetailsProvider>(context, listen: false);
      final sellerProvider =
          Provider.of<SellerProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final termsAndConditionProvider =
          Provider.of<TermsAndConditionProvider>(context, listen: false);

      await productsProvider.fetchProducts();
      productsProvider.getProducts.shuffle();
      await sellerProvider.fetchSellers();
      await categoryProvider.fetchCategories();
      termsAndConditionProvider.fetchTermsAndCondition();

      if (token != null && token.isNotEmpty) {
        CRUD().fetchUserCredentials(userID: token);
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      } else {
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
        ordersProvider.clearLocalOrders();
        orderDetailsProvider.clearLocalOrderDetails();
      }
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.isLightMode
          ? Theme.of(context).canvasColor
          : kDarkPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              context.isLightMode ? lightThemeLogo! : darkThemeLogo!,
              fit: BoxFit.cover,
              width: getProportionateScreenWidth(300),
            ),
          ),
        ],
      ),
    );
  }
}
