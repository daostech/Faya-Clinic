import 'package:faya_clinic/constants/clinic_dates.dart';
import 'package:faya_clinic/models/clininc_date.dart';
import 'package:faya_clinic/models/requests/date_registered_request.dart';
import 'package:faya_clinic/models/section.dart';
import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/models/sub_section.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateScreenController with ChangeNotifier {
  static const TAG = "DateScreenController: ";
  final Database database;
  DateScreenController({@required this.database}) {
    init();
  }

  static List<Section> _sections;
  static List<SubSection> _subSections;
  static List<ClinicService> _services;

  List<ClinicService> _selectedServices = [];
  List<ClinicDate> _availableDates = [];

  Section selectedSection;
  SubSection selectedSubSection;
  DateTime _pickedDateTime;
  ClinicDate pickedClinicDate;

  var isLoading = true;

  List<Section> get sectionsList => _sections;
  List<SubSection> get subSectionsList => _subSections;
  List<ClinicService> get servicesList => _services;
  List<ClinicService> get selectedServices => _selectedServices;
  List<ClinicDate> get availableDates => ClinicDates.standardDates; // ! debug
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

  Future<void> fetchTakenDates(DateTime dateTime) async {
    updateWith(loading: true);
    print("$TAG fetchTakenDates: called");
    // todo implement method
    updateWith(loading: false);
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
    print("onDateTimeChanged: pickedDateTime: ${_pickedDateTime.toString()}");
  }

  void onClinicDateSelected(ClinicDate date) {
    updateWith(pickedDate: date);
  }

  void createNewDate() {
    updateWith(loading: true);
    database.createNewDate(request).then((value) {
      updateWith(loading: false);
    }).catchError((error) {
      print("$TAG [Error] createNewDate: ${error.toString()}");
    });
  }

  bool get isFormReady {
    return selectedSection != null && selectedSubSection != null && pickedDateTime != null && pickedClinicDate != null;
  }

  DateRegisteredRequest get request {
    return DateRegisteredRequest();
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
