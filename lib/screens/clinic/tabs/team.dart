import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/widgets/item_staff.dart';
import 'package:flutter/material.dart';

class ClinicTeamTab extends StatelessWidget {
  const ClinicTeamTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: marginLarge),
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return StaffItem();
        },
      ),
    );
  }
}
