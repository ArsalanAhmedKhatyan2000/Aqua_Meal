import 'dart:io';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class CircularFileImage extends StatelessWidget {
  const CircularFileImage({
    Key? key,
    required File? selectedImageFile,
  })  : _selectedImageFile = selectedImageFile,
        super(key: key);

  final File? _selectedImageFile;

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
          image: FileImage(
            _selectedImageFile!,
          ),
        ),
      ),
    );
  }
}
