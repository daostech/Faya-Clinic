import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage({Key key, this.width = 70, this.height = 70, this.imageUrl, this.circularShapeError = false})
      : super(key: key);
  final double width;
  final double height;
  final String imageUrl;
  final bool circularShapeError;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        // padding: EdgeInsets.all(marginStandard),
        height: width,
        width: height,
        decoration: BoxDecoration(
          color: colorGrey,
          shape: circularShapeError ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
