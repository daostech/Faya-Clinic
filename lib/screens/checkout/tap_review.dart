import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/item_product_checkout_review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutReviewTap extends StatelessWidget {
  const CheckoutReviewTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _controller = context.read<CheckoutController>();
    final _selectedMethod = context.select((CheckoutController controller) => controller.paymentMethod);
    final _shippingMethod = context.select((CheckoutController controller) => controller.shippingMethod);

    return Container(
      padding: const EdgeInsets.all(marginLarge),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              // current tab header
              alignment: Alignment.centerLeft,
              child: Text(
                TransUtil.trans("header_order_details"),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: fontSizeLarge,
                ),
              ),
            ),
            Container(
              //products list view
              height: size.height * 0.3,
              child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: marginLarge),
                itemBuilder: (ctx, index) {
                  return CheckoutReviewProductItem(
                    onTap: () {},
                  );
                },
              ),
            ),
            SizedBox(
              height: marginLarge,
            ),
            Column(
              // price summarry container
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: marginSmall),
                  child: Row(
                    children: [
                      Expanded(child: Text(TransUtil.trans("label_sub_total"))),
                      Text("\$3.200"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: marginSmall),
                  child: Row(
                    children: [
                      // Expanded(child: Text(_shippingMethod?.method)),
                      Expanded(child: Text("Free shipping")),
                      // Text(_shippingMethod.priceString),
                      Text("\$0.0"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: marginSmall),
                  child: Row(
                    children: [
                      Expanded(child: Text(TransUtil.trans("label_total"))),
                      Text("\$3.200"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: marginLarge,
            ),
            Column(
              // note container
              children: [
                Align(
                  // note header
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TransUtil.trans("header_order_note"),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: fontSizeLarge,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  margin: const EdgeInsets.symmetric(vertical: marginSmall),
                  padding: const EdgeInsets.all(marginStandard),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radiusStandard),
                    ),
                    border: Border.all(color: colorGreyDark, width: 0.5),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: marginLarge,
            ),
            InlineButtons(
              positiveText: TransUtil.trans("btn_continue"),
              negativeText: TransUtil.trans("btn_go_back"),
              onPositiveTap: () => _controller.nextTab(),
              onNegativeTap: () => _controller.previousTab(),
            ),
          ],
        ),
      ),
    );
  }
}
