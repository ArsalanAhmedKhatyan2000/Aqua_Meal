import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/wishlist.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/product_details/product_details.dart';
import 'package:aqua_meal/widgets/add_to_wishlist_button.dart';
import 'package:aqua_meal/widgets/build_price_lebel_with_unit.dart';
import 'package:aqua_meal/widgets/build_star_rating.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListTile extends StatelessWidget {
  const WishListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct =
        productProvider.findProdById(wishlistModel.productId);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.productID);
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
              ProductDetails.routeName,
              arguments: getCurrProduct.productID);
        },
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          height: getProportionateScreenHeight(80),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(20))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(80),
                height: getProportionateScreenHeight(80),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenWidth(20))),
                  child: Image(
                    image: CachedNetworkImageProvider(
                      getCurrProduct.productImageUrl!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenWidth(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getCurrProduct.productName!.capitalize(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildStarRating(
                                ratingValue:
                                    ratingCalculator(getCurrProduct.rating!),
                                starSize: 15,
                                isRatingValueVisible: false,
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              BuildPriceLebelWithUnit(
                                regularPrice: getCurrProduct.regularPrice!,
                                discountedPrice:
                                    getCurrProduct.discountedPrice!,
                                unit: getCurrProduct.unit!,
                                smallTextFontSize: 12,
                                largeTextFontSize: 15,
                              ),
                            ],
                          ),
                          AddRemoveToWishlist(
                            productID: getCurrProduct.productID!,
                            isInWishlist: isInWishlist,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
