import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key key, @required this.onTap, this.error, this.buttonText}) : super(key: key);
  final String error;
  final String buttonText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error ?? TransUtil.trans("error_loading_data"),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: marginLarge,
            ),
            StandardButton(
              radius: radiusStandard,
              onTap: onTap,
              text: buttonText ?? TransUtil.trans("btn_try_again"),
            ),
          ],
        ),
      ),
    );
  }
}
