import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentTap extends StatelessWidget {
  const CheckoutPaymentTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _paymentMethods = DummyData.paymentMethods;
    final _controller = context.read<CheckoutController>();
    final _selectedMethod = context.select((CheckoutController controller) => controller.paymentMethod);

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
            itemCount: _paymentMethods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return RadioListTile(
                value: _paymentMethods[index],
                groupValue: _selectedMethod,
                title: Text(_paymentMethods[index].method),
                contentPadding: const EdgeInsets.all(0),
                selected: _selectedMethod == _paymentMethods[index],
                onChanged: (method) => _controller.paymentMethod = method,
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
            onPositiveTap: () => _controller.nextTab(),
            onNegativeTap: () => _controller.previousTab(),
          ),
        ],
      ),
    );
  }
}
