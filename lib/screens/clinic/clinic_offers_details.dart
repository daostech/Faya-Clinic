import 'package:carousel_slider/carousel_slider.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/offer.dart';
import 'package:faya_clinic/screens/dates/dates_screen_global.dart';
import 'package:faya_clinic/utils/trans_util.dart';
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
        title: Text(offer?.title ?? TransUtil.trans("header_offer_details")),
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
              child: !offer.hasImages
                  ? SizedBox()
                  : CarouselSlider(
                      items: offer.images
                          ?.map(
                            (e) => Center(
                              child: NetworkCachedImage(
                                imageUrl: e,
                              ),
                            ),
                          )
                          ?.toList(),
                      options: CarouselOptions(
                        height: _size.width,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => DatesScreenGlobal())),
              text: TransUtil.trans("btn_book_your_date_now"),
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
