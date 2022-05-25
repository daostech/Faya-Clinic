import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class AppBarStandard extends StatelessWidget {
  final Function onBackTap;
  final String title;
  final List<Widget> actions;
  const AppBarStandard({
    Key key,
    this.onBackTap,
    this.actions,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.fromLTRB(marginLarge, paddingTop + marginLarge, marginLarge, marginLarge),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            // the arrow icon seems like it is not in the center
            // when it is exactly in the center so the padding
            // make it looks like in the center for the human eye
            padding: const EdgeInsets.only(left: marginSmall),
            child: FittedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusLarge),
                ),
                child: TextButton(
                  style: ButtonStyle(alignment: Alignment.center),
                  onPressed: onBackTap ?? () => Navigator.of(context).pop(),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: marginLarge,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSizeLarge,
              ),
            ),
          ),
          if (actions != null)
            Row(
              children: actions,
            ),
        ],
      ),
    );
  }
}
