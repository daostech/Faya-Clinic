import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  final double width;
  const OfferItem({Key key, this.width = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radiusStandard),
      ),
      child: Container(
        // image main container
        width: width,
        height: width,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              "https://images.squarespace-cdn.com/content/v1/5c76eb2011f78474bf7cd0f4/1578516048181-1VW6N4LSXZ466I8CS5I1/AS-0849.JPG",
          progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          //error image when user have a picture but failed to load it
          errorWidget: (context, url, error) => Container(
            padding: EdgeInsets.all(marginStandard),
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
