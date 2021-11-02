import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutAddressTap extends StatelessWidget {
  const CheckoutAddressTap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = context.read<CheckoutController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                StandardInput(
                  isReadOnly: true,
                  initialValue: "Ali",
                ),
                StandardInput(
                  isReadOnly: true,
                  initialValue: "Daoud",
                ),
                StandardInput(
                  isReadOnly: true,
                  initialValue: "05366389928",
                ),
                StandardInput(
                  isReadOnly: false,
                  initialValue: "ali@ali.com",
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(marginLarge),
            child: InlineButtons(
              positiveText: TransUtil.trans("btn_select_address"),
              negativeText: TransUtil.trans("btn_save_address"),
              sameColor: colorGrey,
            ),
          ),
          Form(
            child: Column(
              children: [
                StandardInput(
                  hintText: TransUtil.trans("hint_country"),
                  onChanged: (val) {},
                ),
                StandardInput(
                  hintText: TransUtil.trans("hint_city"),
                  onChanged: (val) {},
                ),
                StandardInput(
                  hintText: TransUtil.trans("hint_apartmant"),
                  onChanged: (val) {},
                ),
                StandardInput(
                  hintText: TransUtil.trans("hint_block"),
                  onChanged: (val) {},
                ),
                StandardInput(
                  hintText: TransUtil.trans("hint_street_name"),
                  onChanged: (val) {},
                ),
                StandardInput(
                  hintText: TransUtil.trans("hint_zip_code"),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          StandardButton(
            onTap: () => _controller.nextTab(),
            radius: radiusStandard,
            text: TransUtil.trans("btn_continue"),
          ),
          SizedBox(
            height: marginLarge,
          ),
        ],
      ),
    );
  }
}
