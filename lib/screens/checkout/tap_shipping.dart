import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/cart_controller.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutShippingTap extends StatelessWidget {
  const CheckoutShippingTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutController>();
    final cartController = context.read<CartController>();
    final selectedMethod = context.select((CheckoutController controller) => controller.selectedShippingMethod);

    return Container(
      padding: const EdgeInsets.all(marginLarge),
      child: Column(
        children: [
          Align(
            // header
            alignment: Alignment.centerLeft,
            child: Text(
              TransUtil.trans("header_shipping_methods"),
              style: TextStyle(
                color: Colors.black87,
                fontSize: fontSizeLarge,
              ),
            ),
          ),
          ListView.separated(
            itemCount: controller.shippingMethods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return RadioListTile(
                value: controller.shippingMethods[index],
                groupValue: selectedMethod,
                title: Text(controller.shippingMethods[index].method),
                subtitle: Text(controller.shippingMethods[index].priceString),
                contentPadding: const EdgeInsets.all(0),
                selected: controller.isSelectedShippingMethod(index),
                onChanged: (method) => controller.onShippingSelect(method, cartController.totalPrice),
              );
            },
            separatorBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: marginSmall,
                  horizontal: marginStandard,
                ),
                child: Divider(
                  color: Colors.black45,
                  height: 1.0,
                  thickness: 1.0,
                ),
              );
            },
          ),
          InlineButtons(
            positiveText: TransUtil.trans("btn_continue"),
            negativeText: TransUtil.trans("btn_go_back"),
            onPositiveTap: () {
              final result = controller.nextTab();
              if (!result) DialogUtil.showToastMessage(context, TransUtil.trans("msg_please_complete_this_step"));
            },
            onNegativeTap: () => controller.previousTab(),
          ),
        ],
      ),
    );
  }
}
