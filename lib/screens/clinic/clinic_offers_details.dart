import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ClinicOfferDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/ClinicSectionDetailsScreen";
  const ClinicOfferDetailsScreen({Key key, @required this.offer}) : super(key: key);
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.title ?? "Offer Details"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(marginLarge, marginStandard, marginLarge, 0),
        child: Column(
          children: [
            ClipRRect(
              // image container
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              child: Container(
                // image main container
                width: _size.width,
                height: _size.width,
                child: NetworkCachedImage(
                  imageUrl: offer.img1,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: marginLarge,
                ),
                child: Text(offer.description),
              ),
            ),
            StandardButton(
              onTap: () {},
              text: "Book your date Now",
              radius: radiusStandard,
            ),
            SizedBox(
              height: marginLarge,
            ),
          ],
        ),
      ),
    );
  }
}
