import 'package:cached_network_image/cached_network_image.dart';
import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/order_item.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProductItem extends StatelessWidget {
  final OrderItem orderItem;
  final Function onTap;
  final Function addQTY;
  final Function remoceQTY;
  const CartProductItem({
    Key key,
    this.onTap,
    @required this.orderItem,
    this.addQTY,
    this.remoceQTY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imgWidth = 150.0;
    final count = context.select<CartController, int>((element) => element.itemQTY(orderItem.id)) ?? 0;
    final price = context.select<CartController, double>((element) => element.itemTotalPrice(orderItem.id)) ?? 0.0;

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
                  imageUrl: orderItem?.imageUrl,
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
                  "${AppConfig.PREFFERED_QURRENCY_UNIT}${price?.toStringAsFixed(2)}",
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
                        onTap: remoceQTY,
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
                          count?.toString(),
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
                        onTap: addQTY,
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
