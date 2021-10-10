import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';

class DatesScreen extends StatelessWidget {
  const DatesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_dates"),
      child: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}
