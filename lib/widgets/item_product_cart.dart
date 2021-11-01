import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  final String imgUrl;
  final Function onTap;
  const CartProductItem({Key key, this.imgUrl = "", this.onTap}) : super(key: key);

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
                      : "https://retailminded.com/wp-content/uploads/2016/03/EN_GreenOlive-1.jpg",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  // product name
                  "Organic Cream",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: fontSizeLarge,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: marginSmall,
                ),
                Text(
                  "\$1600",
                  style: TextStyle(color: Colors.black54),
                  // overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: marginSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      // decrease product quantity button
                      borderRadius: BorderRadius.all(
                        Radius.circular(radiusxSmall),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(
                          Radius.circular(radiusxSmall),
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(2),
                          color: colorGreyDark,
                          child: FittedBox(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: marginStandard,
                    ),
                    ClipRRect(
                      // product quantity container
                      borderRadius: BorderRadius.all(
                        Radius.circular(radiusxSmall),
                      ),
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(2),
                        color: Colors.white,
                        child: Text(
                          "1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: marginStandard,
                    ),
                    ClipRRect(
                      // increase product quantity button
                      borderRadius: BorderRadius.all(
                        Radius.circular(radiusxSmall),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(
                          Radius.circular(radiusxSmall),
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(2),
                          color: colorPrimary,
                          child: FittedBox(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
