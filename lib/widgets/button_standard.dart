import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final double radius;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double height;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  const StandardButton({
    Key key,
    @required this.onTap,
    @required this.text,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.radius = 0,
    this.height = 40,
    this.textStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius > 0
          ? BorderRadius.all(
              Radius.circular(radius),
            )
          : BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
      child: InkWell(
        onTap: onTap,
        radius: radiusStandard,
        child: FittedBox(
          child: Container(
            height: height,
            padding: padding ??
                const EdgeInsets.symmetric(
                  vertical: marginSmall,
                  horizontal: marginLarge,
                ),
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(marginStandard),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text.toUpperCase(),
                  style: textStyle ?? TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
