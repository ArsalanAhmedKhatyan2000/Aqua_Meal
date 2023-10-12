import 'package:aqua_meal/screens/about_us/about_us.dart';
import 'package:aqua_meal/screens/cart/cart.dart';
import 'package:aqua_meal/screens/home/components/category_view_all.dart';
import 'package:aqua_meal/screens/home/home.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:aqua_meal/screens/my_profile/my_profile.dart';
import 'package:aqua_meal/screens/orders/order_tabbar.dart';
import 'package:aqua_meal/screens/orders_details/order_details.dart';
import 'package:aqua_meal/screens/product_details/product_details.dart';
import 'package:aqua_meal/screens/signup/signup.dart';
import 'package:aqua_meal/screens/signup/terms_condition.dart';
import 'package:aqua_meal/screens/splash_screen/splash.dart';
import 'package:aqua_meal/screens/support/support.dart';
import 'package:aqua_meal/screens/wishlist/wishlist.dart';
import 'package:aqua_meal/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';

var myRoutes = {
  Home.routeName: (context) => const Home(),
  Splash.routeName: (context) => const Splash(),
  Login.routeName: (context) => const Login(),
  Signup.routeName: (context) => const Signup(),
  OrdersTabBar.routeName: (context) => const OrdersTabBar(),
  ProductDetails.routeName: (context) => const ProductDetails(),
  Wishlist.routeName: (context) => const Wishlist(),
  Cart.routeName: (context) => const Cart(),
  Support.routeName: (context) => const Support(),
  AboutUs.routeName: (context) => const AboutUs(),
};

class CustomRoute {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.routeName:
        return CustomPageRoute(
          child: const Splash(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Home.routeName:
        return CustomPageRoute(
          child: const Home(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case CategoryViewAll.routeName:
        return CustomPageRoute(
          child: const CategoryViewAll(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Login.routeName:
        return CustomPageRoute(
          child: const Login(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Signup.routeName:
        return CustomPageRoute(
          child: const Signup(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case TermsAndCondition.routeName:
        return CustomPageRoute(
          child: const TermsAndCondition(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case OrdersTabBar.routeName:
        return CustomPageRoute(
          child: const OrdersTabBar(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case ProductDetails.routeName:
        return CustomPageRoute(
          child: const ProductDetails(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Wishlist.routeName:
        return CustomPageRoute(
          child: const Wishlist(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Cart.routeName:
        return CustomPageRoute(
          child: const Cart(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case MyProfile.routeName:
        return CustomPageRoute(
          child: const MyProfile(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case Support.routeName:
        return CustomPageRoute(
          child: const Support(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case OrdersDetails.routeName:
        return CustomPageRoute(
          child: const OrdersDetails(),
          direction: AxisDirection.right,
          settings: settings,
        );
      case AboutUs.routeName:
        return CustomPageRoute(
          child: const AboutUs(),
          direction: AxisDirection.right,
          settings: settings,
        );
      default:
        null;
    }
    return null;
  }
}
