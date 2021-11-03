import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_standard.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_add_addresses"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(marginLarge),
                child: Column(
                  children: [
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
                    SizedBox(
                      height: marginLarge,
                    ),
                    InlineButtons(
                      positiveText: TransUtil.trans("btn_save"),
                      negativeText: TransUtil.trans("btn_go_back"),
                      onPositiveTap: () {},
                      onNegativeTap: () {},
                    ),
                    SizedBox(
                      height: marginLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
