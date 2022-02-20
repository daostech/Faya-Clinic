import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class PreviousOrderItem extends StatelessWidget {
  const PreviousOrderItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _imgWidth = 150.0;
    return Container(
      // main  container
      margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              // top container
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusStandard),
                topRight: Radius.circular(radiusStandard),
              ),

              child: Container(
                decoration: BoxDecoration(
                  color: colorGreyLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusStandard),
                    topRight: Radius.circular(radiusStandard),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            // bottom container
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radiusStandard),
              bottomRight: Radius.circular(radiusStandard),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: colorGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radiusStandard),
                  bottomRight: Radius.circular(radiusStandard),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
