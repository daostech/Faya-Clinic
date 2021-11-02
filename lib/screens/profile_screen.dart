import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/buttons_inline.dart';
import 'package:faya_clinic/widgets/input_label_top.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar + tabs container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_profile"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(marginStandard, 50, marginStandard, 0),
              child: Column(
                children: [
                  Container(
                    // user avatar container
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                      color: colorGreyLight,
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
                  ),
                  SizedBox(
                    height: marginLarge,
                  ),
                  Text(
                    "User name",
                    style: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeLarge,
                    ),
                  ),
                  SizedBox(
                    height: marginSmall,
                  ),
                  Text(
                    "please fill out your details",
                  ),
                  SizedBox(
                    height: marginxLarge,
                  ),
                  Form(
                    child: Column(
                      children: [
                        LabeledInput(
                          label: TransUtil.trans("label_name_required"),
                          hintText: TransUtil.trans("hint_your_name"),
                          onChanged: (_) {},
                        ),
                        LabeledInput(
                          label: TransUtil.trans("label_email"),
                          hintText: TransUtil.trans("hint_your_email"),
                          onChanged: (_) {},
                        ),
                        LabeledInput(
                          label: TransUtil.trans("label_phone"),
                          hintText: TransUtil.trans("hint_your_phone"),
                          onChanged: (_) {},
                        ),
                        LabeledInput(
                          label: TransUtil.trans("label_birthday"),
                          hintText: TransUtil.trans("hint_your_birthday"),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: marginLarge,
                  ),
                  InlineButtons(
                    positiveText: TransUtil.trans("btn_save"),
                    negativeText: TransUtil.trans("btn_cancel"),
                    onPositiveTap: () {},
                    onNegativeTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
