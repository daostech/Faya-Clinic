import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_staff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicTeamTab extends StatelessWidget {
  const ClinicTeamTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = context.read<ClinicController>();
    return Container(
      child: _buildContent(controller, width),
    );
  }

  Widget _buildContent(ClinicController controller, width) {
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
    } else if (controller.teamsList!.isEmpty) {
      return Center(
        child: Text(TransUtil.trans("msg_no_data_for_this_section")),
      );
    }
    return ListView.builder(
      itemCount: controller.teamsList!.length,
      itemBuilder: (ctx, index) {
        return StaffItem(
          width: width,
          height: width * 0.7,
          team: controller.teamsList![index],
        );
      },
    );
  }
}
