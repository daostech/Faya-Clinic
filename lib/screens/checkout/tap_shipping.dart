import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutShippingTap extends StatelessWidget {
  const CheckoutShippingTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _shippingMethods = DummyData.shippingMethods;
    final _controller = context.read<CheckoutController>();
    final _selectedMethod = context.select((CheckoutController controller) => controller.shippingMethod);

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
            itemCount: _shippingMethods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return RadioListTile(
                value: _shippingMethods[index],
                groupValue: _selectedMethod,
                title: Text(_shippingMethods[index].method),
                subtitle: Text(_shippingMethods[index].priceString),
                contentPadding: const EdgeInsets.all(0),
                selected: _selectedMethod == _shippingMethods[index],
                onChanged: (method) => _controller.shippingMethod = method,
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
            onPositiveTap: () => _controller.nextTab(),
            onNegativeTap: () => _controller.previousTab(),
          ),
        ],
      ),
    );
  }
}
