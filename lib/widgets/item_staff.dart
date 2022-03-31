import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/team.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class StaffItem extends StatelessWidget {
  final double width;
  final double height;
  final Team team;
  const StaffItem({Key key, this.width = 200, this.height = 225, @required this.team}) : super(key: key);

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
              height: width * 0.25,
              child: Container(
                color: colorPrimary,
              ),
            ),
            Positioned(
              // profile picture container
              top: height * 0.1,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width * 0.3,
                    width: width * 0.3,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: colorGreyLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5000)),
                      child: NetworkCachedImage(
                        width: width * 0.3,
                        height: width * 0.3,
                        // width: double.infinity,
                        // height: double.infinity,
                        circularShapeError: true,
                        imageUrl: team?.imageUrl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 90,
              right: marginLarge,
              left: marginLarge,
              bottom: marginLarge,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(team?.name ?? ""),
                    SizedBox(
                      height: marginStandard,
                    ),
                    Text(
                      team?.description ?? "",
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
