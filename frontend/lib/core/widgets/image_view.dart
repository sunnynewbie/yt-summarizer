import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageType { asset, network, filePath }

class ImageView extends StatelessWidget {
  final ImageType imageType;
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const ImageView({
    required this.imageType,
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return switch (imageType) {
      // TODO: Handle this case.
      ImageType.asset => Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return Placeholder();
        },
      ),
      ImageType.network => CachedNetworkImage(
        imageUrl: imagePath,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Placeholder(),
        errorListener: (value) {},
        errorWidget: (context, url, error) => Placeholder(),
        useOldImageOnUrlChange: false,
      ),
      // TODO: Handle this case.
      ImageType.filePath => Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return Placeholder();
        },
      ),
    };
  }
}
