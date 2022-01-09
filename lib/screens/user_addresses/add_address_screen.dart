import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/user_addresses/address_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_standard.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key key}) : super(key: key);

  void handleBackPressed(BuildContext context, UserAddressesController controller) {
    if (controller.hasUpdates) {
      DialogUtil.showAlertDialog(context, "Unsaved changes close anyway ?", () {
        controller.resetForm();
        Navigator.of(context).pop();
      });
    } else
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserAddressesController>();
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
                      key: controller.formKey,
                      child: Column(
                        children: [
                          StandardInput(
                            hintText: TransUtil.trans("hint_address_label"),
                            isRequiredInput: true,
                            onChanged: (val) => controller.label = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_country"),
                            isRequiredInput: true,
                            onChanged: (val) => controller.country = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_city"),
                            isRequiredInput: true,
                            onChanged: (val) => controller.city = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_apartmant"),
                            isRequiredInput: true,
                            onChanged: (val) => controller.apartment = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_block"),
                            isRequiredInput: true,
                            onChanged: (val) => controller.block = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_street_name"),
                            onChanged: (val) => controller.streetName = val,
                          ),
                          StandardInput(
                            hintText: TransUtil.trans("hint_zip_code"),
                            onChanged: (val) => controller.zipCode = val,
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
                      onPositiveTap: () => controller.submitForm(context),
                      onNegativeTap: () => handleBackPressed(context, controller),
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
