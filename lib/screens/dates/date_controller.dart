import 'package:faya_clinic/constants/clinic_dates.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/models/clinic_date.dart';
import 'package:faya_clinic/models/date_registered.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateScreenController with ChangeNotifier {
  static const TAG = "DateScreenController: ";
  //todo add user repo
  final Database database;
  DateScreenController({@required this.database}) {
    init();
  }

  static List<Section> _sections;
  static List<SubSection> _subSections;
  static List<ClinicService> _services;

  List<ClinicService> _selectedServices = [];
  // List<ClinicDate> _availableDates = [];
  List<ClinicDate> _availableDates = ClinicDates.standardDates; // ! debug

  Section selectedSection;
  SubSection selectedSubSection;
  DateTime _pickedDateTime;
  ClinicDate pickedClinicDate;

  var isLoading = true;

  List<Section> get sectionsList => _sections;
  List<SubSection> get subSectionsList => _subSections;
  List<ClinicService> get servicesList => _services;
  List<ClinicService> get selectedServices => _selectedServices;
  List<ClinicDate> get availableDates => _availableDates;
  DateTime get pickedDateTime => _pickedDateTime;

  init() async {
    fetchSections();
  }

  Future<void> fetchSections() async {
    updateWith(loading: true);
    print("$TAG fetchSections: called");
    final result = await database.fetchSectionsList().catchError((error) {
      print("$TAG [Error] fetchSections : $error");
    });
    updateWith(sections: result, loading: false);
  }

  Future<void> fetchSubSections(String sectionId) async {
    updateWith(loading: true);
    print("$TAG fetchSubSections: called");
    final result = await database.fetchSubSectionsList(sectionId).catchError((error) {
      print("$TAG [Error] fetchSubSections : $error");
    });
    updateWith(subSections: result, loading: false);
  }

  Future<void> fetchServices(String subSectionId) async {
    updateWith(loading: true);
    print("$TAG fetchServices: called");
    final result = await database.fetchServicesList(subSectionId).catchError((error) {
      print("$TAG [Error] fetchServices : $error");
    });
    updateWith(services: result, loading: false);
  }

  Future<void> fetchAvailableDates(DateTime dateTime) async {
    updateWith(loading: true);
    print("$TAG fetchAvailableDates: called");
    // final formattedDate = MyDateFormatter.toStringDate(dateTime); // todo add new format to match the server format if needed
    // final allDates = await database.fetchAllDatesOn(formattedDate).catchError((error) {
    //   print("$TAG [Error] fetchAvailableDates : $error");
    // });
    final avClinicDates =
        getAvailableDates(DummyData.fakeReservedDates); // ! debug change this after the backend issue resolved
    updateWith(loading: false, availableDates: avClinicDates);
  }

  List<ClinicDate> getAvailableDates(List<DateRegistered> reserevedDate) {
    List<ClinicDate> standardClinicDates = [...ClinicDates.standardDates];
    reserevedDate.forEach((reserved) {
      standardClinicDates.removeWhere((standard) => standard.startTimeFormatted24H == reserved.time);
    });
    return standardClinicDates;
  }

  void onSectionSelected(Section section) {
    if (section == null) return;
    _subSections?.clear();
    _selectedServices?.clear();
    updateWith(pickedSection: section, subSections: _subSections, selectedServices: _selectedServices);
    // filterSubSections(section);
    fetchSubSections(section.id);
  }

  void onSubSectionSelected(SubSection subSection) {
    if (subSection == null) return;
    updateWith(pickedSubSection: subSection);
    fetchServices(subSection.id);
  }

  bool isSelectedService(ClinicService service) {
    if (service == null) return false;
    return selectedServices.firstWhere((element) => element.id == service.id, orElse: () => null) != null;
  }

  void toggleService(ClinicService service) {
    if (service == null) return;
    if (isSelectedService(service)) {
      _selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      _selectedServices.add(service);
    }
    updateWith(selectedServices: _selectedServices);
  }

  void onDateTimeChanged(DateRangePickerSelectionChangedArgs args) {
    _pickedDateTime = args.value;
    fetchAvailableDates(_pickedDateTime);
    print("onDateTimeChanged: pickedDateTime: ${_pickedDateTime.toString()}");
  }

  void onClinicDateSelected(ClinicDate date) {
    updateWith(pickedDate: date);
  }

  Future<bool> createNewDate() async {
    print("$TAG createNewDate: request ${request.toJson()}");
    updateWith(loading: true);
    final result = await database.createNewDate(request).catchError((error) {
      print("$TAG [Error] createNewDate: ${error.toString()}");
    });
    if (result.success) {
      resetForm();
    }
    return result?.success ?? false;
  }

  bool get isFormReady {
    return selectedSection != null &&
        selectedSubSection != null &&
        _pickedDateTime != null &&
        pickedClinicDate != null &&
        _selectedServices.isNotEmpty;
  }

  DateRegisteredRequest get request {
    final now = DateTime.now();

    final registeredDate = DateTime(
      now.year,
      now.month,
      now.day,
      pickedClinicDate.startHour,
      pickedClinicDate.startMinutes,
    );

    return DateRegisteredRequest(
      userId: "bbbf3cfa-6d01-4382-91e1-0c20a2adffad", // ! debug
      sectionId: selectedSection.id,
      subSectionId: selectedSubSection.id,
      dateTime: registeredDate,
      timeStr: pickedClinicDate.startTimeFormatted24H,
      services: _selectedServices,
    );
  }

  void resetForm() {
    isLoading = false;
    _subSections = null;
    _services = null;
    selectedSection = null;
    selectedSubSection = null;
    _availableDates = [];
    _selectedServices = [];
    _pickedDateTime = null;
    pickedClinicDate = null;
    notifyListeners();
  }

  updateWith({
    bool loading,
    List<Section> sections,
    List<SubSection> subSections,
    List<ClinicService> services,
    List<ClinicService> selectedServices,
    List<ClinicDate> availableDates,
    Section pickedSection,
    SubSection pickedSubSection,
    DateTime pickedDateTime,
    ClinicDate pickedDate,
  }) {
    isLoading = loading ?? isLoading;
    _sections = sections ?? _sections;
    _subSections = subSections ?? _subSections;
    _services = services ?? _services;
    selectedSection = pickedSection ?? selectedSection;
    selectedSubSection = pickedSubSection ?? selectedSubSection;
    _availableDates = availableDates ?? _availableDates;
    _selectedServices = selectedServices ?? _selectedServices;
    _pickedDateTime = pickedDateTime ?? _pickedDateTime;
    pickedClinicDate = pickedDate ?? pickedClinicDate;
    notifyListeners();
  }
}
