import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/screens/clinic/clinic_sub_sections.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/item_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicSectionsTab extends StatelessWidget {
  const ClinicSectionsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClinicController>();
    return Container(
      child: _buildContent(context, controller),
    );
  }

  Widget _buildContent(BuildContext context, ClinicController controller) {
    if (controller.sectionsList == null) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
          child: MyErrorWidget(
        onTap: controller.fetchSections,
      ));
    } else if (controller.sectionsList.isEmpty) {
      return Center(
        child: Text(TransUtil.trans("msg_no_data_for_this_section")),
      );
    }
    return ListView.builder(
      itemCount: controller.sectionsList.length,
      itemBuilder: (ctx, index) {
        return SectionItem(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => ClinicSubSectionsScreen(
                    sectionId: controller.sectionsList[index].id,
                  ))),
          title: controller.sectionsList[index].name,
          subTitle: controller.sectionsList[index].description,
          image: controller.sectionsList[index].imageUrl,
        );
      },
    );
  }
}
