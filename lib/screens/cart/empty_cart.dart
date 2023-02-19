import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(TransUtil.trans("msg_cart_is_empty")),
      ),
    );
  }
}
