import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class InlineButtons extends StatelessWidget {
  final String positiveText;
  final String negativeText;
  final Function onPositiveTap;
  final Function onNegativeTap;
  final Color sameColor;
  const InlineButtons({
    Key key,
    @required this.positiveText,
    @required this.negativeText,
    this.onPositiveTap,
    this.onNegativeTap,
    this.sameColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: sameColor ?? colorGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusStandard),
                bottomLeft: Radius.circular(radiusStandard),
              ),
            ),
            child: InkWell(
              onTap: onNegativeTap,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusStandard),
                bottomLeft: Radius.circular(radiusStandard),
              ),
              child: Padding(
                padding: const EdgeInsets.all(marginStandard),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    negativeText.toUpperCase(),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: marginStandard,
        ),
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: sameColor ?? colorPrimary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radiusStandard),
                bottomRight: Radius.circular(radiusStandard),
              ),
            ),
            child: InkWell(
              onTap: onPositiveTap,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radiusStandard),
                bottomRight: Radius.circular(radiusStandard),
              ),
              child: Padding(
                padding: const EdgeInsets.all(marginStandard),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    positiveText.toUpperCase(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
