import 'package:carousel_slider/carousel_slider.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/item_section.dart';
import 'package:faya_clinic/widgets/item_product.dart';
import 'package:faya_clinic/widgets/item_staff.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_home"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Center(child: Image.asset("assets/images/slider1.jpeg")),
                Center(child: Image.asset("assets/images/slider2.jpeg")),
                Center(child: Image.asset("assets/images/slider3.jpeg")),
              ],
              options: CarouselOptions(
                height: 200,
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
            Container(
              // user points container
              margin: const EdgeInsets.symmetric(
                horizontal: marginLarge,
                vertical: marginLarge,
              ),
              decoration: BoxDecoration(
                color: colorGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusStandard),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(marginLarge),
                child: Row(
                  children: [
                    // SvgPicture.asset(""),
                    SizedBox(
                      width: marginLarge,
                    ),
                    Text(
                      TransUtil.trans("label_your_points") + " 500",
                    ),
                  ],
                ),
              ),
            ),
            Align(
              // last offers header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                child: Text(
                  TransUtil.trans("header_last_offers"),
                ),
              ),
            ),
            Padding(
              // last offers divider
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Divider(
                thickness: 0.5,
                color: Colors.black87,
              ),
            ),
            Container(
              // offers horizontal list container
              height: 175,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return SectionItem();
                },
              ),
            ),
            Align(
              // last product header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                child: Text(
                  TransUtil.trans("header_last_products"),
                ),
              ),
            ),
            Padding(
              // last products divider
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Divider(
                thickness: 0.5,
                color: Colors.black87,
              ),
            ),
            Container(
              // last products horizontal list container
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return ProductItem();
                },
              ),
            ),
            Align(
              // clinic sections header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                child: Text(
                  TransUtil.trans("header_clinic_sections"),
                ),
              ),
            ),
            Padding(
              // clinic sections divider
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Divider(
                thickness: 0.5,
                color: Colors.black87,
              ),
            ),
            Container(
              // clinic sections horizontal list container
              height: 175,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return SectionItem();
                },
              ),
            ),
            Align(
              // lour staff header
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: marginLarge),
                child: Text(
                  TransUtil.trans("header_our_staff"),
                ),
              ),
            ),
            Padding(
              // our staff divider
              padding: const EdgeInsets.symmetric(horizontal: marginLarge),
              child: Divider(
                thickness: 0.5,
                color: Colors.black87,
              ),
            ),
            Container(
              // our staff horizontal list container
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return StaffItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
