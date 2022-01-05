import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ClinicSubSectionDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/ClinicSectionDetailsScreen";
  const ClinicSubSectionDetailsScreen({Key key, @required this.subSection}) : super(key: key);
  final SubSection subSection;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(subSection.name ?? "Section Details"),
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
                  imageUrl: subSection.img1,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: marginLarge,
              ),
              child: Text(subSection.description),
            ),
          ],
        ),
      ),
    );
  }
}
