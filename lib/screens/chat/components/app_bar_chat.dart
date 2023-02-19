import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.fromLTRB(marginLarge, marginLarge, marginLarge, marginLarge),
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: marginLarge,
          ),
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(IMG_LOGO),
                ),
                SizedBox(
                  width: marginStandard,
                ),
                Text(
                  TransUtil.trans("app_name"),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
