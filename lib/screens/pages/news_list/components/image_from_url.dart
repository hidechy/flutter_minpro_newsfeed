// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  const ImageFromUrl({super.key, this.imageUrl});

  final String? imageUrl;

  ///
  @override
  Widget build(BuildContext context) {
    final isInvalidUrl =
        (imageUrl != null) ? imageUrl!.startsWith('http') : false;

    if (imageUrl == null || imageUrl == '' || !isInvalidUrl) {
      return const Icon(Icons.broken_image);
    } else {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/no_image.png',
        image: imageUrl!,
        imageErrorBuilder: (c, o, s) =>
            Image.asset('assets/images/no_image.png'),
      );
    }
  }
}
