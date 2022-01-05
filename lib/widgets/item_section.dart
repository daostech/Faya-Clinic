import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final Function onTap;
  const SectionItem({Key key, @required this.onTap, @required this.title, @required this.subTitle, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imgWidth = 150.0;
    return Container(
      // main  container
      padding: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
      margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        color: colorGreyLight,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              child: Container(
                // image main container
                width: _imgWidth,
                height: _imgWidth,
                child: NetworkCachedImage(
                  imageUrl: image,
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: marginSmall,
                ),
                Expanded(
                  child: Text(
                    subTitle,
                    style: TextStyle(color: Colors.black54),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
