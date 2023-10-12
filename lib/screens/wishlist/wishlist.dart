import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/wishlist/components/wishlist_tile.dart';
import 'package:aqua_meal/widgets/build_empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  static const String routeName = "/Wishlist";
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wishlist (${wishlistItemsList.length})",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods().showAlertMessage(
                context: context,
                title: "Empty your wishlist?",
                description: "Are you sure, you want to clear your wishlist?",
                rightButtonText: "OK",
                onPressedRightButton: () async {
                  await wishlistProvider.clearOnlineWishlist().then((value) {
                    wishlistProvider.clearLocalWishlist();
                    Navigator.pop(context);
                  });
                },
                leftButtonText: "Cancel",
                onPressedLeftButton: () {
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(Icons.delete),
          )
        ],
        bottomOpacity: 0,
        elevation: 0.0,
      ),
      body: wishlistItemsList.isEmpty
          ? const EmptyScreen(
              svgImagePath: "assets/images/Wishlist.svg",
              title: "Oops! Empty Wishlist",
              description: "Sorry, there are no products in the wishlist.",
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: wishlistItemsList.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    SizedBox(height: getProportionateScreenHeight(10)),
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                ),
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: wishlistItemsList[index],
                  child: const WishListTile(),
                ),
              ),
            ),
    );
  }
}
