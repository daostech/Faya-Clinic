import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/user_order.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/network_image.dart';
import 'package:flutter/material.dart';

class UserOrderDetailsScreen extends StatelessWidget {
  const UserOrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            AppBarStandard(
              title: TransUtil.trans("header_order_details"),
            ),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildHeader(),
          SizedBox(height: marginLarge),
          buildOrderItems(),
          SizedBox(height: marginLarge),
          buildOrderTotalSummary(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(radiusStandard)),
            child: NetworkCachedImage(
              // set the image of the first prodect in the list
              imageUrl: order.orderItems?.first.product?.images[0],
            ),
          ),
        ),
        Text(
          order.status ?? "",
          style: TextStyle(
            fontSize: fontSizexLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          MyDateFormatter.toStringDate(order.date),
          style: TextStyle(
            fontSize: fontSizeLarge,
          ),
        ),
        Text(
          order.note ?? "",
          style: TextStyle(
            fontSize: fontSizeLarge,
          ),
        ),
      ],
    );
  }

  Widget buildOrderItems() {
    return Padding(
      padding: const EdgeInsets.all(marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TransUtil.trans("label_items"),
            style: TextStyle(
              fontSize: fontSizexLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: marginStandard,
          ),
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
            padding: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              color: colorGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: order.orderItems!.length,
              itemBuilder: (context, index) {
                return buildInnerOrderItem(order.orderItems![index]);
              },
              separatorBuilder: (ctx, indx) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderTotalSummary() {
    return Padding(
      padding: const EdgeInsets.all(marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TransUtil.trans("label_total"),
            style: TextStyle(
              fontSize: fontSizexLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: marginStandard,
          ),
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
            padding: const EdgeInsets.symmetric(horizontal: marginStandard, vertical: marginLarge),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
              color: colorGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Column(children: [
              ListTile(
                leading: Text(TransUtil.trans("label_total")),
                trailing: Text("${AppConfig.PREFFERED_QURRENCY_UNIT} ${order.total.toString()}"),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildInnerOrderItem(OrderItem orderItem) {
    return Row(
      children: [
        // quantity label
        Text("${orderItem.count?.toInt().toString()} X "),
        // product name
        Text("${orderItem.product?.productName}"),
        // product price
        Spacer(),
        Text("${AppConfig.PREFFERED_QURRENCY_UNIT}${orderItem.product?.price}"),
      ],
    );
  }
}
