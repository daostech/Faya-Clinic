import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/dates/dates_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';

class DatesScreenGlobal extends StatelessWidget {
  const DatesScreenGlobal({Key key}) : super(key: key);

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
                title: TransUtil.trans("header_dates"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: DatesScreen.create(context),
          ),
        ],
      ),
    );
  }
}
