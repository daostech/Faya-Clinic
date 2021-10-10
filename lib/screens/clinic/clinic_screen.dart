import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/screens/clinic/tabs/offers.dart';
import 'package:faya_clinic/screens/clinic/tabs/sections.dart';
import 'package:faya_clinic/screens/clinic/tabs/team.dart';
import 'package:faya_clinic/screens/clinic/tabs/find_us.dart';

import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ClinicScreen extends StatefulWidget {
  const ClinicScreen({Key key}) : super(key: key);

  @override
  _ClinicScreenState createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  final List<Widget> _tabs = [
    ClinicTeamTab(),
    ClinicSectionsTab(),
    ClinicOffersTab(),
    ClinicFindUsTab(),
  ];

  var _selectedTab = 0;
  void _setSelectedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
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
            initialIndex: _selectedTab,
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
                    onTap: (value) => _setSelectedTab(value),
                    labelColor: colorPrimaryLight,
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
            child: _tabs[_selectedTab],
          ),
        ],
      ),
    );
  }
}
