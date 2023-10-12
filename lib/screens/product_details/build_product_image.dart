import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/wave_clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildProductImage extends StatelessWidget {
  final String? _productImageUrl;
  final String? _productID;
  const BuildProductImage({
    Key? key,
    String? productImageUrl,
    String? productID,
  })  : _productImageUrl = productImageUrl,
        _productID = productID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _productID!,
      child: ClipPath(
        clipper: WaveClipperProductBottom(),
        child: Stack(
          children: [
            Container(
              height: getProportionateScreenHeight(400),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
            if (_productImageUrl != "")
              SizedBox(
                height: getProportionateScreenHeight(400),
                width: SizeConfig.screenWidth,
                child: CachedNetworkImage(
                  imageUrl: _productImageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
