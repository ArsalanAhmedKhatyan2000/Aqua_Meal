import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/about_us/about_us.dart';
import 'package:aqua_meal/screens/cart/cart.dart';
import 'package:aqua_meal/screens/home/home.dart';
import 'package:aqua_meal/screens/login/login.dart';
import 'package:aqua_meal/screens/my_profile/my_profile.dart';
import 'package:aqua_meal/screens/orders/order_tabbar.dart';
import 'package:aqua_meal/screens/support/support.dart';
import 'package:aqua_meal/screens/wishlist/wishlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isUserNull =
        CRUD().getAuthInstance.currentUser == null ? true : false;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              currentAccountPicture: (isUserNull == true ||
                      Users.getProfileImageURL!.isEmpty)
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        size: getProportionateScreenWidth(30),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          CachedNetworkImageProvider(Users.getProfileImageURL!),
                    ),
              margin: EdgeInsets.zero,
              accountName: Text((isUserNull == true || Users.getName!.isEmpty)
                  ? "Guest User"
                  : Users.getName!.capitalize()),
              accountEmail: Text((isUserNull == true) || Users.getEmail!.isEmpty
                  ? ""
                  : Users.getEmail!.capitalize()),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("My Profile"),
            leading: const Icon(Icons.person_outline),
            onTap: () {
              if (isUserNull == true) {
                GlobalMethods().showAlertMessage(
                  context: context,
                  title: "Not Login",
                  description: "No user found, Please login first",
                  rightButtonText: "Login",
                  onPressedRightButton: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Login.routeName);
                  },
                  leftButtonText: "Cancel",
                  onPressedLeftButton: () {
                    Navigator.pop(context);
                  },
                );
                return;
              }
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(MyProfile.routeName);
            },
          ),
          ListTile(
            title: const Text("Cart"),
            leading: const Icon(Icons.shopping_cart_outlined),
            onTap: () {
              if (isUserNull == true) {
                GlobalMethods().showAlertMessage(
                  context: context,
                  title: "Not Login",
                  description: "No user found, Please login first",
                  rightButtonText: "Login",
                  onPressedRightButton: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Login.routeName);
                  },
                  leftButtonText: "Cancel",
                  onPressedLeftButton: () {
                    Navigator.pop(context);
                  },
                );
                return;
              }
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Cart.routeName);
            },
          ),
          ListTile(
            title: const Text("Wishlist"),
            leading: const Icon(Icons.favorite_border_rounded),
            onTap: () {
              if (isUserNull == true) {
                GlobalMethods().showAlertMessage(
                  context: context,
                  title: "Not Login",
                  description: "No user found, Please login first",
                  rightButtonText: "Login",
                  onPressedRightButton: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Login.routeName);
                  },
                  leftButtonText: "Cancel",
                  onPressedLeftButton: () {
                    Navigator.pop(context);
                  },
                );
                return;
              }
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Wishlist.routeName);
            },
          ),
          ListTile(
            title: const Text("My Orders"),
            leading: const Icon(Icons.shopping_cart_checkout_rounded),
            onTap: () {
              if (isUserNull == true) {
                GlobalMethods().showAlertMessage(
                  context: context,
                  title: "Not Login",
                  description: "No user found, Please login first",
                  rightButtonText: "Login",
                  onPressedRightButton: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Login.routeName);
                  },
                  leftButtonText: "Cancel",
                  onPressedLeftButton: () {
                    Navigator.pop(context);
                  },
                );
                return;
              }
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(OrdersTabBar.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Support"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(Support.routeName);
            },
          ),
          ListTile(
            title: const Text("About Us"),
            leading: const Icon(Icons.info_outlined),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(AboutUs.routeName);
            },
          ),
          ListTile(
            title: Text(
              isUserNull == true ? "Sign in" : "Signout",
            ),
            leading: Icon(isUserNull == true ? Icons.login : Icons.logout),
            onTap: isUserNull == true
                ? () {
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Login.routeName);
                  }
                : () {
                    GlobalMethods().showAlertMessage(
                      context: context,
                      title: "Sign out",
                      description: "Are you sure! you want to sign out?",
                      leftButtonText: "CANCEL",
                      rightButtonText: "YES",
                      onPressedLeftButton: () {
                        Navigator.pop(context);
                      },
                      onPressedRightButton: () async {
                        Navigator.pop(context);
                        await CRUD().signoutUser().then((v) {
                          cartProvider.clearLocalCart();
                          wishlistProvider.clearLocalWishlist();
                          ordersProvider.clearLocalOrders();
                          orderDetailsProvider.clearLocalOrderDetails();
                          Users.setAllFieldsNull();
                          Navigator.of(context)
                              .pushReplacementNamed(Home.routeName);
                        });
                      },
                    );
                  },
          ),
        ],
      ),
    );
  }
}
