import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_staff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicTeamTab extends StatelessWidget {
  const ClinicTeamTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ClinicController>();
    return Container(
      child: _buildContent(controller),
    );
  }

  Widget _buildContent(ClinicController controller) {
    if (controller.teamsList == null) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
          child: MyErrorWidget(
        onTap: controller.fetchTeamsList,
      ));
    } else if (controller.teamsList.isEmpty) {
      return Center(
        child: Text("No data for this section !"),
      );
    }
    return ListView.builder(
      itemCount: controller.teamsList.length,
      itemBuilder: (ctx, index) {
        return StaffItem(
          team: controller.teamsList[index],
        );
      },
    );
  }
}
