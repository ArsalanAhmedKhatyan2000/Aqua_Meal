import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularNetworkImage extends StatelessWidget {
  final String? _imageURL;

  const CircularNetworkImage({
    Key? key,
    required String? imageURL,
  })  : _imageURL = imageURL,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(130),
      height: getProportionateScreenWidth(130),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor),
        image: DecorationImage(
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
          alignment: Alignment.center,
          image: CachedNetworkImageProvider(
            _imageURL!,
          ),
        ),
      ),
    );
  }
}
