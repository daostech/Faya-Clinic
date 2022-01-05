import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/clininc_date.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/screens/dates/date_controller.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/button_standard.dart';
import 'package:faya_clinic/widgets/error_widget.dart';
import 'package:faya_clinic/widgets/expanded_tile.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatesScreen extends StatelessWidget {
  const DatesScreen._({Key key, @required this.controller}) : super(key: key);
  final DateScreenController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return ChangeNotifierProvider<DateScreenController>(
      create: (_) => DateScreenController(database: database),
      builder: (ctx, child) {
        return Consumer<DateScreenController>(
          builder: (context, controller, _) => DatesScreen._(controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionCornerContainer(
      title: TransUtil.trans("header_dates"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // _buildSectionsExpanded(),
            MyExpandedTile(
              title: "select section",
              iconData: Icons.settings,
              children: _buildSectionsList(),
            ),
            SizedBox(
              height: marginStandard,
            ),
            MyExpandedTile(
              title: "select sub section",
              iconData: Icons.settings,
              children: _buildSubSectionsList(),
            ),
            MyExpandedTile(
              title: "select service",
              children: _buildServicesList(),
              iconData: Icons.settings,
            ),
            MyExpandedTile(
              title: "select date",
              iconData: Icons.calendar_today_rounded,
              children: [_buildDatePicker()],
            ),
            MyExpandedTile(
              title: "select time",
              iconData: Icons.timer,
              children: _buildDatesList(),
            ),
            SizedBox(
              height: 50,
            ),
            Visibility(
              visible: controller.isFormReady,
              child: StandardButton(
                text: "Confirm",
                radius: radiusStandard,
                onTap: controller.createNewDate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSectionsList() {
    List<Widget> children = [];

    if (controller.sectionsList == null || controller.sectionsList.isEmpty) {
      // fetching sections list has not been completed yet check if still loading and show progress bar
      // otherwise show an error message indicated that an error occured while getting sections list
      if (controller.isLoading)
        children = [Container(height: 70, child: Center(child: CircularProgressIndicator()))];
      else
        children = [
          MyErrorWidget(
            onTap: controller.fetchSections,
            error: "Error loading data !",
          )
        ];
    } else
      children = controller.sectionsList.map((element) => _buildSectionRadioTile(element)).toList();

    return children;
  }

  Widget _buildSectionRadioTile(Section section) {
    return RadioListTile<Section>(
      value: section,
      groupValue: controller.selectedSection,
      toggleable: true,
      selectedTileColor: colorPrimary,
      onChanged: controller.onSectionSelected,
      title: Text(section.name ?? ""),
      activeColor: colorPrimary,
    );
  }

  List<Widget> _buildSubSectionsList() {
    List<Widget> children = [];

    if (controller.selectedSection == null) {
      // the section has not been selected yet show a message to tell user
      // to select the section item first
      children = [_messageContainer("please make sure to select the section first")];
    } else {
      // the section is already fetching sub sections might be in progress show progress bar if so
      // otherwise if has data show list of sub sections or empty message if
      if ((controller.subSectionsList == null || controller.subSectionsList.isEmpty) && controller.isLoading)
        children = [Container(height: 70, child: Center(child: CircularProgressIndicator()))];
      else if (controller.subSectionsList == null || controller.subSectionsList.isEmpty)
        children = [_messageContainer("No sub Sections available for ${controller.selectedSection.name}")];
      else
        children = controller.subSectionsList.map((element) => _buildSubSectionRadioTile(element)).toList();
    }

    return children;
  }

  Widget _buildSubSectionRadioTile(SubSection subSection) {
    return RadioListTile<SubSection>(
      value: subSection,
      groupValue: controller.selectedSubSection,
      toggleable: true,
      selectedTileColor: colorPrimary,
      onChanged: controller.onSubSectionSelected,
      title: Text(subSection.name ?? ""),
      activeColor: colorPrimary,
    );
  }

  List<Widget> _buildServicesList() {
    List<Widget> children = [];

    if (controller.selectedSection == null || controller.selectedSubSection == null) {
      // the section has not been selected yet check if loading and show progress bar
      // otherwise show a message to tell user the select the section item first
      children = [_messageContainer("please make sure to select both section and sub section first")];
    } else {
      // both section and sub section are selected check if there any services realted to show them
      // otherwise show a message that indicates there is no services
      if (controller.isLoading)
        children = [Container(height: 70, child: Center(child: CircularProgressIndicator()))];
      else if (controller.servicesList == null || controller.servicesList.isEmpty) {
        children = [_messageContainer("No services for the selected section")];
      } else
        children = controller.servicesList.map((element) => _buildServiceCheckBoxTile(element)).toList();
    }

    return children;
  }

  Widget _buildServiceCheckBoxTile(ClinicService service) {
    return CheckboxListTile(
      activeColor: colorPrimary,
      dense: true,
      title: Text(
        service.name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
      value: controller.isSelectedService(service),
      onChanged: (_) => controller.toggleService(service),
    );
  }

  Widget _buildDatePicker() {
    return SfDateRangePicker(
      onSelectionChanged: controller.onDateTimeChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      enablePastDates: false,
    );
  }

  Widget _messageContainer(String message) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(marginStandard),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<Widget> _buildDatesList() {
    List<Widget> children = [];

    if (controller.selectedSection == null || controller.selectedSubSection == null) {
      // the section has not been selected yet check if loading and show progress bar
      // otherwise show a message to tell user the select the section item first
      if (controller.isLoading)
        children = [Container(height: 70, child: Center(child: CircularProgressIndicator()))];
      else
        children = [_messageContainer("please make sure to select both section and sub sections first")];
    } else {
      // the section is already selected check if there any sub sections realted to show them
      // otherwise show a message that
      if (controller.availableDates.isEmpty)
        children = [_messageContainer("No available dates for today :(")];
      else
        children = controller.availableDates.map((element) => _buildDateRadioTile(element)).toList();
    }

    return children;
  }

  Widget _buildDateRadioTile(ClinicDate date) {
    return RadioListTile<ClinicDate>(
      value: date,
      groupValue: controller.pickedClinicDate,
      toggleable: true,
      selectedTileColor: colorPrimary,
      onChanged: controller.onClinicDateSelected,
      title: Text(date.title ?? ""),
      activeColor: colorPrimary,
    );
  }
}
