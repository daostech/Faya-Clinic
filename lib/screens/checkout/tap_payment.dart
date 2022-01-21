import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/screens/checkout/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentTap extends StatelessWidget {
  const CheckoutPaymentTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutController>();
    final selectedMethod =
        context.select<CheckoutController, PaymentMethod>((controller) => controller.selectedPaymentMethod);

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
            itemCount: controller.paymentMethods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return RadioListTile<PaymentMethod>(
                value: controller.paymentMethods[index],
                groupValue: selectedMethod,
                title: Text(controller.paymentMethods[index].method),
                contentPadding: const EdgeInsets.all(0),
                selected: controller.isSelectedPayment(index),
                onChanged: (method) => controller.updateWith(paymentMethod: method),
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
            positiveText: TransUtil.trans("btn_place_order"),
            negativeText: TransUtil.trans("btn_go_back"),
            onPositiveTap: () => controller.nextTab(),
            onNegativeTap: () => controller.previousTab(),
          ),
        ],
      ),
    );
  }
}
