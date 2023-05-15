import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  const ImageFromUrl({Key? key, this.imageUrl}) : super(key: key);

  final String? imageUrl;

  ///
  @override
  Widget build(BuildContext context) {
    final isInvalidUrl =
        (imageUrl != null) ? imageUrl!.startsWith("http") : false;

    if (imageUrl == null || imageUrl == '' || !isInvalidUrl) {
      return Icon(Icons.broken_image);
    } else {
      // return CachedNetworkImage(
      //   imageUrl: imageUrl!,
      //   placeholder: (context, url) => CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => Icon(Icons.broken_image),
      //   fit: BoxFit.cover,
      // );

      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/no_image.png',
        image: imageUrl!,
        imageErrorBuilder: (c, o, s) =>
            Image.asset('assets/images/no_image.png'),
      );
    }
  }
}
