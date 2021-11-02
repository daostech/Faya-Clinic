import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  final double width;
  final double height;
  const StaffItem({Key key, this.width = 200, this.height = 225}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // main container
      margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorGreyLight,
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
              height: height * 0.25,
              child: Container(
                color: colorPrimary,
              ),
            ),
            Positioned(
              // profile picture container
              top: height * 0.1,
              right: 0,
              left: 0,
              height: height * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  color: colorGreyLight,
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
