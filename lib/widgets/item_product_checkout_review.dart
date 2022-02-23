import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:flutter/material.dart';

class CheckoutReviewProductItem extends StatelessWidget {
  final OrderItem orderItem;
  const CheckoutReviewProductItem({Key key, this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _imgWidth = size.width * 0.4;
    final _imgHeight = 150.0;

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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(radiusStandard),
            ),
            child: Container(
              // image main container
              width: _imgWidth,
              height: _imgHeight,
              child: CachedNetworkImage(
                imageUrl: orderItem?.imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                //error image when user have a picture but failed to load it
                errorWidget: (context, url, error) => Container(
                  padding: EdgeInsets.all(marginStandard),
                  height: _imgHeight,
                  width: _imgWidth,
                  decoration: BoxDecoration(
                    color: colorGreyDark,
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
          SizedBox(width: marginLarge),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  // product name
                  orderItem?.name ?? "",
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
                  orderItem.totalPrice?.toStringAsFixed(2),
                  style: TextStyle(color: Colors.black54),
                  // overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: marginSmall,
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
                    color: colorGreyDark,
                    child: Text(
                      orderItem.count?.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
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
