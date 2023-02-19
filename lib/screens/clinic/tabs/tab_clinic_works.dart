import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/utils/dialog_util.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_clinic_work.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicWorksTab extends StatelessWidget {
  const ClinicWorksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClinicController>();
    return Container(
      child: _buildContent(context, controller),
    );
  }

  Widget _buildContent(BuildContext context, ClinicController controller) {
    if (controller.worksList == null) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
          child: MyErrorWidget(
        onTap: controller.fetchClinicWorks,
      ));
    } else if (controller.worksList!.isEmpty) {
      return Center(
        child: Text(TransUtil.trans("msg_no_data_for_this_section")),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: marginStandard,
        crossAxisSpacing: marginStandard,
      ),
      itemCount: controller.worksList!.length,
      itemBuilder: (ctx, index) {
        return ClinicWorkItem(
          onTap: () => DialogUtil.showStandardDialog(
              context,
              ClinicWorkItem(
                clinicWork: controller.worksList![index],
              ),
              padding: const EdgeInsets.all(0)),
          clinicWork: controller.worksList![index],
        );
      },
    );
  }
}
