import 'dart:math';

import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  final double width;
  final Offer offer;
  final Function onTap;
  const OfferItem({Key key, this.width = 150, @required this.offer, this.onTap}) : super(key: key);

  // int get random => Random().nextInt(3);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radiusStandard),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        child: Container(
          // image main container
          width: width,
          height: width,
          child: NetworkCachedImage(
            imageUrl: offer.images[0],
          ),
        ),
      ),
    );
  }
}
