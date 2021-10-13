import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class SectionItem extends StatelessWidget {
  final String imgUrl;
  final Function onTap;
  const SectionItem({Key key, this.imgUrl = "", this.onTap}) : super(key: key);

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
        color: colorGrey,
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
                child: CachedNetworkImage(
                  imageUrl: imgUrl.isNotEmpty
                      ? imgUrl
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSELycZjlpOd3aPyR8Cfx5OLGSbn0zRrHAwyA&usqp=CAU",
                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  //error image when user have a picture but failed to load it
                  errorWidget: (context, url, error) => Container(
                    padding: EdgeInsets.all(marginStandard),
                    height: _imgWidth,
                    width: _imgWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  "offer 50 %",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: marginSmall,
                ),
                Expanded(
                  child: Text(
                    "get offer 50 % when purchasing our products",
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
