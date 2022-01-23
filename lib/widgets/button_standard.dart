import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
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
    @required this.text,
    @required this.onTap,
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
    final isRTL = TransUtil.isArLocale(context);

    return ClipRRect(
      borderRadius: radius > 0
          ? BorderRadius.all(
              Radius.circular(radius),
            )
          : BorderRadius.only(
              topLeft: isRTL ? Radius.circular(topRightRadius) : Radius.circular(topLeftRadius),
              topRight: isRTL ? Radius.circular(topLeftRadius) : Radius.circular(topRightRadius),
              bottomLeft: isRTL ? Radius.circular(bottomRightRadius) : Radius.circular(bottomLeftRadius),
              bottomRight: isRTL ? Radius.circular(bottomLeftRadius) : Radius.circular(bottomRightRadius),
            ),
      child: FittedBox(
        child: Container(
          height: height,
          padding: padding ??
              const EdgeInsets.symmetric(
                // vertical: marginSmall,
                horizontal: marginLarge,
              ),
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.only(
              topLeft: isRTL ? Radius.circular(topRightRadius) : Radius.circular(topLeftRadius),
              topRight: isRTL ? Radius.circular(topLeftRadius) : Radius.circular(topRightRadius),
              bottomLeft: isRTL ? Radius.circular(bottomRightRadius) : Radius.circular(bottomLeftRadius),
              bottomRight: isRTL ? Radius.circular(bottomLeftRadius) : Radius.circular(bottomRightRadius),
            ),
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(marginSmall),
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
