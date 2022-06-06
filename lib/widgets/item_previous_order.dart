import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/user_order.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class PreviousOrderItem extends StatelessWidget {
  final UserOrder order;
  final Function onTap;
  const PreviousOrderItem({
    Key key,
    this.order,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _imgWidth = 150.0;
    return InkWell(
      onTap: onTap,
      child: Container(
        // main  container
        margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radiusStandard),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                // top container
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusStandard),
                ),
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(radiusStandard),
                //   topRight: Radius.circular(radiusStandard),
                // ),

                child: Container(
                  padding: const EdgeInsets.all(marginLarge),
                  decoration: BoxDecoration(
                    color: colorGreyLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusStandard),
                      topRight: Radius.circular(radiusStandard),
                    ),
                  ),
                  child: buildContent(),
                ),
              ),
            ),
            // ClipRRect(
            //   // bottom container
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(radiusStandard),
            //     bottomRight: Radius.circular(radiusStandard),
            //   ),
            //   child: Container(
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: colorGrey,
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(radiusStandard),
            //         bottomRight: Radius.circular(radiusStandard),
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black26,
            //           offset: Offset(1.0, 1.0),
            //           blurRadius: 1.0,
            //         ),
            //       ],
            //     ),
            //     child: TextButton(
            //       child: Text(TransUtil.trans("btn_view_details")),
            //       onPressed: onTap,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    final firstProduct = order.orderItems?.first?.product;
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(radiusStandard)),
                child: NetworkCachedImage(
                  // set the image of the first prodect in the list
                  imageUrl: firstProduct?.images[0],
                ),
              ),
            ),
            Text(
              firstProduct?.productName ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeLarge,
              ),
            ),
            Text(firstProduct?.orderItems?.length?.toString() ?? "items"),
            Text(TransUtil.trans(order?.paymentMethod)),
            Text(
              "${AppConfig.PREFFERED_QURRENCY_UNIT} ${order?.total?.toString() ?? "0.0"}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeLarge,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [],
        ),
      ],
    );
  }
}
