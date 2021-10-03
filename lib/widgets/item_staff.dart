import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  const StaffItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = 200.0;
    final _height = 225.0;
    return Container(
      // main container
      margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        child: Stack(
          children: [
            Positioned(
              // header top container
              top: 0,
              right: 0,
              left: 0,
              height: 50,
              child: Container(
                color: primaryColor,
              ),
            ),
            Positioned(
              // profile picture container
              top: 15,
              right: 0,
              left: 0,
              height: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: colorGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90,
              right: marginLarge,
              left: marginLarge,
              bottom: marginLarge,
              child: Container(
                child: Column(
                  children: [
                    Text("Dr. Lorem ipsum"),
                    SizedBox(
                      height: marginStandard,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
