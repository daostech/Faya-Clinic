import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/expanded_tile.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';

class DatesScreen extends StatefulWidget {
  const DatesScreen({Key key}) : super(key: key);

  @override
  _DatesScreenState createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  var _selectedSection = "";

  void updateSelectedSection(String section) {
    if (_selectedSection == section) return;
    setState(() {
      _selectedSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_dates"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyExpandedTile(
              title: "select section",
              iconData: Icons.settings,
              children: [
                RadioListTile(
                  value: "dermatology",
                  selected: _selectedSection == "dermatology",
                  groupValue: _selectedSection,
                  toggleable: true,
                  onChanged: (section) => updateSelectedSection(section),
                  title: Text("Dermatology Clinic"),
                  activeColor: colorPrimary,
                ),
                RadioListTile(
                  value: "salon",
                  selected: _selectedSection == "salon",
                  groupValue: _selectedSection,
                  toggleable: true,
                  onChanged: (section) => updateSelectedSection(section),
                  title: Text("Salon"),
                  activeColor: colorPrimary,
                ),
              ],
            ),
            SizedBox(
              height: marginStandard,
            ),
            MyExpandedTile(
              title: "select sub section",
              iconData: Icons.settings,
            ),
            MyExpandedTile(
              title: "select service",
              iconData: Icons.settings,
            ),
            MyExpandedTile(
              title: "select date",
              iconData: Icons.calendar_today_rounded,
            ),
            MyExpandedTile(
              title: "select time",
              iconData: Icons.timer,
            ),
          ],
        ),
      ),
    );
  }
}
