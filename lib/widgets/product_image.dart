import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductTileImage extends StatelessWidget {
  final String? _imageURL;
  const ProductTileImage({
    Key? key,
    required String? imageURL,
  })  : _imageURL = imageURL,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(170),
      height: getProportionateScreenHeight(130),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(10))),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(10))),
        child: CachedNetworkImage(
          imageUrl: _imageURL!,
          placeholder: ((context, url) => const Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              )),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
