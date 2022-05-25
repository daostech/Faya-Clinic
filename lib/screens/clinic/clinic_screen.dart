import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/clinic/clinic_controller.dart';
import 'package:faya_clinic/services/database_service.dart';

import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen._({Key key, @required this.controller}) : super(key: key);
  final ClinicController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return ChangeNotifierProvider<ClinicController>(
      create: (_) => ClinicController(database: database),
      builder: (ctx, child) {
        return Consumer<ClinicController>(
          builder: (context, controller, _) => ClinicScreen._(controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_clinic"),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DefaultTabController(
            length: 4,
            initialIndex: controller.currentTabIndex,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: marginStandard,
                ),
                Material(
                  color: Colors.transparent,
                  child: TabBar(
                    tabs: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: marginSmall,
                        ),
                        child: Tab(
                          text: TransUtil.trans("tab_team"),
                        ),
                      ),
                      Tab(
                        text: TransUtil.trans("tab_sections"),
                      ),
                      Tab(
                        text: TransUtil.trans("tab_offers"),
                      ),
                      Tab(
                        text: TransUtil.trans("tab_find_us"),
                      ),
                    ],
                    onTap: controller.onTabChanged,
                    labelColor: Colors.white,
                    unselectedLabelColor: colorPrimary,
                    // indicatorColor: Colors.green,
                    overlayColor: MaterialStateProperty.resolveWith((states) => colorAccent),
                    isScrollable: true,
                    indicator: RectangularIndicator(
                      color: colorPrimary,
                      bottomLeftRadius: 100,
                      bottomRightRadius: 100,
                      topLeftRadius: 100,
                      topRightRadius: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: marginStandard,
          ),
          Expanded(
            // height: 400,
            child: controller.currentTab,
          ),
        ],
      ),
    );
  }
}
